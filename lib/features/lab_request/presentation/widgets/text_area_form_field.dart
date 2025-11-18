import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';

/// Text area form field widget for lab request form.
class LabRequestTextAreaFormField extends StatelessWidget {
  /// Creates a new instance of [LabRequestTextAreaFormField].
  const LabRequestTextAreaFormField({
    required this.controller,
    required this.label,
    required this.hint,
    super.key,
  });

  /// Text editing controller
  final TextEditingController controller;

  /// Field label
  final String label;

  /// Field hint text
  final String hint;

  // Design tokens
  static const double _labelFontSize = 12;
  static const double _valueFontSize = 14;
  static const double _lineHeight = 1.4;
  static const double _gap = 8;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
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
        const SizedBox(height: _gap),
        // Text area
        TextFormField(
          controller: controller,
          maxLines: 4,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: _valueFontSize,
                fontWeight: FontWeight.w400,
                color: AppColors.gray100,
                fontFamily: AppConstants.fontFamily,
                height: _lineHeight,
              ),
          decoration: InputDecoration(
            hintText: hint,
            alignLabelWithHint: true,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: _valueFontSize,
                  fontWeight: FontWeight.w400,
                  color: AppColors.gray70,
                  fontFamily: AppConstants.fontFamily,
                  height: _lineHeight,
                ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), // Consistent with FormInputField
              borderSide: const BorderSide(
                color: AppColors.gray20, // Consistent with FormInputField
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), // Consistent with FormInputField
              borderSide: const BorderSide(
                color: AppColors.gray20, // Consistent with FormInputField
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), // Consistent with FormInputField
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }
}


