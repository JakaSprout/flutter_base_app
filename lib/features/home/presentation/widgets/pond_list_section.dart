import 'package:flutter/material.dart';
import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/features/home/presentation/constants/home_constants.dart';
import 'package:app_mobile_afms/features/home/presentation/constants/home_design_constants.dart';
import 'package:app_mobile_afms/features/home/presentation/widgets/pond_list_item.dart';
import 'package:app_mobile_afms/router/routes.dart';
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

  @override
  Widget build(BuildContext context) {
    final pondsList = ponds ?? HomeConstants.defaultPonds;
    final visiblePonds =
        pondsList.take(HomeDesignConstants.pondListMaxVisibleItems).toList();
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
                    fontSize: HomeDesignConstants.pondListTitleFontSize,
                    fontWeight: FontWeight.w600,
                    color: HomeDesignConstants.gray100,
                    fontFamily: AppConstants.fontFamily,
                    height: HomeDesignConstants.pondListLineHeight,
                  ),
                ),
                const SizedBox(
                  width: HomeDesignConstants.pondListCountSpacing,
                ),
                // Count in orange
                Text(
                  '($pondCount)',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: HomeDesignConstants.pondListCountFontSize,
                    fontWeight: FontWeight.w600,
                    color: HomeDesignConstants.secondary,
                    fontFamily: AppConstants.fontFamily,
                    height: HomeDesignConstants.pondListLineHeight,
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
                      context.go(Routes.pond);
                    },
                borderRadius: BorderRadius.circular(
                  HomeDesignConstants.pondListLinkBorderRadius,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal:
                        HomeDesignConstants.pondListLinkPaddingHorizontal,
                    vertical: HomeDesignConstants.pondListLinkPaddingVertical,
                  ),
                  child: Text(
                    HomeConstants.pondListSeeAllLabel,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: HomeDesignConstants.pondListSeeAllFontSize,
                      fontWeight: FontWeight.w600,
                      color: HomeDesignConstants.secondary,
                      fontFamily: AppConstants.fontFamily,
                      height: HomeDesignConstants.pondListLineHeight,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: HomeDesignConstants.pondListHeaderSpacing,
        ),
        // List of pond items
        ...visiblePonds.asMap().entries.map((entry) {
          final index = entry.key;
          final pond = entry.value;
          return Padding(
            padding: EdgeInsets.only(
              bottom: index < visiblePonds.length - 1
                  ? HomeDesignConstants.pondListItemSpacing
                  : 0,
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
