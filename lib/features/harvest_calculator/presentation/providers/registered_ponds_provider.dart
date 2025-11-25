import 'package:app_mobile_afms/core/di/providers/connectivity_provider.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:app_mobile_afms/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/pond_option.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/providers/harvest_simulation_providers.dart';
import 'package:app_mobile_afms/features/home/presentation/providers/home_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show Ref;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'registered_ponds_provider.g.dart';

/// Loads pond options using offline-first strategy: API first → Local DB fallback.
@riverpod
Future<List<PondOption>> registeredPondOptions(Ref ref) async {
  AppLogger.debug('[RegisteredPonds] Starting registered ponds provider');

  final authService = ref.watch(authServiceProvider);
  final employeeId = await authService.getStoredEmployeeId();

  AppLogger.debug('[RegisteredPonds] Retrieved employeeId: "$employeeId"');

  if (employeeId == null || employeeId.isEmpty) {
    AppLogger.error('[RegisteredPonds] Employee ID is null or empty');
    throw StateError(
      'Employee ID tidak tersedia. Login ulang untuk menyegarkan sesi.',
    );
  }

  AppLogger.debug('[RegisteredPonds] Employee ID valid, trying API first');

  // Try API first, fallback to local DB if offline or API fails
  final apiResult = await _tryFetchPondsFromApi(ref);

  // If API fails (returns empty data), try local DB as fallback
  if (apiResult.isEmpty) {
    AppLogger.debug(
      '[RegisteredPonds] API returned empty data, trying local DB as fallback',
    );
    return _tryFetchPondsFromLocalDb(ref);
  }

  // API succeeded, return API data (and save to DB in background if needed)
  AppLogger.debug(
    '[RegisteredPonds] API succeeded, returning data: ${apiResult.length} ponds',
  );
  return apiResult;
}

/// Try to fetch ponds from API if online, return empty if offline.
Future<List<PondOption>> _tryFetchPondsFromApi(Ref ref) async {
  AppLogger.debug('[RegisteredPonds] Starting _tryFetchPondsFromApi');

  try {
    // Check connectivity using sync provider
    var isOnline = false;
    try {
      AppLogger.debug('[RegisteredPonds] Checking connectivity status');
      final connectivitySync = ref.read(connectivityStatusSyncProvider);
      if (connectivitySync != null) {
        isOnline = connectivitySync.isConnected;
        AppLogger.debug(
          '[RegisteredPonds] Sync connectivity status: ${connectivitySync.status}, isOnline=$isOnline',
        );
      } else {
        AppLogger.debug(
          '[RegisteredPonds] Sync connectivity status is null, trying direct check',
        );
        // Fallback to direct connectivity check
        final connectivityService = ref.read(connectivityServiceProvider);
        final directResult = await connectivityService.checkConnectivity();
        isOnline = directResult.isConnected;
        AppLogger.debug(
          '[RegisteredPonds] Direct connectivity check: ${directResult.status}, isOnline=$isOnline',
        );
      }
    } catch (e) {
      // Connectivity check failed, assume offline
      AppLogger.debug(
        '[RegisteredPonds] Connectivity check failed, assuming offline: $e',
      );
      isOnline = false;
    }

    if (!isOnline) {
      // Offline: return empty data (will trigger local DB fallback)
      AppLogger.warning(
        '[RegisteredPonds] Device appears offline, cannot fetch from API',
      );
      return [];
    }

    // Online: try to fetch from API
    AppLogger.debug(
      '[RegisteredPonds] Device appears online, fetching from API',
    );
    final remoteDatasource = ref.read(
      harvestSimulationRemoteDatasourceProvider,
    );
    final apiResult = await remoteDatasource.getRegisteredPonds();

    return apiResult.fold(
      (failure) {
        // API failed: return empty data
        AppLogger.warning('[RegisteredPonds] API failed: $failure');
        return [];
      },
      (ponds) {
        if (ponds.isNotEmpty) {
          // Convert to PondOption and save to DB (fire and forget)
          final pondOptions = ponds.map((pond) {
            return PondOption(
              id: pond.id,
              name: pond.name,
              areaSqm: pond.area,
              code: '', // RegisteredPond doesn't have code field
              status: 'Available', // Default status
              farmId: '', // RegisteredPond doesn't have farmId field
            );
          }).toList();

          // Save to local DB (fire and forget)
          ref
              .read(harvestSimulationLocalDatasourceProvider)
              .savePonds(ponds); // Don't await

          AppLogger.debug(
            '[RegisteredPonds] Returning API data: ${pondOptions.length} ponds',
          );
          return pondOptions;
        } else {
          // API returned empty data
          AppLogger.debug('[RegisteredPonds] API returned empty data');
          return [];
        }
      },
    );
  } catch (e) {
    // Any error: return empty data
    AppLogger.error(
      '[RegisteredPonds] Unexpected error in _tryFetchFromApi: $e',
    );
    return [];
  }
}

/// Try to fetch ponds from local DB as fallback when API fails.
Future<List<PondOption>> _tryFetchPondsFromLocalDb(Ref ref) async {
  AppLogger.debug(
    '[RegisteredPonds] Starting _tryFetchPondsFromLocalDb fallback',
  );

  try {
    // Get selected farm ID from home screen (if available)
    String? selectedFarmId;
    try {
      final farmListData = await ref.watch(farmListDataProvider.future);
      selectedFarmId = farmListData.selectedFarmId?.toString();
    } catch (_) {
      // If home provider is not available, continue without filtering
    }

    final localDatasource = ref.read(harvestSimulationLocalDatasourceProvider);
    final result = await localDatasource.getPondOptions(farmId: selectedFarmId);

    return result.fold(
      (failure) {
        AppLogger.error(
          '[RegisteredPonds] Local DB fallback also failed: $failure',
        );
        return [];
      },
      (pondOptions) {
        AppLogger.debug(
          '[RegisteredPonds] Local DB fallback returned ${pondOptions.length} ponds',
        );
        return pondOptions;
      },
    );
  } catch (e) {
    AppLogger.error('[RegisteredPonds] Error accessing local DB fallback: $e');
    return [];
  }
}
