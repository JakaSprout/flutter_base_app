// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$logoutHash() => r'55e79469b98c432148a91cc53865031efab8bcc8';

/// Provider for logout functionality.
///
/// This provider handles user logout by:
/// 1. Calling logout API to invalidate session on server
/// 2. Clearing all authentication tokens locally
/// 3. Invalidating auth state
/// 4. Manually navigating to login page
///
/// Note: We manually navigate to login instead of relying on router redirect
/// to avoid race conditions with cached provider values.
///
/// Copied from [logout].
@ProviderFor(logout)
final logoutProvider = AutoDisposeFutureProvider<void>.internal(
  logout,
  name: r'logoutProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$logoutHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LogoutRef = AutoDisposeFutureProviderRef<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
