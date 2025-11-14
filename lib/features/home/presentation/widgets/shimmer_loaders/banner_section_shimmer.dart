import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

/// Shimmer loader for BannerSection.
///
/// Mimics the structure of BannerSection with:
/// - Horizontal scrollable cards
/// - Pagination indicators
class BannerSectionShimmer extends StatelessWidget {
  /// Creates a new instance of [BannerSectionShimmer].
  const BannerSectionShimmer({super.key});

  // Design tokens - matching BannerSection
  static const double _cardWidth = 300; // Figma: card width 300px
  static const double _cardHeight = 88; // Figma: card height 88px
  static const double _cardSpacing = 12; // Figma: gap between cards
  static const double _indicatorSpacing = 4; // Figma: gap between indicators
  static const double _indicatorSize = 6; // Figma: indicator dot size
  static const double _peekWidth = 16; // Width of peek for next card
  static const int _cardCount = 2; // Number of banner cards to show

  // Design tokens - matching BannerCard
  static const double _borderRadius = 12; // Figma: borderRadius 12px
  static const double _padding = 12; // Figma: padding 12px
  static const double _imageWidth = 52; // Figma: image width 52px
  static const double _imageHeight = 52; // Figma: image height 52px
  static const double _gap = 12; // Figma: gap 12px between image and text
  static const double _titleHeight =
      20; // Approximate title height (fontSize 14 * lineHeight)
  static const double _titleWidth = 120; // Approximate title width
  static const double _descriptionHeight =
      16; // Approximate description height (fontSize 12 * lineHeight)
  static const double _descriptionWidth = 150; // Approximate description width

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Horizontal scrollable cards with peek
        SizedBox(
          height: _cardHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(
              left: 20, // Left padding for first card
              right: _peekWidth + 20, // Right padding + peek width
            ),
            itemCount: _cardCount,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: index < _cardCount - 1 ? _cardSpacing : 0,
                ),
                child: SizedBox(width: _cardWidth, child: _buildCardShimmer()),
              );
            },
          ),
        ),
        const SizedBox(height: 12), // Spacing between cards and indicators
        // Pagination indicators with horizontal padding
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _cardCount,
              (index) => Container(
                margin: const EdgeInsets.only(right: _indicatorSpacing),
                width: _indicatorSize,
                height: _indicatorSize,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.gray20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds a single card shimmer that mimics BannerCard structure
  Widget _buildCardShimmer() {
    return Shimmer(
      duration: const Duration(seconds: 1),
      color: AppColors.primary20,
      colorOpacity: 0.35,
      child: Container(
        height: _cardHeight,
        decoration: BoxDecoration(
          color: AppColors.gray05,
          borderRadius: BorderRadius.circular(_borderRadius),
          border: Border.all(color: AppColors.gray20),
        ),
        padding: const EdgeInsets.all(_padding),
        child: Row(
          children: [
            // Image shimmer
            Container(
              width: _imageWidth,
              height: _imageHeight,
              decoration: BoxDecoration(
                color: AppColors.gray20,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: _gap),
            // Title and Description column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title shimmer
                  Container(
                    width: _titleWidth,
                    height: _titleHeight,
                    decoration: BoxDecoration(
                      color: AppColors.gray20,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Description shimmer
                  Container(
                    width: _descriptionWidth,
                    height: _descriptionHeight,
                    decoration: BoxDecoration(
                      color: AppColors.gray20,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
