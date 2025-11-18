import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/lab_request/presentation/constants/lab_request_design_constants.dart';

/// Radio button group widget for lab request form.
class LabRequestRadioButtonGroup<T> extends StatelessWidget {
  /// Creates a new instance of [LabRequestRadioButtonGroup].
  const LabRequestRadioButtonGroup({
    required this.label,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    required this.displayText,
    super.key,
  });

  /// Field label
  final String label;

  /// List of options
  final List<T> options;

  /// Selected value
  final T? selectedValue;

  /// Callback when value changes
  final ValueChanged<T> onChanged;

  /// Function to get display text for each option
  final String Function(T) displayText;

  // Design tokens
  static const double _labelFontSize = 12;
  static const double _optionFontSize = 14;
  static const double _lineHeight = 1.4;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        const SizedBox(height: LabRequestDesignConstants.spacingSmall),
        ...options.map((option) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: LabRequestDesignConstants.radioSpacing,
            ),
            child: RadioListTile<T>(
              title: Text(
                displayText(option),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: _optionFontSize,
                      fontWeight: FontWeight.w400,
                      color: AppColors.gray100,
                      fontFamily: AppConstants.fontFamily,
                      height: _lineHeight,
                    ),
              ),
              value: option,
              groupValue: selectedValue,
              onChanged: (value) {
                if (value != null) {
                  onChanged(value);
                }
              },
              contentPadding: EdgeInsets.zero,
            ),
          );
        }),
      ],
    );
  }
}


