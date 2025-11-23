import 'package:app_mobile_afms/features/home/presentation/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  group('HomeHeader', () {
    testWidgets('should display logo and icons', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(child: const HomeHeader()),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - HomeHeader widget should be rendered
      expect(find.byType(HomeHeader), findsOneWidget);
      // Check that Row is present (main structure)
      expect(find.byType(Row), findsWidgets);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should call onRefresh when refresh icon is tapped', (
      tester,
    ) async {
      // Arrange
      var refreshCalled = false;

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: HomeHeader(onRefresh: () => refreshCalled = true),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Find refresh icon - try to find by icon or by InkWell
      final refreshIcon = find.byIcon(Icons.refresh);
      if (refreshIcon.evaluate().isNotEmpty) {
        await tester.tap(refreshIcon);
      } else {
        // If icon not found, try to find InkWell and tap it
        final inkWells = find.byType(InkWell);
        if (inkWells.evaluate().isNotEmpty) {
          await tester.tap(inkWells.first);
        }
      }
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(refreshCalled, isTrue);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets(
      'should call onNotificationTap when notification icon is tapped',
      (tester) async {
        // Arrange
        var notificationCalled = false;

        // Act
        await tester.pumpWidget(
          TestHelpers.createTestApp(
            child: HomeHeader(
              onNotificationTap: () => notificationCalled = true,
            ),
          ),
        );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Find notification icon - try to find by icon or by InkWell
        final notificationIcon = find.byIcon(Icons.notifications_outlined);
        if (notificationIcon.evaluate().isNotEmpty) {
          await tester.tap(notificationIcon);
        } else {
          // If icon not found, try to find the second InkWell (notification
          //is second)
          final inkWells = find.byType(InkWell);
          if (inkWells.evaluate().length >= 2) {
            await tester.tap(inkWells.at(1));
          }
        }
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Assert
        expect(notificationCalled, isTrue);

        // Cleanup to prevent timersPending error
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      },
    );

    testWidgets('should display notification badge when count > 0', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const HomeHeader(notificationCount: 5),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.text('5'), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display 9+ when notification count > 9', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const HomeHeader(notificationCount: 15),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.text('9+'), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should not display badge when count is 0', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const HomeHeader(notificationCount: 0),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - Badge should not be visible
      expect(find.text('0'), findsNothing);
      expect(find.text('9+'), findsNothing);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should not display badge when count is null', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(child: const HomeHeader()),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - Badge should not be visible (no badge text should be found)
      expect(find.text('0'), findsNothing);
      expect(find.text('9+'), findsNothing);
      expect(find.text('1'), findsNothing);
      expect(find.text('5'), findsNothing);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}
