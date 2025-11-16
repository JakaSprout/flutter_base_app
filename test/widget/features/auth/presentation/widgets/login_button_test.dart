import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/auth_constants.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_button.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  group('LoginButton', () {
    testWidgets('should display login button text when not loading', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: LoginButton(
            isLoading: false,
            isTermsAccepted: true,
            isFormValid: true,
            onPressed: () {},
          ),
        ),
      );

      // Assert
      expect(find.text(AuthConstants.buttonLogin), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display loading indicator when loading', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: LoginButton(
            isLoading: true,
            isTermsAccepted: true,
            isFormValid: true,
            onPressed: () {},
          ),
        ),
      );

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text(AuthConstants.buttonLogin), findsNothing);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should be enabled when form is valid and terms accepted', (
      tester,
    ) async {
      // Arrange
      var buttonPressed = false;

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: LoginButton(
            isLoading: false,
            isTermsAccepted: true,
            isFormValid: true,
            onPressed: () => buttonPressed = true,
          ),
        ),
      );

      // Assert
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNotNull);

      // Tap button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Assert callback was called
      expect(buttonPressed, isTrue);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should be disabled when form is invalid', (tester) async {
      // Arrange
      var buttonPressed = false;

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: LoginButton(
            isLoading: false,
            isTermsAccepted: true,
            isFormValid: false,
            onPressed: () => buttonPressed = true,
          ),
        ),
      );

      // Assert
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);

      // Try to tap button (should not work)
      await tester.tap(find.byType(ElevatedButton), warnIfMissed: false);
      await tester.pump();

      // Assert callback was not called
      expect(buttonPressed, isFalse);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should be disabled when terms not accepted', (tester) async {
      // Arrange
      var buttonPressed = false;

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: LoginButton(
            isLoading: false,
            isTermsAccepted: false,
            isFormValid: true,
            onPressed: () => buttonPressed = true,
          ),
        ),
      );

      // Assert
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);

      // Try to tap button (should not work)
      await tester.tap(find.byType(ElevatedButton), warnIfMissed: false);
      await tester.pump();

      // Assert callback was not called
      expect(buttonPressed, isFalse);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should be disabled when loading', (tester) async {
      // Arrange
      var buttonPressed = false;

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: LoginButton(
            isLoading: true,
            isTermsAccepted: true,
            isFormValid: true,
            onPressed: () => buttonPressed = true,
          ),
        ),
      );

      // Assert
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);

      // Try to tap button (should not work)
      await tester.tap(find.byType(ElevatedButton), warnIfMissed: false);
      await tester.pump();

      // Assert callback was not called
      expect(buttonPressed, isFalse);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}
