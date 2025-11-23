import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/harvest_simulation.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/repositories/harvest_simulation_repository.dart';
import 'package:dartz/dartz.dart';

/// Use case for calculating harvest simulation results.
class CalculateSimulationResultsUseCase {
  /// Creates a new instance of [CalculateSimulationResultsUseCase].
  const CalculateSimulationResultsUseCase(this.repository);

  /// The repository used to interact with harvest simulation data.
  final HarvestSimulationRepository repository;

  /// Executes the use case.
  ///
  /// [commodity] - The commodity type (e.g., 'Udang', 'Tilapia').
  /// [cultivationSystem] - The cultivation system (e.g., 'RAS', 'Biofloc').
  /// [pondArea] - The pond area in square meters.
  /// [targetHarvest] - The target harvest amount.
  /// [estimatedADG] - The estimated Average Daily Gain.
  /// [targetDOC] - The target Days of Culture.
  /// [targetSR] - The target Survival Rate.
  /// [estimatedFCR] - The estimated Feed Conversion Ratio.
  /// [targetBiomass] - The target biomass.
  /// [sellingPrice] - The selling price per unit.
  /// [feedPrice] - The feed price per unit.
  /// [cycleType] - The cycle type ('Full Cycle' or 'Mid Cycle').
  /// [currentDOC] - The current Days of Culture (for mid cycle).
  ///
  /// Returns a [Future] that completes with either:
  /// - [Right] containing the calculated [SimulationResults]
  /// - [Left] containing a [Failure] if the operation fails
  Future<Either<Failure, SimulationResults>> call({
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
  }) {
    return repository.calculateSimulationResults(
      commodity: commodity,
      cultivationSystem: cultivationSystem,
      pondArea: pondArea,
      targetHarvest: targetHarvest,
      estimatedADG: estimatedADG,
      targetDOC: targetDOC,
      targetSR: targetSR,
      estimatedFCR: estimatedFCR,
      targetBiomass: targetBiomass,
      sellingPrice: sellingPrice,
      feedPrice: feedPrice,
      cycleType: cycleType,
      currentDOC: currentDOC,
    );
  }
}
