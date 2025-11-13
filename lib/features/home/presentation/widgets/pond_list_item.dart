import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';

/// Pond list item widget for displaying a single pond entry.
///
/// Displays pond name, ID, and a chevron icon for navigation.
/// Used in the Pond List Section.
///
/// Example:
/// ```dart
/// PondListItem(
///   pondName: 'Kolam A1',
///   pondId: 'TKH00A1',
///   onTap: () => navigateToPondDetail('TKH00A1'),
/// )
/// ```
class PondListItem extends StatelessWidget {
  /// Creates a new instance of [PondListItem].
  const PondListItem({
    required this.pondName,
    required this.pondId,
    super.key,
    this.onTap,
  });

  /// Pond name (e.g., "Kolam A1")
  final String pondName;

  /// Pond ID (e.g., "TKH00A1")
  final String pondId;

  /// Optional callback when item is tapped
  final VoidCallback? onTap;

  // Design tokens - exact Figma specs
  static const Color _gray100 = AppColors.gray100;
  static const Color _gray70 = AppColors.gray70;
  static const Color _gray05 = AppColors.gray05;

  static const double _borderRadius = 12; // Figma: borderRadius 12px
  static const double _paddingHorizontal = 16; // Figma: padding horizontal
  static const double _paddingVertical = 12; // Figma: padding vertical
  static const double _gap = 8; // Gap between name and ID
  static const double _iconSize = 24; // Chevron icon size
  static const double _fontSizeName = 14; // Body/Small/Medium/Bold
  static const double _fontSizeId = 12; // Body/Small/Regular
  static const double _lineHeight = 1.4;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: _gray05,
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(_borderRadius),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: _paddingHorizontal,
              vertical: _paddingVertical,
            ),
            child: Row(
              children: [
                // Pond name and ID column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Pond name
                      Text(
                        pondName,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: _fontSizeName,
                          fontWeight: FontWeight.w700, // Bold
                          color: _gray100,
                          fontFamily: AppConstants.fontFamily,
                          height: _lineHeight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: _gap),
                      // Pond ID
                      Text(
                        'Kolam ID: $pondId',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: _fontSizeId,
                          fontWeight: FontWeight.w400, // Regular
                          color: _gray70,
                          fontFamily: AppConstants.fontFamily,
                          height: _lineHeight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: _gap),
                // Chevron icon
                const Icon(
                  Icons.chevron_right,
                  size: _iconSize,
                  color: _gray100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
