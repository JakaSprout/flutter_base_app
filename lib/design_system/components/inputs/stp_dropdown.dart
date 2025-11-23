import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/design_system/theme/app_colors.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Color configuration for STPDropdown.
///
/// Provides predefined color schemes for different dropdown styles.
class STPDropdownColors {
  /// Custom color scheme
  const STPDropdownColors({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.chevronColor,
  });

  /// Primary color scheme (for company dropdown, etc.)
  const STPDropdownColors.primary()
    : backgroundColor = AppColors.infoLight,
      borderColor = AppColors.primary20,
      textColor = AppColors.primary,
      chevronColor = AppColors.primary;

  /// Gray color scheme (for block filter, etc.)
  const STPDropdownColors.gray()
    : backgroundColor = AppColors.white,
      borderColor = AppColors.gray20,
      textColor = AppColors.gray100,
      chevronColor = AppColors.gray100;

  /// Background color for dropdown trigger and menu
  final Color backgroundColor;

  /// Border color for dropdown trigger and menu
  final Color borderColor;

  /// Text color for selected value and menu items
  final Color textColor;

  /// Chevron icon color
  final Color chevronColor;
}

/// Reusable dropdown component with configurable colors and styling.
///
/// This component provides a consistent dropdown implementation that can be
/// used across different features with different color schemes.
///
/// Example:
/// ```dart
/// STPDropdown<String>(
///   items: ['Option 1', 'Option 2', 'Option 3'],
///   selectedValue: selectedValue,
///   onChanged: (value) => setState(() => selectedValue = value),
///   colors: STPDropdownColors.primary(),
///   label: 'Select Option:',
/// )
/// ```
class STPDropdown<T> extends StatefulWidget {
  /// Creates a new instance of [STPDropdown].
  const STPDropdown({
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.colors,
    super.key,
    this.label,
    this.hint,
    this.enabled = true,
    this.showBorder = true,
    this.displayText,
  });

  /// List of items to display in the dropdown
  final List<T> items;

  /// Currently selected value
  final T? selectedValue;

  /// Callback when selection changes
  final ValueChanged<T> onChanged;

  /// Color configuration for the dropdown
  final STPDropdownColors colors;

  /// Optional label to display before the selected value
  final String? label;

  /// Optional hint text when no value is selected
  final String? hint;

  /// Whether the dropdown is enabled
  final bool enabled;

  /// Whether to show border on trigger (default: true)
  final bool showBorder;

  /// Optional function to get display text for each item
  final String Function(T)? displayText;

  @override
  State<STPDropdown<T>> createState() => _STPDropdownState<T>();
}

class _STPDropdownState<T> extends State<STPDropdown<T>> {
  // Design tokens
  static const double _chevronSize = 20;
  static const double _spacingSmall = 8;
  static const double _spacingMedium = 12;
  static const double _borderRadius = 12;
  static const double _fontSizeSmall = 12; // For label
  static const double _fontSizeValue = 14; // For selected value (consistent with FormInputField)
  static const double _lineHeight = 1.4;
  static const double _handleHeight = 4;
  static const double _handleWidth = 40;
  static const double _titleFontSize = 16;
  static const double _itemPaddingVertical = 16;
  static const double _itemPaddingHorizontal = 16;
  static const double _itemSpacing = 8;
  static const double _headerPaddingVertical = 16;
  static const double _headerPaddingHorizontal = 16;
  static const double _bottomSheetPadding = 16;
  static const double _bottomSheetBottomPadding = 40; // Extra spacing at bottom for list items

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.enabled ? () => _showDropdown(context) : null,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: _spacingMedium,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: widget.colors.backgroundColor,
          border: widget.showBorder
              ? Border.all(color: widget.colors.borderColor)
              : null,
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: Row(
          children: [
            // Label (if provided)
            if (widget.label != null) ...[
              Text(
                widget.label!,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontSize: _fontSizeSmall,
                  fontWeight: FontWeight.w400, // Regular
                  color: widget.colors.textColor,
                  fontFamily: AppConstants.fontFamily,
                  height: _lineHeight,
                ),
              ),
              const SizedBox(width: _spacingSmall),
            ],
            // Selected Value or Hint
            Expanded(
              child: Text(
                widget.selectedValue != null
                    ? (widget.displayText != null
                        ? widget.displayText!(widget.selectedValue as T)
                        : widget.selectedValue.toString())
                    : (widget.hint ?? ''),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: _fontSizeValue,
                  fontWeight: widget.selectedValue != null
                      ? FontWeight.w400 // Regular when selected (consistent with FormInputField)
                      : FontWeight.w400, // Regular for hint
                  color: widget.selectedValue != null
                      ? widget.colors.textColor
                      : AppColors.gray70, // Hint color (consistent with FormInputField)
                  fontFamily: AppConstants.fontFamily,
                  height: _lineHeight,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: _spacingSmall),
            // Chevron Down Icon
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                widget.colors.chevronColor,
                BlendMode.srcIn,
              ),
              child: SvgPicture.asset(
                Assets.icons.outline.chevronDown,
                width: _chevronSize,
                height: _chevronSize,
                placeholderBuilder: (context) => Icon(
                  Icons.keyboard_arrow_down,
                  size: _chevronSize,
                  color: widget.colors.chevronColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Shows the dropdown menu as a bottom sheet.
  void _showDropdown(BuildContext context) {
    showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        decoration: BoxDecoration(
          color: widget.colors.backgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(_borderRadius),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: _handleWidth,
                height: _handleHeight,
                decoration: BoxDecoration(
                  color: AppColors.gray20,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Title and Close button (only show if hint is provided)
              if (widget.hint != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: _headerPaddingHorizontal,
                    vertical: _headerPaddingVertical,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.hint!,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                fontSize: _titleFontSize,
                                fontWeight: FontWeight.w600,
                                color: AppColors.gray100,
                                fontFamily: AppConstants.fontFamily,
                              ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 24),
                        color: AppColors.gray100,
                        onPressed: () => Navigator.pop(context),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
              // List of items
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                    left: _bottomSheetPadding,
                    right: _bottomSheetPadding,
                    bottom: _bottomSheetBottomPadding,
                    top: widget.hint != null ? 0 : _spacingSmall,
                  ),
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  final item = widget.items[index];
                  final isSelected = item == widget.selectedValue;

                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index < widget.items.length - 1
                          ? _itemSpacing
                          : 0,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context, item);
                        widget.onChanged(item);
                      },
                      borderRadius: BorderRadius.circular(_borderRadius),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: _itemPaddingHorizontal,
                          vertical: _itemPaddingVertical,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary20
                              : AppColors.white,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.gray20,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(_borderRadius),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.displayText != null
                                    ? widget.displayText!(item)
                                    : item.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontSize: _fontSizeValue,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                      color: widget.colors.textColor,
                                      fontFamily: AppConstants.fontFamily,
                                      height: _lineHeight,
                                    ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (isSelected) ...[
                              const SizedBox(width: _spacingSmall),
                              const Icon(
                                Icons.check,
                                size: 20,
                                color: AppColors.primary,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
