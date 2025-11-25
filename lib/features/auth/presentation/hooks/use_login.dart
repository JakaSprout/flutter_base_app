import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/core/initial_data/di/initial_data_provider.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:app_mobile_afms/features/auth/domain/entities/login_request.dart';
import 'package:app_mobile_afms/features/auth/domain/entities/login_response.dart';
import 'package:app_mobile_afms/features/auth/presentation/constants/login_form_controls.dart';
import 'package:app_mobile_afms/features/auth/presentation/providers/auth_provider.dart';
import 'package:app_mobile_afms/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:app_mobile_afms/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Describes the current progress stage of the login flow.
enum LoginProgressStage { idle, authenticating, seeding }

/// Custom hook for handling login logic.
///
/// Provides unified login handling for both phone and email modes,
/// following DRY principle and SOLID principles.
///
/// Returns a record with:
/// - [isLoading]: ValueNotifier<bool> for loading state
/// - [progressStage]: ValueNotifier<LoginProgressStage> for UI overlays
/// - [handleLogin]: Function to trigger login
({
  ValueNotifier<bool> isLoading,
  ValueNotifier<LoginProgressStage> progressStage,
  Future<void> Function() handleLogin,
})
useLogin({
  required BuildContext context,
  required WidgetRef ref,
  required FormGroup form,
  required bool isPhoneMode,
}) {
  final isLoading = useState(false);
  final progressStage = useState(LoginProgressStage.idle);

  Future<void> handleLogin() async {
    form.markAllAsTouched();

    if (!form.valid) {
      AppLogger.debug('[Login] Form is invalid, aborting login');
      return;
    }

    isLoading.value = true;
    progressStage.value = LoginProgressStage.authenticating;

    try {
      final loginResponse = await _performLogin(
        ref: ref,
        form: form,
        isPhoneMode: isPhoneMode,
      );

      final seedSuccess = await _saveTokensAndRefreshAuth(
        ref: ref,
        loginResponse: loginResponse,
        progressStage: progressStage,
      );

      if (!seedSuccess) {
        // Initial data seeding failed - perform logout and stay on login page
        AppLogger.error(
          '[Login] Initial data seeding failed, performing logout',
        );

        try {
          final authService = ref.read(authServiceProvider);
          await authService.clearTokens();

          // Clear auth state
          ref.invalidate(authStateProvider);
          await ref.read(authStateProvider.future);
        } catch (logoutError) {
          AppLogger.error(
            '[Login] Error during logout after seeding failure: $logoutError',
          );
        }

        // Show error message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Login failed - Could not load initial data. Please try again.',
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 8),
            ),
          );
        }

        // Don't proceed with navigation - stay on login page
        return;
      }

      // Show success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful - Initial data loaded'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      }

      if (context.mounted) {
        context.goNamed(Routes.homeName);
      }
    } catch (e, stackTrace) {
      AppLogger.error('Login error', e, stackTrace);

      if (context.mounted) {
        final errorMessage = e is Failure ? e.message : e.toString();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    } finally {
      isLoading.value = false;
      progressStage.value = LoginProgressStage.idle;
    }
  }

  return (
    isLoading: isLoading,
    progressStage: progressStage,
    handleLogin: handleLogin,
  );
}

/// Performs login based on mode (phone or email).
///
/// Returns the login response.
Future<LoginResponse> _performLogin({
  required WidgetRef ref,
  required FormGroup form,
  required bool isPhoneMode,
}) async {
  if (isPhoneMode) {
    final phoneValue = form.control(LoginFormControls.phone).value as String?;
    final phoneNumber = phoneValue?.trim() ?? '';

    AppLogger.debug('[Login] Performing phone login');
    final request = PhoneLoginRequest(phoneNumber: phoneNumber);
    return await ref.read(phoneLoginProvider(request).future);
  } else {
    final emailValue = form.control(LoginFormControls.email).value as String?;
    final passwordValue =
        form.control(LoginFormControls.password).value as String?;

    AppLogger.debug('[Login] Performing email login');
    final request = EmailLoginRequest(
      email: emailValue?.trim() ?? '',
      password: passwordValue ?? '',
    );
    return await ref.read(emailLoginProvider(request).future);
  }
}

/// Saves tokens and refreshes auth state.
///
/// This ensures AuthGuard sees the updated auth state before navigation.
Future<bool> _saveTokensAndRefreshAuth({
  required WidgetRef ref,
  required LoginResponse loginResponse,
  required ValueNotifier<LoginProgressStage> progressStage,
}) async {
  AppLogger.debug('[Login] Saving tokens and refreshing auth state');
  final authService = ref.read(authServiceProvider);
  await authService.saveTokens(loginResponse);

  // Refresh auth state and wait for it to complete
  // This ensures AuthGuard sees the updated auth state before navigation
  ref.invalidate(authStateProvider);
  await ref.read(authStateProvider.future);
  AppLogger.debug('[Login] Auth state refreshed');

  progressStage.value = LoginProgressStage.seeding;
  final seedSuccess = await _seedInitialData(ref: ref);

  progressStage.value = LoginProgressStage.idle;

  return seedSuccess;
}

Future<bool> _seedInitialData({required WidgetRef ref}) async {
  try {
    AppLogger.info('[Login] Starting initial farm data seeding from API');

    // Get the initial data service from provider
    final initialDataService = ref.read(initialDataServiceProvider);

    final seedSuccess = await initialDataService.seedInitialData();

    if (seedSuccess) {
      AppLogger.info(
        '[Login] Initial data seeding successful: employees and farms seeded',
      );
      return true;
    } else {
      AppLogger.warning('[Login] Initial data seeding failed');
      return false;
    }
  } catch (e) {
    AppLogger.error('[Login] Initial farm data seeding failed: $e');
    return false;
  }
}

String? _resolveUserKey(LoginResponse loginResponse) {
  final employeeId = loginResponse.employeeId?.trim();
  if (employeeId != null && employeeId.isNotEmpty) {
    return employeeId;
  }
  return null;
}
