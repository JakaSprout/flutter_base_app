import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_form_controls.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  // Test if required validators are working
  final pondAreaControl = FormControl<String>(
    value: '',
    validators: [Validators.required],
  );

  final stockingControl = FormControl<String>(
    value: '',
    validators: [Validators.required],
  );

  final targetDOCControl = FormControl<String>(
    value: '',
    validators: [Validators.required],
  );

  // Mark as touched and dirty to trigger validation
  pondAreaControl.markAsTouched();
  pondAreaControl.markAsDirty();
  pondAreaControl.updateValueAndValidity();

  stockingControl.markAsTouched();
  stockingControl.markAsDirty();
  stockingControl.updateValueAndValidity();

  targetDOCControl.markAsTouched();
  targetDOCControl.markAsDirty();
  targetDOCControl.updateValueAndValidity();

  print('🔍 VALIDATION TEST:');
  print('   - pondArea: valid=${pondAreaControl.valid}, errors=${pondAreaControl.errors}');
  print('   - stocking: valid=${stockingControl.valid}, errors=${stockingControl.errors}');
  print('   - targetDOC: valid=${targetDOCControl.valid}, errors=${targetDOCControl.errors}');

  // Test with values
  pondAreaControl.value = '100';
  stockingControl.value = '5000';
  targetDOCControl.value = '120';

  print('\n🔍 AFTER SETTING VALUES:');
  print('   - pondArea: valid=${pondAreaControl.valid}, errors=${pondAreaControl.errors}');
  print('   - stocking: valid=${stockingControl.valid}, errors=${stockingControl.errors}');
  print('   - targetDOC: valid=${targetDOCControl.valid}, errors=${targetDOCControl.errors}');
}
