import 'package:app_mobile_afms/features/home/presentation/constants/home_design_constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

/// Shimmer loader for DashboardSummaryGrid.
///
/// Mimics the structure of DashboardSummaryGrid with:
/// - 2x2 grid of metric cards
class DashboardSummaryShimmer extends StatelessWidget {
  /// Creates a new instance of [DashboardSummaryShimmer].
  const DashboardSummaryShimmer({super.key});

  // Design tokens - matching STPMetricCard and DashboardSummaryGrid
  static const double _cardSpacing = 12; // Figma: gap between cards
  static const double _cardPaddingVertical = 12; // Figma: padding 12px
  static const double _cardPaddingHorizontal = 16; // Figma: padding 16px
  static const double _borderRadius = 12;
  static const double _iconSize = 16; // Figma: 16x16px
  static const double _spacingTiny = 4; // Figma: gap 4px
  static const double _spacingSmall = 8; // Figma: gap 8px
  static const double _titleHeight =
      18; // Approximate title height (fontSize 12 * lineHeight 1.5)
  static const double _titleWidth = 80; // Approximate title width
  static const double _valueHeight =
      28; // Approximate value height (fontSize 20 * lineHeight 1.4)
  static const double _valueWidth = 60; // Approximate value width
  static const double _subtitleHeight =
      14; // Approximate subtitle height (fontSize 10 * lineHeight 1.4)
  static const double _subtitleWidth = 100; // Approximate subtitle width
  static const int _cardCount = 4; // 2x2 grid

  @override
  Widget build(BuildContext context) {
    // Build rows (2 cards per row)
    final rows = <Widget>[];
    for (var i = 0; i < _cardCount; i += 2) {
      final rowCards = List.generate(
        i + 2 <= _cardCount ? 2 : _cardCount - i,
        (index) => Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index == 0 ? _cardSpacing : 0),
            child: _buildCardShimmer(),
          ),
        ),
      );
      rows.add(Row(children: rowCards));
      if (i + 2 < _cardCount) {
        rows.add(const SizedBox(height: _cardSpacing));
      }
    }

    return Column(children: rows);
  }

  /// Builds a single card shimmer that mimics STPMetricCard structure
  Widget _buildCardShimmer() {
    return Shimmer(
      duration: const Duration(seconds: 1),
      color: HomeDesignConstants.primary20,
      colorOpacity: 0.35,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: _cardPaddingVertical,
          horizontal: _cardPaddingHorizontal,
        ),
        decoration: BoxDecoration(
          color: HomeDesignConstants.gray05,
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon and Title row
            Row(
              children: [
                // Icon shimmer
                Container(
                  width: _iconSize,
                  height: _iconSize,
                  decoration: BoxDecoration(
                    color: HomeDesignConstants.gray20,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: _spacingSmall),
                // Title shimmer
                Container(
                  width: _titleWidth,
                  height: _titleHeight,
                  decoration: BoxDecoration(
                    color: HomeDesignConstants.gray20,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
            const SizedBox(height: _spacingTiny),
            // Value and Subtitle column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Value shimmer
                Container(
                  width: _valueWidth,
                  height: _valueHeight,
                  decoration: BoxDecoration(
                    color: HomeDesignConstants.gray20,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: _spacingTiny),
                // Subtitle shimmer
                Container(
                  width: _subtitleWidth,
                  height: _subtitleHeight,
                  decoration: BoxDecoration(
                    color: HomeDesignConstants.gray20,
                    borderRadius: BorderRadius.circular(4),
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
