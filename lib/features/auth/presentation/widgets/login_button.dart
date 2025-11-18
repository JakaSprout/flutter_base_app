import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/auth_constants.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/login_design_constants.dart';

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
              ? AppColors.primary
              : AppColors.gray20,
          foregroundColor: _isButtonEnabled
              ? AppColors.white
              : AppColors.gray70,
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
                  color: AppColors.white,
                ),
              )
            : Text(
                AuthConstants.buttonLogin,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _isButtonEnabled ? AppColors.white : AppColors.gray70,
                  fontFamily: AppConstants.fontFamily,
                ),
              ),
      ),
    );
  }
}
