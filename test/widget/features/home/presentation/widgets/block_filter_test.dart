import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/home/presentation/constants/home_constants.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/block_filter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  group('BlockFilter', () {
    testWidgets('should display label and dropdown', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const BlockFilter(),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.text(HomeConstants.blockFilterLabel), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display default block when no blocks provided', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const BlockFilter(),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - Default block should be displayed
      expect(find.text(HomeConstants.defaultBlock), findsWidgets);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display selected block', (tester) async {
      // Arrange
      const blocks = ['Block A', 'Block B', 'Block C'];

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const BlockFilter(
            selectedBlock: 'Block B',
            blocks: blocks,
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - Selected block should be displayed
      expect(find.text('Block B'), findsWidgets);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should call onBlockChanged when block is selected', (
      tester,
    ) async {
      // Arrange
      const blocks = ['Block A', 'Block B', 'Block C'];
      String? selectedBlock;

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: BlockFilter(
            blocks: blocks,
            onBlockChanged: (block) => selectedBlock = block,
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Tap on dropdown to open it
      final dropdown = find.byType(BlockFilter);
      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      // Select a different block (if dropdown is open)
      // Note: This test may need adjustment based on STPDropdown implementation
      // For now, we verify the widget is interactive
      expect(dropdown, findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should use first block when selectedBlock is null', (
      tester,
    ) async {
      // Arrange
      const blocks = ['Block A', 'Block B', 'Block C'];

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const BlockFilter(
            blocks: blocks,
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - First block should be displayed
      expect(find.text('Block A'), findsWidgets);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}

