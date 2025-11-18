// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authServiceHash() => r'a64d79f71df1f9bfa594bb53ac483074420c34c4';

/// Provider for AuthService instance.
///
/// Copied from [authService].
@ProviderFor(authService)
final authServiceProvider = Provider<AuthService>.internal(
  authService,
  name: r'authServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthServiceRef = ProviderRef<AuthService>;
String _$authStateHash() => r'5d16e794b3a38e76f7b06105f43973cc07742446';

/// Provider for authentication state.
///
/// This provider tracks whether the user is currently authenticated.
/// It automatically checks secure storage for tokens and validates
/// token expiration on initialization.
///
/// Uses [keepAlive: true] because:
/// - Global state that needs to be always accessible
/// - Used by router guard for route protection
/// - Needs to persist across navigation
///
/// Copied from [authState].
@ProviderFor(authState)
final authStateProvider = FutureProvider<bool>.internal(
  authState,
  name: r'authStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthStateRef = FutureProviderRef<bool>;
String _$isAuthenticatedHash() => r'29a5f02176c542dfbed45e2acbc4b33e0b4ec6cb';

/// Provider for checking if user is authenticated (synchronous check).
///
/// This is useful for immediate checks without awaiting.
/// For async operations, use [authStateProvider].
///
/// Uses [keepAlive: true] because:
/// - Depends on [authStateProvider] which is keepAlive
/// - Global state that needs to be always accessible
/// - Used by router guard for route protection
///
/// Copied from [isAuthenticated].
@ProviderFor(isAuthenticated)
final isAuthenticatedProvider = Provider<bool>.internal(
  isAuthenticated,
  name: r'isAuthenticatedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAuthenticatedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsAuthenticatedRef = ProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
