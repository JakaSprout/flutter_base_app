import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/home/presentation/constants/home_constants.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/pond_list_section.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  group('PondListSection', () {
    testWidgets('should display title and count', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const SingleChildScrollView(child: PondListSection()),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.text(HomeConstants.pondListSectionTitle), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display default ponds count', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const SingleChildScrollView(child: PondListSection()),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - Default ponds should be displayed
      final defaultPonds = HomeConstants.defaultPonds;
      expect(find.text('(${defaultPonds.length})'), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display custom ponds count', (tester) async {
      // Arrange
      final customPonds = [
        const PondData(name: 'Kolam A1', id: 'TKH00A1'),
        const PondData(name: 'Kolam A2', id: 'TKH00A2'),
        const PondData(name: 'Kolam A3', id: 'TKH00A3'),
      ];

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: SingleChildScrollView(
            child: PondListSection(ponds: customPonds),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.text('(3)'), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display "Lihat Semua" link', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const SingleChildScrollView(child: PondListSection()),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.text(HomeConstants.pondListSeeAllLabel), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should call onSeeAllTap when "Lihat Semua" is tapped', (
      tester,
    ) async {
      // Arrange
      var seeAllCalled = false;

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: SingleChildScrollView(
            child: PondListSection(onSeeAllTap: () => seeAllCalled = true),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Tap "Lihat Semua"
      await tester.tap(find.text(HomeConstants.pondListSeeAllLabel));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(seeAllCalled, isTrue);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should call onPondTap when pond item is tapped', (
      tester,
    ) async {
      // Arrange
      final customPonds = [
        const PondData(name: 'Kolam A1', id: 'TKH00A1'),
        const PondData(name: 'Kolam A2', id: 'TKH00A2'),
      ];
      String? tappedPondId;

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: SingleChildScrollView(
            child: PondListSection(
              ponds: customPonds,
              onPondTap: (id) => tappedPondId = id,
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Tap on first pond
      await tester.tap(find.text('Kolam A1'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(tappedPondId, equals('TKH00A1'));

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display pond items', (tester) async {
      // Arrange
      final customPonds = [
        const PondData(name: 'Kolam A1', id: 'TKH00A1'),
        const PondData(name: 'Kolam A2', id: 'TKH00A2'),
      ];

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: SingleChildScrollView(
            child: PondListSection(ponds: customPonds),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.text('Kolam A1'), findsOneWidget);
      expect(find.text('Kolam A2'), findsOneWidget);
      expect(find.text('Kolam ID: TKH00A1'), findsOneWidget);
      expect(find.text('Kolam ID: TKH00A2'), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}
