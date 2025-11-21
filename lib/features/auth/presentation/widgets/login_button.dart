import 'package:flutter/material.dart';
import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/features/auth/presentation/constants/auth_constants.dart';
import 'package:app_mobile_afms/features/auth/presentation/constants/login_design_constants.dart';

/// Login button widget for login screen.
class LoginButton extends StatelessWidget {
  /// Creates a new instance of [LoginButton].
  const LoginButton({
    required this.isLoading,
    required this.isFormValid,
    required this.onPressed,
    super.key,
  });

  /// Whether form is loading.
  final bool isLoading;

  /// Whether form is valid.
  final bool isFormValid;

  /// Callback when button is pressed.
  final VoidCallback onPressed;

  bool get _isButtonEnabled => !isLoading && isFormValid;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: LoginDesignConstants.buttonHeight,
      child: ElevatedButton(
        onPressed: _isButtonEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isButtonEnabled
              ? LoginDesignConstants.primary
              : LoginDesignConstants.gray20,
          foregroundColor: _isButtonEnabled
              ? LoginDesignConstants.white
              : LoginDesignConstants.gray70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              LoginDesignConstants.inputBorderRadius,
            ),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: LoginDesignConstants.loadingIndicatorSize,
                height: LoginDesignConstants.loadingIndicatorSize,
                child: CircularProgressIndicator(
                  strokeWidth: LoginDesignConstants.loadingIndicatorStrokeWidth,
                  color: LoginDesignConstants.white,
                ),
              )
            : Text(
                AuthConstants.buttonLogin,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _isButtonEnabled ? LoginDesignConstants.white : LoginDesignConstants.gray70,
                  fontFamily: AppConstants.fontFamily,
                ),
              ),
      ),
    );
  }
}
