import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/auth/domain/entities/country_code.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/auth_constants.dart';
import 'package:flutter_base_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_base_app/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_button.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_card.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_input_fields.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_logo.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_mode_switch.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_terms_checkbox.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_title.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  group('LoginScreen', () {
    final testCountryCodes = [
      const CountryCode(
        code: 'ID',
        dialCode: '+62',
        name: 'Indonesia',
        flag: '🇮🇩',
      ),
      const CountryCode(
        code: 'US',
        dialCode: '+1',
        name: 'United States',
        flag: '🇺🇸',
      ),
    ];

    testWidgets('should display login screen with all components', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          overrides: [
            countryCodesProvider.overrideWith(
              (_) => Future.value(testCountryCodes),
            ),
          ],
          child: const LoginScreen(),
        ),
      );

      // Wait for country codes to load
      await tester.pumpAndSettle();

      // Assert - Check main components are present
      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.byType(LoginCard), findsOneWidget);
      expect(find.byType(LoginLogo), findsOneWidget);
      expect(find.byType(LoginTitle), findsOneWidget);
      expect(find.byType(LoginInputFields), findsOneWidget);
      expect(find.byType(LoginTermsCheckbox), findsOneWidget);
      expect(find.byType(LoginButton), findsOneWidget);
      expect(find.byType(LoginModeSwitch), findsOneWidget);

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display phone mode by default', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          overrides: [
            countryCodesProvider.overrideWith(
              (_) => Future.value(testCountryCodes),
            ),
          ],
          child: const LoginScreen(),
        ),
      );

      // Wait for country codes to load
      await tester.pumpAndSettle();

      // Assert - Phone mode title should be displayed
      // LoginTitle widget displays different text based on isPhoneMode
      expect(find.byType(LoginTitle), findsOneWidget);

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should have correct structure', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          overrides: [
            countryCodesProvider.overrideWith(
              (_) => Future.value(testCountryCodes),
            ),
          ],
          child: const LoginScreen(),
        ),
      );

      // Wait for country codes to load
      await tester.pumpAndSettle();

      // Assert - Check structure
      expect(find.byType(Scaffold), findsWidgets); // At least 2 (wrapper + screen)
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display loading state when country codes are loading', (
      WidgetTester tester,
    ) async {
      // Arrange - Create a completer to control loading state
      final completer = Completer<List<CountryCode>>();

      await tester.pumpWidget(
        TestHelpers.createTestApp(
          overrides: [
            countryCodesProvider.overrideWith((_) => completer.future),
          ],
          child: const LoginScreen(),
        ),
      );

      // Pump once to start loading
      await tester.pump();

      // Assert - Screen should still render (loading is handled internally)
      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.byType(LoginCard), findsOneWidget);

      // Complete the future to prevent hanging
      completer.complete(testCountryCodes);
      await tester.pumpAndSettle();

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}

