import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/auth_constants.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_separator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  group('LoginSeparator', () {
    testWidgets('should display separator with "Or" text', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const LoginSeparator(),
        ),
      );

      // Assert
      expect(find.text(AuthConstants.separatorOr), findsOneWidget);
      expect(find.byType(Divider), findsNWidgets(2));

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should have two dividers', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const LoginSeparator(),
        ),
      );

      // Assert
      expect(find.byType(Divider), findsNWidgets(2));

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display "Or" text between dividers', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const LoginSeparator(),
        ),
      );

      // Assert
      final separators = find.byType(LoginSeparator);
      expect(separators, findsOneWidget);
      expect(find.text(AuthConstants.separatorOr), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}

