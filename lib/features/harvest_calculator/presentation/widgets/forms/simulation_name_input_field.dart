import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';

/// Input field for simulation name.
class SimulationNameInputField extends StatelessWidget {
  /// Creates a new instance of [SimulationNameInputField].
  const SimulationNameInputField({required this.controller, super.key});

  /// Text editing controller.
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: HarvestCalculatorConstants.labelSimulationName,
        hintText: HarvestCalculatorConstants.labelSimulationName,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            HarvestCalculatorDesignConstants.inputBorderRadius,
          ),
          borderSide: const BorderSide(
            color: HarvestCalculatorDesignConstants.borderGray,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            HarvestCalculatorDesignConstants.inputBorderRadius,
          ),
          borderSide: const BorderSide(
            color: HarvestCalculatorDesignConstants.borderGray,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            HarvestCalculatorDesignConstants.inputBorderRadius,
          ),
          borderSide: const BorderSide(
            color: HarvestCalculatorDesignConstants.primaryBlue,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: HarvestCalculatorDesignConstants.inputPaddingHorizontal,
          vertical: HarvestCalculatorDesignConstants.inputPaddingVertical,
        ),
      ),
    );
  }
}
