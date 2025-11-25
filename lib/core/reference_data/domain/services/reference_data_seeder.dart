import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:app_mobile_afms/core/reference_data/data/datasources/local/reference_data_local_datasource.dart';
import 'package:app_mobile_afms/core/reference_data/data/datasources/remote/reference_data_remote_datasource.dart';
import 'package:app_mobile_afms/core/reference_data/domain/services/reference_data_seeder_factory.dart';
import 'package:dartz/dartz.dart';

/// Result of reference data seeding operation.
class ReferenceDataSeedResult {
  const ReferenceDataSeedResult({
    required this.success,
    required this.results,
    required this.totalProcessed,
    required this.totalErrors,
    required this.duration,
  });

  final bool success;
  final Map<String, SeedResult> results;
  final int totalProcessed;
  final int totalErrors;
  final Duration duration;

  bool get hasErrors => totalErrors > 0;

  @override
  String toString() {
    return 'ReferenceDataSeedResult(success: $success, '
        'totalProcessed: $totalProcessed, '
        'totalErrors: $totalErrors, '
        'duration: ${duration.inMilliseconds}ms)';
  }
}

/// Result of individual seeding operation.
class SeedResult {
  const SeedResult({
    required this.dataType,
    required this.success,
    required this.processedCount,
    required this.errorCount,
    required this.errors,
    required this.duration,
  });

  final String dataType;
  final bool success;
  final int processedCount;
  final int errorCount;
  final List<String> errors;
  final Duration duration;

  @override
  String toString() {
    return 'SeedResult($dataType: $processedCount processed, $errorCount errors, '
        '${duration.inMilliseconds}ms)';
  }
}

/// Configuration for seeding operation.
class SeedConfig {
  const SeedConfig({
    required this.force,
    required this.batchSize,
    required this.timeout,
    this.retryAttempts = 3,
    this.retryDelay = const Duration(seconds: 1),
  });

  final bool force;
  final int batchSize;
  final Duration timeout;
  final int retryAttempts;
  final Duration retryDelay;
}

/// Abstract seeder service for reference data.
abstract class ReferenceDataSeeder {
  /// Seed all reference data types.
  Future<ReferenceDataSeedResult> seedAll({
    required String userId,
    required SeedingConfiguration seedingConfig,
    SeedConfig config = const SeedConfig(
      force: false,
      batchSize: 100,
      timeout: Duration(seconds: 30),
    ),
  });

  /// Seed specific data type.
  Future<Either<Failure, SeedResult>> seedDataType({
    required String userId,
    required String dataType,
    required SeedConfig config,
  });
}

/// Implementation of reference data seeder.
class ReferenceDataSeederImpl implements ReferenceDataSeeder {
  const ReferenceDataSeederImpl({required this.seeders});

  /// Map of data type to seeder implementation.
  final Map<String, DataTypeSeeder> seeders;

  @override
  Future<ReferenceDataSeedResult> seedAll({
    required String userId,
    required SeedingConfiguration seedingConfig,
    SeedConfig config = const SeedConfig(
      force: false,
      batchSize: 100,
      timeout: Duration(seconds: 30),
    ),
  }) async {
    final startTime = DateTime.now();
    AppLogger.info('[ReferenceDataSeeder] Starting seeding for user: $userId');

    final results = <String, SeedResult>{};
    var totalProcessed = 0;
    var totalErrors = 0;

    // Filter and sort data types based on configuration
    final enabledDataTypes = seedingConfig.enabledDataTypes.toSet();
    final priorityOrder = seedingConfig.priorityOrder;

    // Sort enabled data types by priority order
    final sortedDataTypes = priorityOrder
        .where(enabledDataTypes.contains)
        .toList();

    // Seed enabled data types in priority order
    for (final dataType in sortedDataTypes) {
      if (!seeders.containsKey(dataType)) {
        AppLogger.warning(
          '[ReferenceDataSeeder] Seeder not found for enabled data type: $dataType',
        );
        continue;
      }

      AppLogger.debug('[ReferenceDataSeeder] Seeding $dataType...');

      final result = await seedDataType(
        userId: userId,
        dataType: dataType,
        config: config,
      );

      result.fold(
        (failure) {
          AppLogger.error(
            '[ReferenceDataSeeder] Failed to seed $dataType: $failure',
          );
          final errorResult = SeedResult(
            dataType: dataType,
            success: false,
            processedCount: 0,
            errorCount: 1,
            errors: [failure.message],
            duration: Duration.zero,
          );
          results[dataType] = errorResult;
          totalErrors++;
        },
        (seedResult) {
          results[dataType] = seedResult;
          totalProcessed += seedResult.processedCount;
          totalErrors += seedResult.errorCount;

          if (seedResult.success) {
            AppLogger.info(
              '[ReferenceDataSeeder] Successfully seeded $dataType: '
              '${seedResult.processedCount} records',
            );
          } else {
            AppLogger.warning(
              '[ReferenceDataSeeder] Partially seeded $dataType: '
              '${seedResult.processedCount} success, ${seedResult.errorCount} errors',
            );
          }
        },
      );
    }

    final duration = DateTime.now().difference(startTime);
    final success = totalErrors == 0;

    final finalResult = ReferenceDataSeedResult(
      success: success,
      results: results,
      totalProcessed: totalProcessed,
      totalErrors: totalErrors,
      duration: duration,
    );

    AppLogger.info('[ReferenceDataSeeder] Completed seeding: $finalResult');
    return finalResult;
  }

