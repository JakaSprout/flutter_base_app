import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/harvest_simulation.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/registered_pond.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

/// Abstract interface for remote harvest simulation data operations.
abstract class HarvestSimulationRemoteDatasource {
  /// Gets all saved harvest simulations from API.
  Future<Either<Failure, List<HarvestSimulation>>> getSavedSimulations();

  /// Gets a specific simulation by ID from API.
  Future<Either<Failure, HarvestSimulation>> getSimulationById(String id);

  /// Saves a harvest simulation to API.
  Future<Either<Failure, HarvestSimulation>> saveSimulation(
    HarvestSimulation simulation,
  );

  /// Updates an existing simulation in API.
  Future<Either<Failure, HarvestSimulation>> updateSimulation(
    HarvestSimulation simulation,
  );

  /// Deletes a simulation from API.
  Future<Either<Failure, void>> deleteSimulation(String id);

  /// Gets registered ponds from API.
  Future<Either<Failure, List<RegisteredPond>>> getRegisteredPonds();

  /// Calculates simulation results via API.
  Future<Either<Failure, SimulationResults>> calculateSimulationResults({
    required String commodity,
    required String cultivationSystem,
    required double pondArea,
    required double targetHarvest,
    required double estimatedADG,
    required int targetDOC,
    required double targetSR,
    required double estimatedFCR,
    required double targetBiomass,
    required double sellingPrice,
    required double feedPrice,
    required String cycleType,
    double? currentDOC,
  });
}

