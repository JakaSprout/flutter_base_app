import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:app_mobile_afms/features/auth/presentation/constants/auth_constants.dart';
import 'package:app_mobile_afms/features/auth/presentation/providers/auth_provider.dart';
import 'package:app_mobile_afms/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:app_mobile_afms/router/app_router.dart';
import 'package:app_mobile_afms/router/routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logout_provider.g.dart';

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
@riverpod
Future<void> logout(LogoutRef ref) async {
  try {
    final authService = ref.read(authServiceProvider);
    final logoutUseCase = ref.read(logoutUseCaseProvider);

    // Step 1: Call logout API to invalidate session on server
    // Even if this fails, we'll still clear local tokens
    final logoutResult = await logoutUseCase();
    logoutResult.fold(
      (Failure failure) {
        // Log error but continue with local logout
        AppLogger.warning(
          'Logout API failed (non-critical): ${failure.message}',
          failure,
          StackTrace.current,
        );
      },
      (_) {
        // Logout API succeeded
        AppLogger.info('Logout API call successful');
      },
    );

    // Step 2: Clear tokens and verify they are cleared
    await authService.clearTokensAndVerify();

    // Step 3: Invalidate AuthService and auth state providers
    // CRITICAL: Must invalidate authService first because it's keepAlive
    // This forces a new AuthService instance that will read fresh from storage
    AppLogger.info('Invalidating authService and authState providers');
    ref
      ..invalidate(authServiceProvider)
      ..invalidate(authStateProvider);

    // Give providers time to invalidate
    await Future<void>.delayed(AuthConstants.providerInvalidationDelay);

    // Step 4: Verify auth state is now false
    try {
      final newAuthState = await ref.read(authStateProvider.future);
      AppLogger.info('After invalidate: new auth state = $newAuthState');

      if (newAuthState) {
        AppLogger.error(
          'CRITICAL: Auth state still true after token clear and invalidate!',
        );
        // Last resort: force clear storage one more time
        await authService.clearTokensAndVerify();
        // Wait a bit
        await Future<void>.delayed(AuthConstants.providerInvalidationDelay);
        // Invalidate again
        ref
          ..invalidate(authServiceProvider)
          ..invalidate(authStateProvider);
        // Check again
        final finalAuthState = await ref.read(authStateProvider.future);
        AppLogger.info('After second invalidate: auth state = $finalAuthState');
      }
    } catch (e) {
      AppLogger.warning('Error verifying auth state: $e');
    }

    // Step 5: Manually navigate to login page
    // Router redirect should now work correctly as authStateProvider is false
    try {
      final router = AppRouter.currentRouter;
      if (router != null) {
        router.goNamed(Routes.loginName);
        AppLogger.info('Navigated to login page after logout');
      } else {
        AppLogger.warning(
          'Router not available, router redirect will handle navigation',
        );
      }
    } catch (e) {
      AppLogger.warning('Error navigating to login: $e');
    }
  } catch (e, stackTrace) {
    // Log error but don't throw - logout should always succeed
    // even if token deletion fails
    AppLogger.warning('Logout error (non-critical): $e', e, stackTrace);

    // Still invalidate auth state even if clearTokens fails
    // This ensures user is logged out even if storage operation fails
    ref.invalidate(authStateProvider);
  }
}
