import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

/// Shimmer loader for InputDataSection.
///
/// Mimics the structure of InputDataSection with:
/// - Grid of 8 items (2 rows x 4 columns)
class InputDataShimmer extends StatelessWidget {
  /// Creates a new instance of [InputDataShimmer].
  const InputDataShimmer({super.key});

  // Design tokens - matching InputDataSection and STPInputDataItem
  static const double _gridSpacing = 8; // Figma: gap 8px
  static const double _headerSpacing = 24; // Spacing between header and grid
  static const double _containerSize =
      81.5; // Figma: 81.5x81.5px (total container)
  static const double _iconContainerSize =
      48; // Figma: 48x48px (icon container)
  static const double _gap = 8; // Figma: gap 8px between icon and label
  static const double _labelHeight =
      14; // Approximate label height (fontSize 10 * lineHeight 1.4)
  static const double _labelWidth = 50; // Approximate label width
  static const double _headerTitleHeight =
      24; // Approximate header title height (fontSize 16 * lineHeight 1.5)
  static const double _headerTitleWidth = 100; // Approximate header title width
  static const double _headerSeeAllHeight =
      18; // Approximate "Lihat Semua" height (fontSize 12 * lineHeight 1.5)
  static const double _headerSeeAllWidth =
      80; // Approximate "Lihat Semua" width
  static const int _itemCount = 8; // 2 rows x 4 columns

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header shimmer
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Title shimmer
            Shimmer(
              duration: const Duration(seconds: 1),
              color: AppColors.primary20,
              colorOpacity: 0.35,
              child: Container(
                width: _headerTitleWidth,
                height: _headerTitleHeight,
                decoration: BoxDecoration(
                  color: AppColors.gray05,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            // "Lihat Semua" shimmer
            Shimmer(
              duration: const Duration(seconds: 1),
              color: AppColors.primary20,
              colorOpacity: 0.35,
              child: Container(
                width: _headerSeeAllWidth,
                height: _headerSeeAllHeight,
                decoration: BoxDecoration(
                  color: AppColors.gray05,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: _headerSpacing),
        // Grid items
        _buildGrid(),
      ],
    );
  }

  /// Builds the grid of shimmer items
  Widget _buildGrid() {
    // Split items into rows (4 items per row)
    final rows = <List<Widget>>[];
    for (var i = 0; i < _itemCount; i += 4) {
      final rowItems = List.generate(
        i + 4 <= _itemCount ? 4 : _itemCount - i,
        (index) => Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index < 3 ? _gridSpacing : 0),
            child: SizedBox(
              width: _containerSize,
              height: _containerSize,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon container shimmer
                  Container(
                    width: _iconContainerSize,
                    height: _iconContainerSize,
                    decoration: const BoxDecoration(
                      color: AppColors.gray05,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: _gap),
                  // Label shimmer
                  Shimmer(
                    duration: const Duration(seconds: 1),
                    color: AppColors.primary20,
                    colorOpacity: 0.35,
                    child: Container(
                      width: _labelWidth,
                      height: _labelHeight,
                      decoration: BoxDecoration(
                        color: AppColors.gray05,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      rows.add(rowItems);
    }

    return Column(
      children: rows.asMap().entries.map((entry) {
        final isLast = entry.key == rows.length - 1;
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: entry.value,
            ),
            if (!isLast) const SizedBox(height: _gridSpacing),
          ],
        );
      }).toList(),
    );
  }
}
