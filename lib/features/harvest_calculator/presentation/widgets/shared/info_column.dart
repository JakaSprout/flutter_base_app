import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';

/// Info column widget for displaying label-value pairs.
class InfoColumn extends StatelessWidget {
  const InfoColumn({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: HarvestCalculatorDesignConstants.smallTextSecondaryStyle
              .copyWith(fontSize: 13),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: HarvestCalculatorDesignConstants.bodyTextStyle.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
