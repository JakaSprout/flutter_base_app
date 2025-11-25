import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/design_system/components/inputs/stp_dropdown.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_design_constants.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart' as reactive_forms;

/// Reactive dropdown field widget for lab request forms.
///
/// Wrapper around STPDropdown integrated with reactive_forms.
/// Pattern follows harvest_calculator reactive form fields.
class ReactiveLabDropdownField<T> extends StatelessWidget {
  /// Creates a new instance of [ReactiveLabDropdownField].
  const ReactiveLabDropdownField({
    required this.formControlName,
    required this.label,
    required this.items,
    this.isRequired = false,
    this.hint,
    this.colors,
    this.displayText,
    this.validationMessages,
    this.onTap,
    super.key,
  });

  /// Form control name
  final String formControlName;

  /// Field label
  final String label;

  /// List of items to display in the dropdown
  final List<T> items;

  /// Whether the field is required (shows asterisk)
  final bool isRequired;

  /// Optional hint text when no value is selected
  final String? hint;

  /// Color configuration for the dropdown
  final STPDropdownColors? colors;

  /// Optional function to get display text for each item
  final String Function(T)? displayText;

  /// Validation messages
  final Map<String, reactive_forms.ValidationMessageFunction>?
  validationMessages;

  /// Optional callback when field is tapped (for external handling)
  final VoidCallback? onTap;

  // Design tokens
  static const double _labelFontSize = 12;
  static const double _lineHeight = 1.4;
  static const double _gap = 8;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label with required indicator
        Row(
          children: [
            if (isRequired) ...[
              const Text(
                '*',
                style: TextStyle(
                  color: Color(0xFFD84639), // Destructive/60 (error color)
                  fontSize: _labelFontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 2),
            ],
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: _labelFontSize,
                fontWeight: FontWeight.w400,
                color: LabRequestDesignConstants.gray100,
                fontFamily: AppConstants.fontFamily,
                height: _lineHeight,
              ),
            ),
          ],
        ),
        const SizedBox(height: _gap),
        // Reactive dropdown field
        reactive_forms.ReactiveFormField<T, T>(
          key: ValueKey('reactive_lab_dropdown_$formControlName'),
          formControlName: formControlName,
          validationMessages: validationMessages,
          showErrors: (control) =>
              control.invalid && (control.dirty || control.touched),
          builder: (field) {
            final errorText = field.errorText;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: AbsorbPointer(
                    absorbing: onTap != null,
                    child: STPDropdown<T>(
                      items: items,
                      selectedValue: field.value,
                      onChanged: (value) {
                        field.didChange(value);
                      },
                      colors: colors ?? const STPDropdownColors.gray(),
                      hint: hint ?? 'Pilih $label',
                      displayText: displayText,
                    ),
                  ),
                ),
                if (errorText != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    errorText,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: _labelFontSize,
                      fontWeight: FontWeight.w400,
                      color: LabRequestDesignConstants.primary,
                      fontFamily: AppConstants.fontFamily,
                      height: _lineHeight,
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}
