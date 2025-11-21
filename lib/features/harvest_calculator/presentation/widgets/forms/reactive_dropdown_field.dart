import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/design_system/components/inputs/stp_dropdown.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:reactive_forms/reactive_forms.dart' as reactive_forms;

/// Reactive dropdown field widget with label and required indicator.
///
/// Uses reactive_forms for form management.
/// Figma: Label with required indicator (*), gap 8px, field with padding 8px 16px,
/// height fixed, border radius 8px, border Gray/20
class ReactiveDropdownFieldWidget<T> extends StatelessWidget {
  /// Creates a new instance of [ReactiveDropdownFieldWidget].
  const ReactiveDropdownFieldWidget({
    required this.formControlName,
    required this.label,
    required this.items,
    this.isRequired = false,
    this.hint,
    this.colors,
    this.displayText,
    this.validationMessages,
    super.key,
  });

  /// Form control name
  final String formControlName;

  /// Field label
  final String label;

  /// List of items to display in the dropdown
  final List<T> items;

  /// Whether the field is required (shows red asterisk)
  final bool isRequired;

  /// Optional hint text when no value is selected
  final String? hint;

  /// Color configuration for the dropdown (default: gray)
  final STPDropdownColors? colors;

  /// Optional function to get display text for each item
  final String Function(T)? displayText;

  /// Validation messages
  final Map<String, reactive_forms.ValidationMessageFunction>? validationMessages;

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
                  color: HarvestCalculatorDesignConstants.errorColor, // Destructive/60
                  fontSize: _labelFontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 2), // Gap 2px
            ],
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: _labelFontSize,
                fontWeight: FontWeight.w400,
                color: AppColors.gray100,
                fontFamily: AppConstants.fontFamily,
                height: _lineHeight,
              ),
            ),
          ],
        ),
        const SizedBox(height: _gap),
        // Dropdown using ReactiveFormField
        reactive_forms.ReactiveFormField<T, T>(
          key: ValueKey('reactive_dropdown_field_$formControlName'),
          formControlName: formControlName,
          validationMessages: validationMessages,
          showErrors: (control) => control.invalid && (control.dirty || control.touched),
          builder: (field) {
            final errorText = field.errorText;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                STPDropdown<T>(
                  items: items,
                  selectedValue: field.value,
                  onChanged: (value) {
                    field.didChange(value);
                  },
                  colors: colors ?? const STPDropdownColors.gray(),
                  hint: hint ?? 'Pilih $label',
                  displayText: displayText,
                ),
                if (errorText != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    errorText,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontSize: _labelFontSize,
                          fontWeight: FontWeight.w400,
                          color: HarvestCalculatorDesignConstants.errorColor,
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

