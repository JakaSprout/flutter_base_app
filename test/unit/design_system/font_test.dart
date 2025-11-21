import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/design_system/theme/app_theme.dart';
import 'package:flutter_test/flutter_test.dart';

/// Test to verify that Open Sans font is properly configured.
void main() {
  group('Font Configuration Tests', () {
    test('AppConstants should have Open Sans as fontFamily', () {
      expect(AppConstants.fontFamily, equals('Open Sans'));
    });

    test('Light theme should use Open Sans fontFamily', () {
      final theme = AppTheme.lightTheme;
      expect(theme.textTheme.bodyMedium?.fontFamily, equals('Open Sans'));
    });

    test('Dark theme should use Open Sans fontFamily', () {
      final theme = AppTheme.darkTheme;
      expect(theme.textTheme.bodyMedium?.fontFamily, equals('Open Sans'));
    });

    test('TextTheme should have Open Sans in all text styles', () {
      final textTheme = AppTheme.lightTheme.textTheme;

      expect(textTheme.displayLarge?.fontFamily, equals('Open Sans'));
      expect(textTheme.displayMedium?.fontFamily, equals('Open Sans'));
      expect(textTheme.displaySmall?.fontFamily, equals('Open Sans'));
      expect(textTheme.headlineLarge?.fontFamily, equals('Open Sans'));
      expect(textTheme.headlineMedium?.fontFamily, equals('Open Sans'));
      expect(textTheme.headlineSmall?.fontFamily, equals('Open Sans'));
      expect(textTheme.titleLarge?.fontFamily, equals('Open Sans'));
      expect(textTheme.titleMedium?.fontFamily, equals('Open Sans'));
      expect(textTheme.titleSmall?.fontFamily, equals('Open Sans'));
      expect(textTheme.bodyLarge?.fontFamily, equals('Open Sans'));
      expect(textTheme.bodyMedium?.fontFamily, equals('Open Sans'));
      expect(textTheme.bodySmall?.fontFamily, equals('Open Sans'));
      expect(textTheme.labelLarge?.fontFamily, equals('Open Sans'));
      expect(textTheme.labelMedium?.fontFamily, equals('Open Sans'));
      expect(textTheme.labelSmall?.fontFamily, equals('Open Sans'));
    });
  });
}
