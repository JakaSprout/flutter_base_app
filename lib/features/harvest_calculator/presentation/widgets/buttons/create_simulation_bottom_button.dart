import 'package:app_mobile_afms/design_system/components/buttons/stp_bottom_action_button.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/simulation_parameters.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/usecases/run_simulation_usecase.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_form_controls.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/simulation_results_models.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/utils/form_validation_helper.dart';
import 'package:app_mobile_afms/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Bottom button widget for creating simulation.
///
/// Always visible but disabled until 3 basic info fields are filled.
/// Field types for automatic parsing
enum FieldType { integer, double }

/// Metadata for field parsing configuration
class FieldMetadata {
  const FieldMetadata(this.type, this.hasThousandSeparators);

  final FieldType type;
  final bool hasThousandSeparators;

  bool get isInteger => type == FieldType.integer;
  bool get isDouble => type == FieldType.double;
}

class CreateSimulationBottomButton extends HookWidget {
  /// Creates a new instance of [CreateSimulationBottomButton].
  const CreateSimulationBottomButton({
    required this.form,
    this.scrollController,
    super.key,
  });

  /// The form group.
  final FormGroup form;

  /// Scroll controller for scrolling to error fields.
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);

    return ReactiveFormConsumer(
      builder: (context, form, child) {
        // Check if agent mode
        final simulationTypeControl =
            form.control(HarvestCalculatorFormControls.simulationType)
                as FormControl<String>;
        final simulationType =
            simulationTypeControl.value ??
            HarvestCalculatorConstants.simulationTypeCycle;
        final isAgentMode =
            simulationType == HarvestCalculatorConstants.simulationTypeAgent;

        final isBasicInfoValid = FormValidationHelper.isBasicInfoValid(form);
        // For agent mode, pond selection is not required (section is hidden)
        // For cycle mode, pond selection is required
        final useRegisteredPond =
            form
                .control(HarvestCalculatorFormControls.useRegisteredPond)
                .value ??
            true;
        final selectedPond = form
            .control(HarvestCalculatorFormControls.selectedPond)
            .value;
        final isPondSelectionValid =
            isAgentMode || (useRegisteredPond == false || selectedPond != null);
        // Button is enabled when basic info is valid AND pond selection is valid (or agent mode)
        final isEnabled = isBasicInfoValid && isPondSelectionValid;

        // Check cultivation system specifically when button disabled
        if (!isEnabled) {
          final cultivationValid = form
              .control(HarvestCalculatorFormControls.cultivationSystem)
              .valid;
          final cultivationRequired = !isAgentMode;

          if (!isBasicInfoValid && cultivationRequired && !cultivationValid) {}
        }

        return STPBottomActionButton(
          key: ValueKey(
            'create_button_${isEnabled}_${isLoading.value}',
          ), // Force rebuild
          text: HarvestCalculatorConstants.buttonCreate,
          backgroundColor: HarvestCalculatorDesignConstants.primaryBlue,
          height: HarvestCalculatorDesignConstants.buttonHeight,
          borderRadius: HarvestCalculatorDesignConstants.buttonBorderRadius,
          fontSize: HarvestCalculatorDesignConstants.bodyFontSize,
          enabled: isEnabled && !isLoading.value,
          isLoading: isLoading.value,
          onPressed: () async {
            // Validate form and mark invalid fields as touched to show errors
            _validateFormAndShowErrors(form);

            // Only proceed if form is valid after validation
            if (form.valid) {
              // Set loading state
              isLoading.value = true;

              try {
                // Create simulation parameters from form
                final parameters = _createSimulationParameters(
                  form,
                  isAgentMode,
                );

                // Run simulation
                const runSimulationUseCase = RunSimulationUseCase();
                final result = await runSimulationUseCase.execute(parameters);

                result.fold(
                  (failure) {
                    // Handle simulation failure
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${failure.message}')),
                      );
                    }
                  },
                  (simulationResult) {
                    // Create results args with actual simulation data
                    final resultsArgs =
                        SimulationResultsScreenArgs.fromSimulationResult(
                          simulationResult,
                          parameters, // Pass the parameters we created
                          simulationName: _readControlValue(
                            form,
                            HarvestCalculatorFormControls.simulationName,
                          ),
                          commodity: _readControlValue(
                            form,
                            HarvestCalculatorFormControls.commodity,
                          ),
                          cultivationSystem: _readControlValue(
                            form,
                            HarvestCalculatorFormControls.cultivationSystem,
                          ),
                          simulationType: simulationType,
                          createdAt: DateTime.now(),
                        );

                    // Navigate to results screen with actual data
                    if (context.mounted) {
                      context.push(
                        Routes.harvestCalculatorResults,
                        extra: resultsArgs,
                      );
                    }
                  },
                );
              } catch (e) {
                // Handle unexpected errors
                if (context.mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Error: $e')));
                }
              } finally {
                // Reset loading state
                isLoading.value = false;
              }
            }
          },
        );
      },
    );
  }

  /// Validates the form and marks all invalid controls as touched to show error messages.
  void _validateFormAndShowErrors(FormGroup form) {
    // Mark all invalid controls as touched so error messages appear
    form.markAllAsTouched();

    // Force validation by accessing the valid property to ensure all validators run
    final _ = form.valid;

    // If form is invalid, scroll to the first error field
    if (!form.valid) {
      _scrollToFirstErrorField(form);
    }
  }

  /// Finds the first invalid field and scrolls to it.
  void _scrollToFirstErrorField(FormGroup form) {
    // Check simulation mode
    final simulationTypeControl =
        form.control(HarvestCalculatorFormControls.simulationType)
            as FormControl<String>;
    final simulationType =
        simulationTypeControl.value ??
        HarvestCalculatorConstants.simulationTypeCycle;
    final isAgentMode =
        simulationType == HarvestCalculatorConstants.simulationTypeAgent;

    // Define the order of fields to check (top to bottom in the form)
    final baseFields = [
      HarvestCalculatorFormControls.simulationName,
      HarvestCalculatorFormControls.commodity,
      HarvestCalculatorFormControls.cultivationSystem,
      HarvestCalculatorFormControls.pondArea,
      HarvestCalculatorFormControls.pondDepth,
      HarvestCalculatorFormControls.capacityKgPerM2,
      HarvestCalculatorFormControls.pondCapacityKgPerPond,
      HarvestCalculatorFormControls.cycleType,
      HarvestCalculatorFormControls.currentDOC,
      HarvestCalculatorFormControls.targetDOC,
      HarvestCalculatorFormControls.stocking,
      HarvestCalculatorFormControls.feedingRate,
      HarvestCalculatorFormControls.targetSR,
      HarvestCalculatorFormControls.estimatedFCR,
    ];

    final cycleSpecificFields = [
      HarvestCalculatorFormControls.currentCommodityWeight,
      HarvestCalculatorFormControls.targetCommodityWeight,
      HarvestCalculatorFormControls.estimatedADG,
      HarvestCalculatorFormControls.targetSellingPrice,
      HarvestCalculatorFormControls.targetFeedPrice,
      HarvestCalculatorFormControls.sellingPrice,
      HarvestCalculatorFormControls.feedPrice,
    ];

    final agentSpecificFields = [
      HarvestCalculatorFormControls.currentBiomass,
      HarvestCalculatorFormControls.totalFeedPaymentObligation,
      HarvestCalculatorFormControls.harvestPurchasePrice,
      HarvestCalculatorFormControls.estimatedHarvestYield,
    ];

    final fieldOrder = [
      ...baseFields,
      if (isAgentMode) ...agentSpecificFields else ...cycleSpecificFields,
    ];

    // Clear error states for fields not relevant to current mode
    if (!isAgentMode) {
      // For cycle mode, clear errors on agent-specific fields
      for (final fieldName in agentSpecificFields) {
        final control = form.control(fieldName);
        control.setErrors({});
        control.markAsPristine();
        control.markAsUntouched();
      }
    }

    // Find the first invalid field in order
    for (final fieldName in fieldOrder) {
      final control = form.control(fieldName);
      final isInvalid = control.invalid;
      if (isInvalid) {
        // Scroll to this field
        _scrollToField(fieldName);
        break;
      }
    }

    for (final entry in form.controls.entries) {
      final controlName = entry.key;
      final control = entry.value;
      if (control.invalid && !fieldOrder.contains(controlName)) {
        // Handle unexpected invalid fields if needed
      }
    }
  }

  /// Scrolls to a specific field by its control name.
  void _scrollToField(String fieldName) {
    if (scrollController == null) return;

    // Define approximate scroll positions for different fields
    // These are rough estimates based on the field order in the form
    final fieldPositions = {
      HarvestCalculatorFormControls.simulationName: 0.0, // Top of form
      HarvestCalculatorFormControls.commodity: 50.0, // After simulation name
      HarvestCalculatorFormControls.cultivationSystem: 100.0, // After commodity
      HarvestCalculatorFormControls.pondArea: 300.0, // In pond capacity section
      HarvestCalculatorFormControls.pondDepth: 350.0, // After pond area
      HarvestCalculatorFormControls.capacityKgPerM2: 400.0, // After pond depth
      HarvestCalculatorFormControls.pondCapacityKgPerPond:
          450.0, // After capacity
      HarvestCalculatorFormControls.cycleType: 500.0, // Cycle type section
      HarvestCalculatorFormControls.currentDOC: 550.0, // After cycle type
      HarvestCalculatorFormControls.targetDOC: 600.0, // After current DOC
      HarvestCalculatorFormControls.stocking: 650.0, // Growth target section
      HarvestCalculatorFormControls.feedingRate: 700.0, // After stocking
      HarvestCalculatorFormControls.targetSR: 750.0, // After feeding rate
      HarvestCalculatorFormControls.estimatedFCR: 800.0, // After target SR
      HarvestCalculatorFormControls.currentCommodityWeight: 850.0, // After FCR
      HarvestCalculatorFormControls.targetCommodityWeight:
          900.0, // After current weight
      HarvestCalculatorFormControls.estimatedADG: 950.0, // After target weight
      HarvestCalculatorFormControls.targetSellingPrice: 1100.0, // Price section
      HarvestCalculatorFormControls.targetFeedPrice:
          1150.0, // After selling price
      HarvestCalculatorFormControls.sellingPrice:
          1200.0, // After target feed price
      HarvestCalculatorFormControls.feedPrice: 1250.0, // After selling price
    };

    final targetPosition = fieldPositions[fieldName] ?? 0.0;

    // Scroll to the field position with smooth animation
    scrollController!.animateTo(
      targetPosition,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
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

  /// Clean number string by removing thousand separators (dots) for parsing
  // Field metadata for automatic parsing configuration
  static final Map<String, FieldMetadata> _fieldMetadata = {
    // Integer fields
    'targetDOC': const FieldMetadata(FieldType.integer, false),
    'currentDOC': const FieldMetadata(FieldType.integer, false),
    'harvest1DOC': const FieldMetadata(FieldType.integer, false),
    'harvest2DOC': const FieldMetadata(FieldType.integer, false),
    'pondArea': const FieldMetadata(
      FieldType.double,
      false,
    ), // Luas kolam dalam m² (double tanpa thousand sep)
    // Double fields with thousand separators
    'pondDepth': const FieldMetadata(
      FieldType.double,
      true,
    ), // Kepadatan tebar bisa decimal
    'capacityKgPerM2': const FieldMetadata(FieldType.double, true),
    'pondCapacityKgPerPond': const FieldMetadata(FieldType.double, true),
    'stocking': const FieldMetadata(FieldType.double, true),
    'currentCommodityWeight': const FieldMetadata(FieldType.double, true),
    'targetCommodityWeight': const FieldMetadata(FieldType.double, true),
    'sellingPrice': const FieldMetadata(FieldType.double, true),
    'feedPrice': const FieldMetadata(FieldType.double, true),
    'currentBiomass': const FieldMetadata(FieldType.double, true),
    'totalFeedPaymentObligation': const FieldMetadata(FieldType.double, true),
    'harvestPurchasePrice': const FieldMetadata(FieldType.double, true),
    'estimatedHarvestYield': const FieldMetadata(FieldType.double, true),

    // Double fields without thousand separators
    'estimatedFCR': const FieldMetadata(FieldType.double, false),
    'targetSR': const FieldMetadata(FieldType.double, false),
    'estimatedADG': const FieldMetadata(FieldType.double, false),
    'harvest1Percentage': const FieldMetadata(FieldType.double, false),
    'harvest2Percentage': const FieldMetadata(FieldType.double, false),
  };

  /// Parse integer field value
  int _parseIntField(
    String fieldName,
    String? rawValue, [
    String defaultValue = '0',
  ]) {
    final value = rawValue ?? defaultValue;
    // Remove commas that may be added by formatter before parsing
    final cleanValue = value.replaceAll(',', '');
    return int.tryParse(cleanValue) ?? 0;
  }

  /// Parse double field value with automatic formatting detection
  double _parseDoubleField(
    String fieldName,
    String? rawValue, [
    String defaultValue = '0',
  ]) {
    final value = rawValue ?? defaultValue;
    final metadata = _fieldMetadata[fieldName];

    if (metadata != null && metadata.hasThousandSeparators) {
      return double.tryParse(_cleanNumberString(value)) ?? 0.0;
    } else {
      return double.tryParse(value) ?? 0.0;
    }
  }

  String _cleanNumberString(String value) {
    // Remove commas used as thousand separators but preserve decimal point
    // Pattern formatter uses: commas for thousands, dots for decimals
    // Examples:
    // "1500" -> "1500"
    // "1,500" -> "1500" (thousand separator)
    // "1.5" -> "1.5" (decimal)
    // "1,500.25" -> "1500.25" (thousand separators + decimal)
    // "1,500,000" -> "1500000" (all thousand separators)

    // Simply remove all commas since they're thousand separators
    // Keep dots as decimal separators
    return value.replaceAll(',', '');
  }

  SimulationParameters _createSimulationParameters(
    FormGroup form,
    bool isAgentMode,
  ) {
    // Get simulation type
    final simulationType =
        _readControlValue(form, HarvestCalculatorFormControls.simulationType) ??
        HarvestCalculatorConstants.simulationTypeCycle;

    // Parse form values with automatic type detection and formatting
    final pondArea = _parseDoubleField(
      'pondArea',
      _readControlValue(form, HarvestCalculatorFormControls.pondArea),
    );

    final stockingDensity = _parseDoubleField(
      'pondDepth',
      _readControlValue(form, HarvestCalculatorFormControls.pondDepth),
    );

    final initialWeight = _parseDoubleField(
      'currentCommodityWeight',
      _readControlValue(
        form,
        HarvestCalculatorFormControls.currentCommodityWeight,
      ),
    );

    final targetSR = _parseDoubleField(
      'targetSR',
      _readControlValue(form, HarvestCalculatorFormControls.targetSR),
    );

    final targetHarvestWeight = _parseDoubleField(
      'targetCommodityWeight',
      _readControlValue(
        form,
        HarvestCalculatorFormControls.targetCommodityWeight,
      ),
    );

    final estimatedFCR = _parseDoubleField(
      'estimatedFCR',
      _readControlValue(form, HarvestCalculatorFormControls.estimatedFCR),
    );

    final targetDOC = _parseIntField(
      'targetDOC',
      _readControlValue(form, HarvestCalculatorFormControls.targetDOC),
    );

    final currentDOC = _parseIntField(
      'currentDOC',
      _readControlValue(form, HarvestCalculatorFormControls.currentDOC),
      '1', // Default to 1 for full cycle
    );

    final estimatedADG = _parseDoubleField(
      'estimatedADG',
      _readControlValue(form, HarvestCalculatorFormControls.estimatedADG),
    );

    // Calculate daily loss percentage: (100 - Target SR%) / Target DOC
    final dailyLossPercentage = (100.0 - targetSR) / targetDOC;

    final capacityKgPerM2 = _parseDoubleField(
      'capacityKgPerM2',
      _readControlValue(form, HarvestCalculatorFormControls.capacityKgPerM2),
    );

    final capacityKgPerPond = _parseDoubleField(
      'pondCapacityKgPerPond',
      _readControlValue(
        form,
        HarvestCalculatorFormControls.pondCapacityKgPerPond,
      ),
    );

    final sellingPricePerKg = _parseDoubleField(
      'sellingPrice',
      _readControlValue(form, HarvestCalculatorFormControls.sellingPrice),
      isAgentMode ? '1' : '0',
    );

    final feedPricePerKg = _parseDoubleField(
      'feedPrice',
      _readControlValue(form, HarvestCalculatorFormControls.feedPrice),
    );

    final feedingRatePercentage =
        double.tryParse(
          _readControlValue(form, HarvestCalculatorFormControls.feedingRate) ??
              (isAgentMode
                  ? '1'
                  : '0'), // Default to 1 for agent mode to pass validation
        ) ??
        (isAgentMode ? 1.0 : 0.0);

    // Parse agent-specific parameters
    final currentBiomass = _parseDoubleField(
      'currentBiomass',
      _readControlValue(form, HarvestCalculatorFormControls.currentBiomass),
    );

    final stocking = _parseDoubleField(
      'stocking',
      _readControlValue(form, HarvestCalculatorFormControls.stocking),
    );

    final totalFeedPaymentObligation = _parseDoubleField(
      'totalFeedPaymentObligation',
      _readControlValue(
        form,
        HarvestCalculatorFormControls.totalFeedPaymentObligation,
      ),
    );

    final estimatedHarvestYield = _parseDoubleField(
      'estimatedHarvestYield',
      _readControlValue(
        form,
        HarvestCalculatorFormControls.estimatedHarvestYield,
      ),
    );

    final harvestPurchasePrice = _parseDoubleField(
      'harvestPurchasePrice',
      _readControlValue(
        form,
        HarvestCalculatorFormControls.harvestPurchasePrice,
      ),
    );

    // Parse harvest events from form fields
    final harvestEvents = <HarvestEvent>[];

    // Harvest 1
    final harvest1DOC = _parseIntField(
      'harvest1DOC',
      _readControlValue(form, HarvestCalculatorFormControls.harvest1DOC),
    );
    final harvest1Percentage = _parseDoubleField(
      'harvest1Percentage',
      _readControlValue(form, HarvestCalculatorFormControls.harvest1Percentage),
    );
    if (harvest1DOC > 0 && harvest1Percentage > 0) {
      harvestEvents.add(
        HarvestEvent(
          doc: harvest1DOC,
          percentage: harvest1Percentage,
          description: 'Panen 1',
        ),
      );
    }

    // Harvest 2
    final harvest2DOC = _parseIntField(
      'harvest2DOC',
      _readControlValue(form, HarvestCalculatorFormControls.harvest2DOC),
    );
    final harvest2Percentage = _parseDoubleField(
      'harvest2Percentage',
      _readControlValue(form, HarvestCalculatorFormControls.harvest2Percentage),
    );
    if (harvest2DOC > 0 && harvest2Percentage > 0) {
      harvestEvents.add(
        HarvestEvent(
          doc: harvest2DOC,
          percentage: harvest2Percentage,
          description: 'Panen 2',
        ),
      );
    }

    // Final Harvest
    final finalHarvestDOC = int.tryParse(
      _readControlValue(form, HarvestCalculatorFormControls.finalHarvestDOC) ??
          '',
    );
    final finalHarvestPercentage = double.tryParse(
      _readControlValue(
            form,
            HarvestCalculatorFormControls.finalHarvestPercentage,
          ) ??
          '',
    );
    if (finalHarvestDOC != null &&
        finalHarvestPercentage != null &&
        finalHarvestPercentage > 0) {
      harvestEvents.add(
        HarvestEvent(
          doc: finalHarvestDOC,
          percentage: finalHarvestPercentage,
          description: 'Panen Raya',
        ),
      );
    }

    return SimulationParameters(
      simulationType: simulationType,
      pondArea: pondArea,
      stockingDensity: stockingDensity,
      initialWeight: initialWeight,
      targetSR: targetSR,
      targetHarvestWeight: targetHarvestWeight,
      estimatedFCR: estimatedFCR,
      targetDOC: targetDOC,
      currentDOC: currentDOC,
      estimatedADG: estimatedADG,
      dailyLossPercentage: dailyLossPercentage,
      capacityKgPerM2: capacityKgPerM2,
      capacityKgPerPond: capacityKgPerPond,
      sellingPricePerKg: sellingPricePerKg,
      feedPricePerKg: feedPricePerKg,
      feedingRatePercentage: feedingRatePercentage,
      harvestEvents: harvestEvents,
      // Agent-specific parameters
      currentBiomass: currentBiomass,
      stocking: stocking,
      totalFeedPaymentObligation: totalFeedPaymentObligation,
      estimatedHarvestYield: estimatedHarvestYield,
      harvestPurchasePrice: harvestPurchasePrice,
    );
  }
}
