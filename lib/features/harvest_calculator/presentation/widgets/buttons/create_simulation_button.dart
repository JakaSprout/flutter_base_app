import 'package:flutter/material.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';

/// Button widget for creating a new simulation.
class CreateSimulationButton extends StatelessWidget {
  /// Creates a new instance of [CreateSimulationButton].
  const CreateSimulationButton({required this.onPressed, super.key});

  /// Callback when button is pressed.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // Figma: Button sizing horizontal: hug, vertical: fixed, height: 36
    // Padding: 12px 16px
    // Note: Removed fixedSize to allow button to expand to fit text
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: HarvestCalculatorDesignConstants.primaryBlue,
        foregroundColor: HarvestCalculatorDesignConstants.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        minimumSize: const Size(
          0,
          HarvestCalculatorDesignConstants.buttonHeight,
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            HarvestCalculatorDesignConstants.buttonBorderRadius,
          ),
        ),
        elevation: 0,
      ),
      child: const Text(
        HarvestCalculatorConstants.buttonCreateSimulation,
        style: HarvestCalculatorDesignConstants.buttonTextStyle,
        overflow: TextOverflow.visible,
        softWrap: true,
      ),
    );
  }
}