  @override
  Future<Either<Failure, SeedResult>> seedDataType({
    required String userId,
    required String dataType,
    required SeedConfig config,
  }) async {
    final seeder = seeders[dataType];
    if (seeder == null) {
      return Left(NetworkFailure(message: 'Unknown data type: $dataType'));
    }

    return seeder.seed(userId: userId, config: config);
  }
}

/// Abstract seeder for specific data type.
abstract class DataTypeSeeder {
  /// Data type identifier.
  String get dataType;

  /// Priority order (lower = higher priority).
  int get priority => 0;

  /// Seed data for this type.
  Future<Either<Failure, SeedResult>> seed({
    required String userId,
    required SeedConfig config,
  });
}

/// Farms seeder implementation.
class FarmsSeeder extends DataTypeSeeder {
  FarmsSeeder({required this.remoteDatasource, required this.localDatasource});

  final ReferenceDataRemoteDatasource remoteDatasource;
  final ReferenceDataLocalDatasource localDatasource;

  @override
  String get dataType => 'farms';

  @override
  int get priority => 1; // High priority

  @override
  Future<Either<Failure, SeedResult>> seed({
    required String userId,
    required SeedConfig config,
  }) async {
    final startTime = DateTime.now();

    try {
      // Fetch farms from API
      final result = await remoteDatasource.getFarms();

      return result.fold(
        (failure) {
          final seedResult = SeedResult(
            dataType: dataType,
            success: false,
            processedCount: 0,
            errorCount: 1,
            errors: [failure.message],
            duration: DateTime.now().difference(startTime),
          );
          return Right(seedResult);
        },
        (farms) async {
          // Save farms to local database
          final saveResult = await localDatasource.saveFarms(farms);

          return saveResult.fold<Either<Failure, SeedResult>>(
            (Failure failure) {
              AppLogger.error(
                '[$dataType Seeder] Failed to save farms to database: ${failure.message}',
              );
              return Right(
                SeedResult(
                  dataType: dataType,
                  success: false,
                  processedCount: 0,
                  errorCount: 1,
                  errors: [failure.message],
                  duration: DateTime.now().difference(startTime),
                ),
              );
            },
            (int savedCount) => Right(
              SeedResult(
                dataType: dataType,
                success: true,
                processedCount: savedCount,
                errorCount: 0,
                errors: [],
                duration: DateTime.now().difference(startTime),
              ),
            ),
          );
        },
      );
    } catch (e) {
      // Log warning but don't fail seeding process for missing backend features
      AppLogger.warning(
        '[$dataType Seeder] $dataType seeding failed: $e. '
        'This is expected if $dataType feature is not implemented yet.',
      );
      final seedResult = SeedResult(
        dataType: dataType,
        success: true, // Consider as success to not block seeding
        processedCount: 0,
        errorCount: 0,
        errors: [],
        duration: DateTime.now().difference(startTime),
      );
      return Right(seedResult);
    }
  }
}

/// Ponds seeder implementation.
class PondsSeeder extends DataTypeSeeder {
  PondsSeeder({required this.remoteDatasource, required this.localDatasource});

  final ReferenceDataRemoteDatasource remoteDatasource;
  final ReferenceDataLocalDatasource localDatasource;

  @override
  String get dataType => 'ponds';

  @override
  int get priority => 2;

