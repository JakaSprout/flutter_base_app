import 'package:flutter_base_app/features/auth/domain/entities/country_code.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/country_code_dropdown.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  group('CountryCodeDropdown', () {
    testWidgets('should display selected country code', (tester) async {
      // Arrange
      const countryCodes = [
        CountryCode(
          code: 'ID',
          dialCode: '+62',
          name: 'Indonesia',
          flag: '🇮🇩',
        ),
        CountryCode(
          code: 'MY',
          dialCode: '+60',
          name: 'Malaysia',
          flag: '🇲🇾',
        ),
      ];
      final selectedCountryCode = countryCodes.first;

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: CountryCodeDropdown(
            countryCodes: countryCodes,
            selectedCountryCode: selectedCountryCode,
            onChanged: (_) {},
          ),
        ),
      );

      // Assert
      expect(find.text('+62'), findsOneWidget);
      expect(find.text('🇮🇩'), findsOneWidget);
    });

    testWidgets('should display first country code when none selected', (
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
        CountryCode(
          code: 'MY',
          dialCode: '+60',
          name: 'Malaysia',
          flag: '🇲🇾',
        ),
      ];

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: CountryCodeDropdown(
            countryCodes: countryCodes,
            selectedCountryCode: null,
            onChanged: (_) {},
          ),
        ),
      );

      // Assert
      expect(find.text('+62'), findsOneWidget);
    });

    testWidgets('should show dropdown menu when tapped', (tester) async {
      // Arrange
      const countryCodes = [
        CountryCode(
          code: 'ID',
          dialCode: '+62',
          name: 'Indonesia',
          flag: '🇮🇩',
        ),
        CountryCode(
          code: 'MY',
          dialCode: '+60',
          name: 'Malaysia',
          flag: '🇲🇾',
        ),
      ];

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: CountryCodeDropdown(
            countryCodes: countryCodes,
            selectedCountryCode: countryCodes.first,
            onChanged: (_) {},
          ),
        ),
      );

      // Tap dropdown
      await tester.tap(find.byType(CountryCodeDropdown));
      await tester.pumpAndSettle();

      // Assert - Modal bottom sheet should appear
      expect(find.text('Indonesia'), findsOneWidget);
      expect(find.text('Malaysia'), findsOneWidget);
    });

    testWidgets('should call onChanged when country is selected', (
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
        CountryCode(
          code: 'MY',
          dialCode: '+60',
          name: 'Malaysia',
          flag: '🇲🇾',
        ),
      ];
      CountryCode? selectedCountry;

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: CountryCodeDropdown(
            countryCodes: countryCodes,
            selectedCountryCode: countryCodes.first,
            onChanged: (country) => selectedCountry = country,
          ),
        ),
      );

      // Tap dropdown
      await tester.tap(find.byType(CountryCodeDropdown));
      await tester.pumpAndSettle();

      // Select Malaysia
      await tester.tap(find.text('Malaysia'));
      await tester.pumpAndSettle();

      // Assert
      expect(selectedCountry, equals(countryCodes[1]));
    });

    testWidgets('should be disabled when enabled is false', (tester) async {
      // Arrange
      const countryCodes = [
        CountryCode(
          code: 'ID',
          dialCode: '+62',
          name: 'Indonesia',
          flag: '🇮🇩',
        ),
      ];
      var onChangedCalled = false;

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: CountryCodeDropdown(
            countryCodes: countryCodes,
            selectedCountryCode: countryCodes.first,
            enabled: false,
            onChanged: (_) => onChangedCalled = true,
          ),
        ),
      );

      // Try to tap dropdown (should not work)
      await tester.tap(find.byType(CountryCodeDropdown), warnIfMissed: false);
      await tester.pumpAndSettle();

      // Assert
      expect(onChangedCalled, isFalse);
      // Modal bottom sheet should not appear when disabled
      expect(find.text('Indonesia'), findsNothing);
    });

    testWidgets('should display all country codes in dropdown', (tester) async {
      // Arrange
      const countryCodes = [
        CountryCode(
          code: 'ID',
          dialCode: '+62',
          name: 'Indonesia',
          flag: '🇮🇩',
        ),
        CountryCode(
          code: 'MY',
          dialCode: '+60',
          name: 'Malaysia',
          flag: '🇲🇾',
        ),
        CountryCode(
          code: 'SG',
          dialCode: '+65',
          name: 'Singapore',
          flag: '🇸🇬',
        ),
      ];

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: CountryCodeDropdown(
            countryCodes: countryCodes,
            selectedCountryCode: countryCodes.first,
            onChanged: (_) {},
          ),
        ),
      );

      // Tap dropdown
      await tester.tap(find.byType(CountryCodeDropdown));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Indonesia'), findsOneWidget);
      expect(find.text('Malaysia'), findsOneWidget);
      expect(find.text('Singapore'), findsOneWidget);
    });
  });
}
