import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';

/// Button widget for "See More" action.
class SeeMoreButton extends StatelessWidget {
  /// Creates a new instance of [SeeMoreButton].
  const SeeMoreButton({this.onTap, super.key});

  /// Callback when button is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            HarvestCalculatorConstants.buttonSeeMore,
            style: HarvestCalculatorDesignConstants.bodyTextStyle.copyWith(
              fontWeight: FontWeight.w600,
              color: HarvestCalculatorDesignConstants.secondaryOrange,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.chevron_right,
            size: 16,
            color: HarvestCalculatorDesignConstants.secondaryOrange,
          ),
        ],
      ),
    );
  }
}


