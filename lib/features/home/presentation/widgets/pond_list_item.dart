import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/home/presentation/constants/home_design_constants.dart';

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

  // Design tokens - using shared colors from design system
  static const Color _gray100 = AppColors.gray100;
  static const Color _gray70 = AppColors.gray70;
  static const Color _gray05 = AppColors.gray05;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: _gray05,
          borderRadius: BorderRadius.circular(
            HomeDesignConstants.pondListItemBorderRadius,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(
            HomeDesignConstants.pondListItemBorderRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: HomeDesignConstants.pondListItemPaddingHorizontal,
              vertical: HomeDesignConstants.pondListItemPaddingVertical,
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
                          fontSize:
                              HomeDesignConstants.pondListItemNameFontSize,
                          fontWeight: FontWeight.w700,
                          color: _gray100,
                          fontFamily: AppConstants.fontFamily,
                          height: HomeDesignConstants.pondListItemLineHeight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: HomeDesignConstants.pondListItemGap,
                      ),
                      // Pond ID
                      Text(
                        'Kolam ID: $pondId',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: HomeDesignConstants.pondListItemIdFontSize,
                          fontWeight: FontWeight.w400,
                          color: _gray70,
                          fontFamily: AppConstants.fontFamily,
                          height: HomeDesignConstants.pondListItemLineHeight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: HomeDesignConstants.pondListItemGap,
                ),
                // Chevron icon
                const Icon(
                  Icons.chevron_right,
                  size: HomeDesignConstants.pondListItemIconSize,
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
