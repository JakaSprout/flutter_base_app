import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/design_system/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Form input field component.
///
/// A consistent input field with label, optional required indicator,
/// and icon support.
///
/// Example:
/// ```dart
/// STPFormInputField(
///   label: 'Tanggal',
///   isRequired: true,
///   value: '28 Okt 2025',
///   icon: Icons.calendar_today,
///   onTap: () => showDatePicker(...),
/// )
/// ```
class STPFormInputField extends StatelessWidget {
  /// Creates a new instance of [STPFormInputField].
  const STPFormInputField({
    required this.label,
    required this.value,
    this.isRequired = false,
    this.icon,
    this.onTap,
    this.validator,
    this.keyboardType,
    this.controller,
    super.key,
  });

  /// Field label
  final String label;

  /// Current value to display
  final String value;

  /// Whether the field is required (shows red asterisk)
  final bool isRequired;

  /// Optional icon to display in the input
  final IconData? icon;

  /// Callback when field is tapped (for date/time pickers)
  final VoidCallback? onTap;

  /// Validator function
  final String? Function(String?)? validator;

  /// Keyboard type
  final TextInputType? keyboardType;

  /// Text editing controller (for editable fields)
  final TextEditingController? controller;

  // Design tokens
  static const double _borderRadius = 12;
  static const double _padding = 12;
  static const double _iconSize = 20;
  static const double _labelFontSize = 12;
  static const double _valueFontSize = 14;
  static const double _lineHeight = 1.4;
  static const double _gap = 8;

  @override
  Widget build(BuildContext context) {
    final isReadOnly = onTap != null;

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
        // Input field
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(_borderRadius),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: _padding),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.gray20),
              borderRadius: BorderRadius.circular(_borderRadius),
            ),
            child: Row(
              children: [
                // Icon (if provided)
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: _iconSize,
                    color: AppColors.gray70,
                  ),
                  const SizedBox(width: _gap),
                ],
                // Value or TextField
                Expanded(
                  child: isReadOnly
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            value.isEmpty ? 'Pilih $label' : value,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: _valueFontSize,
                                  fontWeight: FontWeight.w400,
                                  color: value.isEmpty
                                      ? AppColors.gray70
                                      : AppColors.gray100,
                                  fontFamily: AppConstants.fontFamily,
                                  height: _lineHeight,
                                ),
                          ),
                        )
                      : TextFormField(
                          controller: controller,
                          keyboardType: keyboardType,
                          validator: validator,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 12),
                            isDense: true,
                            hintText: value.isEmpty ? 'Pilih $label' : null,
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                fontSize: _valueFontSize,
                                fontWeight: FontWeight.w400,
                                color: AppColors.gray100,
                                fontFamily: AppConstants.fontFamily,
                                height: _lineHeight,
                              ),
                        ),
                ),
                // Dropdown arrow (if onTap is provided)
                if (onTap != null) ...[
                  const SizedBox(width: _gap),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: _iconSize,
                    color: AppColors.gray70,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

