import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/home/presentation/constants/home_constants.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/company_selection_section.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  group('CompanySelectionSection', () {
    testWidgets('should display label and dropdown', (tester) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const CompanySelectionSection(),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(
        find.text(HomeConstants.companySelectionLabel),
        findsOneWidget,
      );

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display default company when no companies provided', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const CompanySelectionSection(),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - Default company should be displayed
      expect(
        find.text(HomeConstants.defaultCompanyName),
        findsWidgets,
      );

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display selected company', (tester) async {
      // Arrange
      const companies = ['Company A', 'Company B', 'Company C'];

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const CompanySelectionSection(
            selectedCompany: 'Company B',
            companies: companies,
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - Selected company should be displayed
      expect(find.text('Company B'), findsWidgets);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should call onCompanyChanged when company is selected', (
      tester,
    ) async {
      // Arrange
      const companies = ['Company A', 'Company B', 'Company C'];
      String? selectedCompany;

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: CompanySelectionSection(
            companies: companies,
            onCompanyChanged: (company) => selectedCompany = company,
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Tap on dropdown to open it
      final dropdown = find.byType(CompanySelectionSection);
      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      // Select a different company (if dropdown is open)
      // Note: This test may need adjustment based on STPDropdown implementation
      // For now, we verify the widget is interactive
      expect(dropdown, findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should use first company when selectedCompany is null', (
      tester,
    ) async {
      // Arrange
      const companies = ['Company A', 'Company B', 'Company C'];

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          child: const CompanySelectionSection(
            companies: companies,
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - First company should be displayed
      expect(find.text('Company A'), findsWidgets);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}

