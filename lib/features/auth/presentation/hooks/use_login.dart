import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:app_mobile_afms/core/reference_data/domain/services/reference_data_seeder.dart';
import 'package:app_mobile_afms/core/reference_data/domain/services/reference_data_seeder_factory.dart';
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

      final seedResult = await _saveTokensAndRefreshAuth(
        ref: ref,
        loginResponse: loginResponse,
        progressStage: progressStage,
      );

      if (!seedResult.success) {
        // Show error message and fail login
        const errorMessage =
            'Login failed - Could not load reference data. Please try again.';

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 8),
            ),
          );
        }

        // Throw exception to fail login process
        throw Exception('Reference data seeding failed');
      }

      // Show success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Login successful - ${seedResult.totalProcessed} reference records loaded',
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 5),
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
Future<ReferenceDataSeedResult> _saveTokensAndRefreshAuth({
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
  final seedResult = await _seedReferenceData(
    ref: ref,
    loginResponse: loginResponse,
  );

  progressStage.value = LoginProgressStage.idle;

  return seedResult;
}

Future<ReferenceDataSeedResult> _seedReferenceData({
  required WidgetRef ref,
  required LoginResponse loginResponse,
}) async {
  final userKey = _resolveUserKey(loginResponse);
  if (userKey == null) {
    AppLogger.warning(
      '[Login] Unable to resolve employeeId, skipping reference data seeding',
    );
    return const ReferenceDataSeedResult(
      success: false,
      results: {},
      totalProcessed: 0,
      totalErrors: 1,
      duration: Duration.zero,
    );
  }

  try {
    AppLogger.info(
      '[Login] Starting reference data seeding for user: $userKey',
    );

    final seeder = ref.read(referenceDataSeederProvider);
    final config = seedingConfiguration.createDefaultConfig();

    final result = await seeder.seedAll(userId: userKey, config: config);

    if (result.success) {
      AppLogger.info(
        '[Login] Reference data seeding completed successfully: '
        '${result.totalProcessed} records processed',
      );
    } else {
      AppLogger.error(
        '[Login] Reference data seeding failed: '
        '${result.totalErrors} errors, ${result.totalProcessed} processed',
      );
    }

    return result;
  } catch (e, st) {
    AppLogger.error('[Login] Reference data seeding failed', e, st);

    return const ReferenceDataSeedResult(
      success: false,
      results: {},
      totalProcessed: 0,
      totalErrors: 1,
      duration: Duration.zero,
    );
  }
}

String? _resolveUserKey(LoginResponse loginResponse) {
  final employeeId = loginResponse.employeeId?.trim();
  if (employeeId != null && employeeId.isNotEmpty) {
    return employeeId;
  }
  return null;
}
