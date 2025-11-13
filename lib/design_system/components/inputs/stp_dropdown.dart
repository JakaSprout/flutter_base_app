import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/gen/assets.gen.dart';
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

  @override
  State<STPDropdown<T>> createState() => _STPDropdownState<T>();
}

class _STPDropdownState<T> extends State<STPDropdown<T>> {
  final GlobalKey _dropdownKey = GlobalKey();

  // Design tokens
  static const double _chevronSize = 20;
  static const double _spacingSmall = 8;
  static const double _spacingMedium = 12;
  static const double _borderRadius = 12;
  static const double _fontSizeSmall = 12;
  static const double _lineHeight = 1.4;
  static const double _menuGap = 4;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.enabled ? () => _showDropdown(context) : null,
      child: Container(
        key: _dropdownKey,
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
                widget.selectedValue?.toString() ?? widget.hint ?? '',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontSize: _fontSizeSmall,
                  fontWeight: widget.selectedValue != null
                      ? FontWeight
                            .w600 // Semibold when selected
                      : FontWeight.w400, // Regular for hint
                  color: widget.colors.textColor,
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

  /// Shows the dropdown menu below the trigger widget.
  void _showDropdown(BuildContext context) {
    final renderBox =
        _dropdownKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    showMenu<T>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + size.height + _menuGap,
        offset.dx + size.width,
        offset.dy + size.height + _menuGap,
      ),
      color: widget.colors.backgroundColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        side: BorderSide(color: widget.colors.borderColor),
      ),
      constraints: BoxConstraints.tightFor(width: size.width),
      items: widget.items.map((T item) {
        return PopupMenuItem<T>(
          value: item,
          padding: EdgeInsets.zero,
          child: SizedBox(
            width: size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: _spacingMedium,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: widget.colors.borderColor),
                ),
              ),
              child: Text(
                item.toString(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: _fontSizeSmall,
                  fontWeight: FontWeight.w400, // Regular
                  color: widget.colors.textColor,
                  fontFamily: AppConstants.fontFamily,
                  height: _lineHeight,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );
      }).toList(),
    ).then((T? selectedItem) {
      if (selectedItem != null) {
        widget.onChanged(selectedItem);
      }
    });
  }
}
