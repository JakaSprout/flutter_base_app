import 'package:dartz/dartz.dart';
import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/harvest_simulation.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/registered_pond.dart';

/// Repository interface for harvest simulation operations.
abstract class HarvestSimulationRepository {
  /// Gets all saved harvest simulations.
  Future<Either<Failure, List<HarvestSimulation>>> getSavedSimulations();

  /// Gets a specific harvest simulation by ID.
  Future<Either<Failure, HarvestSimulation>> getSimulationById(String id);

  /// Saves a new harvest simulation.
  Future<Either<Failure, HarvestSimulation>> saveSimulation(
    HarvestSimulation simulation,
  );

  /// Updates an existing harvest simulation.
  Future<Either<Failure, HarvestSimulation>> updateSimulation(
    HarvestSimulation simulation,
  );

  /// Deletes a harvest simulation by ID.
  Future<Either<Failure, void>> deleteSimulation(String id);

  /// Calculates simulation results based on input parameters.
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

/// Repository interface for registered pond operations.
abstract class RegisteredPondRepository {
  /// Gets all registered ponds.
  Future<Either<Failure, List<RegisteredPond>>> getRegisteredPonds();

  /// Gets registered ponds by search query.
  Future<Either<Failure, List<RegisteredPond>>> searchRegisteredPonds(
    String query,
  );

  /// Gets a specific registered pond by ID.
  Future<Either<Failure, RegisteredPond>> getRegisteredPondById(String id);
}
