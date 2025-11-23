import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/features/auth/presentation/constants/auth_constants.dart';
import 'package:app_mobile_afms/features/auth/presentation/constants/login_design_constants.dart';
import 'package:flutter/material.dart';

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
        color: isLoading
            ? LoginDesignConstants.gray70
            : LoginDesignConstants.primary,
      ),
      label: Text(
        isPhoneMode
            ? AuthConstants.buttonLoginWithEmail
            : AuthConstants.buttonLoginWithPhone,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: isLoading
              ? LoginDesignConstants.gray70
              : LoginDesignConstants.primary,
          fontFamily: AppConstants.fontFamily,
        ),
      ),
    );
  }
}
