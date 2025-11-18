import 'package:flutter_base_app/core/di/providers/secure_storage_provider.dart';
import 'package:flutter_base_app/features/auth/domain/services/auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_provider.g.dart';

/// Provider for AuthService instance.
@Riverpod(keepAlive: true)
AuthService authService(AuthServiceRef ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return AuthService(secureStorage: secureStorage);
}

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
@Riverpod(keepAlive: true)
Future<bool> authState(AuthStateRef ref) async {
  final authService = ref.watch(authServiceProvider);
  // Use validateSession to check both token existence and expiration
  return await authService.validateSession();
}

/// Provider for checking if user is authenticated (synchronous check).
///
/// This is useful for immediate checks without awaiting.
/// For async operations, use [authStateProvider].
///
/// Uses [keepAlive: true] because:
/// - Depends on [authStateProvider] which is keepAlive
/// - Global state that needs to be always accessible
/// - Used by router guard for route protection
@Riverpod(keepAlive: true)
bool isAuthenticated(IsAuthenticatedRef ref) {
  final authStateAsync = ref.watch(authStateProvider);
  return authStateAsync.value ?? false;
}
