import 'package:flutter/material.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/states/empty_simulation_state.dart';

/// Empty content widget for when no simulations are available.
class EmptySimulationsContent extends StatelessWidget {
  /// Creates a new instance of [EmptySimulationsContent].
  const EmptySimulationsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: HarvestCalculatorDesignConstants.screenPaddingHorizontal,
                right: HarvestCalculatorDesignConstants.screenPaddingHorizontal,
                top: HarvestCalculatorDesignConstants.screenPaddingVertical,
                bottom: HarvestCalculatorDesignConstants.spacingMedium,
              ),
              child: EmptySimulationState(),
            ),
          ),
        ),
      ],
    );
  }
}