/// Implementation of [HarvestSimulationRemoteDatasource] using Dio HTTP client.
class HarvestSimulationRemoteDatasourceImpl
    implements HarvestSimulationRemoteDatasource {
  /// Creates a new instance of [HarvestSimulationRemoteDatasourceImpl].
  const HarvestSimulationRemoteDatasourceImpl({required this.dio});

  /// The HTTP client instance.
  final Dio dio;

  @override
  Future<Either<Failure, List<HarvestSimulation>>> getSavedSimulations() async {
    try {
      AppLogger.debug(
        '[HarvestSimulationRemote] Fetching saved simulations from API',
      );

      final response = await dio.get(
        '/api/v1/harvest-simulations',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      AppLogger.debug(
        '[HarvestSimulationRemote] API Response: ${response.statusCode}',
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        // Validate response structure
        if (responseData is! Map<String, dynamic>) {
          AppLogger.error(
            '[HarvestSimulationRemote] Invalid response format: expected Map, got ${responseData.runtimeType}',
          );
          return const Left(
            NetworkFailure.serverError('Invalid response format from server'),
          );
        }

        final success = responseData['success'] as bool?;
        if (success != true) {
          final message = responseData['message'] as String? ?? 'Unknown error';
          AppLogger.warning(
            '[HarvestSimulationRemote] API returned success=false: $message',
          );
          return Left(NetworkFailure.serverError(message));
        }

        final data = responseData['data'];
        if (data == null) {
          AppLogger.warning('[HarvestSimulationRemote] API returned null data');
          return const Right([]); // Empty list is valid
        }

        if (data is! List) {
          AppLogger.error(
            '[HarvestSimulationRemote] Invalid data format: expected List, got ${data.runtimeType}',
          );
          return const Left(
            NetworkFailure.serverError('Invalid data format from server'),
          );
        }

        final simulations = <HarvestSimulation>[];
        for (final item in data) {
          try {
            if (item is! Map<String, dynamic>) {
              AppLogger.warning(
                '[HarvestSimulationRemote] Skipping invalid item: ${item.runtimeType}',
              );
              continue;
            }

            final simulation = HarvestSimulation.fromJson(item);
            simulations.add(simulation);
          } catch (e) {
            AppLogger.error(
              '[HarvestSimulationRemote] Failed to parse simulation item: $e',
            );
            // Continue with other items instead of failing completely
          }
        }

        AppLogger.info(
          '[HarvestSimulationRemote] Successfully parsed ${simulations.length} simulations',
        );
        return Right(simulations);
      } else {
        AppLogger.error(
          '[HarvestSimulationRemote] HTTP ${response.statusCode}: ${response.statusMessage}',
        );
        return Left(
          NetworkFailure.serverError(
            'Failed to load simulations: HTTP ${response.statusCode}',
          ),
        );
      }
    } on DioException catch (e) {
      AppLogger.error('[HarvestSimulationRemote] DioException: ${e.message}');

      // Handle different types of Dio errors
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const Left(
            NetworkFailure.serverError(
              'Request timeout - please check your connection',
            ),
          );
        case DioExceptionType.connectionError:
          return const Left(
            NetworkFailure.serverError(
              'Connection failed - please check your internet',
            ),
          );
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;
          final message = e.response?.data?['message'] as String?;
          return Left(
            NetworkFailure.serverError(
              message ?? 'Server error: HTTP $statusCode',
            ),
          );
        default:
          return Left(
            NetworkFailure.serverError(e.message ?? 'Network request failed'),
          );
      }
    } catch (e) {
      AppLogger.error('[HarvestSimulationRemote] Unexpected error: $e');
      return Left(NetworkFailure.serverError('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, HarvestSimulation>> getSimulationById(
    String id,
  ) async {
    try {
      // TODO: Implement API call to get simulation by ID
      return const Left(NetworkFailure.serverError('Simulation not found'));
    } catch (e) {
      return Left(NetworkFailure.serverError('Failed to load simulation: $e'));
    }
  }

  @override
  Future<Either<Failure, HarvestSimulation>> saveSimulation(
    HarvestSimulation simulation,
  ) async {
    try {
      AppLogger.debug(
        '[HarvestSimulationRemote] Saving simulation to API: ${simulation.id}',
      );

      final simulationJson = simulation.toJson();
      AppLogger.debug(
        '[HarvestSimulationRemote] Request payload: $simulationJson',
      );

      final response = await dio.post(
        '/api/v1/harvest-simulations',
        data: simulationJson,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      AppLogger.debug(
        '[HarvestSimulationRemote] Save API Response: ${response.statusCode}',
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = response.data;

        // Validate response structure
        if (responseData is! Map<String, dynamic>) {
          AppLogger.error(
            '[HarvestSimulationRemote] Invalid save response format: expected Map, got ${responseData.runtimeType}',
          );
          return const Left(
            NetworkFailure.serverError('Invalid response format from server'),
          );
        }

        final success = responseData['success'] as bool?;
        if (success != true) {
          final message = responseData['message'] as String? ?? 'Unknown error';
          AppLogger.warning(
            '[HarvestSimulationRemote] Save API returned success=false: $message',
          );
          return Left(NetworkFailure.serverError(message));
        }

        final data = responseData['data'];
        if (data == null) {
          AppLogger.warning(
            '[HarvestSimulationRemote] Save API returned null data',
          );
          return const Left(
            NetworkFailure.serverError('Server returned no data after save'),
          );
        }

        if (data is! Map<String, dynamic>) {
          AppLogger.error(
            '[HarvestSimulationRemote] Invalid save data format: expected Map, got ${data.runtimeType}',
          );
          return const Left(
            NetworkFailure.serverError('Invalid data format from server'),
          );
        }

        try {
          final savedSimulation = HarvestSimulation.fromJson(data);
          AppLogger.info(
            '[HarvestSimulationRemote] Successfully saved simulation: ${savedSimulation.id}',
          );
          return Right(savedSimulation);
        } catch (e, stackTrace) {
          AppLogger.error(
            '[HarvestSimulationRemote] Failed to parse saved simulation: $e',
          );
          return Left(
            NetworkFailure.serverError('Failed to parse server response: $e'),
          );
        }
      } else {
        AppLogger.error(
          '[HarvestSimulationRemote] Save HTTP ${response.statusCode}: ${response.statusMessage}',
        );
        return Left(
          NetworkFailure.serverError(
            'Failed to save simulation: HTTP ${response.statusCode}',
          ),
        );
      }
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        '[HarvestSimulationRemote] Save DioException: ${e.message}',
      );

      // Handle different types of Dio errors
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const Left(
            NetworkFailure.serverError(
              'Request timeout - please check your connection',
            ),
          );
        case DioExceptionType.connectionError:
          return const Left(
            NetworkFailure.serverError(
              'Connection failed - please check your internet',
            ),
          );
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;
          final message = e.response?.data?['message'] as String?;
          if (statusCode == 409) {
            return const Left(
              NetworkFailure.serverError('Simulation already exists'),
            );
          } else if (statusCode == 422) {
            return Left(
              NetworkFailure.serverError(message ?? 'Invalid simulation data'),
            );
          }
          return Left(
            NetworkFailure.serverError(
              message ?? 'Server error: HTTP $statusCode',
            ),
          );
        default:
          return Left(
            NetworkFailure.serverError(e.message ?? 'Network request failed'),
          );
      }
    } catch (e, stackTrace) {
      AppLogger.error('[HarvestSimulationRemote] Save unexpected error: $e');
      return Left(NetworkFailure.serverError('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, HarvestSimulation>> updateSimulation(
    HarvestSimulation simulation,
  ) async {
    try {
      // TODO: Implement API call to update simulation
      return Right(simulation);
    } catch (e) {
      return Left(
        NetworkFailure.serverError('Failed to update simulation: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteSimulation(String id) async {
    try {
      // TODO: Implement API call to delete simulation
      return const Right(null);
    } catch (e) {
      return Left(
        NetworkFailure.serverError('Failed to delete simulation: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<RegisteredPond>>> getRegisteredPonds() async {
    try {
      AppLogger.debug(
        '[HarvestSimulationRemote] Fetching registered ponds from API',
      );

      final response = await dio.get(
        '/api/v1/ponds',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      AppLogger.debug(
        '[HarvestSimulationRemote] Ponds API Response: ${response.statusCode}',
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        // Validate response structure
        if (responseData is! Map<String, dynamic>) {
          AppLogger.error(
            '[HarvestSimulationRemote] Invalid ponds response format: expected Map, got ${responseData.runtimeType}',
          );
          return const Left(
            NetworkFailure.serverError('Invalid response format from server'),
          );
        }

        final success = responseData['success'] as bool?;
        if (success != true) {
          final message = responseData['message'] as String? ?? 'Unknown error';
          AppLogger.warning(
            '[HarvestSimulationRemote] Ponds API returned success=false: $message',
          );
          return Left(NetworkFailure.serverError(message));
        }

        final data = responseData['data'];
        if (data == null) {
          AppLogger.warning(
            '[HarvestSimulationRemote] Ponds API returned null data',
          );
          return const Right([]); // Empty list is valid
        }

        if (data is! List) {
          AppLogger.error(
            '[HarvestSimulationRemote] Invalid ponds data format: expected List, got ${data.runtimeType}',
          );
          return const Left(
            NetworkFailure.serverError('Invalid data format from server'),
          );
        }

        final ponds = <RegisteredPond>[];
        for (final item in data) {
          try {
            if (item is! Map<String, dynamic>) {
              AppLogger.warning(
                '[HarvestSimulationRemote] Skipping invalid pond item: ${item.runtimeType}',
              );
              continue;
            }

            final pond = RegisteredPond.fromJson(item);
            ponds.add(pond);
          } catch (e) {
            AppLogger.error(
              '[HarvestSimulationRemote] Failed to parse pond item: $e',
            );
            // Continue with other items instead of failing completely
          }
        }

        AppLogger.info(
          '[HarvestSimulationRemote] Successfully parsed ${ponds.length} ponds',
        );
        return Right(ponds);
      } else {
        AppLogger.error(
          '[HarvestSimulationRemote] Ponds HTTP ${response.statusCode}: ${response.statusMessage}',
        );
        return Left(
          NetworkFailure.serverError(
            'Failed to load ponds: HTTP ${response.statusCode}',
          ),
        );
      }
    } on DioException catch (e) {
      AppLogger.error(
        '[HarvestSimulationRemote] Ponds DioException: ${e.message}',
      );

      // Handle different types of Dio errors
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const Left(
            NetworkFailure.serverError(
              'Request timeout - please check your connection',
            ),
          );
        case DioExceptionType.connectionError:
          return const Left(
            NetworkFailure.serverError(
              'Connection failed - please check your internet',
            ),
          );
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;
          final message = e.response?.data?['message'] as String?;
          return Left(
            NetworkFailure.serverError(
              message ?? 'Server error: HTTP $statusCode',
            ),
          );
        default:
          return Left(
            NetworkFailure.serverError(e.message ?? 'Network request failed'),
          );
      }
    } catch (e, stackTrace) {
      AppLogger.error('[HarvestSimulationRemote] Ponds unexpected error: $e');
      return Left(NetworkFailure.serverError('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, SimulationResults>> calculateSimulationResults({
    required String commodity,
    required String cultivationSystem,
    required double pondArea,
    required double targetHarvest,
    required double estimatedADG,
    required int targetDOC,
    required double targetSR,
    required double estimatedFCR,
    required double targetBiomass,
    required double sellingPrice,
    required double feedPrice,
    required String cycleType,
    double? currentDOC,
  }) async {
    try {
      // TODO: Implement API call for calculation
      return const Left(
        NetworkFailure.serverError('Calculation not implemented'),
      );
    } catch (e) {
      return Left(
        NetworkFailure.serverError('Failed to calculate results: $e'),
      );
    }
  }
}
