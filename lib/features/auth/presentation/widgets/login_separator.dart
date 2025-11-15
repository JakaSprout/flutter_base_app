import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/auth_constants.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/login_design_constants.dart';

/// Separator widget with "Or" text for login screen.
class LoginSeparator extends StatelessWidget {
  /// Creates a new instance of [LoginSeparator].
  const LoginSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.gray20)),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: LoginDesignConstants.spacingSmall,
          ),
          child: Text(
            AuthConstants.separatorOr,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.gray100,
              fontFamily: AppConstants.fontFamily,
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.gray20)),
      ],
    );
  }
}
