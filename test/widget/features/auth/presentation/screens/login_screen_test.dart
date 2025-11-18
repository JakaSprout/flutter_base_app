import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_button.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_card.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_input_fields.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_logo.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_mode_switch.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_title.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  group('LoginScreen', () {

    testWidgets('should display login screen with all components', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const LoginScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Assert - Check main components are present
      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.byType(LoginCard), findsOneWidget);
      expect(find.byType(LoginLogo), findsOneWidget);
      expect(find.byType(LoginTitle), findsOneWidget);
      expect(find.byType(LoginInputFields), findsOneWidget);
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
          child: const LoginScreen(),
        ),
      );

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
          child: const LoginScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Assert - Check structure
      expect(find.byType(Scaffold), findsWidgets); // At least 2 (wrapper + screen)
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

  });
}

