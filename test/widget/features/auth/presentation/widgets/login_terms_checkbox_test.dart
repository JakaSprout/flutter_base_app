import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/auth_constants.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_terms_checkbox.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  group('LoginTermsCheckbox', () {
    testWidgets('should display checkbox and terms text', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: LoginTermsCheckbox(
            isTermsAccepted: false,
            isLoading: false,
            onChanged: (_) {},
          ),
        ),
      );

      // Assert
      expect(find.byType(Checkbox), findsOneWidget);
      expect(
        find.textContaining(AuthConstants.termsAgreementPrefix),
        findsOneWidget,
      );
      expect(
        find.textContaining(AuthConstants.termsAndConditions),
        findsOneWidget,
      );
      expect(find.textContaining(AuthConstants.privacyPolicy), findsOneWidget);
    });

    testWidgets('should show checked checkbox when terms accepted', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: LoginTermsCheckbox(
            isTermsAccepted: true,
            isLoading: false,
            onChanged: (_) {},
          ),
        ),
      );

      // Assert
      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.value, isTrue);
    });

    testWidgets('should show unchecked checkbox when terms not accepted', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: LoginTermsCheckbox(
            isTermsAccepted: false,
            isLoading: false,
            onChanged: (_) {},
          ),
        ),
      );

      // Assert
      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.value, isFalse);
    });

    testWidgets('should call onChanged when checkbox is tapped', (
      tester,
    ) async {
      // Arrange
      bool? changedValue;

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: LoginTermsCheckbox(
            isTermsAccepted: false,
            isLoading: false,
            onChanged: (value) => changedValue = value,
          ),
        ),
      );

      // Tap checkbox
      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      // Assert
      expect(changedValue, isTrue);
    });

    testWidgets('should not call onChanged when loading', (tester) async {
      // Arrange
      bool? changedValue;

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: LoginTermsCheckbox(
            isTermsAccepted: false,
            isLoading: true,
            onChanged: (value) => changedValue = value,
          ),
        ),
      );

      // Try to tap checkbox (should not work)
      await tester.tap(find.byType(Checkbox), warnIfMissed: false);
      await tester.pump();

      // Assert
      expect(changedValue, isNull);
    });

    testWidgets('should be disabled when loading', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: LoginTermsCheckbox(
            isTermsAccepted: false,
            isLoading: true,
            onChanged: (_) {},
          ),
        ),
      );

      // Assert
      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.onChanged, isNull);
    });
  });
}
