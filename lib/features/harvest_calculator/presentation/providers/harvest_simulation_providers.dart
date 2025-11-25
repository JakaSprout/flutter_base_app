import 'package:app_mobile_afms/core/di/providers/database_provider.dart';
import 'package:app_mobile_afms/core/di/providers/dio_provider.dart';
import 'package:app_mobile_afms/features/harvest_calculator/data/datasources/local/harvest_simulation_local_datasource.dart';
import 'package:app_mobile_afms/features/harvest_calculator/data/datasources/remote/harvest_simulation_remote_datasource.dart';
import 'package:app_mobile_afms/features/harvest_calculator/data/repositories/harvest_simulation_repository_impl.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/repositories/harvest_simulation_repository.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/usecases/calculate_simulation_results_usecase.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/usecases/get_saved_simulations_usecase.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/usecases/save_simulation_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'harvest_simulation_providers.g.dart';

/// Local datasource provider for harvest simulation operations.
@riverpod
HarvestSimulationLocalDatasource harvestSimulationLocalDatasource(
  HarvestSimulationLocalDatasourceRef ref,
) {
  final database = ref.watch(databaseProvider);
  return HarvestSimulationLocalDatasourceImpl(database: database);
}

/// Remote datasource provider for harvest simulation operations.
@riverpod
HarvestSimulationRemoteDatasource harvestSimulationRemoteDatasource(
  HarvestSimulationRemoteDatasourceRef ref,
) {
  final dio = ref.watch(dioProvider);
  return HarvestSimulationRemoteDatasourceImpl(dio: dio);
}

/// Repository provider for harvest simulation operations.
@riverpod
HarvestSimulationRepository harvestSimulationRepository(
  HarvestSimulationRepositoryRef ref,
) {
  final localDatasource = ref.watch(harvestSimulationLocalDatasourceProvider);
  final remoteDatasource = ref.watch(harvestSimulationRemoteDatasourceProvider);
  return HarvestSimulationRepositoryImpl(
    localDatasource: localDatasource,
    remoteDatasource: remoteDatasource,
  );
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
