import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/auth_constants.dart';

/// Mode switch button widget for login screen.
///
/// Allows switching between phone and email login modes.
class LoginModeSwitch extends StatelessWidget {
  /// Creates a new instance of [LoginModeSwitch].
  const LoginModeSwitch({
    required this.isPhoneMode,
    required this.isLoading,
    required this.onPressed,
    super.key,
  });

  /// Whether the login mode is phone (true) or email (false).
  final bool isPhoneMode;

  /// Whether form is loading.
  final bool isLoading;

  /// Callback when button is pressed.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: isLoading ? null : onPressed,
      icon: Icon(
        isPhoneMode ? Icons.email_outlined : Icons.phone_outlined,
        color: isLoading ? AppColors.gray70 : AppColors.primary,
      ),
      label: Text(
        isPhoneMode
            ? AuthConstants.buttonLoginWithEmail
            : AuthConstants.buttonLoginWithPhone,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: isLoading ? AppColors.gray70 : AppColors.primary,
          fontFamily: AppConstants.fontFamily,
        ),
      ),
    );
  }
}
