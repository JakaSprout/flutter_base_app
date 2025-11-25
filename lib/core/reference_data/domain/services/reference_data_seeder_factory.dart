import 'package:app_mobile_afms/core/di/providers/master_data_sync_provider.dart';
import 'package:app_mobile_afms/core/reference_data/data/datasources/local/reference_data_local_datasource.dart';
import 'package:app_mobile_afms/core/reference_data/data/datasources/remote/reference_data_remote_datasource.dart';
import 'package:app_mobile_afms/core/reference_data/domain/services/reference_data_seeder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reference_data_seeder_factory.g.dart';

/// Factory for creating reference data seeders.
/// This makes it easy to add new data types and maintain seeding logic.
class ReferenceDataSeederFactory {
  /// Create seeder with all available data types.
  static ReferenceDataSeeder createDefaultSeeder({
    required ReferenceDataRemoteDatasource remoteDatasource,
    required ReferenceDataLocalDatasource localDatasource,
  }) {
    final seeders = <String, DataTypeSeeder>{
      'farms': FarmsSeeder(
        remoteDatasource: remoteDatasource,
        localDatasource: localDatasource,
      ),
      'ponds': PondsSeeder(
        remoteDatasource: remoteDatasource,
        localDatasource: localDatasource,
      ),
      'employees': EmployeesSeeder(
        remoteDatasource: remoteDatasource,
        localDatasource: localDatasource,
      ),
      // 'customers': CustomersSeeder(  // TODO: Re-enable when customers API is implemented
      //   remoteDatasource: remoteDatasource,
      //   localDatasource: localDatasource,
      // ),
      'lab_test_types': LabTestTypesSeeder(
        remoteDatasource: remoteDatasource,
        localDatasource: localDatasource,
      ),
    };

    return ReferenceDataSeederImpl(seeders: seeders);
  }

  /// Create seeder with specific data types only.
  static ReferenceDataSeeder createCustomSeeder({
    required ReferenceDataRemoteDatasource remoteDatasource,
    required ReferenceDataLocalDatasource localDatasource,
    required List<String> dataTypes,
  }) {
    final allSeeders = <String, DataTypeSeeder>{
      'farms': FarmsSeeder(
        remoteDatasource: remoteDatasource,
        localDatasource: localDatasource,
      ),
      'ponds': PondsSeeder(
        remoteDatasource: remoteDatasource,
        localDatasource: localDatasource,
      ),
      'employees': EmployeesSeeder(
        remoteDatasource: remoteDatasource,
        localDatasource: localDatasource,
      ),
      // 'customers': CustomersSeeder(
      //   remoteDatasource: remoteDatasource,
      //   localDatasource: localDatasource,
      // ),
      'lab_test_types': LabTestTypesSeeder(
        remoteDatasource: remoteDatasource,
        localDatasource: localDatasource,
      ),
    };

    final filteredSeeders = <String, DataTypeSeeder>{};
    for (final dataType in dataTypes) {
      final seeder = allSeeders[dataType];
      if (seeder != null) {
        filteredSeeders[dataType] = seeder;
      }
    }

    return ReferenceDataSeederImpl(seeders: filteredSeeders);
  }

  /// Create seeder with priority-based ordering.
  static ReferenceDataSeeder createPrioritySeeder({
    required ReferenceDataRemoteDatasource remoteDatasource,
    required ReferenceDataLocalDatasource localDatasource,
  }) {
    final allSeeders = <DataTypeSeeder>[
      FarmsSeeder(
        remoteDatasource: remoteDatasource,
        localDatasource: localDatasource,
      ),
      PondsSeeder(
        remoteDatasource: remoteDatasource,
        localDatasource: localDatasource,
      ),
      EmployeesSeeder(
        remoteDatasource: remoteDatasource,
        localDatasource: localDatasource,
      ),
      // TODO: Re-enable when customers API is implemented
      // CustomersSeeder(
      //   remoteDatasource: remoteDatasource,
      //   localDatasource: localDatasource,
      // ),
      LabTestTypesSeeder(
        remoteDatasource: remoteDatasource,
        localDatasource: localDatasource,
      ),
    ];

    // Sort by priority (lower number = higher priority)
    allSeeders.sort((a, b) => a.priority.compareTo(b.priority));

    final seeders = <String, DataTypeSeeder>{};
    for (final seeder in allSeeders) {
      seeders[seeder.dataType] = seeder;
    }

    return ReferenceDataSeederImpl(seeders: seeders);
  }
}

/// Riverpod provider for reference data seeder.
@riverpod
ReferenceDataSeeder referenceDataSeeder(ReferenceDataSeederRef ref) {
  final remoteDatasource = ref.watch(referenceDataRemoteDatasourceProvider);
  final localDatasource = ref.watch(referenceDataLocalDatasourceProvider);
  return ReferenceDataSeederFactory.createPrioritySeeder(
    remoteDatasource: remoteDatasource,
    localDatasource: localDatasource,
  );
}

/// Configuration for seeding operations.
/// This makes it easy to customize seeding behavior.
class SeedingConfiguration {
  const SeedingConfiguration({
    this.defaultBatchSize = 100,
    this.defaultTimeout = const Duration(seconds: 30),
    this.defaultRetryAttempts = 3,
    this.defaultRetryDelay = const Duration(seconds: 1),
    this.enabledDataTypes = const [
      'farms',
      'ponds',
      'employees',
      'customers',
      'lab_test_types',
    ],
    this.priorityOrder = const [
      'farms', // Most important for company selection
      'ponds', // Needed for harvest calculator
      'employees', // User management
      'customers', // Business relations
      'lab_test_types', // Lab operations
    ],
  });

  final int defaultBatchSize;
  final Duration defaultTimeout;
  final int defaultRetryAttempts;
  final Duration defaultRetryDelay;
  final List<String> enabledDataTypes;
  final List<String> priorityOrder;

  /// Create default seed config from this configuration.
  SeedConfig createDefaultConfig({bool force = false}) {
    return SeedConfig(
      force: force,
      batchSize: defaultBatchSize,
      timeout: defaultTimeout,
      retryAttempts: defaultRetryAttempts,
      retryDelay: defaultRetryDelay,
    );
  }

  /// Check if data type is enabled for seeding.
  bool isDataTypeEnabled(String dataType) {
    return enabledDataTypes.contains(dataType);
  }

  /// Get priority order for data types.
  List<String> getOrderedDataTypes() {
    final ordered = <String>[];
    for (final dataType in priorityOrder) {
      if (enabledDataTypes.contains(dataType)) {
        ordered.add(dataType);
      }
    }
    // Add any remaining enabled types not in priority order
    for (final dataType in enabledDataTypes) {
      if (!ordered.contains(dataType)) {
        ordered.add(dataType);
      }
    }
    return ordered;
  }
}

/// Global seeding configuration.
/// Modify this to change seeding behavior across the app.
const seedingConfiguration = SeedingConfiguration();
