import 'package:flutter_base_app/app.dart';
import 'package:flutter_base_app/core/config/app_config.dart';
import 'package:flutter_base_app/core/config/navigation_constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  // Initialize Flutter binding for tests
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Navigation Tests', () {
    testWidgets('should navigate to home screen', (tester) async {
      // Arrange
      const config = AppConfig.dev;

      // Act
      await tester.pumpWidget(const ProviderScope(child: App(config: config)));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text(NavigationConstants.navHome), findsOneWidget);
      expect(find.text(NavigationConstants.placeholderHome), findsOneWidget);
    });

    testWidgets('should navigate to graph screen', (tester) async {
      // Arrange
      const config = AppConfig.dev;

      // Act
      await tester.pumpWidget(const ProviderScope(child: App(config: config)));
      await tester.pumpAndSettle();

      // Navigate to graph
      await tester.tap(find.text(NavigationConstants.navGraph));
      await tester.pumpAndSettle();

      // Assert
      expect(
        find.text(NavigationConstants.screenGraphTitle),
        findsOneWidget,
      );
      expect(
        find.text(NavigationConstants.placeholderGraph),
        findsOneWidget,
      );
    });

    testWidgets('should navigate to input data screen', (tester) async {
      // Arrange
      const config = AppConfig.dev;

      // Act
      await tester.pumpWidget(const ProviderScope(child: App(config: config)));
      await tester.pumpAndSettle();

      // Navigate to input data (tap center button)
      await tester.tap(find.text(NavigationConstants.navInputData));
      await tester.pumpAndSettle();

      // Assert
      expect(
        find.text(NavigationConstants.screenInputDataTitle),
        findsOneWidget,
      );
      expect(
        find.text(NavigationConstants.placeholderInputData),
        findsOneWidget,
      );
    });

    testWidgets('should navigate to pond screen', (tester) async {
      // Arrange
      const config = AppConfig.dev;

      // Act
      await tester.pumpWidget(const ProviderScope(child: App(config: config)));
      await tester.pumpAndSettle();

      // Navigate to pond
      await tester.tap(find.text(NavigationConstants.navPond));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text(NavigationConstants.screenPondTitle), findsOneWidget);
      expect(find.text(NavigationConstants.placeholderPond), findsOneWidget);
    });

    testWidgets('should navigate to profile screen', (tester) async {
      // Arrange
      const config = AppConfig.dev;

      // Act
      await tester.pumpWidget(const ProviderScope(child: App(config: config)));
      await tester.pumpAndSettle();

      // Navigate to profile
      await tester.tap(find.text(NavigationConstants.navProfile));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text(NavigationConstants.screenProfileTitle), findsOneWidget);
      expect(find.text(NavigationConstants.placeholderProfile), findsOneWidget);
    });

    testWidgets('should show bottom navigation bar', (tester) async {
      // Arrange
      const config = AppConfig.dev;

      // Act
      await tester.pumpWidget(const ProviderScope(child: App(config: config)));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text(NavigationConstants.navHome), findsOneWidget);
      expect(find.text(NavigationConstants.navGraph), findsOneWidget);
      expect(find.text(NavigationConstants.navInputData), findsOneWidget);
      expect(find.text(NavigationConstants.navPond), findsOneWidget);
      expect(find.text(NavigationConstants.navProfile), findsOneWidget);
    });
  });
}
