import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';

/// Header displaying the count of simulations.
class SimulationCountHeader extends StatelessWidget {
  /// Creates a new instance of [SimulationCountHeader].
  const SimulationCountHeader({
    super.key,
    required this.count,
  });

  /// Number of simulations to display.
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: HarvestCalculatorDesignConstants.screenPaddingHorizontal,
        vertical: HarvestCalculatorDesignConstants.spacingMedium,
      ),
      child: Text(
        HarvestCalculatorConstants.simulationCount(count),
        style: HarvestCalculatorDesignConstants.labelTextSecondaryStyle
            .copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
