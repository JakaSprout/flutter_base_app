import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';

/// Search field widget for filtering simulations.
class SimulationSearchField extends StatelessWidget {
  /// Creates a new instance of [SimulationSearchField].
  const SimulationSearchField({
    super.key,
    this.onChanged,
    this.controller,
  });

  /// Callback when the search text changes.
  final ValueChanged<String>? onChanged;

  /// Controller for the text field.
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: HarvestCalculatorDesignConstants.screenPaddingHorizontal,
        top: 16,
        right: HarvestCalculatorDesignConstants.screenPaddingHorizontal,
        bottom: 12,
      ),
      child: SizedBox(
        height: 40,
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: HarvestCalculatorConstants.hintSearchCycles,
            hintStyle: HarvestCalculatorDesignConstants.formFieldPlaceholderTextStyle,
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 12, right: 8),
              child: Icon(Icons.search, size: 20, color: AppColors.gray60),
            ),
            prefixIconConstraints: const BoxConstraints(
              minHeight: 20,
              minWidth: 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.gray20),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.gray20),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.gray20),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.gray20),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
          ),
        ),
      ),
    );
  }
}
