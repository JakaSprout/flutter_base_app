import 'dart:async';

import 'package:flutter_base_app/core/logging/logger.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/login_form_controls.dart';
import 'package:flutter_base_app/features/auth/presentation/validators/phone_format_validator.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Configures validators for login form based on mode (phone or email).
void configureValidatorsForMode({
  required FormGroup form,
  required bool isPhoneMode,
}) {
  AppLogger.debug(
    '[LoginForm] Configuring validators for mode: ${isPhoneMode ? "PHONE" : "EMAIL"}',
  );

  final phoneControl =
      form.control(LoginFormControls.phone) as FormControl<String>;
  final emailControl =
      form.control(LoginFormControls.email) as FormControl<String>;
  final passwordControl =
      form.control(LoginFormControls.password) as FormControl<String>;

  if (isPhoneMode) {
    // Phone mode: phone is required and must have valid format
    AppLogger.debug(
      '[LoginForm] Setting validators: Phone=required+format, Email=none, Password=none',
    );
    phoneControl
      ..reset()
      ..setValidators([
        Validators.required,
        Validators.delegate(phoneFormatValidator),
      ])
      ..markAsUntouched();
    emailControl
      ..reset()
      ..setValidators([]) // Remove validators for unused fields
      ..markAsUntouched();
    passwordControl
      ..reset()
      ..setValidators([]) // Remove validators for unused fields
      ..markAsUntouched();
  } else {
    // Email mode: email and password are required
    AppLogger.debug(
      '[LoginForm] Setting validators: Phone=none, Email=required+email, Password=required',
    );
    phoneControl
      ..reset()
      ..setValidators([]) // Remove validators for unused fields
      ..markAsUntouched();
    emailControl
      ..reset()
      ..setValidators([Validators.required, Validators.email])
      ..markAsUntouched();
    passwordControl
      ..reset()
      ..setValidators([Validators.required])
      ..markAsUntouched();
  }

  // Update validity for each control
  phoneControl.updateValueAndValidity();
  emailControl.updateValueAndValidity();
  passwordControl.updateValueAndValidity();

  // Also update form-level validity
  form.updateValueAndValidity();

  AppLogger.debug('[LoginForm] After validator configuration:');
  AppLogger.debug(
    '  Phone valid: ${phoneControl.valid}, value: "${phoneControl.value}"',
  );
  AppLogger.debug(
    '  Email valid: ${emailControl.valid}, value: "${emailControl.value}"',
  );
  AppLogger.debug(
    '  Password valid: ${passwordControl.valid}, value: "${passwordControl.value != null && (passwordControl.value!).isNotEmpty ? "***" : ""}"',
  );
  AppLogger.debug('  Form valid: ${form.valid}, status: ${form.status}');
}

/// Custom hook for managing login form validation.
///
/// Automatically updates validators when mode changes and tracks form validity.
void useLoginFormValidation({
  required FormGroup form,
  required bool isPhoneMode,
}) {
  // Configure validators when mode changes
  useEffect(() {
    AppLogger.debug(
      '[LoginForm] Mode changed to: ${isPhoneMode ? "PHONE" : "EMAIL"}',
    );
    configureValidatorsForMode(form: form, isPhoneMode: isPhoneMode);
    return null;
  }, [isPhoneMode, form]);

  // Listen to form changes for validation state
  useEffect(() {
    void logValidationState() {
      final phoneControl =
          form.control(LoginFormControls.phone) as FormControl<String>;
      final emailControl =
          form.control(LoginFormControls.email) as FormControl<String>;
      final passwordControl =
          form.control(LoginFormControls.password) as FormControl<String>;

      final phoneValue = phoneControl.value ?? '';
      final emailValue = emailControl.value ?? '';
      final passwordValue = passwordControl.value ?? '';

      final phoneValid = phoneControl.valid;
      final emailValid = emailControl.valid;
      final passwordValid = passwordControl.valid;

      final formValid = form.valid;

      AppLogger.debug('[LoginForm] Form Validation State:');
      AppLogger.debug('  Mode: ${isPhoneMode ? "PHONE" : "EMAIL"}');
      AppLogger.debug('  Phone: "$phoneValue" (valid: $phoneValid)');
      AppLogger.debug('  Email: "$emailValue" (valid: $emailValid)');
      AppLogger.debug(
        '  Password: "${passwordValue.isNotEmpty ? "***" : ""}" (valid: $passwordValid)',
      );
      AppLogger.debug('  Form Valid: $formValid');
      AppLogger.debug('  Form Status: ${form.status}');
    }

    final subscriptions = <StreamSubscription<dynamic>>[
      form.valueChanges.listen((_) {
        AppLogger.debug('[LoginForm] Form value changed');
        logValidationState();
      }),
      form.statusChanged.listen((_) {
        AppLogger.debug('[LoginForm] Form status changed: ${form.status}');
        logValidationState();
      }),
    ];

    logValidationState();

    return () {
      for (final sub in subscriptions) {
        sub.cancel();
      }
    };
  }, [form, isPhoneMode]);
}