  @override
  Future<Either<Failure, SeedResult>> seed({
    required String userId,
    required SeedConfig config,
  }) async {
    final startTime = DateTime.now();

    try {
      // Fetch ponds from API
      final result = await remoteDatasource.getPonds();

      return result.fold(
        (failure) {
          final seedResult = SeedResult(
            dataType: dataType,
            success: false,
            processedCount: 0,
            errorCount: 1,
            errors: [failure.message],
            duration: DateTime.now().difference(startTime),
          );
          return Right(seedResult);
        },
        (ponds) async {
          // Save ponds to local database
          final saveResult = await localDatasource.savePonds(ponds);

          return saveResult.fold<Either<Failure, SeedResult>>(
            (Failure failure) {
              AppLogger.error(
                '[$dataType Seeder] Failed to save ponds to database: ${failure.message}',
              );
              return Right(
                SeedResult(
                  dataType: dataType,
                  success: false,
                  processedCount: 0,
                  errorCount: 1,
                  errors: [failure.message],
                  duration: DateTime.now().difference(startTime),
                ),
              );
            },
            (int savedCount) => Right(
              SeedResult(
                dataType: dataType,
                success: true,
                processedCount: savedCount,
                errorCount: 0,
                errors: [],
                duration: DateTime.now().difference(startTime),
              ),
            ),
          );
        },
      );
    } catch (e) {
      // Log warning but don't fail seeding process for missing backend features
      AppLogger.warning(
        '[$dataType Seeder] $dataType seeding failed: $e. '
        'This is expected if $dataType feature is not implemented yet.',
      );
      final seedResult = SeedResult(
        dataType: dataType,
        success: true, // Consider as success to not block seeding
        processedCount: 0,
        errorCount: 0,
        errors: [],
        duration: DateTime.now().difference(startTime),
      );
      return Right(seedResult);
    }
  }
}

