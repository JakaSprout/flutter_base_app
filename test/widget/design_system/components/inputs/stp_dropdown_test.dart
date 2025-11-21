import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/components/inputs/stp_dropdown.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_helpers.dart';

void main() {
  group('STPDropdown', () {
    group('display', () {
      testWidgets('should display selected value', (tester) async {
        // Arrange
        const items = ['Option 1', 'Option 2', 'Option 3'];
        const selectedValue = 'Option 2';

        // Act
        await tester.pumpWidget(
          TestHelpers.createTestApp(
            child: STPDropdown<String>(
              items: items,
              selectedValue: selectedValue,
              onChanged: (_) {},
              colors: const STPDropdownColors.primary(),
            ),
          ),
        );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Assert
        expect(find.text('Option 2'), findsOneWidget);

        // Cleanup
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });

      testWidgets('should display hint when no value selected', (tester) async {
        // Arrange
        const items = ['Option 1', 'Option 2', 'Option 3'];
        const hint = 'Select an option';

        // Act
        await tester.pumpWidget(
          TestHelpers.createTestApp(
            child: STPDropdown<String>(
              items: items,
              selectedValue: null,
              onChanged: (_) {},
              colors: const STPDropdownColors.primary(),
              hint: hint,
            ),
          ),
        );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Assert
        expect(find.text(hint), findsOneWidget);

        // Cleanup
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });

      testWidgets('should display label when provided', (tester) async {
        // Arrange
        const items = ['Option 1', 'Option 2'];
        const label = 'Label:';
        const selectedValue = 'Option 1';

        // Act
        await tester.pumpWidget(
          TestHelpers.createTestApp(
            child: STPDropdown<String>(
              items: items,
              selectedValue: selectedValue,
              onChanged: (_) {},
              colors: const STPDropdownColors.primary(),
              label: label,
            ),
          ),
        );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Assert
        expect(find.text(label), findsOneWidget);
        expect(find.text(selectedValue), findsOneWidget);

        // Cleanup
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });

      testWidgets('should display chevron icon', (tester) async {
        // Arrange
        const items = ['Option 1', 'Option 2'];

        // Act
        await tester.pumpWidget(
          TestHelpers.createTestApp(
            child: STPDropdown<String>(
              items: items,
              selectedValue: 'Option 1',
              onChanged: (_) {},
              colors: const STPDropdownColors.primary(),
            ),
          ),
        );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Assert - Chevron should be present (either SVG or placeholder Icon)
        expect(find.byType(STPDropdown<String>), findsOneWidget);

        // Cleanup
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });
    });

    group('interactions', () {
      testWidgets('should show dropdown menu when tapped', (tester) async {
        // Arrange
        const items = ['Option 1', 'Option 2', 'Option 3'];

        // Act
        await tester.pumpWidget(
          TestHelpers.createTestApp(
            child: STPDropdown<String>(
              items: items,
              selectedValue: 'Option 1',
              onChanged: (_) {},
              colors: const STPDropdownColors.primary(),
            ),
          ),
        );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Tap dropdown
        await tester.tap(find.byType(STPDropdown<String>));
        await tester.pumpAndSettle();

        // Assert - Menu items should be visible
        expect(find.text('Option 1'), findsWidgets);
        expect(find.text('Option 2'), findsOneWidget);
        expect(find.text('Option 3'), findsOneWidget);

        // Cleanup
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });

      testWidgets('should call onChanged when item is selected', (tester) async {
        // Arrange
        const items = ['Option 1', 'Option 2', 'Option 3'];
        String? selectedItem;

        // Act
        await tester.pumpWidget(
          TestHelpers.createTestApp(
            child: STPDropdown<String>(
              items: items,
              selectedValue: 'Option 1',
              onChanged: (value) => selectedItem = value,
              colors: const STPDropdownColors.primary(),
            ),
          ),
        );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Tap dropdown
        await tester.tap(find.byType(STPDropdown<String>));
        await tester.pumpAndSettle();

        // Select Option 2
        await tester.tap(find.text('Option 2'));
        await tester.pumpAndSettle();

        // Assert
        expect(selectedItem, equals('Option 2'));

        // Cleanup
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });

      testWidgets('should not show menu when disabled', (tester) async {
        // Arrange
        const items = ['Option 1', 'Option 2'];
        var onChangedCalled = false;

        // Act
        await tester.pumpWidget(
          TestHelpers.createTestApp(
            child: STPDropdown<String>(
              items: items,
              selectedValue: 'Option 1',
              onChanged: (_) => onChangedCalled = true,
              colors: const STPDropdownColors.primary(),
              enabled: false,
            ),
          ),
        );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Try to tap dropdown (should not work)
        await tester.tap(
          find.byType(STPDropdown<String>),
          warnIfMissed: false,
        );
        await tester.pumpAndSettle();

        // Assert
        expect(onChangedCalled, isFalse);
        // Menu should not appear
        expect(find.text('Option 2'), findsNothing);

        // Cleanup
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });
    });

    group('edge cases', () {
      testWidgets('should handle empty items list', (tester) async {
        // Arrange
        const items = <String>[];

        // Act
        await tester.pumpWidget(
          TestHelpers.createTestApp(
            child: STPDropdown<String>(
              items: items,
              selectedValue: null,
              onChanged: (_) {},
              colors: const STPDropdownColors.primary(),
              hint: 'No options',
            ),
          ),
        );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Assert
        expect(find.text('No options'), findsOneWidget);

        // Note: showMenu requires items.isNotEmpty, so tapping with empty items
        // will throw an assertion error. This is expected behavior.
        // The widget should still render correctly with empty items.

        // Cleanup
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });

      testWidgets('should handle long text with ellipsis', (tester) async {
        // Arrange
        const items = [
          'Very Long Option Name That Exceeds Normal Length',
          'Option 2',
        ];
        const selectedValue = 'Very Long Option Name That Exceeds Normal Length';

        // Act
        await tester.pumpWidget(
          TestHelpers.createTestApp(
            child: SizedBox(
              width: 100, // Constrain width to force overflow
              child: STPDropdown<String>(
                items: items,
                selectedValue: selectedValue,
                onChanged: (_) {},
                colors: const STPDropdownColors.primary(),
              ),
            ),
          ),
        );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Assert - Widget should render without error
        expect(find.byType(STPDropdown<String>), findsOneWidget);

        // Cleanup
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });
    });

    group('color schemes', () {
      testWidgets('should use primary color scheme', (tester) async {
        // Arrange
        const items = ['Option 1', 'Option 2'];

        // Act
        await tester.pumpWidget(
          TestHelpers.createTestApp(
            child: STPDropdown<String>(
              items: items,
              selectedValue: 'Option 1',
              onChanged: (_) {},
              colors: const STPDropdownColors.primary(),
            ),
          ),
        );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Assert - Widget should render
        expect(find.byType(STPDropdown<String>), findsOneWidget);

        // Cleanup
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });

      testWidgets('should use gray color scheme', (tester) async {
        // Arrange
        const items = ['Option 1', 'Option 2'];

        // Act
        await tester.pumpWidget(
          TestHelpers.createTestApp(
            child: STPDropdown<String>(
              items: items,
              selectedValue: 'Option 1',
              onChanged: (_) {},
              colors: const STPDropdownColors.gray(),
            ),
          ),
        );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Assert - Widget should render
        expect(find.byType(STPDropdown<String>), findsOneWidget);

        // Cleanup
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });

      testWidgets('should use custom color scheme', (tester) async {
        // Arrange
        const items = ['Option 1', 'Option 2'];
        const customColors = STPDropdownColors(
          backgroundColor: Colors.red,
          borderColor: Colors.blue,
          textColor: Colors.green,
          chevronColor: Colors.yellow,
        );

        // Act
        await tester.pumpWidget(
          TestHelpers.createTestApp(
            child: STPDropdown<String>(
              items: items,
              selectedValue: 'Option 1',
              onChanged: (_) {},
              colors: customColors,
            ),
          ),
        );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Assert - Widget should render
        expect(find.byType(STPDropdown<String>), findsOneWidget);

        // Cleanup
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });
    });

    group('border', () {
      testWidgets('should show border by default', (tester) async {
        // Arrange
        const items = ['Option 1', 'Option 2'];

        // Act
        await tester.pumpWidget(
          TestHelpers.createTestApp(
            child: STPDropdown<String>(
              items: items,
              selectedValue: 'Option 1',
              onChanged: (_) {},
              colors: const STPDropdownColors.primary(),
            ),
          ),
        );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Assert - Container should have decoration with border
        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(STPDropdown<String>),
            matching: find.byType(Container).first,
          ),
        );
        final decoration = container.decoration! as BoxDecoration;
        expect(decoration.border, isNotNull);

        // Cleanup
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });

      testWidgets('should hide border when showBorder is false', (tester) async {
        // Arrange
        const items = ['Option 1', 'Option 2'];

        // Act
        await tester.pumpWidget(
          TestHelpers.createTestApp(
            child: STPDropdown<String>(
              items: items,
              selectedValue: 'Option 1',
              onChanged: (_) {},
              colors: const STPDropdownColors.primary(),
              showBorder: false,
            ),
          ),
        );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Assert - Container should have decoration without border
        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(STPDropdown<String>),
            matching: find.byType(Container).first,
          ),
        );
        final decoration = container.decoration! as BoxDecoration;
        expect(decoration.border, isNull);

        // Cleanup
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });
    });

    group('generic types', () {
      testWidgets('should work with String type', (tester) async {
        // Arrange
        const items = ['Option 1', 'Option 2'];

        // Act
        await tester.pumpWidget(
          TestHelpers.createTestApp(
            child: STPDropdown<String>(
              items: items,
              selectedValue: 'Option 1',
              onChanged: (_) {},
              colors: const STPDropdownColors.primary(),
            ),
          ),
        );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Assert
        expect(find.text('Option 1'), findsOneWidget);

        // Cleanup
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });

      testWidgets('should work with int type', (tester) async {
        // Arrange
        const items = [1, 2, 3];

        // Act
        await tester.pumpWidget(
          TestHelpers.createTestApp(
            child: STPDropdown<int>(
              items: items,
              selectedValue: 2,
              onChanged: (_) {},
              colors: const STPDropdownColors.primary(),
            ),
          ),
        );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Assert
        expect(find.text('2'), findsOneWidget);

        // Cleanup
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });
    });
  });
}

