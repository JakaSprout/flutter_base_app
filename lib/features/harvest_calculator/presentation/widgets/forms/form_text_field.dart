import 'package:flutter/material.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';

/// Reusable text field widget with label and required indicator.
///
/// Figma: Label with required indicator (*), gap 8px, field with padding 8px 16px,
/// height fixed, border radius 8px, border Gray/20
class FormTextField extends StatelessWidget {
  /// Creates a new instance of [FormTextField].
  const FormTextField({
    required this.label,
    required this.controller,
    this.isRequired = false,
    this.hint,
    this.suffix,
    this.keyboardType,
    this.validator,
    super.key,
  });

  /// Field label
  final String label;

  /// Text editing controller
  final TextEditingController controller;

  /// Whether the field is required (shows red asterisk)
  final bool isRequired;

  /// Optional hint text
  final String? hint;

  /// Optional suffix widget (e.g., unit label)
  final Widget? suffix;

  /// Keyboard type
  final TextInputType? keyboardType;

  /// Validator function
  final String? Function(String?)? validator;

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
            border: Border.all(
              color: HarvestCalculatorDesignConstants.borderGray, // Gray/20
            ),
            borderRadius: BorderRadius.circular(
              HarvestCalculatorDesignConstants.inputBorderRadius, // 8px
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: HarvestCalculatorDesignConstants.formFieldPlaceholderTextStyle,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: _fieldPaddingHorizontal,
                      vertical: _fieldPaddingVertical,
                    ),
                    isDense: true,
                  ),
                  style: HarvestCalculatorDesignConstants.formFieldTextStyle,
                ),
              ),
              if (suffix != null) ...[
                Padding(
                  padding: const EdgeInsets.only(right: _fieldPaddingHorizontal),
                  child: suffix,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

