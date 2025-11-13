import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/home/presentation/constants/home_constants.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/pond_list_item.dart';
import 'package:go_router/go_router.dart';

/// Pond List section for Home screen.
///
/// Displays a list of ponds with a header containing title with count
/// and "Lihat Semua" link.
class PondListSection extends StatelessWidget {
  /// Creates a new instance of [PondListSection].
  const PondListSection({
    super.key,
    this.ponds,
    this.onSeeAllTap,
    this.onPondTap,
  });

  /// List of ponds to display
  final List<PondData>? ponds;

  /// Callback when "Lihat Semua" is tapped
  final VoidCallback? onSeeAllTap;

  /// Callback when a pond item is tapped
  /// Receives the pond ID as parameter
  final ValueChanged<String>? onPondTap;

  // Design tokens - exact Figma specs
  static const double _headerSpacing = 24; // Spacing between header and list
  static const double _itemSpacing = 12; // Figma: gap 12px between list items
  static const double _fontSizeTitle =
      16; // Figma: Body/Small/Medium/Semibold - fontSize 16
  static const double _fontSizeCount =
      16; // Figma: Body/Small/Medium/Semibold - fontSize 16 (orange)
  static const double _fontSizeSeeAll =
      12; // Figma: Label/Medium/Semibold - fontSize 12
  static const double _lineHeight = 1.5; // Figma: lineHeight 1.5em
  static const int _maxVisibleItems = 8; // Maximum items to show

  @override
  Widget build(BuildContext context) {
    final pondsList = ponds ?? HomeConstants.defaultPonds;
    final visiblePonds = pondsList.take(_maxVisibleItems).toList();
    final pondCount = pondsList.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header: Title with count and "Lihat Semua" link
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Title with count
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  HomeConstants.pondListSectionTitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: _fontSizeTitle,
                    fontWeight: FontWeight.w600, // Semibold
                    color: AppColors.gray100,
                    fontFamily: AppConstants.fontFamily,
                    height: _lineHeight,
                  ),
                ),
                const SizedBox(width: 4),
                // Count in orange
                Text(
                  '($pondCount)',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: _fontSizeCount,
                    fontWeight: FontWeight.w600, // Semibold
                    color: AppColors.secondary, // Secondary/60 (Base)
                    fontFamily: AppConstants.fontFamily,
                    height: _lineHeight,
                  ),
                ),
              ],
            ),
            // "Lihat Semua" link with tap feedback
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap:
                    onSeeAllTap ??
                    () {
                      context.go('/pond');
                    },
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  child: Text(
                    HomeConstants.pondListSeeAllLabel,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: _fontSizeSeeAll,
                      fontWeight: FontWeight.w600, // Semibold
                      color: AppColors.secondary, // Secondary/60 (Base)
                      fontFamily: AppConstants.fontFamily,
                      height: _lineHeight,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: _headerSpacing),
        // List of pond items
        ...visiblePonds.asMap().entries.map((entry) {
          final index = entry.key;
          final pond = entry.value;
          return Padding(
            padding: EdgeInsets.only(
              bottom: index < visiblePonds.length - 1 ? _itemSpacing : 0,
            ),
            child: PondListItem(
              pondName: pond.name,
              pondId: pond.id,
              onTap: () => onPondTap?.call(pond.id),
            ),
          );
        }),
      ],
    );
  }
}
