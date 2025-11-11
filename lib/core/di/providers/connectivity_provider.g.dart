// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$connectivityServiceHash() =>
    r'e5819d741b2371a9301a8957fc45e2d8d6ab3aed';

/// Provider for connectivity service.
///
/// This provider creates a singleton ConnectivityService instance that
/// monitors network connectivity changes. The service is automatically
/// disposed when the provider is disposed.
///
/// Copied from [connectivityService].
@ProviderFor(connectivityService)
final connectivityServiceProvider =
    AutoDisposeProvider<ConnectivityService>.internal(
      connectivityService,
      name: r'connectivityServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$connectivityServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConnectivityServiceRef = AutoDisposeProviderRef<ConnectivityService>;
String _$connectivityStatusHash() =>
    r'85962ce4ead1d506d0f26f646c3e901c1f27f373';

/// Provider for current connectivity status stream.
///
/// This provider provides a stream of connectivity status changes.
/// Use this when you need to react to connectivity changes in real-time.
///
/// Copied from [connectivityStatus].
@ProviderFor(connectivityStatus)
final connectivityStatusProvider =
    AutoDisposeStreamProvider<AppConnectivityResult>.internal(
      connectivityStatus,
      name: r'connectivityStatusProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$connectivityStatusHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConnectivityStatusRef =
    AutoDisposeStreamProviderRef<AppConnectivityResult>;
String _$connectivityStatusSyncHash() =>
    r'b390c7dbf2c07d525cf681a5016e05ff0a816d2c';

/// Provider for current connectivity status (synchronous).
///
/// This provider provides the current connectivity status synchronously.
/// Use this when you need the current status without listening to changes.
///
/// Copied from [connectivityStatusSync].
@ProviderFor(connectivityStatusSync)
final connectivityStatusSyncProvider =
    AutoDisposeProvider<AppConnectivityResult?>.internal(
      connectivityStatusSync,
      name: r'connectivityStatusSyncProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$connectivityStatusSyncHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConnectivityStatusSyncRef =
    AutoDisposeProviderRef<AppConnectivityResult?>;
String _$isConnectedHash() => r'442bc52e8dcd7bc4f31cf44379da4c1b21dfe176';

/// Provider to check if device is connected.
///
/// This provider provides a boolean indicating whether the device is
/// currently connected to the internet.
///
/// Copied from [isConnected].
@ProviderFor(isConnected)
final isConnectedProvider = AutoDisposeProvider<bool>.internal(
  isConnected,
  name: r'isConnectedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isConnectedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsConnectedRef = AutoDisposeProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
