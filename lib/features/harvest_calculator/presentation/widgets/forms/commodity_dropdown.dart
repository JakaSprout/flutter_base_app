import 'package:flutter/material.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';

/// Dropdown widget for selecting commodity.
class CommodityDropdown extends StatelessWidget {
  /// Creates a new instance of [CommodityDropdown].
  const CommodityDropdown({
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
        labelText: HarvestCalculatorConstants.labelCommodity,
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
          value: HarvestCalculatorConstants.commodityShrimp,
          child: Text(HarvestCalculatorConstants.commodityShrimp),
        ),
        DropdownMenuItem<String>(
          value: HarvestCalculatorConstants.commodityFish,
          child: Text(HarvestCalculatorConstants.commodityFish),
        ),
      ],
    );
  }
}
