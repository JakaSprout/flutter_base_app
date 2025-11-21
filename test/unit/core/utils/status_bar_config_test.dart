import 'package:flutter/material.dart';
import 'package:app_mobile_afms/core/utils/status_bar_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('StatusBarConfig', () {
    test('setLightStatusBar should configure light status bar', () {
      // Act & Assert - Method should execute without throwing exception
      // Note: SystemChrome may throw in test context when platform channel is not available,
      // but we verify the method can be called
      expect(StatusBarConfig.setLightStatusBar, returnsNormally);
    });

    test('setDarkStatusBar should configure dark status bar', () {
      // Act & Assert - Method should execute without throwing exception
      expect(StatusBarConfig.setDarkStatusBar, returnsNormally);
    });

    test('setStatusBarForBrightness should set light for Brightness.light', () {
      // Act & Assert - Method should execute without throwing exception
      expect(
        () => StatusBarConfig.setStatusBarForBrightness(Brightness.light),
        returnsNormally,
      );
    });

    test('setStatusBarForBrightness should set dark for Brightness.dark', () {
      // Act & Assert - Method should execute without throwing exception
      expect(
        () => StatusBarConfig.setStatusBarForBrightness(Brightness.dark),
        returnsNormally,
      );
    });

    test('setStatusBarForThemeMode should set based on ThemeMode', () {
      // Act & Assert - Methods should execute without throwing exception
      expect(
        () => StatusBarConfig.setStatusBarForThemeMode(
          ThemeMode.light,
          Brightness.light,
        ),
        returnsNormally,
      );
      expect(
        () => StatusBarConfig.setStatusBarForThemeMode(
          ThemeMode.dark,
          Brightness.dark,
        ),
        returnsNormally,
      );
      expect(
        () => StatusBarConfig.setStatusBarForThemeMode(
          ThemeMode.system,
          Brightness.light,
        ),
        returnsNormally,
      );
    });

    test(
      'setStatusBarForDarkBackground should configure for dark background',
      () {
        // Act & Assert - Method should execute without throwing exception
        expect(StatusBarConfig.setStatusBarForDarkBackground, returnsNormally);
      },
    );

    test('getStatusBarStyleForDarkBackground should return correct style', () {
      // Act
      final style = StatusBarConfig.getStatusBarStyleForDarkBackground();

      // Assert
      expect(style.statusBarColor, equals(Colors.transparent));
      expect(style.statusBarIconBrightness, equals(Brightness.light));
      expect(style.statusBarBrightness, equals(Brightness.dark));
      expect(style.systemNavigationBarColor, equals(Colors.transparent));
      expect(style.systemNavigationBarIconBrightness, equals(Brightness.light));
    });

    test('getStatusBarStyleForLightBackground should return correct style', () {
      // Act
      final style = StatusBarConfig.getStatusBarStyleForLightBackground();

      // Assert
      expect(style.statusBarColor, equals(Colors.transparent));
      expect(style.statusBarIconBrightness, equals(Brightness.dark));
      expect(style.statusBarBrightness, equals(Brightness.light));
      expect(style.systemNavigationBarColor, equals(Colors.transparent));
      expect(style.systemNavigationBarIconBrightness, equals(Brightness.dark));
    });
  });
}
