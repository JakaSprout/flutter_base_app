import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/core/utils/status_bar_config.dart';
import 'package:flutter_base_app/features/auth/domain/entities/country_code.dart';
import 'package:flutter_base_app/features/auth/domain/entities/login_request.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/auth_constants.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/login_design_constants.dart';
import 'package:flutter_base_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_button.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_card.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_input_fields.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_logo.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_mode_switch.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_separator.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_terms_checkbox.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_title.dart';
import 'package:flutter_base_app/router/routes.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Login screen with phone and email modes.
///
/// Allows users to switch between phone and email login.
class LoginScreen extends HookConsumerWidget {
  /// Creates a new instance of [LoginScreen].
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // State
    final isPhoneMode = useState(true);
    final phoneController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final countryCodesAsync = ref.watch(countryCodesProvider);
    final selectedCountryCode = useState<CountryCode?>(null);
    final isPasswordVisible = useState(false);
    final isTermsAccepted = useState(false);
    final isLoading = useState(false);

    // Form validation state
    final phoneText = useState('');
    final emailText = useState('');
    final passwordText = useState('');
    final isFormValid = useState(false);

    // Set status bar for dark background immediately on mount
    // Set immediately and also after frame to override _StatusBarUpdater
    useEffect(() {
      // Set immediately
      StatusBarConfig.setStatusBarForDarkBackground();

      // Also set after frame to ensure it overrides _StatusBarUpdater
      WidgetsBinding.instance.addPostFrameCallback((_) {
        StatusBarConfig.setStatusBarForDarkBackground();
      });

      return null;
    }, []);

    // Set default country code when loaded
    useEffect(() {
      countryCodesAsync.whenData((codes) {
        if (codes.isNotEmpty && selectedCountryCode.value == null) {
          selectedCountryCode.value = codes.firstWhere(
            (code) => code.code == AuthConstants.defaultCountryCode,
            orElse: () => codes.first,
          );
        }
      });
      return null;
    }, [countryCodesAsync]);

    // Clear controllers when switching mode
    useEffect(() {
      phoneController.clear();
      emailController.clear();
      passwordController.clear();
      phoneText.value = '';
      emailText.value = '';
      passwordText.value = '';
      isPasswordVisible.value = false;
      return null;
    }, [isPhoneMode.value]);

    // Update form validation
    void updateFormValidation() {
      final valid = isPhoneMode.value
          ? (selectedCountryCode.value != null &&
                phoneText.value.isNotEmpty &&
                passwordText.value.isNotEmpty)
          : (emailText.value.isNotEmpty && passwordText.value.isNotEmpty);
      isFormValid.value = valid;
    }

    // Listen to text changes for form validation
    useEffect(() {
      void phoneListener() {
        phoneText.value = phoneController.text;
        updateFormValidation();
      }

      void emailListener() {
        emailText.value = emailController.text;
        updateFormValidation();
      }

      void passwordListener() {
        passwordText.value = passwordController.text;
        updateFormValidation();
      }

      phoneController.addListener(phoneListener);
      emailController.addListener(emailListener);
      passwordController.addListener(passwordListener);

      return () {
        phoneController.removeListener(phoneListener);
        emailController.removeListener(emailListener);
        passwordController.removeListener(passwordListener);
      };
    }, [phoneController, emailController, passwordController]);

    // Update form validation when dependencies change
    useEffect(() {
      updateFormValidation();
      return null;
    }, [isPhoneMode.value, selectedCountryCode.value, isTermsAccepted.value]);

    // Handle login
    Future<void> handleLogin() async {
      if (!isTermsAccepted.value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AuthConstants.errorTermsNotAccepted)),
        );
        return;
      }

      if (isPhoneMode.value) {
        await _handlePhoneLogin(
          context,
          ref,
          selectedCountryCode.value,
          phoneController,
          passwordController,
          isLoading,
        );
      } else {
        await _handleEmailLogin(
          context,
          ref,
          emailController,
          passwordController,
          isLoading,
        );
      }
    }

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
                    LoginInputFields(
                      isPhoneMode: isPhoneMode.value,
                      phoneController: phoneController,
                      emailController: emailController,
                      passwordController: passwordController,
                      selectedCountryCode: selectedCountryCode.value,
                      isPasswordVisible: isPasswordVisible.value,
                      isLoading: isLoading.value,
                      onCountryCodeChanged: (code) =>
                          selectedCountryCode.value = code,
                      onPasswordVisibilityToggle: () =>
                          isPasswordVisible.value = !isPasswordVisible.value,
                    ),
                    const SizedBox(height: LoginDesignConstants.spacingMedium),
                    LoginTermsCheckbox(
                      isTermsAccepted: isTermsAccepted.value,
                      isLoading: isLoading.value,
                      onChanged: (value) => isTermsAccepted.value = value,
                    ),
                    const SizedBox(height: LoginDesignConstants.spacingLarge),
                    LoginButton(
                      isLoading: isLoading.value,
                      isTermsAccepted: isTermsAccepted.value,
                      isFormValid: isFormValid.value,
                      onPressed: handleLogin,
                    ),
                    const SizedBox(height: LoginDesignConstants.spacingLarge),
                    const LoginSeparator(),
                    const SizedBox(height: LoginDesignConstants.spacingLarge),
                    LoginModeSwitch(
                      isPhoneMode: isPhoneMode.value,
                      isLoading: isLoading.value,
                      onPressed: () => isPhoneMode.value = !isPhoneMode.value,
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

  /// Handle phone login.
  Future<void> _handlePhoneLogin(
    BuildContext context,
    WidgetRef ref,
    CountryCode? countryCode,
    TextEditingController phoneController,
    TextEditingController passwordController,
    ValueNotifier<bool> isLoading,
  ) async {
    if (countryCode == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AuthConstants.errorCountryCodeNotSelected),
        ),
      );
      return;
    }

    if (phoneController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AuthConstants.errorFieldsEmpty)),
      );
      return;
    }

    // Validate phone number length
    final phoneDigits = phoneController.text.trim().replaceAll(
      RegExp(r'\D'),
      '',
    );
    if (phoneDigits.length < AuthConstants.phoneMinDigits ||
        phoneDigits.length > AuthConstants.phoneMaxDigits) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AuthConstants.errorPhoneNumberLength)),
      );
      return;
    }

    isLoading.value = true;

    try {
      final request = PhoneLoginRequest(
        countryCode: countryCode.dialCode,
        phoneNumber: phoneController.text.trim(),
        password: passwordController.text,
      );

      await ref.read(phoneLoginProvider(request).future);

      if (context.mounted) {
        context.goNamed(Routes.homeName);
      }
    } catch (e) {
      if (context.mounted) {
        final errorMessage = e is Failure ? e.message : e.toString();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// Handle email login.
  Future<void> _handleEmailLogin(
    BuildContext context,
    WidgetRef ref,
    TextEditingController emailController,
    TextEditingController passwordController,
    ValueNotifier<bool> isLoading,
  ) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AuthConstants.errorFieldsEmpty)),
      );
      return;
    }

    isLoading.value = true;

    try {
      final request = EmailLoginRequest(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      await ref.read(emailLoginProvider(request).future);

      if (context.mounted) {
        context.goNamed(Routes.homeName);
      }
    } catch (e) {
      if (context.mounted) {
        final errorMessage = e is Failure ? e.message : e.toString();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    } finally {
      isLoading.value = false;
    }
  }
}
