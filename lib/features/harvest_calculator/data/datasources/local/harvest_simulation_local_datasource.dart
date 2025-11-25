import 'package:app_mobile_afms/core/database/app_database.dart';
import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/harvest_simulation.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/registered_pond.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/pond_option.dart';
import 'package:dartz/dartz.dart';

/// Abstract interface for local harvest simulation data operations.
abstract class HarvestSimulationLocalDatasource {
  /// Gets all saved harvest simulations from local database.
  Future<Either<Failure, List<HarvestSimulation>>> getSavedSimulations();

  /// Gets a specific simulation by ID.
  Future<Either<Failure, HarvestSimulation?>> getSimulationById(String id);

  /// Saves a harvest simulation to local database.
  Future<Either<Failure, HarvestSimulation>> saveSimulation(
    HarvestSimulation simulation,
  );

  /// Updates an existing simulation in local database.
  Future<Either<Failure, HarvestSimulation>> updateSimulation(
    HarvestSimulation simulation,
  );

  /// Deletes a simulation from local database.
  Future<Either<Failure, void>> deleteSimulation(String id);

  /// Gets registered ponds from local database.
  Future<Either<Failure, List<RegisteredPond>>> getRegisteredPonds();

  /// Saves ponds to local database.
  Future<Either<Failure, int>> savePonds(List<RegisteredPond> ponds);

  /// Gets ponds as PondOption list for UI.
  Future<Either<Failure, List<PondOption>>> getPondOptions({
    String? farmId,
    String? farmName,
  });
}

