import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';

/// Card widget for Harvest Calculator feature.
///
/// Displays the title and description of the Harvest Calculator.
class HarvestCalculatorCard extends StatelessWidget {
  /// Creates a new instance of [HarvestCalculatorCard].
  const HarvestCalculatorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        HarvestCalculatorDesignConstants.cardPadding,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          HarvestCalculatorDesignConstants.cardBorderRadius,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              HarvestCalculatorDesignConstants.boxShadowOpacity,
            ),
            blurRadius: HarvestCalculatorDesignConstants.boxShadowBlurRadius,
            offset: const Offset(
              0,
              HarvestCalculatorDesignConstants.boxShadowOffsetY,
            ),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            HarvestCalculatorConstants.cardTitle,
            style: HarvestCalculatorDesignConstants.cardTitleTextStyle,
          ),
          SizedBox(height: HarvestCalculatorDesignConstants.spacingSmall),
          Text(
            HarvestCalculatorConstants.cardDescription,
            style: HarvestCalculatorDesignConstants.bodyTextSecondaryStyle,
          ),
        ],
      ),
    );
  }
}




