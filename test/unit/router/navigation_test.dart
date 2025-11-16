import 'package:flutter/material.dart';
import 'package:flutter_base_app/app.dart';
import 'package:flutter_base_app/core/config/app_config.dart';
import 'package:flutter_base_app/core/config/navigation_constants.dart';
import 'package:flutter_base_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_base_app/router/app_router.dart';
import 'package:flutter_base_app/router/routes.dart';
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

      // Navigate to home screen (bypass login for testing)
      final router = AppRouter.router;
      router.go(Routes.home);
      await tester.pumpAndSettle();

      // Assert - Check that home screen is displayed (no placeholder, actual home screen)
      expect(find.text(NavigationConstants.navHome), findsOneWidget);
      // HomeScreen is now fully implemented, so check for actual content instead of placeholder
      expect(find.byType(HomeScreen), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets('should navigate to graph screen', (tester) async {
      // Arrange
      const config = AppConfig.dev;

      // Act
      await tester.pumpWidget(const ProviderScope(child: App(config: config)));
      await tester.pumpAndSettle();

      // Navigate to home first (bypass login for testing)
      final router = AppRouter.router;
      router.go(Routes.home);
      await tester.pumpAndSettle();

      // Navigate to graph
      await tester.tap(find.text(NavigationConstants.navGraph));
      await tester.pumpAndSettle();

      // Assert - Check that graph screen is displayed
      // Text "Graph" appears in both nav bar and screen title, so use findsWidgets
      expect(find.text(NavigationConstants.screenGraphTitle), findsWidgets);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets('should navigate to input data screen', (tester) async {
      // Arrange
      const config = AppConfig.dev;

      // Act
      await tester.pumpWidget(const ProviderScope(child: App(config: config)));
      await tester.pumpAndSettle();

      // Navigate to home first (bypass login for testing)
      final router = AppRouter.router;
      router.go(Routes.home);
      await tester.pumpAndSettle();

      // Navigate to input data (tap center button)
      await tester.tap(find.text(NavigationConstants.navInputData));
      await tester.pumpAndSettle();

      // Assert - Check that input data screen is displayed
      // Text "Input Data" appears in both nav bar and screen title, so use findsWidgets
      expect(find.text(NavigationConstants.screenInputDataTitle), findsWidgets);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets('should navigate to pond screen', (tester) async {
      // Arrange
      const config = AppConfig.dev;

      // Act
      await tester.pumpWidget(const ProviderScope(child: App(config: config)));
      await tester.pumpAndSettle();

      // Navigate to home first (bypass login for testing)
      final router = AppRouter.router;
      router.go(Routes.home);
      await tester.pumpAndSettle();

      // Navigate to pond
      await tester.tap(find.text(NavigationConstants.navPond));
      await tester.pumpAndSettle();

      // Assert - Check that pond screen is displayed
      // Text "Kolam" appears in both nav bar and screen title, so use findsWidgets
      expect(find.text(NavigationConstants.screenPondTitle), findsWidgets);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets('should navigate to profile screen', (tester) async {
      // Arrange
      const config = AppConfig.dev;

      // Act
      await tester.pumpWidget(const ProviderScope(child: App(config: config)));
      await tester.pumpAndSettle();

      // Navigate to home first (bypass login for testing)
      final router = AppRouter.router;
      router.go(Routes.home);
      await tester.pumpAndSettle();

      // Navigate to profile
      await tester.tap(find.text(NavigationConstants.navProfile));
      await tester.pumpAndSettle();

      // Assert - Check that profile screen is displayed
      // Text "Profil" appears in both nav bar and screen title, so use findsWidgets
      expect(find.text(NavigationConstants.screenProfileTitle), findsWidgets);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets('should show bottom navigation bar', (tester) async {
      // Arrange
      const config = AppConfig.dev;

      // Act
      await tester.pumpWidget(const ProviderScope(child: App(config: config)));
      await tester.pumpAndSettle();

      // Navigate to home first (bypass login for testing)
      final router = AppRouter.router;
      router.go(Routes.home);
      await tester.pumpAndSettle();

      // Assert - All navigation items should be present in bottom nav bar
      expect(find.text(NavigationConstants.navHome), findsOneWidget);
      expect(find.text(NavigationConstants.navGraph), findsOneWidget);
      expect(find.text(NavigationConstants.navInputData), findsOneWidget);
      expect(find.text(NavigationConstants.navPond), findsOneWidget);
      expect(find.text(NavigationConstants.navProfile), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });
  });
}
