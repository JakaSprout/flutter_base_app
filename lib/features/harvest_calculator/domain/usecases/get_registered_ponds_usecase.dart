import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/registered_pond.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/repositories/harvest_simulation_repository.dart';
import 'package:dartz/dartz.dart';

/// Use case for getting all registered ponds.
class GetRegisteredPondsUseCase {
  /// Creates a new instance of [GetRegisteredPondsUseCase].
  const GetRegisteredPondsUseCase(this.repository);

  /// The repository used to interact with registered pond data.
  final HarvestSimulationRepository repository;

  /// Executes the use case.
  ///
  /// Returns a [Future] that completes with either:
  /// - [Right] containing a list of [RegisteredPond] entities
  /// - [Left] containing a [Failure] if the operation fails
  Future<Either<Failure, List<RegisteredPond>>> call() {
    // Note: This should use RegisteredPondRepository, but for now using the main repo
    // TODO: Create separate RegisteredPondRepository when needed
    throw UnimplementedError('RegisteredPondRepository not implemented yet');
  }
}
