import 'package:flutter_base_app/core/sync/models/sync_status.dart';
import 'package:flutter_base_app/core/sync/providers/sync_queue_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sync_status_provider.g.dart';

/// Provider for sync status stream.
///
/// This provider provides a stream of sync status changes from the sync
/// service.
@riverpod
Stream<SyncStatusModel> syncStatus(SyncStatusRef ref) {
  final syncService = ref.watch(syncServiceProvider);
  return syncService.onStatusChanged;
}

/// Provider for current sync status (synchronous).
///
/// This provider provides the current sync status synchronously.
/// Use this when you need the current status without listening to changes.
@riverpod
SyncStatusModel syncStatusSync(SyncStatusSyncRef ref) {
  final asyncStatus = ref.watch(syncStatusProvider);
  return asyncStatus.valueOrNull ??
      const SyncStatusModel(status: SyncStatus.idle);
}

/// Provider to check if sync is in progress.
@riverpod
bool isSyncing(IsSyncingRef ref) {
  final status = ref.watch(syncStatusSyncProvider);
  return status.isSyncing;
}
