import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_form_controls.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/pond_option.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Helper functions for form validation in Harvest Calculator.
class FormValidationHelper {
  const FormValidationHelper._();

  /// Checks if basic info fields (simulation name, commodity, cultivation system) are valid.
  ///
  /// Returns `true` if all required fields are valid, `false` otherwise.
  /// For agent mode, cultivation system is not required.
  static bool isBasicInfoValid(FormGroup form) {
    // Check simulation type
    final simulationTypeControl =
        form.control(HarvestCalculatorFormControls.simulationType)
            as FormControl<String>;
    final simulationType = simulationTypeControl.value ??
        HarvestCalculatorConstants.simulationTypeCycle;
    final isAgentMode =
        simulationType == HarvestCalculatorConstants.simulationTypeAgent;

    final simulationNameControl =
        form.control(HarvestCalculatorFormControls.simulationName)
            as FormControl<String>;
    final commodityControl =
        form.control(HarvestCalculatorFormControls.commodity)
            as FormControl<String>;

    // For agent mode, only simulation name and commodity are required
    if (isAgentMode) {
      return simulationNameControl.valid && commodityControl.valid;
    }

    // For cycle mode, all three fields are required
    final cultivationSystemControl =
        form.control(HarvestCalculatorFormControls.cultivationSystem)
            as FormControl<String>;

    return simulationNameControl.valid &&
        commodityControl.valid &&
        cultivationSystemControl.valid;
  }

  /// Checks if registered pond is selected (when useRegisteredPond is true).
  ///
  /// Returns `true` if:
  /// - useRegisteredPond is false (manual mode), OR
  /// - useRegisteredPond is true AND selectedPond is not empty
  static bool isPondSelectionValid(FormGroup form) {
    final useRegisteredPondControl =
        form.control(HarvestCalculatorFormControls.useRegisteredPond)
            as FormControl<bool>;
    final useRegisteredPond = useRegisteredPondControl.value ?? false;

    if (!useRegisteredPond) {
      // Manual mode - always valid
      return true;
    }

    // Registered pond mode - check if pond is selected
    final selectedPondControl =
        form.control(HarvestCalculatorFormControls.selectedPond)
            as FormControl<PondOption?>;
    final selectedPond = selectedPondControl.value;
    return selectedPond != null;
  }

  /// Checks if cultivation info section should be active.
  ///
  /// Returns `true` if:
  /// - useRegisteredPond is false (manual mode), OR
  /// - useRegisteredPond is true AND selectedPond is not empty
  static bool shouldShowCultivationInfo(FormGroup form) {
    return isPondSelectionValid(form);
  }
}


