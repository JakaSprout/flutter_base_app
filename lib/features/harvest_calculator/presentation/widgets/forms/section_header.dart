import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Section header widget with orange section indicator.
///
/// Figma: Orange section indicator (8x14) positioned at start (0),
/// title with font 16px semibold, gap 12px between indicator and title
/// Each section has its own padding, so indicator will be at section's left edge
class SectionHeader extends StatelessWidget {
  /// Creates a new instance of [SectionHeader].
  const SectionHeader({required this.title, this.isActive = true, super.key});

  /// Section title
  final String title;

  /// Whether the section is active (affects indicator opacity)
  final bool isActive;

  // Design tokens from Figma
  static const double _indicatorWidth = 8;
  static const double _indicatorHeight = 14;
  static const double _gap = 12; // Gap between indicator and title (12px)

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Orange section indicator - positioned at start (0)
        // Each section has its own padding, so indicator will be at section's left edge
        Opacity(
          opacity: isActive ? 1.0 : 0.2,
          child: SvgPicture.asset(
            Assets.icons.general.sectionIndicator,
            width: _indicatorWidth,
            height: _indicatorHeight,
          ),
        ),
        const SizedBox(width: _gap), // Gap 12px between indicator and title
        // Title - Body/Small/Medium/Semibold or Body/Medium/Regular
        Expanded(
          child: Text(
            title,
            style: HarvestCalculatorDesignConstants.sectionTitleTextStyle
                .copyWith(
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  color: isActive
                      ? HarvestCalculatorDesignConstants.textPrimary
                      : HarvestCalculatorDesignConstants.placeholderColor,
                ),
          ),
        ),
      ],
    );
  }
}
