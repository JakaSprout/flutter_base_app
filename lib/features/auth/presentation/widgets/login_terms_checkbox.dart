import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/features/auth/presentation/constants/auth_constants.dart';
import 'package:app_mobile_afms/features/auth/presentation/constants/login_design_constants.dart';
import 'package:flutter/material.dart';

/// Terms and conditions checkbox widget for login screen.
class LoginTermsCheckbox extends StatelessWidget {
  /// Creates a new instance of [LoginTermsCheckbox].
  const LoginTermsCheckbox({
    required this.isTermsAccepted,
    required this.isLoading,
    required this.onChanged,
    super.key,
  });

  /// Whether terms are accepted.
  final bool isTermsAccepted;

  /// Whether form is loading.
  final bool isLoading;

  /// Callback when checkbox value changes.
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isTermsAccepted,
          onChanged: isLoading ? null : (value) => onChanged(value ?? false),
          activeColor: LoginDesignConstants.primary,
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              text: AuthConstants.termsAgreementPrefix,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: LoginDesignConstants.gray100,
                fontFamily: AppConstants.fontFamily,
              ),
              children: const [
                TextSpan(
                  text: AuthConstants.termsAndConditions,
                  style: TextStyle(color: LoginDesignConstants.primary),
                ),
                TextSpan(text: AuthConstants.termsSeparator),
                TextSpan(
                  text: AuthConstants.privacyPolicy,
                  style: TextStyle(color: LoginDesignConstants.primary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
