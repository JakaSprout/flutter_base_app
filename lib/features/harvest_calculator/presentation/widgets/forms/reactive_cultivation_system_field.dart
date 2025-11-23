import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/modals/select_cultivation_system_modal.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart' as reactive_forms;

/// Reactive cultivation system field widget with bottom sheet modal.
///
/// Uses reactive_forms for form management and shows bottom sheet modal
/// for cultivation system selection instead of regular dropdown.
class ReactiveCultivationSystemFieldWidget extends StatelessWidget {
  /// Creates a new instance of [ReactiveCultivationSystemFieldWidget].
  const ReactiveCultivationSystemFieldWidget({
    required this.formControlName,
    required this.label,
    this.isRequired = false,
    this.hint,
    this.validationMessages,
    super.key,
  });

  /// Form control name
  final String formControlName;

  /// Field label
  final String label;

  /// Whether the field is required (shows red asterisk)
  final bool isRequired;

  /// Optional hint text when no value is selected
  final String? hint;

  /// Validation messages
  final Map<String, reactive_forms.ValidationMessageFunction>?
  validationMessages;

  // Design tokens
  static const double _labelFontSize = 12;
  static const double _lineHeight = 1.4;
  static const double _gap = 8;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label with required indicator
        Row(
          children: [
            if (isRequired) ...[
              const Text(
                '*',
                style: TextStyle(
                  color: HarvestCalculatorDesignConstants
                      .errorColor, // Destructive/60
                  fontSize: _labelFontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 2), // Gap 2px
            ],
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: _labelFontSize,
                fontWeight: FontWeight.w400,
                color: HarvestCalculatorDesignConstants.gray100,
                fontFamily: AppConstants.fontFamily,
                height: _lineHeight,
              ),
            ),
          ],
        ),
        const SizedBox(height: _gap),
        // Field using ReactiveFormField
        reactive_forms.ReactiveFormField<String, String>(
          key: ValueKey('reactive_cultivation_system_field_$formControlName'),
          formControlName: formControlName,
          validationMessages: validationMessages,
          showErrors: (control) =>
              control.invalid && (control.dirty || control.touched),
          builder: (field) {
            final errorText = field.errorText;
            final selectedValue = field.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    // Show bottom sheet modal for cultivation system selection
                    showModalBottomSheet<void>(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (modalContext) => SelectCultivationSystemModal(
                        initialValue: selectedValue,
                        onSave: (value) {
                          field.didChange(value);
                        },
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: HarvestCalculatorDesignConstants.white,
                      border: Border.all(
                        color: HarvestCalculatorDesignConstants.gray20,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            (selectedValue != null && selectedValue.isNotEmpty)
                                ? selectedValue
                                : (hint ?? 'Pilih $label'),
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: (selectedValue != null && selectedValue.isNotEmpty)
                                      ? HarvestCalculatorDesignConstants.gray100
                                      : HarvestCalculatorDesignConstants.gray70,
                                  fontFamily: AppConstants.fontFamily,
                                  height: 1.4,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                          color: HarvestCalculatorDesignConstants.gray100,
                        ),
                      ],
                    ),
                  ),
                ),
                if (errorText != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    errorText,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: _labelFontSize,
                      fontWeight: FontWeight.w400,
                      color: HarvestCalculatorDesignConstants.errorColor,
                      fontFamily: AppConstants.fontFamily,
                      height: _lineHeight,
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}
