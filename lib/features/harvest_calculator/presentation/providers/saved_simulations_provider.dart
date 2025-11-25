import 'package:app_mobile_afms/core/di/providers/connectivity_provider.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:app_mobile_afms/features/harvest_calculator/data/datasources/local/harvest_simulation_local_datasource.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/harvest_simulation.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/providers/harvest_simulation_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'saved_simulations_provider.g.dart';

/// State provider for managing saved harvest simulations.
/// Uses API-first strategy like home page when online.
@riverpod
class SavedSimulations extends _$SavedSimulations {
  @override
  FutureOr<List<HarvestSimulation>> build() async {
    final useCase = ref.watch(getSavedSimulationsUseCaseProvider);
    final result = await useCase();

    return result.fold((failure) {
      // Throw exception to trigger AsyncError state in Riverpod
      // This allows UI to properly handle and display error states
      throw Exception('Failed to load saved simulations: ${failure.message}');
    }, (simulations) => simulations);
  }

  /// Refreshes the saved simulations list.
  Future<void> refresh() async {
    ref.invalidateSelf();
  }

  /// Adds a new simulation to the saved list.
  ///
  /// Throws an exception if the save operation fails, allowing
  /// callers to handle the error appropriately (e.g., show snackbar).
  Future<void> addSimulation(HarvestSimulation simulation) async {
    final useCase = ref.read(saveSimulationUseCaseProvider);
    final result = await useCase(simulation);

    result.fold(
      (failure) {
        // Throw exception to allow proper error handling by callers
        throw Exception('Failed to save simulation: ${failure.message}');
      },
      (savedSimulation) {
        // Refresh the list to include the new simulation
        ref.invalidateSelf();
      },
    );
  }
}

/// Provider that fetches saved simulations with API-first strategy.
/// Similar to farmListData in home page: API first when online, local DB fallback.
@riverpod
Future<List<HarvestSimulation>> savedSimulationsData(
  SavedSimulationsDataRef ref,
) async {
  AppLogger.debug(
    '[SavedSimulationsData] Starting saved simulations data provider',
  );

  // Try API first, fallback to local DB if offline or API fails
  final apiResult = await _tryFetchSimulationsFromApi(ref);

  // If API fails (returns empty data), try local DB as fallback
  if (apiResult.isEmpty) {
    AppLogger.debug(
      '[SavedSimulationsData] API returned empty data, trying local DB as fallback',
    );
    return _tryFetchSimulationsFromLocalDb(ref);
  }

  // API succeeded, return API data (and save to DB in background if needed)
  AppLogger.debug(
    '[SavedSimulationsData] API succeeded, returning data: ${apiResult.length} simulations',
  );
  return apiResult;
}

/// Try to fetch simulations from API if online, return empty if offline.
Future<List<HarvestSimulation>> _tryFetchSimulationsFromApi(
  SavedSimulationsDataRef ref,
) async {
  AppLogger.debug(
    '[SavedSimulationsData] Starting _tryFetchSimulationsFromApi',
  );

  try {
    // Check connectivity using sync provider
    var isOnline = false;
    try {
      AppLogger.debug('[SavedSimulationsData] Checking connectivity status');
      final connectivitySync = ref.read(connectivityStatusSyncProvider);
      if (connectivitySync != null) {
        isOnline = connectivitySync.isConnected;
        AppLogger.debug(
          '[SavedSimulationsData] Sync connectivity status: ${connectivitySync.status}, isOnline=$isOnline',
        );
      } else {
        AppLogger.debug(
          '[SavedSimulationsData] Sync connectivity status is null, trying direct check',
        );
        // Fallback to direct connectivity check
        final connectivityService = ref.read(connectivityServiceProvider);
        final directResult = await connectivityService.checkConnectivity();
        isOnline = directResult.isConnected;
        AppLogger.debug(
          '[SavedSimulationsData] Direct connectivity check: ${directResult.status}, isOnline=$isOnline',
        );
      }
    } catch (e) {
      // Connectivity check failed, assume offline
      AppLogger.debug(
        '[SavedSimulationsData] Connectivity check failed, assuming offline: $e',
      );
      isOnline = false;
    }

    if (!isOnline) {
      // Offline: return empty data (will trigger local DB fallback)
      AppLogger.warning(
        '[SavedSimulationsData] Device appears offline, cannot fetch from API',
      );
      return [];
    }

    // Online: try to fetch from API
    AppLogger.debug(
      '[SavedSimulationsData] Device appears online, fetching from API',
    );
    final remoteDatasource = ref.read(
      harvestSimulationRemoteDatasourceProvider,
    );
    final apiResult = await remoteDatasource.getSavedSimulations();

    return apiResult.fold(
      (failure) {
        // API failed: return empty data
        AppLogger.warning('[SavedSimulationsData] API failed: $failure');
        return [];
      },
      (simulations) {
        if (simulations.isNotEmpty) {
          // Save to local DB (fire and forget)
          final localDatasource = ref.read(
            harvestSimulationLocalDatasourceProvider,
          );
          _saveSimulationsToLocalDb(
            localDatasource,
            simulations,
          ); // Don't await

          AppLogger.debug(
            '[SavedSimulationsData] Returning API data: ${simulations.length} simulations',
          );
          return simulations;
        } else {
          // API returned empty data
          AppLogger.debug('[SavedSimulationsData] API returned empty data');
          return [];
        }
      },
    );
  } catch (e) {
    // Any error: return empty data
    AppLogger.error(
      '[SavedSimulationsData] Unexpected error in _tryFetchFromApi: $e',
    );
    return [];
  }
}

/// Try to fetch simulations from local DB as fallback when API fails.
Future<List<HarvestSimulation>> _tryFetchSimulationsFromLocalDb(
  SavedSimulationsDataRef ref,
) async {
  AppLogger.debug(
    '[SavedSimulationsData] Starting _tryFetchSimulationsFromLocalDb fallback',
  );

  try {
    final localDatasource = ref.read(harvestSimulationLocalDatasourceProvider);
    final result = await localDatasource.getSavedSimulations();

    return result.fold(
      (failure) {
        AppLogger.error(
          '[SavedSimulationsData] Local DB fallback also failed: $failure',
        );
        return [];
      },
      (simulations) {
        AppLogger.debug(
          '[SavedSimulationsData] Local DB fallback returned ${simulations.length} simulations',
        );
        return simulations;
      },
    );
  } catch (e) {
    AppLogger.error(
      '[SavedSimulationsData] Error accessing local DB fallback: $e',
    );
    return [];
  }
}

/// Saves simulations to local DB in background (fire and forget).
Future<void> _saveSimulationsToLocalDb(
  HarvestSimulationLocalDatasource localDatasource,
  List<HarvestSimulation> simulations,
) async {
  try {
    for (final simulation in simulations) {
      await localDatasource.saveSimulation(simulation);
    }
    AppLogger.debug(
      '[SavedSimulationsData] Successfully saved ${simulations.length} simulations to local DB',
    );
  } catch (e) {
    // Don't fail the main operation if local save fails
    AppLogger.warning(
      '[SavedSimulationsData] Failed to save simulations to local DB: $e',
    );
  }
}
