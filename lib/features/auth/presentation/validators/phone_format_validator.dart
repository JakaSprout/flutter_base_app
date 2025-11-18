import 'package:reactive_forms/reactive_forms.dart';

/// Custom validator for phone number format.
///
/// Validates that phone number has 10-15 digits after removing non-digit characters.
/// Only validates format, not required (required is handled by Validators.required).
Map<String, dynamic>? phoneFormatValidator(AbstractControl<dynamic> control) {
  final value = control.value as String?;
  // Skip validation if value is empty (required validator will handle it)
  if (value == null || value.isEmpty) {
    return null;
  }
  // Remove all non-digit characters for validation
  final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
  if (digitsOnly.length < 10 || digitsOnly.length > 15) {
    return <String, dynamic>{
      'phoneFormat': 'Please enter a valid phone number',
    };
  }
  return null; // Valid format
}
