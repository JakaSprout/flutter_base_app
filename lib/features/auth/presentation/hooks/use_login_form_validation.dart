import 'dart:async';

import 'package:app_mobile_afms/features/auth/presentation/constants/login_form_controls.dart';
import 'package:app_mobile_afms/features/auth/presentation/validators/phone_format_validator.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Configures validators for login form based on mode (phone or email).
void configureValidatorsForMode({
  required FormGroup form,
  required bool isPhoneMode,
}) {
  final phoneControl =
      form.control(LoginFormControls.phone) as FormControl<String>;
  final emailControl =
      form.control(LoginFormControls.email) as FormControl<String>;
  final passwordControl =
      form.control(LoginFormControls.password) as FormControl<String>;

  if (isPhoneMode) {
    // Phone mode: phone is required and must have valid format
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
    configureValidatorsForMode(form: form, isPhoneMode: isPhoneMode);
    return null;
  }, [isPhoneMode, form]);

  // Listen to form changes for validation state
  useEffect(() {
    final subscriptions = <StreamSubscription<dynamic>>[
      form.valueChanges.listen((_) {
        // Form value changed - handled by reactive forms automatically
      }),
      form.statusChanged.listen((_) {
        // Form status changed - handled by reactive forms automatically
      }),
    ];

    return () {
      for (final sub in subscriptions) {
        sub.cancel();
      }
    };
  }, [form, isPhoneMode]);
}
