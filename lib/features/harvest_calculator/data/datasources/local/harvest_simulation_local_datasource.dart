import 'package:app_mobile_afms/core/database/app_database.dart';
import 'package:app_mobile_afms/core/error/failures.dart';
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
  Future<Either<Failure, List<PondOption>>> getPondOptions({String? farmId});
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
          name: pond.pondName ?? pond.pondCode,
          area: pond.pondSize ?? 0.0,
          location: pond.pondCode, // Use pond code as location identifier
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
  }) async {
    try {
      final pondsResult = await getRegisteredPonds();
      return pondsResult.fold(Left.new, (ponds) {
        var filteredPonds = ponds;

        // Filter by farm ID if provided
        // Note: RegisteredPond doesn't have farmId field, so farm filtering is not implemented yet
        // TODO: Add farm filtering when RegisteredPond includes farmId
        if (farmId != null) {
          // For now, don't filter - return all ponds
          filteredPonds = ponds;
        }

        final pondOptions = filteredPonds.map((pond) {
          return PondOption(
            id: pond.id,
            name: pond.name,
            areaSqm: pond.area,
            code:
                '', // PondOption code is optional, RegisteredPond doesn't have code
            status:
                'Available', // Default status since RegisteredPond doesn't have status
            farmId: '', // Will be filtered by farmId parameter if needed
          );
        }).toList();

        // Sort by name
        pondOptions.sort((a, b) => a.name.compareTo(b.name));

        return Right(pondOptions);
      });
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get pond options: $e'));
    }
  }
}
