import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';

/// Utility class for configuring system status bar based on theme.
///
/// This class provides methods to set status bar color and icon brightness
/// based on the current theme mode (light/dark).
class StatusBarConfig {
  /// Private constructor to prevent instantiation.
  StatusBarConfig._();

  /// Configure status bar for light theme.
  ///
  /// Sets:
  /// - Status bar color: White
  /// - Status bar icon brightness: Dark (for visibility on light background)
  static void setLightStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark, // Dark icons on light background
        statusBarBrightness: Brightness.light, // For iOS
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  /// Configure status bar for dark theme.
  ///
  /// Sets:
  /// - Status bar color: Black or dark background
  /// - Status bar icon brightness: Light (for visibility on dark background)
  static void setDarkStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.black,
        statusBarIconBrightness: Brightness.light, // Light icons on dark background
        statusBarBrightness: Brightness.dark, // For iOS
        systemNavigationBarColor: AppColors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  /// Configure status bar based on theme brightness.
  ///
  /// Automatically selects the appropriate status bar style based on
  /// the provided [Brightness].
  ///
  /// - [Brightness.light] → Light status bar (dark icons)
  /// - [Brightness.dark] → Dark status bar (light icons)
  static void setStatusBarForBrightness(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        setLightStatusBar();
        break;
      case Brightness.dark:
        setDarkStatusBar();
        break;
    }
  }

  /// Configure status bar based on theme mode.
  ///
  /// Automatically determines the appropriate status bar style based on
  /// the current [ThemeMode] and system brightness.
  ///
  /// - [ThemeMode.light] → Light status bar
  /// - [ThemeMode.dark] → Dark status bar
  /// - [ThemeMode.system] → Based on system brightness
  static void setStatusBarForThemeMode(
    ThemeMode themeMode,
    Brightness systemBrightness,
  ) {
    final brightness = switch (themeMode) {
      ThemeMode.light => Brightness.light,
      ThemeMode.dark => Brightness.dark,
      ThemeMode.system => systemBrightness,
    };

    setStatusBarForBrightness(brightness);
  }

  /// Configure status bar based on current theme context.
  ///
  /// Reads the theme brightness from the provided [BuildContext] and
  /// configures the status bar accordingly.
  ///
  /// This is the recommended method to use in widgets that have access
  /// to a [BuildContext] with theme information.
  static void setStatusBarFromContext(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    setStatusBarForBrightness(brightness);
  }
}

