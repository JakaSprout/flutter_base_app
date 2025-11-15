import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/auth/domain/entities/country_code.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/auth_constants.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/login_design_constants.dart';
import 'package:flutter_base_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/country_code_dropdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Input fields widget for login screen.
///
/// Handles both phone and email input modes.
class LoginInputFields extends ConsumerWidget {
  /// Creates a new instance of [LoginInputFields].
  const LoginInputFields({
    required this.isPhoneMode,
    required this.phoneController,
    required this.emailController,
    required this.passwordController,
    required this.selectedCountryCode,
    required this.isPasswordVisible,
    required this.isLoading,
    required this.onCountryCodeChanged,
    required this.onPasswordVisibilityToggle,
    super.key,
  });

  /// Whether the login mode is phone (true) or email (false).
  final bool isPhoneMode;

  /// Phone number text controller.
  final TextEditingController phoneController;

  /// Email text controller.
  final TextEditingController emailController;

  /// Password text controller.
  final TextEditingController passwordController;

  /// Selected country code.
  final CountryCode? selectedCountryCode;

  /// Whether password is visible.
  final bool isPasswordVisible;

  /// Whether form is loading.
  final bool isLoading;

  /// Callback when country code changes.
  final ValueChanged<CountryCode> onCountryCodeChanged;

  /// Callback when password visibility toggles.
  final VoidCallback onPasswordVisibilityToggle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryCodesAsync = ref.watch(countryCodesProvider);

    return Column(
      children: [
        // Phone or Email input
        if (isPhoneMode)
          _buildPhoneInput(context, countryCodesAsync)
        else
          _buildEmailInput(context),
        const SizedBox(height: LoginDesignConstants.spacingMedium),
        // Password input
        _buildPasswordInput(context),
      ],
    );
  }

  Widget _buildPhoneInput(
    BuildContext context,
    AsyncValue<List<CountryCode>> countryCodesAsync,
  ) {
    return countryCodesAsync.when(
      data: (codes) => Row(
        children: [
          CountryCodeDropdown(
            countryCodes: codes,
            selectedCountryCode: selectedCountryCode,
            onChanged: onCountryCodeChanged,
            enabled: !isLoading,
          ),
          const SizedBox(width: LoginDesignConstants.spacingSmall),
          Expanded(
            child: _buildTextField(
              context: context,
              controller: phoneController,
              keyboardType: TextInputType.phone,
              hintText: AuthConstants.hintPhoneNumber,
              enabled: !isLoading,
            ),
          ),
        ],
      ),
      loading: () => Row(
        children: [
          // Placeholder for country code dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.gray05,
              border: Border.all(color: AppColors.gray20),
              borderRadius: BorderRadius.circular(
                LoginDesignConstants.inputBorderRadius,
              ),
            ),
            child: const SizedBox(width: 80, height: 20),
          ),
          const SizedBox(width: LoginDesignConstants.spacingSmall),
          Expanded(
            child: _buildTextField(
              context: context,
              controller: phoneController,
              keyboardType: TextInputType.phone,
              hintText: AuthConstants.hintPhoneNumber,
              enabled: false,
            ),
          ),
        ],
      ),
      error: (error, stack) => Text('Error: $error'),
    );
  }

  Widget _buildEmailInput(BuildContext context) {
    return _buildTextField(
      context: context,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      hintText: AuthConstants.hintEmail,
      enabled: !isLoading,
    );
  }

  Widget _buildPasswordInput(BuildContext context) {
    return _buildTextField(
      context: context,
      controller: passwordController,
      obscureText: !isPasswordVisible,
      hintText: AuthConstants.hintPassword,
      enabled: !isLoading,
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

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    bool obscureText = false,
    bool enabled = true,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      enabled: enabled,
      decoration: InputDecoration(
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
      ),
    );
  }
}
