import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Metric card widget for displaying key metrics with icon, title, value,
/// and subtitle.
///
/// This is a reusable component that can be used across different features
/// to display metric information in a consistent card format.
///
/// Example:
/// ```dart
/// STPMetricCard(
///   iconPath: 'assets/icons/outline/chart.svg',
///   title: 'Total Sales',
///   value: '1.000',
///   unit: 'kg',
///   subtitle: 'from 8 active items',
///   onTap: () => navigateToDetails(),
/// )
/// ```
class STPMetricCard extends StatelessWidget {
  /// Creates a new instance of [STPMetricCard].
  const STPMetricCard({
    required this.iconPath,
    required this.title,
    required this.value,
    required this.subtitle,
    this.unit,
    this.onTap,
    super.key,
  });

  /// Path to the icon asset (SVG)
  final String iconPath;

  /// Card title
  final String title;

  /// Card value (main number/text)
  final String value;

  /// Card unit (e.g., "kg", "juta", "%")
  final String? unit;

  /// Card subtitle (additional info)
  final String subtitle;

  /// Optional callback when card is tapped
  final VoidCallback? onTap;

  // Design tokens - using shared colors from design system
  static const Color _gray100 = AppColors.gray100;
  static const Color _gray70 = AppColors.gray70;
  static const Color _gray05 = AppColors.gray05;

  // Widget-specific spacing constants - exact Figma specs
  static const double _iconSize = 16; // Figma: 16x16px
  static const double _spacingTiny = 4; // Figma: gap 4px
  static const double _spacingSmall = 8; // Figma: gap 8px
  static const double _borderRadius = 12;
  static const double _fontSizeSmall = 12; // Title
  static const double _fontSizeValue = 20; // Value: Body/H4 (20)/Bold
  static const double _fontSizeUnit = 10; // Unit: Body/Small/Small/Regular
  static const double _fontSizeSubtitle = 10; // Subtitle: Label/Small/Regular
  static const double _lineHeight = 1.4;
  static const double _cardPaddingVertical = 12; // Figma: padding 12px 16px
  static const double _cardPaddingHorizontal = 16;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: _cardPaddingVertical,
          horizontal: _cardPaddingHorizontal,
        ),
        decoration: BoxDecoration(
          color: _gray05,
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon and Title row - Figma: Frame 2095586025 with gap 8px
            Row(
              children: [
                // Only apply color filter if icon doesn't have hardcoded colors
                // (_color suffix)
                if (iconPath.contains('_color'))
                  SvgPicture.asset(
                    iconPath,
                    width: _iconSize,
                    height: _iconSize,
                    placeholderBuilder: (context) => const Icon(
                      Icons.help_outline,
                      size: _iconSize,
                      color: _gray100,
                    ),
                  )
                else
                  ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      _gray100,
                      BlendMode.srcIn,
                    ),
                    child: SvgPicture.asset(
                      iconPath,
                      width: _iconSize,
                      height: _iconSize,
                      placeholderBuilder: (context) => const Icon(
                        Icons.help_outline,
                        size: _iconSize,
                        color: _gray100,
                      ),
                    ),
                  ),
                const SizedBox(width: _spacingSmall),
                // Title
                Flexible(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: _fontSizeSmall,
                          fontWeight: FontWeight.w400, // Regular
                          color: _gray100,
                          fontFamily: AppConstants.fontFamily,
                          height: 1.5, // Figma: lineHeight 1.5em
                        ),
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: _spacingTiny), // Figma: gap 4px
            // Value and Subtitle column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Value with unit - Figma: Frame 25 with gap 4px
                IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Value
                      Text(
                        value,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              fontSize: _fontSizeValue,
                              fontWeight: FontWeight.w700, // Bold
                              color: _gray100,
                              fontFamily: AppConstants.fontFamily,
                              height: _lineHeight,
                            ),
                      ),
                      if (unit != null) ...[
                        const SizedBox(width: _spacingTiny), // Figma: gap 4px
                        // Unit - vertically centered with value
                        Center(
                          child: Text(
                            unit!,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  fontSize: _fontSizeUnit,
                                  fontWeight: FontWeight.w400, // Regular
                                  color: _gray100,
                                  fontFamily: AppConstants.fontFamily,
                                  height: _lineHeight,
                                ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                // Subtitle
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: _fontSizeSubtitle,
                        fontWeight: FontWeight.w400, // Regular
                        color: _gray70, // Figma: Gray/70
                        fontFamily: AppConstants.fontFamily,
                        height: _lineHeight,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
