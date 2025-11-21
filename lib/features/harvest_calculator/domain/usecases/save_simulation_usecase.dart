import 'package:dartz/dartz.dart';
import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/harvest_simulation.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/repositories/harvest_simulation_repository.dart';

/// Use case for saving a harvest simulation.
class SaveSimulationUseCase {
  /// Creates a new instance of [SaveSimulationUseCase].
  const SaveSimulationUseCase(this.repository);

  /// The repository used to interact with harvest simulation data.
  final HarvestSimulationRepository repository;

  /// Executes the use case.
  ///
  /// [simulation] - The harvest simulation to save.
  ///
  /// Returns a [Future] that completes with either:
  /// - [Right] containing the saved [HarvestSimulation] entity
  /// - [Left] containing a [Failure] if the operation fails
  Future<Either<Failure, HarvestSimulation>> call(
    HarvestSimulation simulation,
  ) {
    return repository.saveSimulation(simulation);
  }
}
