import 'package:app_mobile_afms/features/home/presentation/constants/home_design_constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

/// Shimmer loader for BannerSection.
///
/// Mimics the structure of BannerSection with:
/// - Vertical list of cards
/// - Gray background container
class BannerSectionShimmer extends StatelessWidget {
  /// Creates a new instance of [BannerSectionShimmer].
  const BannerSectionShimmer({super.key});

  // Design tokens - matching BannerSection
  static const int _cardCount = 2; // Number of banner cards to show in shimmer

  // Design tokens - matching BannerCard
  static const double _padding = 12; // Figma: padding 12px
  static const double _imageWidth = 52; // Figma: image width 52px
  static const double _imageHeight = 52; // Figma: image height 52px
  static const double _gap = 12; // Figma: gap 12px between image and text
  static const double _titleHeight = 20; // Approximate title height
  static const double _titleWidth = 120; // Approximate title width
  static const double _descriptionHeight = 16; // Approximate description height
  static const double _descriptionWidth = 150; // Approximate description width

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: HomeDesignConstants.screenHorizontalPadding,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: HomeDesignConstants.gray05,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: List.generate(_cardCount, (index) {
            final isLast = index == _cardCount - 1;
            return Column(
              children: [
                _buildCardShimmer(),
                if (!isLast)
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: HomeDesignConstants.gray20,
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }

  /// Builds a single card shimmer that mimics BannerCard structure
  Widget _buildCardShimmer() {
    return Shimmer(
      duration: const Duration(seconds: 1),
      color: HomeDesignConstants.white, // Using white for shimmer on gray bg
      colorOpacity: 0.4,
      child: Padding(
        padding: const EdgeInsets.all(_padding),
        child: Row(
          children: [
            // Image shimmer
            Container(
              width: _imageWidth,
              height: _imageHeight,
              decoration: BoxDecoration(
                color: HomeDesignConstants.gray20,
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
                      color: HomeDesignConstants.gray20,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Description shimmer
                  Container(
                    width: _descriptionWidth,
                    height: _descriptionHeight,
                    decoration: BoxDecoration(
                      color: HomeDesignConstants.gray20,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: _gap),
            // Arrow placeholder
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: HomeDesignConstants.gray20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
