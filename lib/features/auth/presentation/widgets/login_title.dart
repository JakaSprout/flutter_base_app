import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/auth_constants.dart';

/// Title widget for login screen.
class LoginTitle extends StatelessWidget {
  /// Creates a new instance of [LoginTitle].
  const LoginTitle({required this.isPhoneMode, super.key});

  /// Whether the login mode is phone (true) or email (false).
  final bool isPhoneMode;

  @override
  Widget build(BuildContext context) {
    return Text(
      isPhoneMode
          ? AuthConstants.titlePhoneLogin
          : AuthConstants.titleEmailLogin,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.gray100,
        fontFamily: AppConstants.fontFamily,
      ),
      textAlign: TextAlign.center,
    );
  }
}
