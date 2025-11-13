import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/app_config.dart';
import 'package:flutter_base_app/core/utils/status_bar_config.dart';
import 'package:flutter_base_app/design_system/theme/app_theme.dart';
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
          darkTheme: AppTheme.lightTheme, // Always use light theme
          themeMode: ThemeMode.light, // Always use light mode
          routerConfig: AppRouter.router,
          builder: (context, widget) {
            // Wrap widget with StatusBarUpdater to handle theme changes
            final wrappedWidget = _StatusBarUpdater(
              child: widget ?? const SizedBox.shrink(),
            );

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
                child: wrappedWidget,
              );
            }
            return wrappedWidget;
          },
        );
      },
    );
  }
}

/// Widget that updates status bar when theme changes.
///
/// This widget listens to theme changes and automatically updates
/// the status bar configuration based on the current theme brightness.
class _StatusBarUpdater extends StatefulWidget {
  /// Creates a new instance of [_StatusBarUpdater].
  const _StatusBarUpdater({required this.child});

  /// Child widget to wrap.
  final Widget child;

  @override
  State<_StatusBarUpdater> createState() => _StatusBarUpdaterState();
}

class _StatusBarUpdaterState extends State<_StatusBarUpdater> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update status bar whenever theme changes
    _updateStatusBar();
  }

  void _updateStatusBar() {
    // Always use light status bar regardless of theme mode
    StatusBarConfig.setLightStatusBar();
  }

  @override
  Widget build(BuildContext context) {
    // Update status bar on build as well (for initial setup)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateStatusBar();
    });

    return widget.child;
  }
}
