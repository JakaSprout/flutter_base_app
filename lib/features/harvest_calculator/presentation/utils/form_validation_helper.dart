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
    final simulationType =
        simulationTypeControl.value ??
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

  /// Checks if agent-specific parameters are valid for agent mode.
  ///
  /// Validates: totalFeedPaymentObligation, harvestPurchasePrice, estimatedHarvestYield
  /// Uses manual parsing since form validation may not be triggered yet
  static bool isAgentParametersValid(FormGroup form) {
    // Check simulation type
    final simulationTypeControl =
        form.control(HarvestCalculatorFormControls.simulationType)
            as FormControl<String>;
    final simulationType =
        simulationTypeControl.value ??
        HarvestCalculatorConstants.simulationTypeCycle;
    final isAgentMode =
        simulationType == HarvestCalculatorConstants.simulationTypeAgent;

    if (!isAgentMode) {
      return true; // Skip validation for non-agent modes
    }

    // Validate total feed payment obligation
    final totalFeedPaymentObligationControl =
        form.control(HarvestCalculatorFormControls.totalFeedPaymentObligation)
            as FormControl<String>;
    final totalFeedPaymentObligation = double.tryParse(
      totalFeedPaymentObligationControl.value ?? '',
    );
    if (totalFeedPaymentObligation == null || totalFeedPaymentObligation <= 0) {
      return false;
    }

    // Validate harvest purchase price
    final harvestPurchasePriceControl =
        form.control(HarvestCalculatorFormControls.harvestPurchasePrice)
            as FormControl<String>;
    final harvestPurchasePrice = double.tryParse(
      harvestPurchasePriceControl.value ?? '',
    );
    if (harvestPurchasePrice == null || harvestPurchasePrice <= 0) {
      return false;
    }

    // Validate estimated harvest yield
    final estimatedHarvestYieldControl =
        form.control(HarvestCalculatorFormControls.estimatedHarvestYield)
            as FormControl<String>;
    final estimatedHarvestYield = double.tryParse(
      estimatedHarvestYieldControl.value ?? '',
    );
    if (estimatedHarvestYield == null || estimatedHarvestYield <= 0) {
      return false;
    }

    return true;
  }

  /// Checks if all required fields are valid across all sections.
  ///
  /// This is a comprehensive validation that includes basic info,
  /// pond selection (for cycle mode), and agent parameters (for agent mode).
  static bool isFormCompletelyValid(FormGroup form) {
    // Check simulation type
    final simulationTypeControl =
        form.control(HarvestCalculatorFormControls.simulationType)
            as FormControl<String>;
    final simulationType =
        simulationTypeControl.value ??
        HarvestCalculatorConstants.simulationTypeCycle;
    final isAgentMode =
        simulationType == HarvestCalculatorConstants.simulationTypeAgent;

    // Basic info validation (required for all modes)
    if (!isBasicInfoValid(form)) {
      return false;
    }

    // Pond selection validation (required for cycle mode only)
    if (!isAgentMode && !isPondSelectionValid(form)) {
      return false;
    }

    // Agent parameters validation (required for agent mode only)
    if (isAgentMode && !isAgentParametersValid(form)) {
      return false;
    }

    // 🔍 CRITICAL: Check ALL required field validations
    // This ensures individual field validations are also satisfied
    if (!isAllRequiredFieldsValid(form, isAgentMode)) {
      return false;
    }

    // All critical sections and field validations are valid
    return true;
  }

  /// Checks if all required fields are valid for the current mode
  static bool isAllRequiredFieldsValid(FormGroup form, bool isAgentMode) {
    // For cycle mode, check cycle-specific required fields
    if (!isAgentMode) {
      // Check pond-related fields (only required when using manual input)
      final useRegisteredPond =
          form.control(HarvestCalculatorFormControls.useRegisteredPond).value
              as bool? ??
          false;
      if (!useRegisteredPond) {
        // Manual input mode - these fields are required
        final requiredCycleFields = [
          HarvestCalculatorFormControls.pondArea,
          HarvestCalculatorFormControls.stocking,
          HarvestCalculatorFormControls.targetDOC,
          HarvestCalculatorFormControls.feedingRate,
          HarvestCalculatorFormControls.targetSR,
          HarvestCalculatorFormControls.estimatedFCR,
          HarvestCalculatorFormControls.sellingPrice,
          HarvestCalculatorFormControls.feedPrice,
        ];

        for (final fieldName in requiredCycleFields) {
          final control = form.control(fieldName);
          if (control is FormControl && !control.valid) {
            return false;
          }
        }
      }

      // Check cycle type fields
      final cycleTypeControl =
          form.control(HarvestCalculatorFormControls.cycleType)
              as FormControl<String>;
      final isMidCycle =
          cycleTypeControl.value == HarvestCalculatorConstants.cycleTypeMid;
      if (isMidCycle) {
        final currentDOCControl =
            form.control(HarvestCalculatorFormControls.currentDOC)
                as FormControl<String>;
        if (!currentDOCControl.valid) {
          return false;
        }
      }
    } else {
      // For agent mode, check agent-specific required fields
      final requiredAgentFields = [
        HarvestCalculatorFormControls.currentBiomass,
        HarvestCalculatorFormControls.stocking,
        HarvestCalculatorFormControls.targetSR,
        HarvestCalculatorFormControls.estimatedFCR,
        HarvestCalculatorFormControls.totalFeedPaymentObligation,
        HarvestCalculatorFormControls.harvestPurchasePrice,
        HarvestCalculatorFormControls.estimatedHarvestYield,
        HarvestCalculatorFormControls.targetDOC,
      ];

      for (final fieldName in requiredAgentFields) {
        final control = form.control(fieldName);
        if (control is FormControl && !control.valid) {
          return false;
        }
      }
    }

    return true;
  }
}
