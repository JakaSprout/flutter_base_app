// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_refresh_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tokenRefreshMonitorHash() =>
    r'd11b65226be6623989d292ac3f70f37c1c6638da';

/// Provider for automatic token refresh.
///
/// This provider monitors token expiration and automatically refreshes
/// tokens before they expire.
///
/// Copied from [TokenRefreshMonitor].
@ProviderFor(TokenRefreshMonitor)
final tokenRefreshMonitorProvider =
    AutoDisposeAsyncNotifierProvider<TokenRefreshMonitor, void>.internal(
      TokenRefreshMonitor.new,
      name: r'tokenRefreshMonitorProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$tokenRefreshMonitorHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TokenRefreshMonitor = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
