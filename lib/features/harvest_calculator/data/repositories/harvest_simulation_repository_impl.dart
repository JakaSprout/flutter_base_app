import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:app_mobile_afms/features/harvest_calculator/data/datasources/local/harvest_simulation_local_datasource.dart';
import 'package:app_mobile_afms/features/harvest_calculator/data/datasources/remote/harvest_simulation_remote_datasource.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/harvest_simulation.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/repositories/harvest_simulation_repository.dart';
import 'package:dartz/dartz.dart';

/// Implementation of [HarvestSimulationRepository].
///
/// Uses offline-first strategy: Local DB as primary, API for sync/calculation.
class HarvestSimulationRepositoryImpl implements HarvestSimulationRepository {
  /// Creates a new instance of [HarvestSimulationRepositoryImpl].
  const HarvestSimulationRepositoryImpl({
    required this.localDatasource,
    required this.remoteDatasource,
  });

  /// Local data source for offline operations.
  final HarvestSimulationLocalDatasource localDatasource;

  /// Remote data source for API operations.
  final HarvestSimulationRemoteDatasource remoteDatasource;

  @override
  Future<Either<Failure, List<HarvestSimulation>>> getSavedSimulations() async {
    try {
      // API First strategy like Home Page: try API first, fallback to local DB
      AppLogger.debug('[HarvestSimulationRepo] Fetching saved simulations - API first strategy');

      final remoteResult = await remoteDatasource.getSavedSimulations();
      return remoteResult.fold(
        (failure) {
          // API failed, fallback to local DB
          AppLogger.debug('[HarvestSimulationRepo] API failed, falling back to local DB: $failure');
          return localDatasource.getSavedSimulations();
        },
        (simulations) {
          // API success, save to local DB (fire and forget) and return API data
          AppLogger.debug('[HarvestSimulationRepo] API success, saving to local DB and returning fresh data');
          _saveSimulationsToLocalDb(simulations); // Background save
          return Right(simulations);
        },
      );
    } catch (e) {
      AppLogger.error('[HarvestSimulationRepo] Unexpected error in getSavedSimulations: $e');
      return const Left(
        NetworkFailure.serverError('Failed to load saved simulations'),
      );
    }
  }

  /// Saves simulations to local DB in background (fire and forget).
  Future<void> _saveSimulationsToLocalDb(List<HarvestSimulation> simulations) async {
    try {
      for (final simulation in simulations) {
        await localDatasource.saveSimulation(simulation);
      }
      AppLogger.debug('[HarvestSimulationRepo] Successfully saved ${simulations.length} simulations to local DB');
    } catch (e) {
      // Don't fail the main operation if local save fails
      AppLogger.warning('[HarvestSimulationRepo] Failed to save simulations to local DB: $e');
    }
  }

  @override
  Future<Either<Failure, HarvestSimulation>> getSimulationById(
    String id,
  ) async {
    try {
      // TODO: Implement actual data fetching
      return const Left(NetworkFailure.serverError('Simulation not found'));
    } catch (e) {
      return const Left(
        NetworkFailure.serverError('Failed to load simulation'),
      );
    }
  }

  @override
  Future<Either<Failure, HarvestSimulation>> saveSimulation(
    HarvestSimulation simulation,
  ) async {
    try {
      // Save to local DB first (immediate response)
      final localResult = await localDatasource.saveSimulation(simulation);
      return localResult.fold(
        (failure) => Left(failure),
        (savedSimulation) {
          // Sync to API in background (fire and forget)
          _syncSimulationToApi(savedSimulation);
          return Right(savedSimulation);
        },
      );
    } catch (e) {
      return const Left(
        NetworkFailure.serverError('Failed to save simulation'),
      );
    }
  }

  /// Syncs simulation to API in background (fire and forget).
  Future<void> _syncSimulationToApi(HarvestSimulation simulation) async {
    try {
      await remoteDatasource.saveSimulation(simulation);
      // TODO: Update local sync status when API sync succeeds
    } catch (e) {
      // API sync failed, will retry on next app launch
      // TODO: Mark simulation as needing sync
    }
  }

  @override
  Future<Either<Failure, HarvestSimulation>> updateSimulation(
    HarvestSimulation simulation,
  ) async {
    try {
      // TODO: Implement actual data updating
      return Right(simulation);
    } catch (e) {
      return const Left(
        NetworkFailure.serverError('Failed to update simulation'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteSimulation(String id) async {
    try {
      // TODO: Implement actual data deletion
      return const Right(null);
    } catch (e) {
      return const Left(
        NetworkFailure.serverError('Failed to delete simulation'),
      );
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
      // TODO: Implement actual calculation logic
      // This should call a calculation service or external API
      return const Left(
        NetworkFailure.serverError('Calculation not implemented yet'),
      );
    } catch (e) {
      return const Left(
        NetworkFailure.serverError('Failed to calculate simulation results'),
      );
    }
  }
}
