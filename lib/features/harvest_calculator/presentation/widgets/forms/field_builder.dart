import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/reactive_text_field.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Builder for creating reactive form fields with consistent styling.
///
/// Provides factory methods for common field types to reduce duplication.
class FieldBuilder {
  const FieldBuilder._();

  /// Fields that should allow decimal input (automatically detected)
  static final Set<String> _decimalFields = {
    // Cycle mode decimal fields
    'capacityKgPerM2', // kg/m² can be 1.5
    'estimatedFCR', // Feed Conversion Ratio: 1.2, 1.5
    'sellingPrice', // Price per kg: 80.500
    'feedPrice', // Feed price per kg: 18.500
    'currentCommodityWeight', // gram: 2.5, 1.25
    'targetCommodityWeight', // gram: 30.5, 25.75
    'estimatedADG', // gram/day: 1.2, 2.5
    // Agent mode decimal fields
    'currentBiomass', // kg: 5.500
    'stocking', // count: 21.500
    'targetSR', // percentage: 90.5
    'harvestPurchasePrice', // Price per kg: 28.500
    'estimatedHarvestYield', // kg: 6.500
  };

  /// Creates a number field with automatic formatting and decimal detection.
  ///
  /// All number fields automatically get calculator-style formatting:
  /// - Thousand separators use commas: 1,000,000
  /// - Decimal separator uses dots: 1,500.25
  /// - Uses pattern_formatter library for robust formatting
  ///
  /// ⚡ **Decimal input is automatically enabled** for fields that typically require decimal values:
  /// - `capacityKgPerM2`: Capacity (kg/m²) - can be 1.5, 2.3
  /// - `estimatedFCR`: Feed Conversion Ratio - 1.2, 1.5, 1.8
  /// - `sellingPrice`, `feedPrice`, `harvestPurchasePrice`: Prices per kg - 80,500.00, 18,750.50
  /// - `currentCommodityWeight`, `targetCommodityWeight`: Weight in grams - 2.5, 30.25
  /// - `estimatedADG`: Average Daily Gain in grams/day - 1.2, 2.5
  /// - `currentBiomass`, `estimatedHarvestYield`: Biomass/Yield in kg - 5,500.25, 6,250.75
  /// - `stocking`: Stocking count - 21,500.25
  /// - `targetSR`: Survival Rate percentage - 90.5
  ///
  /// Example:
  /// ```dart
  /// FieldBuilder.number(
  ///   formControlName: 'pondArea',  // Integer field (no decimal)
  ///   label: 'Luas Kolam',
  ///   hint: '100,000',
  ///   suffix: 'm²',
  ///   isRequired: true,
  /// )
  /// FieldBuilder.number(
  ///   formControlName: 'estimatedFCR',  // Decimal field (auto-detected)
  ///   label: 'FCR',
  ///   hint: '1.5',
  ///   isRequired: true,
  /// )
  /// ```
  ///
  /// All number fields automatically get calculator-style formatting using pattern_formatter.
  /// No need to manually specify `allowDecimal` - it's handled automatically!
  static Widget number({
    required String formControlName,
    required String label,
    String? hint,
    dynamic prefix,
    dynamic suffix,
    bool isRequired = false,
    bool readOnly = false,
    Map<String, ValidationMessageFunction>? validationMessages,
    Key? key,
  }) {
    // Automatically detect if this field should allow decimal input
    final allowDecimal = _decimalFields.contains(formControlName);
    Widget? prefixWidget;
    if (prefix != null) {
      if (prefix is String) {
        prefixWidget = Text(
          prefix,
          style: HarvestCalculatorDesignConstants.smallTextStyle.copyWith(
            fontWeight: FontWeight.w700,
            color: readOnly
                ? HarvestCalculatorDesignConstants.disabledTextColor
                : HarvestCalculatorDesignConstants.textPrimary,
          ),
        );
      } else if (prefix is Widget) {
        prefixWidget = prefix;
      }
    }

    Widget? suffixWidget;
    if (suffix != null) {
      if (suffix is String) {
        suffixWidget = Text(
          suffix,
          style: HarvestCalculatorDesignConstants.smallTextStyle.copyWith(
            fontWeight: FontWeight.w700,
            color: readOnly
                ? HarvestCalculatorDesignConstants.disabledTextColor
                : HarvestCalculatorDesignConstants.textPrimary,
          ),
        );
      } else if (suffix is Widget) {
        suffixWidget = suffix;
      }
    }

    return ReactiveTextFieldWidget(
      key: key,
      formControlName: formControlName,
      label: label,
      isRequired: isRequired,
      hint: hint,
      prefix: prefixWidget,
      keyboardType: allowDecimal
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.number,
      suffix: suffixWidget,
      inputFormatters: [
        NumberTextInputFormatter(allowDecimal: allowDecimal),
      ], // Thousand separators or decimal support
      validationMessages: validationMessages,
      readOnly: readOnly,
    );
  }

  /// Creates a text field.
  ///
  /// Example:
  /// ```dart
  /// FieldBuilder.text(
  ///   formControlName: 'simulationName',
  ///   label: 'Nama Simulasi',
  ///   hint: 'Simulasi 18 Nov',
  ///   isRequired: true,
  /// )
  /// ```
  static Widget text({
    required String formControlName,
    required String label,
    String? hint,
    bool isRequired = false,
    Map<String, ValidationMessageFunction>? validationMessages,
  }) {
    return ReactiveTextFieldWidget(
      formControlName: formControlName,
      label: label,
      isRequired: isRequired,
      hint: hint,
      validationMessages: validationMessages,
    );
  }
}
