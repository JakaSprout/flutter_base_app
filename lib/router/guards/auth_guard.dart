import 'package:go_router/go_router.dart';

/// Authentication guard for route protection.
///
/// This guard checks if user is authenticated before allowing access to
/// protected routes.
// TODO(team): Implement authentication check logic
class AuthGuard {
  /// Check if user is authenticated.
  ///
  /// Returns true if user is authenticated, false otherwise.
  static bool isAuthenticated() {
    // TODO(team): Implement authentication check
    return false;
  }

  /// Redirect to login if not authenticated.
  static void redirectToLogin(GoRouter router) {
    // TODO(team): Implement redirect to login
    router.go('/login');
  }
}
