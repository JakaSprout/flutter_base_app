import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:reactive_forms/reactive_forms.dart' as reactive_forms;

/// Reactive text field widget with label and required indicator.
///
/// Uses reactive_forms for form management.
/// Figma: Label with required indicator (*), gap 8px, field with padding 8px 16px,
/// height fixed, border radius 8px, border Gray/20
class ReactiveTextFieldWidget extends StatelessWidget {
  /// Creates a new instance of [ReactiveTextFieldWidget].
  const ReactiveTextFieldWidget({
    required this.formControlName,
    required this.label,
    this.isRequired = false,
    this.hint,
    this.prefix,
    this.suffix,
    this.keyboardType,
    this.validationMessages,
    this.readOnly = false,
    super.key,
  });

  /// Form control name
  final String formControlName;

  /// Field label
  final String label;

  /// Whether the field is required (shows red asterisk)
  final bool isRequired;

  /// Optional hint text
  final String? hint;

  /// Optional prefix widget (e.g., currency label)
  final Widget? prefix;

  /// Optional suffix widget (e.g., unit label)
  final Widget? suffix;

  /// Keyboard type
  final TextInputType? keyboardType;

  /// Validation messages
  final Map<String, reactive_forms.ValidationMessageFunction>?
  validationMessages;

  /// Whether the field is read-only (disabled)
  final bool readOnly;

  // Design tokens from Figma
  static const double _gap = 8;
  static const double _fieldPaddingHorizontal = 16;
  static const double _fieldPaddingVertical = 8;
  static const double _fieldHeight = 40; // Calculated from padding

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label Container with required indicator
        Row(
          children: [
            if (isRequired) ...[
              Text(
                '*',
                style: HarvestCalculatorDesignConstants.smallTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  color: HarvestCalculatorDesignConstants.errorColor,
                ),
              ),
              const SizedBox(width: 2), // Gap 2px
            ],
            Text(
              label,
              style: HarvestCalculatorDesignConstants.formLabelTextStyle,
            ),
          ],
        ),
        const SizedBox(height: _gap), // Gap 8px
        // Field
        Container(
          height: _fieldHeight,
          decoration: BoxDecoration(
            color: readOnly
                ? HarvestCalculatorDesignConstants.disabledFieldBackgroundColor
                : null,
            border: Border.all(
              color: HarvestCalculatorDesignConstants.borderGray, // Gray/20
            ),
            borderRadius: BorderRadius.circular(
              HarvestCalculatorDesignConstants.inputBorderRadius, // 8px
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              HarvestCalculatorDesignConstants.inputBorderRadius, // 8px
            ),
            child: Row(
              children: [
                if (prefix != null) ...[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: _fieldPaddingHorizontal,
                      right: 8,
                    ),
                    child: prefix,
                  ),
                ],
                Expanded(
                  child: reactive_forms.ReactiveTextField<String>(
                    key: ValueKey('reactive_text_field_$formControlName'),
                    formControlName: formControlName,
                    keyboardType: keyboardType,
                    validationMessages: validationMessages,
                    readOnly: readOnly,
                    showErrors: (control) => false,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: HarvestCalculatorDesignConstants.formFieldPlaceholderTextStyle,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                        left: prefix == null ? _fieldPaddingHorizontal : 0,
                        right: _fieldPaddingHorizontal,
                        top: _fieldPaddingVertical,
                        bottom: _fieldPaddingVertical,
                      ),
                      isDense: true,
                      filled: false,
                    ),
                    style: HarvestCalculatorDesignConstants.formFieldTextStyle.copyWith(
                      color: readOnly
                          ? HarvestCalculatorDesignConstants.disabledTextColor
                          : HarvestCalculatorDesignConstants.textPrimary,
                    ),
                  ),
                ),
                if (suffix != null) ...[
                  Padding(
                    padding: const EdgeInsets.only(
                      right: _fieldPaddingHorizontal,
                    ),
                    child: suffix,
                  ),
                ],
              ],
            ),
          ),
        ),
        reactive_forms.ReactiveValueListenableBuilder<String>(
          formControlName: formControlName,
          builder: (context, control, child) {
            final errorText = _resolveErrorText(control);
            if (errorText == null) {
              return const SizedBox.shrink();
            }
            return Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                errorText,
                style: HarvestCalculatorDesignConstants.formErrorTextStyle,
              ),
            );
          },
        ),
      ],
    );
  }

  String? _resolveErrorText(reactive_forms.AbstractControl<dynamic> control) {
    if (!_shouldShowError(control)) return null;
    final errors = control.errors;
    if (errors.isEmpty) return null;

    if (validationMessages != null) {
      for (final entry in errors.entries) {
        final messageBuilder = validationMessages![entry.key];
        if (messageBuilder != null) {
          return messageBuilder(entry.value);
        }
      }
    }

    final firstError = errors.entries.first;
    final dynamic value = firstError.value;
    if (value == null) return 'Field tidak valid';
    return value.toString();
  }

  bool _shouldShowError(reactive_forms.AbstractControl<dynamic> control) {
    return control.invalid && (control.dirty || control.touched);
  }
}
