import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/features/auth/presentation/constants/auth_constants.dart';
import 'package:app_mobile_afms/features/auth/presentation/constants/login_design_constants.dart';
import 'package:flutter/material.dart';

/// Separator widget with "Or" text for login screen.
class LoginSeparator extends StatelessWidget {
  /// Creates a new instance of [LoginSeparator].
  const LoginSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: LoginDesignConstants.gray20)),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: LoginDesignConstants.spacingSmall,
          ),
          child: Text(
            AuthConstants.separatorOr,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: LoginDesignConstants.gray100,
              fontFamily: AppConstants.fontFamily,
            ),
          ),
        ),
        const Expanded(child: Divider(color: LoginDesignConstants.gray20)),
      ],
    );
  }
}
