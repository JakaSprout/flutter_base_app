import 'package:dartz/dartz.dart';
import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/harvest_simulation.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/repositories/harvest_simulation_repository.dart';

/// Use case for getting all saved harvest simulations.
class GetSavedSimulationsUseCase {
  /// Creates a new instance of [GetSavedSimulationsUseCase].
  const GetSavedSimulationsUseCase(this.repository);

  /// The repository used to interact with harvest simulation data.
  final HarvestSimulationRepository repository;

  /// Executes the use case.
  ///
  /// Returns a [Future] that completes with either:
  /// - [Right] containing a list of [HarvestSimulation] entities
  /// - [Left] containing a [Failure] if the operation fails
  Future<Either<Failure, List<HarvestSimulation>>> call() {
    return repository.getSavedSimulations();
  }
}
