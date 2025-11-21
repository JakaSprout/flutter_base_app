import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Metric tile widget displaying key performance indicators.
class MetricTile extends StatelessWidget {
  /// Creates a new instance of [MetricTile].
  const MetricTile({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.indicatorColor,
    required this.iconAsset,
    super.key,
  });

  /// Title text.
  final String title;

  /// Main value text.
  final String value;

  /// Subtitle text.
  final String subtitle;

  /// Indicator color (unused but kept for consistency).
  final Color indicatorColor;

  /// Icon asset path.
  final String iconAsset;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        HarvestCalculatorDesignConstants.cardPadding,
      ),
      decoration: BoxDecoration(
        color: AppColors.gray05,
        borderRadius: BorderRadius.circular(
          HarvestCalculatorDesignConstants.cardBorderRadius,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Center(
                child: SvgPicture.asset(iconAsset, width: 16, height: 16),
              ),
              const SizedBox(
                width: HarvestCalculatorDesignConstants.spacingXSmall,
              ),
              Expanded(
                child: Text(
                  title,
                  style: HarvestCalculatorDesignConstants.smallTextSecondaryStyle,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: HarvestCalculatorDesignConstants.spacingXSmall,
          ),
          Text(
            value,
            style: HarvestCalculatorDesignConstants.bodyTextStyle.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: HarvestCalculatorDesignConstants.spacingXSmall,
          ),
          Text(
            subtitle,
            style: HarvestCalculatorDesignConstants.smallTextSecondaryStyle,
          ),
        ],
      ),
    );
  }
}


