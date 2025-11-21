import 'package:flutter/material.dart';
import 'package:app_mobile_afms/core/utils/extensions/context_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_helpers.dart';

void main() {
  group('ContextExtensions', () {
    testWidgets('should get theme data', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: Builder(
            builder: (context) {
              final theme = context.theme;
              return Text('Theme: ${theme.brightness}');
            },
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.textContaining('Theme:'), findsOneWidget);

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should get text theme', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: Builder(
            builder: (context) {
              final textTheme = context.textTheme;
              return Text('TextTheme: ${textTheme.bodySmall?.fontSize}');
            },
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.textContaining('TextTheme:'), findsOneWidget);

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should get color scheme', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: Builder(
            builder: (context) {
              final colorScheme = context.colorScheme;
              return Text('ColorScheme: ${colorScheme.brightness}');
            },
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.textContaining('ColorScheme:'), findsOneWidget);

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should get screen size', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: Builder(
            builder: (context) {
              final screenSize = context.screenSize;
              return Text('Size: ${screenSize.width}x${screenSize.height}');
            },
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.textContaining('Size:'), findsOneWidget);

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should get screen width and height', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: Builder(
            builder: (context) {
              final width = context.screenWidth;
              final height = context.screenHeight;
              return Text('$width x $height');
            },
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - Should have width and height values
      expect(find.textContaining('x'), findsOneWidget);

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should check orientation', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: Builder(
            builder: (context) {
              final isLandscape = context.isLandscape;
              final isPortrait = context.isPortrait;
              return Text('Landscape: $isLandscape, Portrait: $isPortrait');
            },
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.textContaining('Landscape:'), findsOneWidget);

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should check device type', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: Builder(
            builder: (context) {
              final isTablet = context.isTablet;
              final isPhone = context.isPhone;
              return Text('Tablet: $isTablet, Phone: $isPhone');
            },
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.textContaining('Tablet:'), findsOneWidget);

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should show snackbar', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () => context.showSnackBar('Test message'),
                child: const Text('Show Snackbar'),
              );
            },
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Tap button
      await tester.tap(find.text('Show Snackbar'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.text('Test message'), findsOneWidget);

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should show error snackbar', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () => context.showErrorSnackBar('Error message'),
                child: const Text('Show Error'),
              );
            },
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Tap button
      await tester.tap(find.text('Show Error'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.text('Error message'), findsOneWidget);

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should show success snackbar', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () => context.showSuccessSnackBar('Success message'),
                child: const Text('Show Success'),
              );
            },
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Tap button
      await tester.tap(find.text('Show Success'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.text('Success message'), findsOneWidget);

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should check can pop', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: Builder(
            builder: (context) {
              final canPop = context.canPop;
              return Text('CanPop: $canPop');
            },
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.textContaining('CanPop:'), findsOneWidget);

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should unfocus', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: Builder(
            builder: (context) {
              return TextField(
                onTap: () => context.unfocus(),
              );
            },
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Tap to focus
      await tester.tap(find.byType(TextField));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Unfocus
      final context = tester.element(find.byType(TextField));
      context.unfocus();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - No error should occur
      expect(find.byType(TextField), findsOneWidget);

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}

