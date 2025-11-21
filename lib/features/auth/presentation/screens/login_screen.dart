import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_mobile_afms/core/utils/status_bar_config.dart';
import 'package:app_mobile_afms/features/auth/presentation/constants/login_design_constants.dart';
import 'package:app_mobile_afms/features/auth/presentation/hooks/use_login.dart';
import 'package:app_mobile_afms/features/auth/presentation/hooks/use_login_form.dart';
import 'package:app_mobile_afms/features/auth/presentation/hooks/use_login_form_validation.dart';
import 'package:app_mobile_afms/features/auth/presentation/widgets/login_button.dart';
import 'package:app_mobile_afms/features/auth/presentation/widgets/login_card.dart';
import 'package:app_mobile_afms/features/auth/presentation/widgets/login_input_fields.dart';
import 'package:app_mobile_afms/features/auth/presentation/widgets/login_logo.dart';
import 'package:app_mobile_afms/features/auth/presentation/widgets/login_mode_switch.dart';
import 'package:app_mobile_afms/features/auth/presentation/widgets/login_separator.dart';
import 'package:app_mobile_afms/features/auth/presentation/widgets/login_title.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Login screen with phone and email modes.
///
/// Allows users to switch between phone and email login.
class LoginScreen extends HookConsumerWidget {
  /// Creates a new instance of [LoginScreen].
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // UI State
    final isPhoneMode = useState(true);
    final isPasswordVisible = useState(false);

    // Form management using custom hook
    final form = useLoginForm();

    // Dispose form when widget is removed
    useEffect(() {
      return form.dispose;
    }, [form]);

    // Form validation management using custom hook
    useLoginFormValidation(form: form, isPhoneMode: isPhoneMode.value);

    // Reset password visibility when switching mode
    useEffect(() {
      isPasswordVisible.value = false;
      return null;
    }, [isPhoneMode.value]);

    // Login logic using custom hook
    final loginResult = useLogin(
      context: context,
      ref: ref,
      form: form,
      isPhoneMode: isPhoneMode.value,
    );

    // Listen to loading state changes
    final isLoading = useValueListenable(loginResult.isLoading);

    // Set status bar for dark background immediately on mount
    useEffect(() {
      StatusBarConfig.setStatusBarForDarkBackground();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        StatusBarConfig.setStatusBarForDarkBackground();
      });
      return null;
    }, []);

    return Scaffold(
      backgroundColor: LoginDesignConstants.backgroundBlue,
      body: SafeArea(
        bottom: false, // Don't add bottom safe area
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: StatusBarConfig.getStatusBarStyleForDarkBackground(),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(LoginDesignConstants.spacingLarge),
              child: LoginCard(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const LoginLogo(),
                    const SizedBox(height: LoginDesignConstants.spacingXLarge),
                    LoginTitle(isPhoneMode: isPhoneMode.value),
                    const SizedBox(height: LoginDesignConstants.spacingXLarge),
                    ReactiveForm(
                      formGroup: form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ReactiveFormConsumer(
                            builder: (context, form, child) {
                              return LoginInputFields(
                                form: form,
                                isPhoneMode: isPhoneMode.value,
                                isPasswordVisible: isPasswordVisible.value,
                                isLoading: isLoading,
                                onPasswordVisibilityToggle: () =>
                                    isPasswordVisible.value =
                                        !isPasswordVisible.value,
                              );
                            },
                          ),
                          const SizedBox(
                            height: LoginDesignConstants.spacingLarge,
                          ),
                          ReactiveFormConsumer(
                            builder: (context, form, child) {
                              return LoginButton(
                                isLoading: isLoading,
                                isFormValid: form.valid,
                                onPressed: loginResult.handleLogin,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: LoginDesignConstants.spacingLarge),
                    const LoginSeparator(),
                    const SizedBox(height: LoginDesignConstants.spacingLarge),
                    LoginModeSwitch(
                      isPhoneMode: isPhoneMode.value,
                      isLoading: isLoading,
                      onPressed: () {
                        // Unfocus any focused text field when switching mode
                        FocusScope.of(context).unfocus();
                        isPhoneMode.value = !isPhoneMode.value;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
