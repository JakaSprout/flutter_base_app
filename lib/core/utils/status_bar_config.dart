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
    // Ensure status bar is enabled (for Android)
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: const [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness:
            Brightness.dark, // Dark icons on light background
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
    // Ensure status bar is enabled (for Android)
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: const [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.black,
        statusBarIconBrightness:
            Brightness.light, // Light icons on dark background
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
      case Brightness.dark:
        setDarkStatusBar();
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

  /// Configure status bar for dark background with light icons.
  ///
  /// Use this for screens with dark backgrounds (e.g., login screen with blue background)
  /// where white text/icons are needed for visibility.
  ///
  /// Sets:
  /// - Status bar: Transparent with light icons (white)
  /// - Navigation bar: Transparent (Android)
  static void setStatusBarForDarkBackground() {
    // Ensure status bar is enabled (for Android)
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: const [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Always transparent
        statusBarIconBrightness:
            Brightness.light, // Light icons (white) for dark background
        statusBarBrightness:
            Brightness.dark, // Dark status bar style for iOS (white text/icons)
        systemNavigationBarColor:
            Colors.transparent, // Transparent navigation bar
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  /// Get SystemUiOverlayStyle for dark background with light icons.
  ///
  /// Use this with [AnnotatedRegion] widget for per-screen status bar configuration.
  ///
  /// Returns:
  /// - [SystemUiOverlayStyle] configured for dark background with white icons.
  static SystemUiOverlayStyle getStatusBarStyleForDarkBackground() {
    return const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Always transparent
      statusBarIconBrightness:
          Brightness.light, // Light icons (white) for dark background
      statusBarBrightness:
          Brightness.dark, // Dark status bar style for iOS (white text/icons)
      systemNavigationBarColor:
          Colors.transparent, // Transparent navigation bar
      systemNavigationBarIconBrightness: Brightness.light,
    );
  }

  /// Get SystemUiOverlayStyle for light background with dark icons.
  ///
  /// Use this with [AnnotatedRegion] widget for per-screen status bar configuration.
  ///
  /// Returns:
  /// - [SystemUiOverlayStyle] configured for light background with dark icons.
  static SystemUiOverlayStyle getStatusBarStyleForLightBackground() {
    return const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Always transparent
      statusBarIconBrightness:
          Brightness.dark, // Dark icons (black) for light background
      statusBarBrightness:
          Brightness.light, // Light status bar style for iOS (black text/icons)
      systemNavigationBarColor:
          Colors.transparent, // Transparent navigation bar
      systemNavigationBarIconBrightness: Brightness.dark,
    );
  }
}
