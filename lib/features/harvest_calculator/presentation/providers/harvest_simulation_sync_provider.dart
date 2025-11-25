import 'package:app_mobile_afms/core/di/providers/dio_provider.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/services/harvest_simulation_sync_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'harvest_simulation_sync_provider.g.dart';

/// Provider for harvest simulation sync service.
@Riverpod(keepAlive: true)
HarvestSimulationSyncService harvestSimulationSyncService(
  HarvestSimulationSyncServiceRef ref,
) {
  final dio = ref.watch(dioProvider);
  return HarvestSimulationSyncService(ref: ref, dio: dio);
}

/// Provider for harvest simulation sync operation.
///
/// This provider triggers sync when watched and returns the sync result.
/// Use this to sync harvest simulations when needed.
@riverpod
Future<HarvestSimulationSyncResult> harvestSimulationSync(
  HarvestSimulationSyncRef ref, {
  required String employeeId,
}) async {
  final syncService = ref.watch(harvestSimulationSyncServiceProvider);
  return syncService.syncHarvestSimulations(employeeId: employeeId);
}


