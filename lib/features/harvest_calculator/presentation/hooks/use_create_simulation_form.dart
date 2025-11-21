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
      // Cultivation system is optional (not required for agent mode)
      // Validators will be added conditionally in the UI
      HarvestCalculatorFormControls.cultivationSystem: FormControl<String>(),
      // Pond Capacity (will be enabled later)
      HarvestCalculatorFormControls.pondArea: FormControl<String>(value: ''),
      HarvestCalculatorFormControls.pondDepth: FormControl<String>(value: ''),
      HarvestCalculatorFormControls.capacityKgPerM2: FormControl<String>(
        value: '',
      ),
      HarvestCalculatorFormControls.capacityGrams: FormControl<String>(
        value: '',
      ),
      HarvestCalculatorFormControls.pondCapacityKgPerPond: FormControl<String>(
        value: '',
      ),
      HarvestCalculatorFormControls.fryCount: FormControl<String>(value: ''),
      // Growth Target (will be enabled later)
      HarvestCalculatorFormControls.targetHarvest: FormControl<String>(
        value: '',
      ),
      HarvestCalculatorFormControls.estimatedADG: FormControl<String>(
        value: '',
      ),
      HarvestCalculatorFormControls.targetDOC: FormControl<String>(value: ''),
      HarvestCalculatorFormControls.targetSR: FormControl<String>(value: ''),
      HarvestCalculatorFormControls.estimatedFCR: FormControl<String>(
        value: '',
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
      HarvestCalculatorFormControls.feedPrice: FormControl<String>(value: ''),
      // Cycle type (Full Cycle or Mid Cycle)
      HarvestCalculatorFormControls.cycleType: FormControl<String>(
        value: HarvestCalculatorConstants.cycleTypeFull,
      ),
      // Current DOC (when Mid Cycle is selected)
      HarvestCalculatorFormControls.currentDOC: FormControl<String>(value: ''),
      // Stocking density (Tebar)
      HarvestCalculatorFormControls.stocking: FormControl<String>(value: ''),
      // Feeding rate
      HarvestCalculatorFormControls.feedingRate: FormControl<String>(value: ''),
      // Current commodity weight
      HarvestCalculatorFormControls.currentCommodityWeight: FormControl<String>(
        value: '',
      ),
      // Target commodity weight
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
      ),
      HarvestCalculatorFormControls.totalFeedPaymentObligation:
          FormControl<String>(
        value: '',
      ),
      HarvestCalculatorFormControls.harvestPurchasePrice: FormControl<String>(
        value: '',
      ),
      HarvestCalculatorFormControls.estimatedHarvestYield:
          FormControl<String>(
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
