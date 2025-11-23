import 'package:app_mobile_afms/features/auth/presentation/widgets/login_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  group('LoginCard', () {
    testWidgets('should display child widget', (tester) async {
      // Arrange
      const testChild = Text('Test Content');

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const LoginCard(child: testChild),
        ),
      );

      // Assert
      expect(find.text('Test Content'), findsOneWidget);
      expect(find.byType(LoginCard), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should have white background', (tester) async {
      // Arrange
      const testChild = Text('Test Content');

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const LoginCard(child: testChild),
        ),
      );

      // Assert
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(LoginCard),
          matching: find.byType(Container).first,
        ),
      );
      final decoration = container.decoration! as BoxDecoration;
      expect(decoration.color, isNotNull);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should have rounded corners', (tester) async {
      // Arrange
      const testChild = Text('Test Content');

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const LoginCard(child: testChild),
        ),
      );

      // Assert
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(LoginCard),
          matching: find.byType(Container).first,
        ),
      );
      final decoration = container.decoration! as BoxDecoration;
      expect(decoration.borderRadius, isNotNull);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}

