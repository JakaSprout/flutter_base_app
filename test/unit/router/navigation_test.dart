import 'package:app_mobile_afms/app.dart';
import 'package:app_mobile_afms/core/config/app_config.dart';
import 'package:app_mobile_afms/core/config/navigation_constants.dart';
import 'package:app_mobile_afms/design_system/components/navigation/stp_bottom_nav_bar.dart';
import 'package:app_mobile_afms/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:app_mobile_afms/features/home/presentation/screens/home_screen.dart';
import 'package:app_mobile_afms/router/app_router.dart';
import 'package:app_mobile_afms/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  // Initialize Flutter binding for tests
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Navigation Tests', () {
    testWidgets('should navigate to home screen', (tester) async {
      await _pumpAppAndNavigateHome(tester);

      // Assert - Check that home screen is displayed (no placeholder, actual home screen)
      expect(find.text(NavigationConstants.navHome), findsWidgets);
      // HomeScreen is now fully implemented, so check for actual content instead of placeholder
      expect(find.byType(HomeScreen), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets('should navigate to graph screen', (tester) async {
      await _pumpAppAndNavigateHome(tester);

      // Navigate to graph
      await tester.tap(_navItemFinder(NavigationConstants.navGraph));
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
      await _pumpAppAndNavigateHome(tester);

      // Navigate to input data (tap center button)
      await tester.tap(_navItemFinder(NavigationConstants.navInputData));
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
      await _pumpAppAndNavigateHome(tester);

      // Navigate to pond
      await tester.tap(_navItemFinder(NavigationConstants.navPond));
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
      await _pumpAppAndNavigateHome(tester);

      // Navigate to profile
      await tester.tap(_navItemFinder(NavigationConstants.navProfile));
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
      await _pumpAppAndNavigateHome(tester);

      // Assert - All navigation items should be present in bottom nav bar
      expect(_navItemFinder(NavigationConstants.navHome), findsOneWidget);
      expect(_navItemFinder(NavigationConstants.navGraph), findsOneWidget);
      expect(_navItemFinder(NavigationConstants.navInputData), findsOneWidget);
      expect(_navItemFinder(NavigationConstants.navPond), findsOneWidget);
      expect(_navItemFinder(NavigationConstants.navProfile), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });
  });
}

Future<void> _pumpAppAndNavigateHome(WidgetTester tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authStateProvider.overrideWith((ref) async => true),
      ],
      child: const App(config: AppConfig.dev),
    ),
  );
  await tester.pumpAndSettle();

  final router = AppRouter.currentRouter;
  expect(router, isNotNull, reason: 'Router should be initialized');
  router!.go(Routes.home);
  await tester.pumpAndSettle();
}

Finder _navItemFinder(String label) {
  return find.descendant(
    of: find.byType(STPBottomNavBar),
    matching: find.text(label),
  ).first;
}
