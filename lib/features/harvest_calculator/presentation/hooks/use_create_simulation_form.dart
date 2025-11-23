import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_form_controls.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/pond_option.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Custom hook for managing create simulation form.
///
/// Creates and manages the FormGroup for create simulation screen with
/// all required form controls.
///
/// Uses useState and useEffect to ensure form is properly disposed
/// before creating a new one, preventing GlobalKey duplicate errors.
FormGroup useCreateSimulationForm() {
  final formRef = useRef<FormGroup?>(null);

  useEffect(() {
    // Dispose previous form if exists (important for hot reload)
    formRef.value?.dispose();

    // Generate timestamp for simulation name
    final now = DateTime.now();
    final timestamp = DateFormat('yyyy-MMM-dd HH:mm:ss').format(now);
    final generatedName = 'Simulasi $timestamp';

    // Create new form
    formRef.value = FormGroup({
      // Use Registered Pond
      HarvestCalculatorFormControls.useRegisteredPond: FormControl<bool>(
        value: true, // Default to "Ya, Gunakan"
      ),
      HarvestCalculatorFormControls.selectedPond: FormControl<PondOption?>(),
      // Basic Info
      HarvestCalculatorFormControls.simulationName: FormControl<String>(
        value: generatedName,
        validators: [Validators.required],
      ),
      HarvestCalculatorFormControls.commodity: FormControl<String>(
        validators: [Validators.required],
      ),
      // Cultivation system - required for cycle mode only
      HarvestCalculatorFormControls.cultivationSystem: FormControl<String>(),
      // Pond Capacity - required for cycle mode (manual input) only
      HarvestCalculatorFormControls.pondArea: FormControl<String>(value: ''),
      HarvestCalculatorFormControls.pondDepth: FormControl<String>(value: ''),
      HarvestCalculatorFormControls.capacityKgPerM2: FormControl<String>(
        value: '',
      ),
      HarvestCalculatorFormControls.capacityGrams: FormControl<String>(
        value: '',
      ),
      HarvestCalculatorFormControls.pondCapacityKgPerPond: FormControl<String>(
        value: '0',
      ),
      HarvestCalculatorFormControls.fryCount: FormControl<String>(value: ''),
      // Growth Target (will be enabled later)
      HarvestCalculatorFormControls.targetHarvest: FormControl<String>(
        value: '',
      ),
      HarvestCalculatorFormControls.estimatedADG: FormControl<String>(
        value: '',
      ),
      HarvestCalculatorFormControls.targetDOC: FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
      HarvestCalculatorFormControls.targetSR: FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
      HarvestCalculatorFormControls.estimatedFCR: FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
      HarvestCalculatorFormControls.targetBiomass: FormControl<String>(
        value: '',
      ),
      // Price Info (will be enabled later)
      HarvestCalculatorFormControls.targetSellingPrice: FormControl<String>(
        value: '',
      ),
      HarvestCalculatorFormControls.targetFeedPrice: FormControl<String>(
        value: '',
      ),
      HarvestCalculatorFormControls.sellingPrice: FormControl<String>(
        value: '',
      ),
      HarvestCalculatorFormControls.feedPrice: FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
      // Cycle type (Full Cycle or Mid Cycle)
      HarvestCalculatorFormControls.cycleType: FormControl<String>(
        value: HarvestCalculatorConstants.cycleTypeFull,
      ),
      // Current DOC (when Mid Cycle is selected)
      HarvestCalculatorFormControls.currentDOC: FormControl<String>(value: ''),
      // Stocking density (Tebar) - auto-calculated from pondArea × pondDepth (cycle mode)
      // Manual input for agent mode
      HarvestCalculatorFormControls.stocking: FormControl<String>(
        value:
            '0', // Default '0' for cycle mode, will be cleared for agent mode
        validators: [
          Validators.required,
        ], // Required for both modes, but validated differently
      ),
      // Feeding rate - required for cycle mode only
      HarvestCalculatorFormControls.feedingRate: FormControl<String>(value: ''),
      // Current commodity weight - required for cycle mode only
      HarvestCalculatorFormControls.currentCommodityWeight: FormControl<String>(
        value: '',
      ),
      // Target commodity weight - required for cycle mode only
      HarvestCalculatorFormControls.targetCommodityWeight: FormControl<String>(
        value: '',
      ),
      // Simulation type (Cycle or Agent)
      HarvestCalculatorFormControls.simulationType: FormControl<String>(
        value: HarvestCalculatorConstants.simulationTypeCycle,
      ),
      // Agent mode specific fields
      HarvestCalculatorFormControls.currentBiomass: FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
      HarvestCalculatorFormControls.totalFeedPaymentObligation:
          FormControl<String>(value: '', validators: [Validators.required]),
      HarvestCalculatorFormControls.harvestPurchasePrice: FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
      HarvestCalculatorFormControls.estimatedHarvestYield: FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
      // Harvest events (Partial harvest)
      HarvestCalculatorFormControls.harvest1Percentage: FormControl<String>(
        value: '50',
      ),
      HarvestCalculatorFormControls.harvest1DOC: FormControl<String>(value: ''),
      HarvestCalculatorFormControls.harvest2Percentage: FormControl<String>(
        value: '50',
      ),
      HarvestCalculatorFormControls.harvest2DOC: FormControl<String>(value: ''),
      HarvestCalculatorFormControls.finalHarvestPercentage: FormControl<String>(
        value: '100',
      ),
      HarvestCalculatorFormControls.finalHarvestDOC: FormControl<String>(
        value: '',
      ),
    });

    // Dispose form on unmount
    return () {
      formRef.value?.dispose();
      formRef.value = null;
    };
  }, []);

  // Return form or create a temporary empty one (should not happen)
  if (formRef.value == null) {
    formRef.value = FormGroup({});
  }

  return formRef.value!;
}
