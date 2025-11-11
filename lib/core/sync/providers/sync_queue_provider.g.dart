// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_queue_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$syncServiceHash() => r'd8533f678ee3b9ce369e814b85eec4a42ee86e1f';

/// Provider for sync service.
///
/// This provider creates a singleton SyncService instance that manages
/// offline sync operations with batch sync and SSE listener support.
/// The service is automatically disposed when the provider is disposed.
///
/// Copied from [syncService].
@ProviderFor(syncService)
final syncServiceProvider = AutoDisposeProvider<SyncService>.internal(
  syncService,
  name: r'syncServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$syncServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SyncServiceRef = AutoDisposeProviderRef<SyncService>;
String _$syncQueueItemsHash() => r'd478590e654008e1bf98dc168d8f4465be08ef7b';

/// Provider for sync queue items.
///
/// This provider provides a list of all items currently in the sync queue.
///
/// Copied from [syncQueueItems].
@ProviderFor(syncQueueItems)
final syncQueueItemsProvider = AutoDisposeProvider<List<SyncItem>>.internal(
  syncQueueItems,
  name: r'syncQueueItemsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$syncQueueItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SyncQueueItemsRef = AutoDisposeProviderRef<List<SyncItem>>;
String _$syncQueueSizeHash() => r'2be5a1b4c6a03d99fee13bdbab19a5e52167b59f';

/// Provider for sync queue size.
///
/// This provider provides the number of items in the sync queue.
///
/// Copied from [syncQueueSize].
@ProviderFor(syncQueueSize)
final syncQueueSizeProvider = AutoDisposeProvider<int>.internal(
  syncQueueSize,
  name: r'syncQueueSizeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$syncQueueSizeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SyncQueueSizeRef = AutoDisposeProviderRef<int>;
String _$isSyncQueueEmptyHash() => r'ef73b263c881fe7ce25f7b6e660a32a7a707c3cc';

/// Provider to check if sync queue is empty.
///
/// Copied from [isSyncQueueEmpty].
@ProviderFor(isSyncQueueEmpty)
final isSyncQueueEmptyProvider = AutoDisposeProvider<bool>.internal(
  isSyncQueueEmpty,
  name: r'isSyncQueueEmptyProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isSyncQueueEmptyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsSyncQueueEmptyRef = AutoDisposeProviderRef<bool>;
String _$failedSyncItemsHash() => r'78c239793647291ef70d50b9feb0a95386a92afa';

/// Provider for failed sync items.
///
/// This provider provides a list of sync items that have exceeded max retries.
///
/// Copied from [failedSyncItems].
@ProviderFor(failedSyncItems)
final failedSyncItemsProvider = AutoDisposeProvider<List<SyncItem>>.internal(
  failedSyncItems,
  name: r'failedSyncItemsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$failedSyncItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FailedSyncItemsRef = AutoDisposeProviderRef<List<SyncItem>>;
String _$pendingSyncItemsHash() => r'c9959eb2d96199020687dbb7f7407dbd140f6c5c';

/// Provider for pending sync items.
///
/// This provider provides a list of sync items that can still be retried.
///
/// Copied from [pendingSyncItems].
@ProviderFor(pendingSyncItems)
final pendingSyncItemsProvider = AutoDisposeProvider<List<SyncItem>>.internal(
  pendingSyncItems,
  name: r'pendingSyncItemsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pendingSyncItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PendingSyncItemsRef = AutoDisposeProviderRef<List<SyncItem>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
