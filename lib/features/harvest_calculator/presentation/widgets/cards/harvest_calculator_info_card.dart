import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';
import 'package:flutter/material.dart';

/// Info card widget for Harvest Calculator feature.
///
/// Displays calculator image, title and description according to Figma design.
/// Figma: Card with background #F4F4F4, padding 12px, gap 12px, image 52x52
class HarvestCalculatorInfoCard extends StatelessWidget {
  /// Creates a new instance of [HarvestCalculatorInfoCard].
  const HarvestCalculatorInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: HarvestCalculatorDesignConstants
            .lightBackgroundGray, // Figma: fill_T2BIXL
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Image - 52x52
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Assets.images.kalkulatorPanen.image(
              width: 52,
              height: 52,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12), // Gap 12px
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title - Body/Small/Bold, fontSize 14, fontWeight 700
                Text(
                  HarvestCalculatorConstants.cardTitle,
                  style: HarvestCalculatorDesignConstants.bodyTextStyle
                      .copyWith(
                        fontWeight: FontWeight.w700,
                        color: HarvestCalculatorDesignConstants.neutral80,
                      ),
                ),
                const SizedBox(height: 4),
                // Description - Label/Medium/Regular, fontSize 12, fontWeight 400
                Text(
                  HarvestCalculatorConstants.cardDescription,
                  style: HarvestCalculatorDesignConstants.smallTextStyle
                      .copyWith(
                        color: HarvestCalculatorDesignConstants.neutral50,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
