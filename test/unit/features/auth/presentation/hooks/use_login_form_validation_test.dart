import 'package:flutter/material.dart';
import 'package:app_mobile_afms/features/auth/presentation/constants/login_form_controls.dart';
import 'package:app_mobile_afms/features/auth/presentation/hooks/use_login_form_validation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../helpers/test_helpers.dart';

/// Test widget that uses the hook
class _TestWidget extends HookConsumerWidget {
  const _TestWidget({required this.isPhoneMode});
  final bool isPhoneMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = useMemoized<FormGroup>(
      () => FormGroup({
        LoginFormControls.phone: FormControl<String>(value: ''),
        LoginFormControls.email: FormControl<String>(value: ''),
        LoginFormControls.password: FormControl<String>(value: ''),
      }),
      const [],
    );

    useLoginFormValidation(form: form, isPhoneMode: isPhoneMode);

    return Container(
      child: Column(
        children: [
          Text('Mode: ${isPhoneMode ? "Phone" : "Email"}'),
          Text('Form valid: ${form.valid}'),
        ],
      ),
    );
  }
}

void main() {
  group('useLoginFormValidation', () {
    testWidgets('should configure validators for phone mode', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(child: const _TestWidget(isPhoneMode: true)),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Mode: Phone'), findsOneWidget);
      expect(find.text('Form valid: false'), findsOneWidget);

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should configure validators for email mode', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(child: const _TestWidget(isPhoneMode: false)),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Mode: Email'), findsOneWidget);
      expect(find.text('Form valid: false'), findsOneWidget);

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should update validators when mode changes', (tester) async {
      // Arrange
      var isPhoneMode = true;

      await tester.pumpWidget(
        TestHelpers.createTestApp(child: _TestWidget(isPhoneMode: isPhoneMode)),
      );

      await tester.pumpAndSettle();

      expect(find.text('Mode: Phone'), findsOneWidget);

      // Act - Change mode
      isPhoneMode = false;
      await tester.pumpWidget(
        TestHelpers.createTestApp(child: _TestWidget(isPhoneMode: isPhoneMode)),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Mode: Email'), findsOneWidget);

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}
