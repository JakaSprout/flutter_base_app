import 'package:flutter_base_app/features/harvest_calculator/data/repositories/harvest_simulation_repository_impl.dart';
import 'package:flutter_base_app/features/harvest_calculator/domain/repositories/harvest_simulation_repository.dart';
import 'package:flutter_base_app/features/harvest_calculator/domain/usecases/calculate_simulation_results_usecase.dart';
import 'package:flutter_base_app/features/harvest_calculator/domain/usecases/get_saved_simulations_usecase.dart';
import 'package:flutter_base_app/features/harvest_calculator/domain/usecases/save_simulation_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'harvest_simulation_providers.g.dart';

/// Repository provider for harvest simulation operations.
@riverpod
HarvestSimulationRepository harvestSimulationRepository(
  HarvestSimulationRepositoryRef ref,
) {
  return const HarvestSimulationRepositoryImpl();
}

/// Use case provider for getting saved simulations.
@riverpod
GetSavedSimulationsUseCase getSavedSimulationsUseCase(
  GetSavedSimulationsUseCaseRef ref,
) {
  final repository = ref.watch(harvestSimulationRepositoryProvider);
  return GetSavedSimulationsUseCase(repository);
}

/// Use case provider for saving simulations.
@riverpod
SaveSimulationUseCase saveSimulationUseCase(SaveSimulationUseCaseRef ref) {
  final repository = ref.watch(harvestSimulationRepositoryProvider);
  return SaveSimulationUseCase(repository);
}

/// Use case provider for calculating simulation results.
@riverpod
CalculateSimulationResultsUseCase calculateSimulationResultsUseCase(
  CalculateSimulationResultsUseCaseRef ref,
) {
  final repository = ref.watch(harvestSimulationRepositoryProvider);
  return CalculateSimulationResultsUseCase(repository);
}
