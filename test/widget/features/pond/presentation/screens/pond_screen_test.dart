import 'package:app_mobile_afms/core/config/navigation_constants.dart';
import 'package:app_mobile_afms/features/pond/presentation/screens/pond_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  group('PondScreen', () {
    testWidgets('should display screen title', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const PondScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(
        find.text(NavigationConstants.screenPondTitle),
        findsOneWidget,
      );

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display placeholder message', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const PondScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(
        find.text(NavigationConstants.placeholderPond),
        findsOneWidget,
      );

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display icon', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const PondScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byIcon(Icons.grid_view), findsOneWidget);

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should have correct structure', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const PondScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      // TestHelpers.createTestApp wraps with Scaffold, so PondScreen's Scaffold is nested
      expect(find.byType(Scaffold), findsWidgets); // At least 2 Scaffolds (wrapper + screen)
      expect(find.byType(Center), findsWidgets); // At least 1 Center (from PondScreen)
      expect(find.byType(Column), findsOneWidget); // Column from PondScreen

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}

