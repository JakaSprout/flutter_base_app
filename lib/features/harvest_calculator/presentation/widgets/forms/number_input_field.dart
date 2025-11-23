import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Input field for numeric values.
class NumberInputField extends StatelessWidget {
  /// Creates a new instance of [NumberInputField].
  const NumberInputField({
    required this.label,
    required this.controller,
    this.hintText,
    this.suffix,
    this.keyboardType = TextInputType.number,
    super.key,
  });

  /// Label text.
  final String label;

  /// Text editing controller.
  final TextEditingController controller;

  /// Hint text.
  final String? hintText;

  /// Suffix widget (e.g., unit).
  final Widget? suffix;

  /// Keyboard type.
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))],
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText ?? label,
        suffix: suffix,
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
