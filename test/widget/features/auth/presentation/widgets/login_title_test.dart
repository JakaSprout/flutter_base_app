import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/auth_constants.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login_title.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  group('LoginTitle', () {
    testWidgets('should display phone login title when in phone mode', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const LoginTitle(isPhoneMode: true),
        ),
      );

      // Assert
      expect(find.text(AuthConstants.titlePhoneLogin), findsOneWidget);
      expect(find.text(AuthConstants.titleEmailLogin), findsNothing);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display email login title when in email mode', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const LoginTitle(isPhoneMode: false),
        ),
      );

      // Assert
      expect(find.text(AuthConstants.titleEmailLogin), findsOneWidget);
      expect(find.text(AuthConstants.titlePhoneLogin), findsNothing);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should update title when mode changes', (tester) async {
      // Arrange
      const isPhoneMode = true;

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: StatefulBuilder(
            builder: (context, setState) {
              return const LoginTitle(
                isPhoneMode: isPhoneMode,
                key: Key('login_title'),
              );
            },
          ),
        ),
      );

      // Assert - Initial state (phone mode)
      expect(find.text(AuthConstants.titlePhoneLogin), findsOneWidget);

      // Act - Change to email mode
      await tester.binding.setSurfaceSize(const Size(800, 600));
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: StatefulBuilder(
            builder: (context, setState) {
              return const LoginTitle(
                isPhoneMode: false,
                key: Key('login_title'),
              );
            },
          ),
        ),
      );

      // Assert - Email mode
      expect(find.text(AuthConstants.titleEmailLogin), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}

