import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/core/di/providers/secure_storage_provider.dart';
import 'package:flutter_base_app/core/logging/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

/// Theme mode provider that manages theme preference.
///
/// This provider handles theme mode state and persistence.
/// It supports three modes: light, dark, and system (follows device setting).
@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  Future<ThemeMode> build() async {
    // Load saved theme preference
    final secureStorage = ref.read(secureStorageProvider);
    final savedTheme = await _loadThemePreference(secureStorage);

    // Listen to system theme changes if mode is system
    if (savedTheme == ThemeMode.system) {
      // TODO: Listen to system theme changes if needed
      // For now, just return the saved preference
    }

    return savedTheme;
  }

  /// Load theme preference from storage.
  Future<ThemeMode> _loadThemePreference(
    FlutterSecureStorage secureStorage,
  ) async {
    try {
      final savedValue = await secureStorage.read(
        key: AppConstants.storageThemeMode,
      );

      if (savedValue == null) {
        // Default to system theme
        return ThemeMode.system;
      }

      // Parse saved value
      switch (savedValue.toLowerCase()) {
        case 'light':
          return ThemeMode.light;
        case 'dark':
          return ThemeMode.dark;
        case 'system':
        default:
          return ThemeMode.system;
      }
    } catch (e, stackTrace) {
      AppLogger.error('Failed to load theme preference', e, stackTrace);
      return ThemeMode.system; // Default to system
    }
  }

  /// Save theme preference to storage.
  Future<void> _saveThemePreference(
    FlutterSecureStorage secureStorage,
    ThemeMode themeMode,
  ) async {
    try {
      String value;
      switch (themeMode) {
        case ThemeMode.light:
          value = 'light';
          break;
        case ThemeMode.dark:
          value = 'dark';
          break;
        case ThemeMode.system:
          value = 'system';
          break;
      }

      await secureStorage.write(
        key: AppConstants.storageThemeMode,
        value: value,
      );

      AppLogger.debug('Theme preference saved: $value');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to save theme preference', e, stackTrace);
    }
  }

  /// Set theme mode.
  ///
  /// Updates the theme mode and saves the preference.
  Future<void> setThemeMode(ThemeMode themeMode) async {
    state = AsyncValue.data(themeMode);

    // Save preference
    final secureStorage = ref.read(secureStorageProvider);
    await _saveThemePreference(secureStorage, themeMode);
  }

  /// Toggle between light and dark theme.
  ///
  /// If current mode is system, switches to light.
  /// If current mode is light, switches to dark.
  /// If current mode is dark, switches to light.
  Future<void> toggleTheme() async {
    final currentMode = await future;
    ThemeMode newMode;

    switch (currentMode) {
      case ThemeMode.light:
        newMode = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        newMode = ThemeMode.light;
        break;
      case ThemeMode.system:
        // If system, check actual brightness and toggle
        // For simplicity, switch to light
        newMode = ThemeMode.light;
        break;
    }

    await setThemeMode(newMode);
  }
}

/// Provider for current theme mode (synchronous access).
///
/// This provides synchronous access to the current theme mode.
/// Use this when you need the theme mode synchronously.
@riverpod
ThemeMode currentThemeMode(CurrentThemeModeRef ref) {
  final asyncThemeMode = ref.watch(themeModeNotifierProvider);
  return asyncThemeMode.when(
    data: (mode) => mode,
    loading: () => ThemeMode.system, // Default while loading
    error: (_, __) => ThemeMode.system, // Default on error
  );
}

