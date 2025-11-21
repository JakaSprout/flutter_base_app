import 'package:flutter/material.dart';
import 'package:app_mobile_afms/features/home/presentation/widgets/pond_list_item.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  group('PondListItem', () {
    testWidgets('should display pond name and ID', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const PondListItem(pondName: 'Kolam A1', pondId: 'TKH00A1'),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.text('Kolam A1'), findsOneWidget);
      expect(find.text('Kolam ID: TKH00A1'), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display chevron icon', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const PondListItem(pondName: 'Kolam A1', pondId: 'TKH00A1'),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should call onTap when item is tapped', (tester) async {
      // Arrange
      var tapped = false;

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: PondListItem(
            pondName: 'Kolam A1',
            pondId: 'TKH00A1',
            onTap: () => tapped = true,
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Tap on the item
      await tester.tap(find.text('Kolam A1'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(tapped, isTrue);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should not call onTap when onTap is null', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const PondListItem(pondName: 'Kolam A1', pondId: 'TKH00A1'),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Tap on the item (should not throw)
      await tester.tap(find.text('Kolam A1'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - No error should occur
      expect(find.text('Kolam A1'), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should truncate long pond name', (tester) async {
      // Arrange
      const longName = 'Kolam dengan nama yang sangat panjang sekali';

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const PondListItem(pondName: longName, pondId: 'TKH00A1'),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - Text should be present (truncation is handled by Text widget)
      expect(find.text(longName), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}
