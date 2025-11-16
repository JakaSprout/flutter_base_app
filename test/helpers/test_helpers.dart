import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/app_config.dart';
import 'package:flutter_base_app/core/di/provider_overrides.dart';
import 'package:flutter_base_app/core/di/providers/dio_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Test helpers for common test setup.
class TestHelpers {
  /// Create a ProviderContainer with test overrides.
  ///
  /// This is useful for unit tests that need to access providers.
  ///
  /// Example:
  /// ```dart
  /// final container = TestHelpers.createContainer();
  /// final config = container.read(appConfigProvider);
  /// ```
  static ProviderContainer createContainer({
    List<Override>? overrides,
    AppConfig? appConfig,
  }) {
    final testOverrides = <Override>[
      ...testProviderOverrides,
      if (appConfig != null) appConfigProvider.overrideWithValue(appConfig),
      if (overrides != null) ...overrides,
    ];

    return ProviderContainer(overrides: testOverrides);
  }

  /// Create a MaterialApp with ProviderScope for widget tests.
  ///
  /// This is useful for widget tests that need Material context.
  ///
  /// Example:
  /// ```dart
  /// testWidgets('MyWidget test', (tester) async {
  ///   await tester.pumpWidget(
  ///     TestHelpers.createTestApp(
  ///       child: MyWidget(),
  ///     ),
  ///   );
  /// });
  /// ```
  static Widget createTestApp({
    required Widget child,
    List<Override>? overrides,
    ThemeData? theme,
    ThemeData? darkTheme,
  }) {
    final container = createContainer(overrides: overrides);

    return UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: theme,
        darkTheme: darkTheme,
        home: Scaffold(body: child),
      ),
    );
  }

  /// Create a MaterialApp with ProviderScope for widget tests and return both widget and container.
  ///
  /// This is useful for widget tests that need to dispose the container explicitly.
  ///
  /// Example:
  /// ```dart
  /// testWidgets('MyWidget test', (tester) async {
  ///   final result = TestHelpers.createTestAppWithContainer(
  ///     child: MyWidget(),
  ///   );
  ///   await tester.pumpWidget(result.widget);
  ///   // ... test code ...
  ///   result.container.dispose();
  /// });
  /// ```
  static ({Widget widget, ProviderContainer container})
  createTestAppWithContainer({
    required Widget child,
    List<Override>? overrides,
    ThemeData? theme,
    ThemeData? darkTheme,
  }) {
    final container = createContainer(overrides: overrides);

    final widget = UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: theme,
        darkTheme: darkTheme,
        home: Scaffold(body: child),
      ),
    );

    return (widget: widget, container: container);
  }

  /// Create a test AppConfig with custom values.
  ///
  /// Useful for testing with specific configuration.
  static AppConfig createTestConfig({
    String? apiBaseUrl,
    String? appName,
    AppFlavor? flavor,
  }) {
    return AppConfig(
      apiBaseUrl: apiBaseUrl ?? 'https://test-api.example.com',
      appName: appName ?? 'Test App',
      flavor: flavor ?? AppFlavor.dev,
      enableLogging: false,
      enableCrashReporting: false,
    );
  }
}
