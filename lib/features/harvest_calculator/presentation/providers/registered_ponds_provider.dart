import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:app_mobile_afms/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/pond_option.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/providers/harvest_simulation_providers.dart';
import 'package:app_mobile_afms/features/home/domain/entities/farm_list_data.dart';
import 'package:app_mobile_afms/features/home/presentation/providers/home_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show Ref;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'registered_ponds_provider.g.dart';

/// Loads pond options directly from local database.
@riverpod
Future<List<PondOption>> registeredPondOptions(Ref ref) async {
  // Watch farm data to make this provider reactive to farm selection changes
  final currentFarmData = await ref.watch(farmListNotifierProvider.future);

  AppLogger.debug(
    '[RegisteredPonds] Starting registered ponds provider with reactive farm data',
  );

  final authService = ref.watch(authServiceProvider);
  final employeeId = await authService.getStoredEmployeeId();

  AppLogger.debug('[RegisteredPonds] Retrieved employeeId: "$employeeId"');

  if (employeeId == null || employeeId.isEmpty) {
    AppLogger.error('[RegisteredPonds] Employee ID is null or empty');
    throw StateError(
      'Employee ID tidak tersedia. Login ulang untuk menyegarkan sesi.',
    );
  }

  AppLogger.debug(
    '[RegisteredPonds] Employee ID valid, fetching from local database',
  );

  // Fetch directly from local database
  return _tryFetchPondsFromLocalDb(ref, currentFarmData);
}

/// Fetch ponds directly from local database.
Future<List<PondOption>> _tryFetchPondsFromLocalDb(
  Ref ref,
  FarmListData farmData,
) async {
  AppLogger.debug('[RegisteredPonds] Fetching ponds from local database');

  try {
    // Use the farm data we already watched
    final selectedFarmUuid = farmData.selectedFarmUuid;
    final selectedFarmName = farmData.selectedFarm;

    AppLogger.debug(
      '[RegisteredPonds] ===== POND PROVIDER FARM UUID FLOW =====',
    );
    AppLogger.debug(
      '[RegisteredPonds] 1. Farm data farms count: ${farmData.farms.length}',
    );
    AppLogger.debug(
      '[RegisteredPonds] 2. Farm data selectedFarm: "$selectedFarmName"',
    );
    AppLogger.debug(
      '[RegisteredPonds] 3. Farm data selectedFarmUuid: "$selectedFarmUuid"',
    );
    AppLogger.debug(
      '[RegisteredPonds] 4. Farm data selectedFarmId: "${farmData.selectedFarmId}"',
    );
    AppLogger.debug(
      '[RegisteredPonds] =======================================',
    );

    final localDatasource = ref.read(harvestSimulationLocalDatasourceProvider);
    final result = await localDatasource.getPondOptions(
      farmId: selectedFarmUuid, // Now passing farm UUID instead of ID
      farmName: selectedFarmName,
    );

    return result.fold(
      (failure) {
        AppLogger.error(
          '[RegisteredPonds] Failed to fetch ponds from local DB: $failure',
        );
        AppLogger.error(
          '[RegisteredPonds] Selected farm UUID: $selectedFarmUuid, name: $selectedFarmName',
        );
        AppLogger.error(
          '[RegisteredPonds] farmId passed to getPondOptions: $selectedFarmUuid',
        );
        return [];
      },
      (pondOptions) {
        AppLogger.debug(
          '[RegisteredPonds] Successfully fetched ${pondOptions.length} ponds from local DB',
        );
        AppLogger.debug(
          '[RegisteredPonds] Selected farm UUID: $selectedFarmUuid, name: $selectedFarmName',
        );
        AppLogger.debug(
          '[RegisteredPonds] farmId passed to getPondOptions: $selectedFarmUuid',
        );
        if (pondOptions.isNotEmpty) {
          AppLogger.debug(
            '[RegisteredPonds] Sample pond: ${pondOptions.first.name} (Code: ${pondOptions.first.code}, FarmId: ${pondOptions.first.farmId})',
          );
          // Show all ponds for debugging
          for (var i = 0; i < pondOptions.length && i < 5; i++) {
            final pond = pondOptions[i];
            AppLogger.debug(
              '  Pond ${i + 1}: ${pond.name} (Code: ${pond.code}, FarmId: ${pond.farmId})',
            );
          }
        } else {
          AppLogger.warning(
            '[RegisteredPonds] No ponds returned from database!',
          );
        }
        return pondOptions;
      },
    );
  } catch (e) {
    AppLogger.error('[RegisteredPonds] Error accessing local DB fallback: $e');
    return [];
  }
}
