import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/login_design_constants.dart';

/// Card container widget for login screen.
class LoginCard extends StatelessWidget {
  /// Creates a new instance of [LoginCard].
  const LoginCard({required this.child, super.key});

  /// Child widget to display inside the card.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: LoginDesignConstants.maxCardWidth,
      ),
      padding: const EdgeInsets.all(LoginDesignConstants.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          LoginDesignConstants.cardBorderRadius,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              LoginDesignConstants.boxShadowOpacity,
            ),
            blurRadius: LoginDesignConstants.boxShadowBlurRadius,
            offset: const Offset(0, LoginDesignConstants.boxShadowOffsetY),
          ),
        ],
      ),
      child: child,
    );
  }
}
