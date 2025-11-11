import 'package:flutter_base_app/core/di/providers/dio_provider.dart';
import 'package:flutter_base_app/core/di/providers/secure_storage_provider.dart';
import 'package:flutter_base_app/core/sync/models/sync_item.dart';
import 'package:flutter_base_app/core/sync/services/sync_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sync_queue_provider.g.dart';

/// Provider for sync service.
///
/// This provider creates a singleton SyncService instance that manages
/// offline sync operations with batch sync and SSE listener support.
/// The service is automatically disposed when the provider is disposed.
@riverpod
SyncService syncService(SyncServiceRef ref) {
  final config = ref.watch(appConfigProvider);
  final secureStorage = ref.watch(secureStorageProvider);

  final service = SyncService(
    ref: ref,
    config: config,
    secureStorage: secureStorage,
  );
  ref.onDispose(service.dispose);
  return service;
}

/// Provider for sync queue items.
///
/// This provider provides a list of all items currently in the sync queue.
@riverpod
List<SyncItem> syncQueueItems(SyncQueueItemsRef ref) {
  final syncService = ref.watch(syncServiceProvider);
  return syncService.queue.items;
}

/// Provider for sync queue size.
///
/// This provider provides the number of items in the sync queue.
@riverpod
int syncQueueSize(SyncQueueSizeRef ref) {
  final items = ref.watch(syncQueueItemsProvider);
  return items.length;
}

/// Provider to check if sync queue is empty.
@riverpod
bool isSyncQueueEmpty(IsSyncQueueEmptyRef ref) {
  final size = ref.watch(syncQueueSizeProvider);
  return size == 0;
}

/// Provider for failed sync items.
///
/// This provider provides a list of sync items that have exceeded max retries.
@riverpod
List<SyncItem> failedSyncItems(FailedSyncItemsRef ref) {
  final syncService = ref.watch(syncServiceProvider);
  return syncService.queue.getFailedItems();
}

/// Provider for pending sync items.
///
/// This provider provides a list of sync items that can still be retried.
@riverpod
List<SyncItem> pendingSyncItems(PendingSyncItemsRef ref) {
  final syncService = ref.watch(syncServiceProvider);
  return syncService.queue.getPendingItems();
}
