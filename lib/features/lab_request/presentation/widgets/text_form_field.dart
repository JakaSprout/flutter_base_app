import 'package:app_mobile_afms/design_system/components/forms/stp_form_input_field.dart';
import 'package:flutter/material.dart';

/// Text form field widget for lab request form.
///
/// Uses design system STPFormInputField for consistency.
class LabRequestTextFormField extends StatelessWidget {
  /// Creates a new instance of [LabRequestTextFormField].
  const LabRequestTextFormField({
    required this.controller,
    required this.label,
    required this.hint,
    this.isRequired = true,
    this.keyboardType,
    this.validator,
    super.key,
  });

  /// Text editing controller
  final TextEditingController controller;

  /// Field label
  final String label;

  /// Field hint text
  final String hint;

  /// Whether the field is required
  final bool isRequired;

  /// Keyboard type
  final TextInputType? keyboardType;

  /// Validator function
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return STPFormInputField(
      label: label,
      value: controller.text,
      isRequired: isRequired,
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}


