import 'package:app_mobile_afms/features/home/presentation/constants/home_design_constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

/// Shimmer loader for FarmSelectionSection.
///
/// Mimics the structure of FarmSelectionSection with:
/// - Label placeholder
/// - Dropdown placeholder
class FarmSelectionShimmer extends StatelessWidget {
  /// Creates a new instance of [FarmSelectionShimmer].
  const FarmSelectionShimmer({super.key});

  // Design tokens - matching FarmSelectionSection
  static const double _labelSpacing =
      8; // Figma: gap 8px between label and dropdown
  static const double _labelHeight =
      18; // Approximate label height (12px font * 1.5 line height)
  static const double _dropdownHeight = 48; // Standard dropdown height

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label placeholder
        Shimmer(
          duration: const Duration(seconds: 1),
          color: HomeDesignConstants.primary20,
          colorOpacity: 0.35,
          child: Container(
            width: 80, // Approximate "Pilih Farm" label width
            height: _labelHeight,
            decoration: BoxDecoration(
              color: HomeDesignConstants.gray05,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(height: _labelSpacing),
        // Dropdown placeholder
        Shimmer(
          duration: const Duration(seconds: 1),
          color: HomeDesignConstants.primary20,
          colorOpacity: 0.35,
          child: Container(
            width: double.infinity,
            height: _dropdownHeight,
            decoration: BoxDecoration(
              color: HomeDesignConstants.gray05,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: HomeDesignConstants.gray20),
            ),
          ),
        ),
      ],
    );
  }
}
