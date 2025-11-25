import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter/material.dart';

/// Header displaying the count of simulations.
class SimulationCountHeader extends StatelessWidget {
  /// Creates a new instance of [SimulationCountHeader].
  const SimulationCountHeader({required this.count, super.key});

  /// Number of simulations to display.
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        HarvestCalculatorDesignConstants.screenPaddingHorizontal,
        HarvestCalculatorDesignConstants.spacing12,
        HarvestCalculatorDesignConstants.screenPaddingHorizontal,
        0,
      ),
      child: Text(
        HarvestCalculatorConstants.simulationCount(count),
        style: HarvestCalculatorDesignConstants.labelTextSecondaryStyle
            .copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
