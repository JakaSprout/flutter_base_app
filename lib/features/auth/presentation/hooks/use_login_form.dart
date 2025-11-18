import 'package:flutter_base_app/features/auth/presentation/constants/login_form_controls.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Custom hook for managing login form.
///
/// Creates and manages the FormGroup for login screen with phone, email, and password controls.
FormGroup useLoginForm() {
  return useMemoized<FormGroup>(
    () => FormGroup({
      LoginFormControls.phone: FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
      LoginFormControls.email: FormControl<String>(
        value: '',
        validators: [Validators.required, Validators.email],
      ),
      LoginFormControls.password: FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
    }),
    const [],
  );
}
