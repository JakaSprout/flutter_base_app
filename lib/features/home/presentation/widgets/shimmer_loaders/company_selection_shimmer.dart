import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';

/// Shimmer loader for CompanySelectionSection.
///
/// Mimics the structure of CompanySelectionSection with:
/// - Label placeholder
/// - Dropdown placeholder
class CompanySelectionShimmer extends StatelessWidget {
  /// Creates a new instance of [CompanySelectionShimmer].
  const CompanySelectionShimmer({super.key});

  // Design tokens - matching CompanySelectionSection
  static const double _labelSpacing = 8; // Figma: gap 8px between label and dropdown
  static const double _labelHeight = 18; // Approximate label height (12px font * 1.5 line height)
  static const double _dropdownHeight = 48; // Standard dropdown height

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label placeholder
        Shimmer(
          duration: const Duration(seconds: 2),
          color: AppColors.white,
          colorOpacity: 0.3,
          child: Container(
            width: 60, // Approximate label width
            height: _labelHeight,
            decoration: BoxDecoration(
              color: AppColors.gray05,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(height: _labelSpacing),
        // Dropdown placeholder
        Shimmer(
          duration: const Duration(seconds: 2),
          color: AppColors.white,
          colorOpacity: 0.3,
          child: Container(
            width: double.infinity,
            height: _dropdownHeight,
            decoration: BoxDecoration(
              color: AppColors.gray05,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.gray20),
            ),
          ),
        ),
      ],
    );
  }
}

