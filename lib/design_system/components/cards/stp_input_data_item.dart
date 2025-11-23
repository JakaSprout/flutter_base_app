import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/design_system/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Input Data item widget for displaying a single input data category.
///
/// Displays a circular icon with background color and a label below.
/// Used in the Input Data Section grid.
///
/// Example:
/// ```dart
/// STPInputDataItem(
///   iconPath: 'assets/icons/outline/feed.svg',
///   label: 'Pakan',
///   backgroundColor: AppColors.inputDataPakanBg,
///   iconColor: AppColors.inputDataPakanIcon,
///   onTap: () => navigateToPakanInput(),
/// )
/// ```
class STPInputDataItem extends StatelessWidget {
  /// Creates a new instance of [STPInputDataItem].
  const STPInputDataItem({
    required this.iconPath,
    required this.label,
    required this.backgroundColor,
    required this.iconColor,
    this.onTap,
    super.key,
  });

  /// Path to the icon asset (SVG)
  final String iconPath;

  /// Label text below the icon
  final String label;

  /// Background color for the circular icon container
  final Color backgroundColor;

  /// Icon color
  final Color iconColor;

  /// Optional callback when item is tapped
  final VoidCallback? onTap;

  // Design tokens - exact Figma specs
  static const double _containerSize = 81.5; // Figma: 81.5x81.5px
  static const double _iconContainerSize = 48; // Figma: 48x48px
  static const double _iconSize =
      48; // Icon size for _color icons (already have background)
  static const double _iconSizeNoColor =
      24; // Icon size for icons without background
  static const double _gap = 8; // Figma: gap 8px
  static const double _borderRadius = 200; // Circular (200px for full circle)
  static const double _fontSize = 10; // Label/Small/Semibold
  static const double _lineHeight = 1.4; // Figma: lineHeight 1.4em

  @override
  Widget build(BuildContext context) {
    // Check if icon has hardcoded colors (_color suffix)
    // Icons with _color suffix (48x48px with background) are rendered directly
    // Icons without _color suffix (24x24px without background) use container
    final hasColor = iconPath.contains('_color');

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: _containerSize,
          height: _containerSize,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon container
              if (hasColor)
                // Icon with hardcoded colors and background (48x48px)
                // - render directly
                SvgPicture.asset(
                  iconPath,
                  width: _iconSize,
                  height: _iconSize,
                  placeholderBuilder: (context) => Icon(
                    Icons.help_outline,
                    size: _iconSize,
                    color: iconColor,
                  ),
                )
              else
                // Icon without background (24x24px)
                // - add background and color filter
                Container(
                  width: _iconContainerSize,
                  height: _iconContainerSize,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(_borderRadius),
                  ),
                  child: Center(
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                      child: SvgPicture.asset(
                        iconPath,
                        width: _iconSizeNoColor,
                        height: _iconSizeNoColor,
                        placeholderBuilder: (context) => Icon(
                          Icons.help_outline,
                          size: _iconSizeNoColor,
                          color: iconColor,
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: _gap),
              // Label
              Text(
                label,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: _fontSize,
                  fontWeight: FontWeight.w600, // Semibold
                  color: AppColors.gray100,
                  fontFamily: AppConstants.fontFamily,
                  height: _lineHeight,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
