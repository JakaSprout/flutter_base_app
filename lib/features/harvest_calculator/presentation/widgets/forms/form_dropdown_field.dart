import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter/material.dart';

/// Reusable dropdown field widget with label and required indicator.
///
/// Figma: Label with required indicator (*), gap 8px, field with padding 8px 16px,
/// height fixed, border radius 8px, border Gray/20, dropdown arrow icon
class FormDropdownField<T> extends StatelessWidget {
  /// Creates a new instance of [FormDropdownField].
  const FormDropdownField({
    required this.label,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.isRequired = false,
    this.hint,
    this.displayText,
    super.key,
  });

  /// Field label
  final String label;

  /// List of items to display
  final List<T> items;

  /// Currently selected value
  final T? selectedValue;

  /// Callback when selection changes
  final ValueChanged<T> onChanged;

  /// Whether the field is required (shows red asterisk)
  final bool isRequired;

  /// Optional hint text when no value is selected
  final String? hint;

  /// Optional function to get display text for each item
  final String Function(T)? displayText;

  // Design tokens from Figma
  static const double _gap = 8;
  static const double _fieldPaddingHorizontal = 16;
  static const double _fieldPaddingVertical = 8;
  static const double _fieldHeight = 40;
  static const double _iconSize = 24;

  @override
  Widget build(BuildContext context) {
    final displayValue = selectedValue != null
        ? (displayText != null
              ? displayText!(selectedValue as T)
              : selectedValue.toString())
        : null;

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
          child: InkWell(
            onTap: () {
              _showDropdownBottomSheet<T>(
                context: context,
                items: items,
                selectedValue: selectedValue,
                onChanged: onChanged,
                displayText: displayText,
              );
            },
            borderRadius: BorderRadius.circular(
              HarvestCalculatorDesignConstants.inputBorderRadius,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: _fieldPaddingHorizontal,
                vertical: _fieldPaddingVertical,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      displayValue ?? hint ?? 'Pilih $label',
                      style: displayValue != null
                          ? HarvestCalculatorDesignConstants.formFieldTextStyle
                          : HarvestCalculatorDesignConstants
                                .formFieldPlaceholderTextStyle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Dropdown arrow icon
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: _iconSize,
                    color: HarvestCalculatorDesignConstants.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDropdownBottomSheet<T>({
    required BuildContext context,
    required List<T> items,
    required T? selectedValue,
    required ValueChanged<T> onChanged,
    String Function(T)? displayText,
  }) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Items list
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final isSelected = item == selectedValue;
                  final displayItem = displayText != null
                      ? displayText(item)
                      : item.toString();

                  return ListTile(
                    title: Text(displayItem),
                    selected: isSelected,
                    onTap: () {
                      onChanged(item);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
