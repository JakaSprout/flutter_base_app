import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/core/di/providers/secure_storage_provider.dart';
import 'package:app_mobile_afms/design_system/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/mock_factories.dart';
import '../../../helpers/test_helpers.dart';

void main() {
  // Initialize Flutter binding for tests that need platform channels
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ThemeModeNotifier', () {
    late ProviderContainer container;
    late MockFlutterSecureStorage mockStorage;

    setUp(() {
      mockStorage = MockFlutterSecureStorage();

      // Setup mock storage to return null by default (system theme)
      when(
        () => mockStorage.read(key: AppConstants.storageThemeMode),
      ).thenAnswer((_) async => null);
      when(
        () => mockStorage.write(
          key: AppConstants.storageThemeMode,
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async => {});

      container = TestHelpers.createContainer(
        overrides: [secureStorageProvider.overrideWithValue(mockStorage)],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('should initialize with system theme by default', () async {
      // Act
      final themeMode = await container.read(themeModeNotifierProvider.future);

      // Assert
      expect(themeMode, equals(ThemeMode.system));
    });

    test('should save and load theme preference', () async {
      // Arrange
      final notifier = container.read(themeModeNotifierProvider.notifier);

      // Setup mock to return 'dark' after write
      when(
        () => mockStorage.read(key: AppConstants.storageThemeMode),
      ).thenAnswer((_) async => 'dark');

      // Act
      await notifier.setThemeMode(ThemeMode.dark);
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Verify write was called
      verify(
        () => mockStorage.write(
          key: AppConstants.storageThemeMode,
          value: 'dark',
        ),
      ).called(1);

      // Create new container to test persistence
      final newContainer = TestHelpers.createContainer(
        overrides: [secureStorageProvider.overrideWithValue(mockStorage)],
      );

      final savedTheme = await newContainer.read(
        themeModeNotifierProvider.future,
      );

      // Assert
      expect(savedTheme, equals(ThemeMode.dark));

      newContainer.dispose();
    });

    test('should toggle theme correctly', () async {
      // Arrange
      final notifier = container.read(themeModeNotifierProvider.notifier);

      // Setup mock to return 'light' initially, then 'dark' after toggle
      when(
        () => mockStorage.read(key: AppConstants.storageThemeMode),
      ).thenAnswer((_) async => 'light');

      await notifier.setThemeMode(ThemeMode.light);
      await Future<void>.delayed(const Duration(milliseconds: 50));

      // Update mock to return 'dark' after toggle
      when(
        () => mockStorage.read(key: AppConstants.storageThemeMode),
      ).thenAnswer((_) async => 'dark');

      // Act
      await notifier.toggleTheme();
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      final themeMode = await container.read(themeModeNotifierProvider.future);
      expect(themeMode, equals(ThemeMode.dark));
    });

    test('should cycle through themes when toggling', () async {
      // Arrange
      final notifier = container.read(themeModeNotifierProvider.notifier);

      // Setup mock to return 'light' initially
      when(
        () => mockStorage.read(key: AppConstants.storageThemeMode),
      ).thenAnswer((_) async => 'light');

      // Act & Assert - Light -> Dark
      await notifier.setThemeMode(ThemeMode.light);
      when(
        () => mockStorage.read(key: AppConstants.storageThemeMode),
      ).thenAnswer((_) async => 'dark');
      await notifier.toggleTheme();
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(
        await container.read(themeModeNotifierProvider.future),
        equals(ThemeMode.dark),
      );

      // Act & Assert - Dark -> System
      when(
        () => mockStorage.read(key: AppConstants.storageThemeMode),
      ).thenAnswer((_) async => 'system');
      await notifier.toggleTheme();
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(
        await container.read(themeModeNotifierProvider.future),
        equals(ThemeMode.system),
      );

      // Act & Assert - System -> Light
      when(
        () => mockStorage.read(key: AppConstants.storageThemeMode),
      ).thenAnswer((_) async => 'light');
      await notifier.toggleTheme();
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(
        await container.read(themeModeNotifierProvider.future),
        equals(ThemeMode.light),
      );
    });
  });
}
