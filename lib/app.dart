import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/app_config.dart';
import 'package:flutter_base_app/design_system/theme/app_theme.dart';
import 'package:flutter_base_app/router/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Root widget of the application.
class App extends StatelessWidget {
  /// Creates a new instance of [App].
  const App({required this.config, super.key});

  /// Application configuration
  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Design size from Figma (adjust according to design system)
      // Default: iPhone 14 Pro (390 x 844)
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: config.appName,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          routerConfig: AppRouter.router,
          builder: (context, widget) {
            // Show flavor banner in debug mode
            if (kDebugMode) {
              return Banner(
                location: BannerLocation.topStart,
                message: config.flavor.name.toUpperCase(),
                color: Colors.green.withAlpha(150),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  letterSpacing: 1,
                ),
                textDirection: TextDirection.ltr,
                child: widget ?? const SizedBox.shrink(),
              );
            }
            return widget ?? const SizedBox.shrink();
          },
        );
      },
    );
  }
}
