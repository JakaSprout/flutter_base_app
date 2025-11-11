// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$syncStatusHash() => r'6f36c43722b54bad69e1021b11405692d1d35aac';

/// Provider for sync status stream.
///
/// This provider provides a stream of sync status changes from the sync
/// service.
///
/// Copied from [syncStatus].
@ProviderFor(syncStatus)
final syncStatusProvider = AutoDisposeStreamProvider<SyncStatusModel>.internal(
  syncStatus,
  name: r'syncStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$syncStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SyncStatusRef = AutoDisposeStreamProviderRef<SyncStatusModel>;
String _$syncStatusSyncHash() => r'412e8710175dd89cf17dce2912c71bcedf89d748';

/// Provider for current sync status (synchronous).
///
/// This provider provides the current sync status synchronously.
/// Use this when you need the current status without listening to changes.
///
/// Copied from [syncStatusSync].
@ProviderFor(syncStatusSync)
final syncStatusSyncProvider = AutoDisposeProvider<SyncStatusModel>.internal(
  syncStatusSync,
  name: r'syncStatusSyncProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$syncStatusSyncHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SyncStatusSyncRef = AutoDisposeProviderRef<SyncStatusModel>;
String _$isSyncingHash() => r'357fb9e4d4f2dc3c3ca4b337b9d35220c4462e64';

/// Provider to check if sync is in progress.
///
/// Copied from [isSyncing].
@ProviderFor(isSyncing)
final isSyncingProvider = AutoDisposeProvider<bool>.internal(
  isSyncing,
  name: r'isSyncingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isSyncingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsSyncingRef = AutoDisposeProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
