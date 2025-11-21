import 'package:flutter/material.dart';
import 'package:app_mobile_afms/features/auth/presentation/constants/login_design_constants.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Logo widget for login screen.
class LoginLogo extends StatelessWidget {
  /// Creates a new instance of [LoginLogo].
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        Assets.icons.general.logo,
        height: LoginDesignConstants.logoHeight,
      ),
    );
  }
}
