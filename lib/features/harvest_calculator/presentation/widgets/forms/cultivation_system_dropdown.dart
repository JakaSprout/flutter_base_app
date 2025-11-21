import 'package:flutter/material.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';

/// Dropdown widget for selecting cultivation system.
class CultivationSystemDropdown extends StatelessWidget {
  /// Creates a new instance of [CultivationSystemDropdown].
  const CultivationSystemDropdown({
    required this.value,
    required this.onChanged,
    super.key,
  });

  /// Selected value.
  final String? value;

  /// Callback when value changes.
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: HarvestCalculatorConstants.labelCultivationSystem,
        hintText: HarvestCalculatorConstants.hintSelectCultivationSystem,
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
      items: const [
        DropdownMenuItem<String>(
          value: HarvestCalculatorConstants.systemRAS,
          child: Text(HarvestCalculatorConstants.systemRAS),
        ),
        DropdownMenuItem<String>(
          value: HarvestCalculatorConstants.systemBiofloc,
          child: Text(HarvestCalculatorConstants.systemBiofloc),
        ),
        DropdownMenuItem<String>(
          value: HarvestCalculatorConstants.systemTraditional,
          child: Text(HarvestCalculatorConstants.systemTraditional),
        ),
      ],
    );
  }
}
