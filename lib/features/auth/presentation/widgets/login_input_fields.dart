import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/auth_constants.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/login_design_constants.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/login_form_controls.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Input fields widget for login screen.
///
/// Handles both phone and email input modes using reactive_forms.
class LoginInputFields extends StatelessWidget {
  /// Creates a new instance of [LoginInputFields].
  const LoginInputFields({
    required this.form,
    required this.isPhoneMode,
    required this.isPasswordVisible,
    required this.isLoading,
    required this.onPasswordVisibilityToggle,
    super.key,
  });

  /// Login [FormGroup].
  final FormGroup form;

  /// Whether the login mode is phone (true) or email (false).
  final bool isPhoneMode;

  /// Whether password is visible.
  final bool isPasswordVisible;

  /// Whether form is loading.
  final bool isLoading;

  /// Callback when password visibility toggles.
  final VoidCallback onPasswordVisibilityToggle;

  @override
  Widget build(BuildContext context) {
    // Note: ReactiveForm wrapper is provided by parent (login_screen.dart)
    return Column(
      children: [
        if (isPhoneMode)
          _buildPhoneInput(context)
        else
          _buildEmailInput(context),
        if (!isPhoneMode) ...[
          const SizedBox(height: LoginDesignConstants.spacingMedium),
          _buildPasswordInput(context),
        ],
      ],
    );
  }

  Widget _buildPhoneInput(BuildContext context) {
    return _buildReactiveTextField(
      context: context,
      key: const ValueKey('phone_input'),
      formControlName: LoginFormControls.phone,
      hintText: AuthConstants.hintPhoneNumber,
      keyboardType: TextInputType.phone,
      validationMessages: {
        ValidationMessage.required: (_) =>
            AuthConstants.errorPhoneNumberRequired,
        'phoneFormat': (error) {
          if (error is Map<String, dynamic>) {
            final errorMessage = error['phoneFormat'] as String?;
            return errorMessage ?? 'Please enter a valid phone number';
          }
          return 'Please enter a valid phone number';
        },
      },
    );
  }

  Widget _buildEmailInput(BuildContext context) {
    return _buildReactiveTextField(
      context: context,
      key: const ValueKey('email_input'),
      formControlName: LoginFormControls.email,
      hintText: AuthConstants.hintEmail,
      keyboardType: TextInputType.emailAddress,
      validationMessages: {
        ValidationMessage.required: (_) =>
            AuthConstants.errorEmailAndPasswordRequired,
        ValidationMessage.email: (_) => AuthConstants.errorInvalidEmailFormat,
      },
    );
  }

  Widget _buildPasswordInput(BuildContext context) {
    return _buildReactiveTextField(
      context: context,
      key: const ValueKey('password_input'),
      formControlName: LoginFormControls.password,
      hintText: AuthConstants.hintPassword,
      obscureText: !isPasswordVisible,
      validationMessages: {
        ValidationMessage.required: (_) =>
            AuthConstants.errorEmailAndPasswordRequired,
      },
      suffixIcon: IconButton(
        icon: Icon(
          isPasswordVisible
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
        ),
        onPressed: isLoading ? null : onPasswordVisibilityToggle,
      ),
    );
  }

  Widget _buildReactiveTextField({
    required BuildContext context,
    required String formControlName,
    required String hintText,
    Key? key,
    Map<String, ValidationMessageFunction>? validationMessages,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return ReactiveTextField<String>(
      key: key,
      formControlName: formControlName,
      keyboardType: keyboardType,
      validationMessages: validationMessages,
      readOnly: isLoading,
      obscureText: obscureText,
      cursorColor: AppColors.primary,
      decoration: _buildInputDecoration(context, hintText, suffixIcon),
    );
  }

  InputDecoration _buildInputDecoration(
    BuildContext context,
    String hintText,
    Widget? suffixIcon,
  ) {
    return InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          LoginDesignConstants.inputBorderRadius,
        ),
        borderSide: const BorderSide(color: AppColors.gray20),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          LoginDesignConstants.inputBorderRadius,
        ),
        borderSide: const BorderSide(color: AppColors.gray20),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          LoginDesignConstants.inputBorderRadius,
        ),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          LoginDesignConstants.inputBorderRadius,
        ),
        borderSide: const BorderSide(color: AppColors.gray20),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: LoginDesignConstants.inputPaddingHorizontal,
        vertical: LoginDesignConstants.inputPaddingVertical,
      ),
      suffixIcon: suffixIcon,
    );
  }
}
