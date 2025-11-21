import 'package:flutter/material.dart';
import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:app_mobile_afms/features/auth/domain/entities/login_request.dart';
import 'package:app_mobile_afms/features/auth/domain/entities/login_response.dart';
import 'package:app_mobile_afms/features/auth/presentation/constants/login_form_controls.dart';
import 'package:app_mobile_afms/features/auth/presentation/providers/auth_provider.dart';
import 'package:app_mobile_afms/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:app_mobile_afms/router/routes.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Custom hook for handling login logic.
///
/// Provides unified login handling for both phone and email modes,
/// following DRY principle and SOLID principles.
///
/// Returns a record with:
/// - [isLoading]: ValueNotifier<bool> for loading state
/// - [handleLogin]: Function to trigger login
({ValueNotifier<bool> isLoading, Future<void> Function() handleLogin})
useLogin({
  required BuildContext context,
  required WidgetRef ref,
  required FormGroup form,
  required bool isPhoneMode,
}) {
  final isLoading = useState(false);

  Future<void> handleLogin() async {
    form.markAllAsTouched();

    if (!form.valid) {
      AppLogger.debug('[Login] Form is invalid, aborting login');
      return;
    }

    isLoading.value = true;

    try {
      final loginResponse = await _performLogin(
        ref: ref,
        form: form,
        isPhoneMode: isPhoneMode,
      );

      await _saveTokensAndRefreshAuth(ref: ref, loginResponse: loginResponse);

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
    }
  }

  return (isLoading: isLoading, handleLogin: handleLogin);
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
Future<void> _saveTokensAndRefreshAuth({
  required WidgetRef ref,
  required LoginResponse loginResponse,
}) async {
  AppLogger.debug('[Login] Saving tokens and refreshing auth state');
  final authService = ref.read(authServiceProvider);
  await authService.saveTokens(loginResponse);

  // Refresh auth state and wait for it to complete
  // This ensures AuthGuard sees the updated auth state before navigation
  ref.invalidate(authStateProvider);
  await ref.read(authStateProvider.future);
  AppLogger.debug('[Login] Auth state refreshed');
}
