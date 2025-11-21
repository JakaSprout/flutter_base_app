import 'package:flutter/material.dart';
import 'package:app_mobile_afms/features/auth/presentation/constants/auth_constants.dart';
import 'package:app_mobile_afms/features/auth/presentation/widgets/login_mode_switch.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  group('LoginModeSwitch', () {
    testWidgets('should display email icon and text when in phone mode', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: LoginModeSwitch(
            isPhoneMode: true,
            isLoading: false,
            onPressed: () {},
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.text(AuthConstants.buttonLoginWithEmail), findsOneWidget);
      expect(find.byIcon(Icons.email_outlined), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display phone icon and text when in email mode', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: LoginModeSwitch(
            isPhoneMode: false,
            isLoading: false,
            onPressed: () {},
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.text(AuthConstants.buttonLoginWithPhone), findsOneWidget);
      expect(find.byIcon(Icons.phone_outlined), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should call onPressed when tapped and not loading', (
      tester,
    ) async {
      // Arrange
      var buttonPressed = false;

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: LoginModeSwitch(
            isPhoneMode: true,
            isLoading: false,
            onPressed: () => buttonPressed = true,
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Tap button - use byWidgetPredicate to find TextButton
      final buttonFinder = find.byWidgetPredicate(
        (widget) => widget is TextButton,
      );
      await tester.tap(buttonFinder);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(buttonPressed, isTrue);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should not call onPressed when loading', (tester) async {
      // Arrange
      var buttonPressed = false;

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: LoginModeSwitch(
            isPhoneMode: true,
            isLoading: true,
            onPressed: () => buttonPressed = true,
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Try to tap button (should not work)
      final buttonFinder = find.byWidgetPredicate(
        (widget) => widget is TextButton,
      );
      await tester.tap(buttonFinder, warnIfMissed: false);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(buttonPressed, isFalse);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should be disabled when loading', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: LoginModeSwitch(
            isPhoneMode: true,
            isLoading: true,
            onPressed: () {},
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - TextButton.icon creates a TextButton widget
      final buttonFinder = find.byWidgetPredicate(
        (widget) => widget is TextButton,
      );
      expect(buttonFinder, findsOneWidget);
      final button = tester.widget<TextButton>(buttonFinder);
      expect(button.onPressed, isNull);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}