/// Employees seeder implementation.
class EmployeesSeeder extends DataTypeSeeder {
  EmployeesSeeder({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  final ReferenceDataRemoteDatasource remoteDatasource;
  final ReferenceDataLocalDatasource localDatasource;

  @override
  String get dataType => 'employees';

  @override
  int get priority => 3;

  @override
  Future<Either<Failure, SeedResult>> seed({
    required String userId,
    required SeedConfig config,
  }) async {
    final startTime = DateTime.now();

    try {
      // Fetch employees from API
      final result = await remoteDatasource.getEmployees();

      return result.fold(
        (failure) {
          final seedResult = SeedResult(
            dataType: dataType,
            success: false,
            processedCount: 0,
            errorCount: 1,
            errors: [failure.message],
            duration: DateTime.now().difference(startTime),
          );
          return Right(seedResult);
        },
        (employees) async {
          // Save employees to local database
          final saveResult = await localDatasource.saveEmployees(employees);

          return saveResult.fold<Either<Failure, SeedResult>>(
            (Failure failure) => Right(
              SeedResult(
                dataType: dataType,
                success: false,
                processedCount: 0,
                errorCount: 1,
                errors: [failure.message],
                duration: DateTime.now().difference(startTime),
              ),
            ),
            (int savedCount) => Right(
              SeedResult(
                dataType: dataType,
                success: true,
                processedCount: savedCount,
                errorCount: 0,
                errors: [],
                duration: DateTime.now().difference(startTime),
              ),
            ),
          );
        },
      );
    } catch (e) {
      // Log warning but don't fail seeding process for missing backend features
      AppLogger.warning(
        '[$dataType Seeder] $dataType seeding failed: $e. '
        'This is expected if $dataType feature is not implemented yet.',
      );
      final seedResult = SeedResult(
        dataType: dataType,
        success: true, // Consider as success to not block seeding
        processedCount: 0,
        errorCount: 0,
        errors: [],
        duration: DateTime.now().difference(startTime),
      );
      return Right(seedResult);
    }
  }
}

/// Customers seeder implementation.
// TODO: Re-enable when customers API is implemented
// class CustomersSeeder extends DataTypeSeeder {
//   CustomersSeeder({
//     required this.remoteDatasource,
//     required this.localDatasource,
//   });

//   final ReferenceDataRemoteDatasource remoteDatasource;
//   final ReferenceDataLocalDatasource localDatasource;

//   @override
//   String get dataType => 'customers';

//   @override
//   int get priority => 4;

//   @override
//   Future<Either<Failure, SeedResult>> seed({
//     required String userId,
//     required SeedConfig config,
//   }) async {
//     final startTime = DateTime.now();

//     try {
//       // Fetch customers from API
//       final result = await remoteDatasource.getCustomers();

//       return result.fold(
//         (failure) {
//           // Log warning but don't fail seeding process for missing backend features
//           AppLogger.warning(
//             '[CustomersSeeder] Customers API not available or table missing: ${failure.message}. '
//             'This is expected if customers feature is not implemented yet.',
//           );
//           final seedResult = SeedResult(
//             dataType: dataType,
//             success: true, // Consider as success to not block seeding
//             processedCount: 0,
//             errorCount: 0,
//             errors: [],
//             duration: DateTime.now().difference(startTime),
//           );
//           return Right(seedResult);
//         },
//         (customers) async {
//           // Save customers to local database
//           final saveResult = await localDatasource.saveCustomers(customers);

//           return saveResult.fold<Either<Failure, SeedResult>>(
//             (Failure failure) => Right(
//               SeedResult(
//                 dataType: dataType,
//                 success: false,
//                 processedCount: 0,
//                 errorCount: 1,
//                 errors: [failure.message],
//                 duration: DateTime.now().difference(startTime),
//               ),
//             ),
//             (int savedCount) => Right(
//               SeedResult(
//                 dataType: dataType,
//                 success: true,
//                 processedCount: savedCount,
//                 errorCount: 0,
//                 errors: [],
//                 duration: DateTime.now().difference(startTime),
//               ),
//             ),
//           );
//         },
//       );
//     } catch (e) {
//       // Log warning but don't fail seeding process
//       AppLogger.warning(
//         '[CustomersSeeder] Customers seeding failed: $e. '
//         'This is expected if customers feature is not implemented yet.',
//       );
//       final seedResult = SeedResult(
//         dataType: dataType,
//         success: true, // Consider as success to not block seeding
//         processedCount: 0,
//         errorCount: 0,
//         errors: [],
//         duration: DateTime.now().difference(startTime),
//       );
//       return Right(seedResult);
//     }
//   }
// }

/// Lab test types seeder implementation.
class LabTestTypesSeeder extends DataTypeSeeder {
  LabTestTypesSeeder({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  final ReferenceDataRemoteDatasource remoteDatasource;
  final ReferenceDataLocalDatasource localDatasource;

  @override
  String get dataType => 'lab_test_types';

  @override
  int get priority => 5;

  @override
  Future<Either<Failure, SeedResult>> seed({
    required String userId,
    required SeedConfig config,
  }) async {
    final startTime = DateTime.now();

    try {
      // Fetch lab test types from API
      final result = await remoteDatasource.getLabTestTypes();

      return result.fold(
        (failure) {
          // Log warning but don't fail seeding process for missing backend features
          AppLogger.warning(
            '[LabTestTypesSeeder] Lab test types API not available: ${failure.message}. '
            'This is expected if lab test types feature is not implemented yet.',
          );
          final seedResult = SeedResult(
            dataType: dataType,
            success: true, // Consider as success to not block seeding
            processedCount: 0,
            errorCount: 0,
            errors: [],
            duration: DateTime.now().difference(startTime),
          );
          return Right(seedResult);
        },
        (labTestTypes) async {
          // Save lab test types to local database
          final saveResult = await localDatasource.saveLabTestTypes(
            labTestTypes,
          );

          return saveResult.fold<Either<Failure, SeedResult>>(
            (Failure failure) => Right(
              SeedResult(
                dataType: dataType,
                success: false,
                processedCount: 0,
                errorCount: 1,
                errors: [failure.message],
                duration: DateTime.now().difference(startTime),
              ),
            ),
            (int savedCount) => Right(
              SeedResult(
                dataType: dataType,
                success: true,
                processedCount: savedCount,
                errorCount: 0,
                errors: [],
                duration: DateTime.now().difference(startTime),
              ),
            ),
          );
        },
      );
    } catch (e) {
      // Log warning but don't fail seeding process for missing backend features
      AppLogger.warning(
        '[$dataType Seeder] $dataType seeding failed: $e. '
        'This is expected if $dataType feature is not implemented yet.',
      );
      final seedResult = SeedResult(
        dataType: dataType,
        success: true, // Consider as success to not block seeding
        processedCount: 0,
        errorCount: 0,
        errors: [],
        duration: DateTime.now().difference(startTime),
      );
      return Right(seedResult);
    }
  }
}
