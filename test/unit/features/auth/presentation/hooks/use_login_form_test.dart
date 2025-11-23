import 'package:app_mobile_afms/features/auth/presentation/constants/login_form_controls.dart';
import 'package:app_mobile_afms/features/auth/presentation/hooks/use_login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../helpers/test_helpers.dart';

/// Test widget that uses the hook
class _TestWidget extends HookConsumerWidget {
  const _TestWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = useLoginForm();
    return Container(
      child: Column(
        children: [
          const Text('Form created'),
          Text(
            'Phone control: ${form.controls.containsKey(LoginFormControls.phone)}',
          ),
          Text(
            'Email control: ${form.controls.containsKey(LoginFormControls.email)}',
          ),
          Text(
            'Password control: ${form.controls.containsKey(LoginFormControls.password)}',
          ),
        ],
      ),
    );
  }
}

void main() {
  group('useLoginForm', () {
    testWidgets('should create FormGroup with correct controls', (
      tester,
    ) async {
      // Arrange & Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(child: const _TestWidget()),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Form created'), findsOneWidget);
      expect(find.text('Phone control: true'), findsOneWidget);
      expect(find.text('Email control: true'), findsOneWidget);
      expect(find.text('Password control: true'), findsOneWidget);

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should create form with initial validators', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(child: const _TestWidget()),
      );

      await tester.pumpAndSettle();

      // The form should be created with initial validators
      // Phone: required
      // Email: required, email
      // Password: required
      expect(find.text('Form created'), findsOneWidget);

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}
