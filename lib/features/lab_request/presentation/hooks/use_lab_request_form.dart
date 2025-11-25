import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_form_controls.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Custom hook for managing lab request form.
///
/// Creates and manages the FormGroup for lab request form screen with
/// all required form controls.
///
/// Pattern follows harvest_calculator/presentation/hooks/use_create_simulation_form.dart
/// Uses useState and useEffect to ensure form is properly disposed
/// before creating a new one, preventing GlobalKey duplicate errors.
FormGroup useLabRequestForm() {
  final formRef = useRef<FormGroup?>(null);

  useEffect(() {
    // Dispose previous form if exists (important for hot reload)
    formRef.value?.dispose();

    // Create new form
    formRef.value = FormGroup({
      // Farm Information Section
      LabRequestFormControls.selectedFarm: FormControl<String>(
        validators: [Validators.required],
      ),
      LabRequestFormControls.sendDate: FormControl<DateTime>(
        validators: [Validators.required],
      ),

      // Sample Section - FormArray to hold multiple samples
      LabRequestFormControls.samples: FormArray<Map<String, dynamic>>(
        [],
        validators: [Validators.minLength(1)], // At least one sample required
      ),

      // Additional fields (can be added later)
      LabRequestFormControls.senderName: FormControl<String>(),
      LabRequestFormControls.senderPhone: FormControl<String>(),
      LabRequestFormControls.senderEmail: FormControl<String>(),
      LabRequestFormControls.customer: FormControl<String>(),
      LabRequestFormControls.anamnesa: FormControl<String>(),
      LabRequestFormControls.sampleDescription: FormControl<String>(),
      LabRequestFormControls.testingType: FormControl<String>(),
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
