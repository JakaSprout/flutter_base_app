import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/app_config.dart';
import 'package:flutter_base_app/design_system/theme/app_theme.dart';
import 'package:flutter_base_app/design_system/theme/theme_provider.dart';
import 'package:flutter_base_app/router/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Root widget of the application.
class App extends HookConsumerWidget {
  /// Creates a new instance of [App].
  const App({required this.config, super.key});

  /// Application configuration
  final AppConfig config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch theme mode from provider
    final themeMode = ref.watch(currentThemeModeProvider);

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
          themeMode: themeMode, // Use theme mode from provider
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
