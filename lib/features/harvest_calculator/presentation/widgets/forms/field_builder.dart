import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/forms/reactive_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Builder for creating reactive form fields with consistent styling.
///
/// Provides factory methods for common field types to reduce duplication.
class FieldBuilder {
  const FieldBuilder._();

  /// Creates a number field with optional suffix unit.
  ///
  /// Example:
  /// ```dart
  /// FieldBuilder.number(
  ///   formControlName: 'pondArea',
  ///   label: 'Luas Kolam',
  ///   hint: '100.000',
  ///   suffix: 'm²',
  ///   isRequired: true,
  /// )
  /// ```
  ///
  /// Or with custom suffix widget:
  /// ```dart
  /// FieldBuilder.number(
  ///   formControlName: 'capacity',
  ///   label: 'Kapasitas',
  ///   hint: '5',
  ///   suffix: Row(
  ///     children: [
  ///       Text('kg/m²'),
  ///       Icon(Icons.info),
  ///     ],
  ///   ),
  ///   isRequired: true,
  /// )
  /// ```
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
      keyboardType: TextInputType.number,
      suffix: suffixWidget,
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
