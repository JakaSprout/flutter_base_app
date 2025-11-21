import 'package:flutter/material.dart';
import 'package:app_mobile_afms/features/home/presentation/constants/home_constants.dart';
import 'package:app_mobile_afms/features/home/presentation/widgets/dashboard_summary_grid.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  group('DashboardSummaryGrid', () {
    testWidgets('should display dashboard cards', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const SingleChildScrollView(
            child: DashboardSummaryGrid(),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - Check for card titles
      expect(
        find.text(HomeConstants.cardEstimasiBiomassaTitle),
        findsOneWidget,
      );
      expect(find.text(HomeConstants.cardTotalPakanTitle), findsOneWidget);
      expect(find.text(HomeConstants.cardBiayaPakanTitle), findsOneWidget);
      expect(find.text(HomeConstants.cardEstimasiSRTitle), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display custom values', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const SingleChildScrollView(
            child: DashboardSummaryGrid(
              estimasiBiomassa: '1000',
              totalPakan: '500',
              biayaPakan: '10',
              estimasiSR: '80',
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - Values should be displayed
      expect(find.text('1000'), findsOneWidget);
      expect(find.text('500'), findsOneWidget);
      expect(find.text('10'), findsOneWidget);
      expect(find.text('80'), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display default values when not provided', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const SingleChildScrollView(
            child: DashboardSummaryGrid(),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - Default values should be displayed
      expect(
        find.text(HomeConstants.defaultEstimasiBiomassa),
        findsOneWidget,
      );
      expect(find.text(HomeConstants.defaultTotalPakan), findsOneWidget);
      expect(find.text(HomeConstants.defaultBiayaPakan), findsOneWidget);
      expect(find.text(HomeConstants.defaultEstimasiSR), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display toggle button when there are more cards', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const SingleChildScrollView(
            child: DashboardSummaryGrid(),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - Toggle button should be present if there are more than 4 cards
      // The grid has 7 cards by default, so toggle should be visible
      expect(find.text('Tampilkan Semua'), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should call onShowAllTap when toggle button is tapped', (
      tester,
    ) async {
      // Arrange
      var showAllCalled = false;

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: SingleChildScrollView(
            child: DashboardSummaryGrid(
              onShowAllTap: () => showAllCalled = true,
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Tap toggle button
      await tester.tap(find.text('Tampilkan Semua'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300)); // Wait for animation

      // Assert
      expect(showAllCalled, isTrue);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should expand and collapse when toggle is tapped', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const SingleChildScrollView(
            child: DashboardSummaryGrid(),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Initially should show "Tampilkan Semua"
      expect(find.text('Tampilkan Semua'), findsOneWidget);

      // Tap to expand
      await tester.tap(find.text('Tampilkan Semua'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300)); // Wait for animation

      // Should now show "Sembunyikan"
      expect(find.text('Sembunyikan'), findsOneWidget);

      // Tap to collapse
      await tester.tap(find.text('Sembunyikan'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300)); // Wait for animation

      // Should show "Tampilkan Semua" again
      expect(find.text('Tampilkan Semua'), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display custom active ponds count', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const SingleChildScrollView(
            child: DashboardSummaryGrid(
              activePonds: 10,
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - Custom active ponds subtitle should be displayed
      expect(
        find.text(HomeConstants.activePondsSubtitle(10)),
        findsWidgets,
      );

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}

