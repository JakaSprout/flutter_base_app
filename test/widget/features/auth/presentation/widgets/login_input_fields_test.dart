import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/auth/domain/entities/country_code.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/auth_constants.dart';
import 'package:flutter_base_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_input_fields.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  group('LoginInputFields', () {
    late TextEditingController phoneController;
    late TextEditingController emailController;
    late TextEditingController passwordController;

    setUp(() {
      phoneController = TextEditingController();
      emailController = TextEditingController();
      passwordController = TextEditingController();
    });

    tearDown(() {
      phoneController.dispose();
      emailController.dispose();
      passwordController.dispose();
    });

    testWidgets('should display phone input when in phone mode', (
      tester,
    ) async {
      // Arrange
      const countryCodes = [
        CountryCode(
          code: 'ID',
          dialCode: '+62',
          name: 'Indonesia',
          flag: '🇮🇩',
        ),
      ];

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          overrides: [
            countryCodesProvider.overrideWith((_) async => countryCodes),
          ],
          child: LoginInputFields(
            isPhoneMode: true,
            phoneController: phoneController,
            emailController: emailController,
            passwordController: passwordController,
            selectedCountryCode: countryCodes.first,
            isPasswordVisible: false,
            isLoading: false,
            onCountryCodeChanged: (_) {},
            onPasswordVisibilityToggle: () {},
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
      // Arrange
      const countryCodes = <CountryCode>[];

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          overrides: [
            countryCodesProvider.overrideWith((_) async => countryCodes),
          ],
          child: LoginInputFields(
            isPhoneMode: false,
            phoneController: phoneController,
            emailController: emailController,
            passwordController: passwordController,
            selectedCountryCode: null,
            isPasswordVisible: false,
            isLoading: false,
            onCountryCodeChanged: (_) {},
            onPasswordVisibilityToggle: () {},
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
      // Arrange
      const countryCodes = <CountryCode>[];

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          overrides: [
            countryCodesProvider.overrideWith((_) async => countryCodes),
          ],
          child: LoginInputFields(
            isPhoneMode: false,
            phoneController: phoneController,
            emailController: emailController,
            passwordController: passwordController,
            selectedCountryCode: null,
            isPasswordVisible: false,
            isLoading: false,
            onCountryCodeChanged: (_) {},
            onPasswordVisibilityToggle: () {},
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
      // Arrange
      const countryCodes = <CountryCode>[];

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          overrides: [
            countryCodesProvider.overrideWith((_) async => countryCodes),
          ],
          child: LoginInputFields(
            isPhoneMode: false,
            phoneController: phoneController,
            emailController: emailController,
            passwordController: passwordController,
            selectedCountryCode: null,
            isPasswordVisible: false,
            isLoading: false,
            onCountryCodeChanged: (_) {},
            onPasswordVisibilityToggle: () {},
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
      // Arrange
      const countryCodes = <CountryCode>[];

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          overrides: [
            countryCodesProvider.overrideWith((_) async => countryCodes),
          ],
          child: LoginInputFields(
            isPhoneMode: false,
            phoneController: phoneController,
            emailController: emailController,
            passwordController: passwordController,
            selectedCountryCode: null,
            isPasswordVisible: true,
            isLoading: false,
            onCountryCodeChanged: (_) {},
            onPasswordVisibilityToggle: () {},
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
        const countryCodes = <CountryCode>[];

        // Act
        await tester.pumpWidget(
          TestHelpers.createTestApp(
            overrides: [
              countryCodesProvider.overrideWith((_) async => countryCodes),
            ],
            child: LoginInputFields(
              isPhoneMode: false,
              phoneController: phoneController,
              emailController: emailController,
              passwordController: passwordController,
              selectedCountryCode: null,
              isPasswordVisible: false,
              isLoading: false,
              onCountryCodeChanged: (_) {},
              onPasswordVisibilityToggle: () => toggleCalled = true,
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
      // Arrange
      const countryCodes = <CountryCode>[];

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          overrides: [
            countryCodesProvider.overrideWith((_) async => countryCodes),
          ],
          child: LoginInputFields(
            isPhoneMode: false,
            phoneController: emailController,
            emailController: emailController,
            passwordController: passwordController,
            selectedCountryCode: null,
            isPasswordVisible: false,
            isLoading: true,
            onCountryCodeChanged: (_) {},
            onPasswordVisibilityToggle: () {},
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      final textFields = tester.widgetList<TextField>(find.byType(TextField));
      for (final field in textFields) {
        expect(field.enabled, isFalse);
      }

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should allow text input when not loading', (tester) async {
      // Arrange
      const countryCodes = <CountryCode>[];

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          overrides: [
            countryCodesProvider.overrideWith((_) async => countryCodes),
          ],
          child: LoginInputFields(
            isPhoneMode: false,
            phoneController: phoneController,
            emailController: emailController,
            passwordController: passwordController,
            selectedCountryCode: null,
            isPasswordVisible: false,
            isLoading: false,
            onCountryCodeChanged: (_) {},
            onPasswordVisibilityToggle: () {},
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
      expect(emailController.text, equals('test@example.com'));

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}
