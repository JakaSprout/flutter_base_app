import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/components/buttons/stp_bottom_action_button.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_form_controls.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/models/simulation_results_models.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/utils/form_validation_helper.dart';
import 'package:flutter_base_app/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Bottom button widget for creating simulation.
///
/// Always visible but disabled until 3 basic info fields are filled.
class CreateSimulationBottomButton extends StatelessWidget {
  /// Creates a new instance of [CreateSimulationBottomButton].
  const CreateSimulationBottomButton({required this.form, super.key});

  /// The form group.
  final FormGroup form;

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        // Check if agent mode
        final simulationTypeControl =
            form.control(HarvestCalculatorFormControls.simulationType)
                as FormControl<String>;
        final simulationType = simulationTypeControl.value ??
            HarvestCalculatorConstants.simulationTypeCycle;
        final isAgentMode =
            simulationType == HarvestCalculatorConstants.simulationTypeAgent;

        final isBasicInfoValid = FormValidationHelper.isBasicInfoValid(form);
        // For agent mode, pond selection is not required (section is hidden)
        // For cycle mode, pond selection is required
        final isPondSelectionValid = isAgentMode
            ? true
            : FormValidationHelper.isPondSelectionValid(form);
        // Button is enabled when basic info is valid AND (pond selection is valid OR agent mode)
        final isEnabled = isBasicInfoValid && isPondSelectionValid;
        final isFormValid = form.valid;

        return STPBottomActionButton(
          text: HarvestCalculatorConstants.buttonCreate,
          backgroundColor: HarvestCalculatorDesignConstants.primaryBlue,
          height: HarvestCalculatorDesignConstants.buttonHeight,
          borderRadius: HarvestCalculatorDesignConstants.buttonBorderRadius,
          fontSize: HarvestCalculatorDesignConstants.bodyFontSize,
          enabled: isEnabled,
          onPressed: () {
            if (isFormValid) {
              // Use preview based on simulation type
              final previewArgs = isAgentMode
                  ? SimulationResultsScreenArgs.previewAgent()
                  : SimulationResultsScreenArgs.preview();
              
              final simulationName = _readControlValue(
                form,
                HarvestCalculatorFormControls.simulationName,
              );
              final commodity = _readControlValue(
                form,
                HarvestCalculatorFormControls.commodity,
              );
              final system = _readControlValue(
                form,
                HarvestCalculatorFormControls.cultivationSystem,
              );

              final customizedArgs = previewArgs.copyWith(
                simulationName: simulationName?.isNotEmpty ?? false
                    ? simulationName!
                    : previewArgs.simulationName,
                commodity: commodity ?? previewArgs.commodity,
                cultivationSystem: system ?? previewArgs.cultivationSystem,
                simulationType: simulationType,
                createdAt: DateTime.now(),
              );

              context.push(
                Routes.harvestCalculatorResults,
                extra: customizedArgs,
              );
            }
          },
        );
      },
    );
  }

  String? _readControlValue(FormGroup form, String controlName) {
    final control = form.control(controlName);
    final value = control.value;
    if (value is String) {
      return value.trim();
    }
    return null;
  }
}