/// Implementation of [HarvestSimulationLocalDatasource] using Drift database.
class HarvestSimulationLocalDatasourceImpl
    implements HarvestSimulationLocalDatasource {
  /// Creates a new instance of [HarvestSimulationLocalDatasourceImpl].
  const HarvestSimulationLocalDatasourceImpl({required this.database});

  /// The database instance.
  final AppDatabase database;

  @override
  Future<Either<Failure, List<HarvestSimulation>>> getSavedSimulations() async {
    try {
      // TODO: Implement when harvest simulation tables are fully implemented
      // For now, return empty list
      return const Right([]);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get saved simulations: $e'));
    }
  }

  @override
  Future<Either<Failure, HarvestSimulation?>> getSimulationById(
    String id,
  ) async {
    try {
      // TODO: Implement when harvest simulation tables are fully implemented
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get simulation by ID: $e'));
    }
  }

  @override
  Future<Either<Failure, HarvestSimulation>> saveSimulation(
    HarvestSimulation simulation,
  ) async {
    try {
      // TODO: Implement when harvest simulation tables are fully implemented
      return Right(simulation);
    } catch (e) {
      return Left(CacheFailure.writeError('Failed to save simulation: $e'));
    }
  }

  @override
  Future<Either<Failure, HarvestSimulation>> updateSimulation(
    HarvestSimulation simulation,
  ) async {
    try {
      // TODO: Implement when harvest simulation tables are fully implemented
      return Right(simulation);
    } catch (e) {
      return Left(CacheFailure.writeError('Failed to update simulation: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSimulation(String id) async {
    try {
      // TODO: Implement when harvest simulation tables are fully implemented
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure.writeError('Failed to delete simulation: $e'));
    }
  }

  @override
  Future<Either<Failure, List<RegisteredPond>>> getRegisteredPonds() async {
    try {
      // Get ponds from fms_mt_ponds table
      final ponds = await database.select(database.fmsMtPonds).get();

      final registeredPonds = ponds.map((pond) {
        return RegisteredPond(
          id: pond.pondId.toString(),
          name: pond.pondName ?? pond.pondCode ?? '',
          area: pond.pondSize ?? 0.0,
          location: pond.pondCode ?? '', // Use pond code as location identifier
          registeredAt: pond.createdDate ?? DateTime.now(),
        );
      }).toList();

      return Right(registeredPonds);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get registered ponds: $e'));
    }
  }

  @override
  Future<Either<Failure, int>> savePonds(List<RegisteredPond> ponds) async {
    try {
      // Note: We're not saving ponds here as they come from reference data seeding
      // This method is for future use if we need to save ponds from API
      await database.batch((batch) {
        // Empty batch - no actual saving implemented yet
      });
      return Right(ponds.length);
    } catch (e) {
      return Left(CacheFailure.writeError('Failed to save ponds: $e'));
    }
  }

  @override
  Future<Either<Failure, List<PondOption>>> getPondOptions({
    String? farmId,
    String? farmName,
  }) async {
    try {
      AppLogger.debug(
        '[HarvestSimulationLocal] ===== GET POND OPTIONS DEBUG =====',
      );
      AppLogger.debug('[HarvestSimulationLocal] 1. Received farmId: "$farmId"');
      AppLogger.debug(
        '[HarvestSimulationLocal] 2. Received farmName: "$farmName"',
      );
      AppLogger.debug(
        '[HarvestSimulationLocal] 3. farmId is null: ${farmId == null}',
      );
      AppLogger.debug(
        '[HarvestSimulationLocal] 4. farmId is empty: ${farmId?.isEmpty ?? true}',
      );
      AppLogger.debug(
        '[HarvestSimulationLocal] =================================',
      );

      // If farmId is provided as UUID, filter ponds directly by farm_uuid
      if (farmId != null && farmId.isNotEmpty) {
        AppLogger.debug(
          '[HarvestSimulationLocal] Checking if farmId is UUID: "$farmId" (length: ${farmId.length})',
        );

        // Check if farmId looks like a UUID (standard UUID format: 8-4-4-4-12)
        final uuidRegex = RegExp(
          r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
        );
        final isUuid = uuidRegex.hasMatch(farmId.toLowerCase());

        AppLogger.debug(
          '[HarvestSimulationLocal] UUID detection result: $isUuid for farmId: "$farmId"',
        );

        if (isUuid) {
          AppLogger.debug(
            '[HarvestSimulationLocal] Filtering ponds by farm UUID: "$farmId"',
          );
          // Direct filter ponds by farm_uuid
          final filteredPonds = await (database.select(
            database.fmsMtPonds,
          )..where((p) => p.farmUuid.equals(farmId))).get();

          final pondOptions = filteredPonds.map((pond) {
            return PondOption(
              id: pond.pondId.toString(),
              name: pond.pondName ?? pond.pondCode ?? '',
              areaSqm: pond.pondSize ?? 0.0,
              code: pond.pondCode ?? '',
              status: pond.pondStatus ?? 'Available',
              farmId: farmId, // Use the farm UUID as farmId
            );
          }).toList();

          // Sort by name
          pondOptions.sort((a, b) => a.name.compareTo(b.name));

          AppLogger.debug(
            '[HarvestSimulationLocal] Returning ${pondOptions.length} ponds filtered by UUID',
          );
          return Right(pondOptions);
        } else {
          // Not a UUID, try fallback methods
          AppLogger.debug(
            '[HarvestSimulationLocal] farmId "$farmId" is not a UUID, trying fallback',
          );
        }
      }

      // Fallback: If farmId is provided (as integer string), try to filter by farm_id
      if (farmId != null) {
        final farmIdInt = int.tryParse(farmId);
        if (farmIdInt != null) {
          AppLogger.debug(
            '[HarvestSimulationLocal] Fallback: Filtering ponds by farmId: $farmId (int: $farmIdInt)',
          );

          // Get farm_uuid from the selected farm_id
          final selectedFarm = await (database.select(
            database.fmsMtFarms,
          )..where((f) => f.farmId.equals(farmIdInt))).getSingleOrNull();

          AppLogger.debug(
            '[HarvestSimulationLocal] Fallback farm lookup found: ${selectedFarm != null}',
          );

          if (selectedFarm != null) {
            // Filter ponds by farm_uuid
            final filteredPonds = await (database.select(
              database.fmsMtPonds,
            )..where((p) => p.farmUuid.equals(selectedFarm.farmUuid))).get();

            final pondOptions = filteredPonds.map((pond) {
              return PondOption(
                id: pond.pondId.toString(),
                name: pond.pondName ?? pond.pondCode ?? '',
                areaSqm: pond.pondSize ?? 0.0,
                code: pond.pondCode ?? '',
                status: pond.pondStatus ?? 'Available',
                farmId: selectedFarm.farmId.toString(),
              );
            }).toList();

            // Sort by name
            pondOptions.sort((a, b) => a.name.compareTo(b.name));

            return Right(pondOptions);
          } else {
            // Farm not found, return empty list
            AppLogger.debug(
              '[HarvestSimulationLocal] Fallback farm not found, returning empty list',
            );
            return const Right([]);
          }
        }
      }
      final allPonds = await database.select(database.fmsMtPonds).get();

      if (allPonds.isEmpty) {
        // Debug: Check if database is initialized
        AppLogger.debug(
          '[HarvestSimulationLocal] No ponds found - checking database initialization',
        );

        // Check if farms exist
        final farmCount =
            (await database.select(database.fmsMtFarms).get()).length;
        AppLogger.debug(
          '[HarvestSimulationLocal] Farm count in database: $farmCount',
        );

        // Check if other tables have data
        try {
          final employeeCount =
              (await database.select(database.fmsMtEmployees).get()).length;
          AppLogger.debug(
            '[HarvestSimulationLocal] Employee count in database: $employeeCount',
          );
        } catch (e) {
          AppLogger.debug(
            '[HarvestSimulationLocal] Error checking employees: $e',
          );
        }
      } else {
        // Show sample ponds
        AppLogger.debug('[HarvestSimulationLocal] Sample ponds:');
        for (var i = 0; i < allPonds.length && i < 3; i++) {
          final pond = allPonds[i];
          AppLogger.debug(
            '  Pond ID: ${pond.pondId}, UUID: ${pond.pondUuid}, Code: ${pond.pondCode}, Name: ${pond.pondName}, FarmUUID: ${pond.farmUuid}',
          );
        }
      }

      final pondOptions = allPonds.map((pond) {
        return PondOption(
          id: pond.pondId.toString(),
          name: pond.pondName ?? pond.pondCode ?? '',
          areaSqm: pond.pondSize ?? 0.0,
          code: pond.pondCode ?? '',
          status: pond.pondStatus ?? 'Available',
          farmId: '', // No farm filtering applied
        );
      }).toList();
      return Right(pondOptions);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get pond options: $e'));
    }
  }
}
