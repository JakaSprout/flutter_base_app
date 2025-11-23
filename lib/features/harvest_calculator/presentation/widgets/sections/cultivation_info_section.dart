import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_form_controls.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/utils/form_validation_helper.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/form_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/reactive_commodity_field.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/reactive_cultivation_system_field.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/reactive_text_field.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Section widget for cultivation information (basic info).
///
/// Contains fields for:
/// - Simulation name
/// - Commodity selection
/// - Cultivation system selection
class CultivationInfoSection extends StatelessWidget {
  /// Creates a new instance of [CultivationInfoSection].
  const CultivationInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: SectionFieldPadding.horizontal),
      child: ReactiveFormConsumer(
        builder: (context, form, child) {
          // Check if agent mode - if so, always active
          final simulationTypeControl =
              form.control(HarvestCalculatorFormControls.simulationType)
                  as FormControl<String>;
          final simulationType =
              simulationTypeControl.value ??
              HarvestCalculatorConstants.simulationTypeCycle;
          final isAgentMode =
              simulationType == HarvestCalculatorConstants.simulationTypeAgent;

          // For agent mode, always active. For cycle mode, check pond selection
          final isActive = isAgentMode
              ? true
              : FormValidationHelper.shouldShowCultivationInfo(form);

          // Update cultivation system validators based on mode
          final cultivationSystemControl =
              form.control(HarvestCalculatorFormControls.cultivationSystem)
                  as FormControl<String>;
          if (isAgentMode) {
            // Remove required validator for agent mode
            cultivationSystemControl.setValidators([]);
            cultivationSystemControl.updateValueAndValidity();
          } else {
            // Add required validator for cycle mode
            cultivationSystemControl.setValidators([Validators.required]);
            cultivationSystemControl.updateValueAndValidity();
          }

          return FormSection(
            title: HarvestCalculatorConstants.sectionCultivationInfo,
            isActive: isActive,
            children: isActive
                ? [
                    SectionFieldPadding.wrap(
                      child: ReactiveTextFieldWidget(
                        formControlName:
                            HarvestCalculatorFormControls.simulationName,
                        label: HarvestCalculatorConstants.labelSimulationName,
                        isRequired: true,
                        hint: 'Simulasi 18 Nov',
                        validationMessages: {
                          'required': (_) => HarvestCalculatorConstants.errorSimulationNameRequired,
                        },
                      ),
                    ),
                    const SizedBox(height: SectionFieldPadding.fieldSpacing),
                    SectionFieldPadding.wrap(
                      child: ReactiveCommodityFieldWidget(
                        formControlName:
                            HarvestCalculatorFormControls.commodity,
                        label: HarvestCalculatorConstants.labelCommodity,
                        hint: HarvestCalculatorConstants.hintSelectCommodity,
                        isRequired: true,
                        validationMessages: {
                          'required': (_) => HarvestCalculatorConstants.errorCommodityRequired,
                        },
                      ),
                    ),
                    const SizedBox(height: SectionFieldPadding.fieldSpacing),
                    SectionFieldPadding.wrap(
                      child: ReactiveCultivationSystemFieldWidget(
                        formControlName:
                            HarvestCalculatorFormControls.cultivationSystem,
                        label:
                            HarvestCalculatorConstants.labelCultivationSystem,
                        hint: HarvestCalculatorConstants
                            .hintSelectCultivationSystem,
                        // For agent mode, cultivation system is not required
                        isRequired: !isAgentMode,
                        validationMessages: isAgentMode
                            ? null
                            : {
                                'required': (_) => HarvestCalculatorConstants.errorCultivationSystemRequired,
                              },
                      ),
                    ),
                  ]
                : [],
          );
        },
      ),
    );
  }
}
