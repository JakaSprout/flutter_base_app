import 'package:flutter/material.dart';
import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/design_system/components/inputs/stp_dropdown.dart';
import 'package:app_mobile_afms/design_system/theme/app_colors.dart';

/// Dropdown form field component.
///
/// A consistent dropdown field with label and optional required indicator.
/// Uses bottom sheet popup like in login screen.
///
/// Example:
/// ```dart
/// STPDropdownFormField<String>(
///   label: 'Pilih Blok',
///   isRequired: true,
///   items: ['Blok A', 'Blok B', 'Blok C'],
///   selectedValue: selectedBlock,
///   onChanged: (value) => setState(() => selectedBlock = value),
/// )
/// ```
class STPDropdownFormField<T> extends StatelessWidget {
  /// Creates a new instance of [STPDropdownFormField].
  const STPDropdownFormField({
    required this.label,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.isRequired = false,
    this.hint,
    this.colors,
    this.displayText,
    super.key,
  });

  /// Field label
  final String label;

  /// List of items to display in the dropdown
  final List<T> items;

  /// Currently selected value
  final T? selectedValue;

  /// Callback when selection changes
  final ValueChanged<T> onChanged;

  /// Whether the field is required (shows red asterisk)
  final bool isRequired;

  /// Optional hint text when no value is selected
  final String? hint;

  /// Color configuration for the dropdown (default: gray)
  final STPDropdownColors? colors;

  /// Optional function to get display text for each item
  final String Function(T)? displayText;

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
                  color: Color(0xFFD84639), // Destructive/60
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
        // Dropdown
        STPDropdown<T>(
          items: items,
          selectedValue: selectedValue,
          onChanged: onChanged,
          colors: colors ?? const STPDropdownColors.gray(),
          hint: hint ?? 'Pilih $label',
          displayText: displayText,
        ),
      ],
    );
  }
}
