import 'package:flutter/material.dart';
import 'package:app_mobile_afms/features/auth/presentation/constants/auth_constants.dart';
import 'package:app_mobile_afms/features/auth/presentation/constants/login_form_controls.dart';
import 'package:app_mobile_afms/features/auth/presentation/widgets/login_input_fields.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  group('LoginInputFields', () {
    late FormGroup form;

    setUp(() {
      form = FormGroup({
        LoginFormControls.phone: FormControl<String>(),
        LoginFormControls.email: FormControl<String>(),
        LoginFormControls.password: FormControl<String>(),
      });
    });

    tearDown(() {
      form.dispose();
    });

    testWidgets('should display phone input when in phone mode', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: ReactiveForm(
            formGroup: form,
            child: LoginInputFields(
              form: form,
              isPhoneMode: true,
              isPasswordVisible: false,
              isLoading: false,
              onPasswordVisibilityToggle: () {},
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.text(AuthConstants.hintPhoneNumber), findsOneWidget);
      expect(find.text(AuthConstants.hintEmail), findsNothing);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display email input when in email mode', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: ReactiveForm(
            formGroup: form,
            child: LoginInputFields(
              form: form,
              isPhoneMode: false,
              isPasswordVisible: false,
              isLoading: false,
              onPasswordVisibilityToggle: () {},
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.text(AuthConstants.hintEmail), findsOneWidget);
      expect(find.text(AuthConstants.hintPhoneNumber), findsNothing);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display password input', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: ReactiveForm(
            formGroup: form,
            child: LoginInputFields(
              form: form,
              isPhoneMode: false,
              isPasswordVisible: false,
              isLoading: false,
              onPasswordVisibilityToggle: () {},
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.text(AuthConstants.hintPassword), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should show password visibility toggle button', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: ReactiveForm(
            formGroup: form,
            child: LoginInputFields(
              form: form,
              isPhoneMode: false,
              isPasswordVisible: false,
              isLoading: false,
              onPasswordVisibilityToggle: () {},
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should show visibility icon when password is visible', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: ReactiveForm(
            formGroup: form,
            child: LoginInputFields(
              form: form,
              isPhoneMode: false,
              isPasswordVisible: true,
              isLoading: false,
              onPasswordVisibilityToggle: () {},
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off_outlined), findsNothing);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets(
      'should call onPasswordVisibilityToggle when visibility icon is tapped',
      (tester) async {
        // Arrange
        var toggleCalled = false;

        // Act
        await tester.pumpWidget(
          TestHelpers.createTestApp(
            child: ReactiveForm(
              formGroup: form,
              child: LoginInputFields(
                form: form,
                isPhoneMode: false,
                isPasswordVisible: false,
                isLoading: false,
                onPasswordVisibilityToggle: () => toggleCalled = true,
              ),
            ),
          ),
        );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Tap visibility icon
        await tester.tap(find.byIcon(Icons.visibility_off_outlined));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Assert
        expect(toggleCalled, isTrue);

        // Cleanup to prevent timersPending error
        await tester.runAsync(() async {
          await tester.pumpWidget(Container());
          await tester.pump(const Duration(milliseconds: 100));
        });
      },
    );

    testWidgets('should disable inputs when loading', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: ReactiveForm(
            formGroup: form,
            child: LoginInputFields(
              form: form,
              isPhoneMode: false,
              isPasswordVisible: false,
              isLoading: true,
              onPasswordVisibilityToggle: () {},
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      final textFields = tester.widgetList<TextField>(find.byType(TextField));
      for (final field in textFields) {
        expect(field.readOnly, isTrue);
      }

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should allow text input when not loading', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: ReactiveForm(
            formGroup: form,
            child: LoginInputFields(
              form: form,
              isPhoneMode: false,
              isPasswordVisible: false,
              isLoading: false,
              onPasswordVisibilityToggle: () {},
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Enter text - find TextField by hint text
      final emailField = find.byWidgetPredicate(
        (widget) =>
            widget is TextField &&
            widget.decoration?.hintText == AuthConstants.hintEmail,
      );
      await tester.enterText(emailField, 'test@example.com');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(
        form.control(LoginFormControls.email).value,
        equals('test@example.com'),
      );

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}
