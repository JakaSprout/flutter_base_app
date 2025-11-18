import 'package:flutter_base_app/features/auth/domain/services/auth_service.dart'
    show AuthService;
import 'package:flutter_base_app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:flutter_base_app/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Authentication guard for route protection.
///
/// This guard checks if user is authenticated before allowing access to
/// protected routes.
///
/// Uses [AuthService] to check authentication state from secure storage.
class AuthGuard {
  /// Check if user is authenticated.
  ///
  /// Returns true if user is authenticated, false otherwise.
  ///
  /// This method checks the auth state from Riverpod provider.
  /// For async operations, use [isAuthenticatedAsync].
  static bool isAuthenticated(WidgetRef ref) {
    final authStateAsync = ref.read(authStateProvider);
    return authStateAsync.value ?? false;
  }

  /// Check if user is authenticated (async).
  ///
  /// Returns a Future<bool> that resolves to true if user is authenticated.
  ///
  /// This method directly checks secure storage, useful when provider
  /// state might not be available yet.
  static Future<bool> isAuthenticatedAsync(WidgetRef ref) async {
    final authService = ref.read(authServiceProvider);
    return authService.isAuthenticated();
  }

  /// Check if a route is public (doesn't require authentication).
  ///
  /// Returns true if the route is public, false otherwise.
  static bool isPublicRoute(String path) {
    return path == Routes.login || path == Routes.splash;
  }

  /// Get redirect path based on authentication state.
  ///
  /// Returns:
  /// - `Routes.home` if authenticated and trying to access login
  /// - `Routes.login` if not authenticated and trying to access protected route
  /// - `null` if no redirect is needed
  static String? getRedirectPath(WidgetRef ref, String currentPath) {
    final authStateAsync = ref.read(authStateProvider);

    // If auth state is still loading, don't redirect yet
    if (!authStateAsync.hasValue) {
      return null;
    }

    final isAuthenticated = authStateAsync.value ?? false;
    final isLoginRoute = currentPath == Routes.login;

    // If user is authenticated and trying to access login, redirect to home
    if (isAuthenticated && isLoginRoute) {
      return Routes.home;
    }

    // If user is not authenticated and trying to access protected route,
    // redirect to login
    if (!isAuthenticated && !isLoginRoute && !isPublicRoute(currentPath)) {
      return Routes.login;
    }

    // No redirect needed
    return null;
  }

  /// Redirect to login if not authenticated.
  ///
  /// This method checks authentication state and redirects to login
  /// if user is not authenticated.
  static void redirectToLoginIfNeeded(WidgetRef ref, GoRouter router) {
    if (!isAuthenticated(ref)) {
      router.go(Routes.login);
    }
  }
}
