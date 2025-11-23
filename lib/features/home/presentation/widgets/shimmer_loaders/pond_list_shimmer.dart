import 'package:app_mobile_afms/features/home/presentation/constants/home_design_constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

/// Shimmer loader for PondListSection.
///
/// Mimics the structure of PondListSection with:
/// - Header (title + count + "Lihat Semua")
/// - List of pond items
class PondListShimmer extends StatelessWidget {
  /// Creates a new instance of [PondListShimmer].
  const PondListShimmer({super.key});

  // Design tokens - matching PondListSection and PondListItem
  static const double _headerSpacing = 24; // Spacing between header and list
  static const double _itemSpacing = 12; // Figma: gap 12px between list items
  static const double _itemPaddingHorizontal =
      16; // Figma: padding horizontal 16px
  static const double _itemPaddingVertical = 12; // Figma: padding vertical 12px
  static const double _borderRadius = 12; // Figma: borderRadius 12px
  static const double _gap = 8; // Gap between name and ID
  static const double _iconSize = 24; // Chevron icon size
  static const double _nameHeight =
      20; // Approximate name height (fontSize 14 * lineHeight 1.4)
  static const double _nameWidth = 120; // Approximate name width
  static const double _idHeight =
      17; // Approximate ID height (fontSize 12 * lineHeight 1.4)
  static const double _idWidth = 100; // Approximate ID width
  static const int _itemCount = 4; // Number of items to show

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header placeholder
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Title with count placeholder
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Shimmer(
                  duration: const Duration(seconds: 1),
                  color: HomeDesignConstants.primary20,
                  colorOpacity: 0.35,
                  child: Container(
                    width: 120,
                    height: 24,
                    decoration: BoxDecoration(
                      color: HomeDesignConstants.gray05,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                // Count placeholder
                Shimmer(
                  duration: const Duration(seconds: 1),
                  color: HomeDesignConstants.primary20,
                  colorOpacity: 0.35,
                  child: Container(
                    width: 40,
                    height: 24,
                    decoration: BoxDecoration(
                      color: HomeDesignConstants.gray05,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
            // "Lihat Semua" placeholder
            Shimmer(
              duration: const Duration(seconds: 1),
              color: HomeDesignConstants.primary20,
              colorOpacity: 0.35,
              child: Container(
                width: 80,
                height: 18,
                decoration: BoxDecoration(
                  color: HomeDesignConstants.gray05,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: _headerSpacing),
        // List items
        ...List.generate(
          _itemCount,
          (index) => Padding(
            padding: EdgeInsets.only(
              bottom: index < _itemCount - 1 ? _itemSpacing : 0,
            ),
            child: _buildItemShimmer(),
          ),
        ),
      ],
    );
  }

  /// Builds a single item shimmer that mimics PondListItem structure
  Widget _buildItemShimmer() {
    return Shimmer(
      duration: const Duration(seconds: 1),
      color: HomeDesignConstants.primary20,
      colorOpacity: 0.35,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: _itemPaddingHorizontal,
          vertical: _itemPaddingVertical,
        ),
        decoration: BoxDecoration(
          color: HomeDesignConstants.gray05,
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: Row(
          children: [
            // Pond name and ID column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Pond name shimmer
                  Container(
                    width: _nameWidth,
                    height: _nameHeight,
                    decoration: BoxDecoration(
                      color: HomeDesignConstants.gray20,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: _gap),
                  // Pond ID shimmer
                  Container(
                    width: _idWidth,
                    height: _idHeight,
                    decoration: BoxDecoration(
                      color: HomeDesignConstants.gray20,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: _gap),
            // Chevron icon shimmer
            Container(
              width: _iconSize,
              height: _iconSize,
              decoration: BoxDecoration(
                color: HomeDesignConstants.gray20,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
