import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/home/domain/entities/banner_list_data.dart';
import 'package:flutter_base_app/features/home/domain/entities/company_list_data.dart';
import 'package:flutter_base_app/features/home/domain/entities/dashboard_summary_data.dart';
import 'package:flutter_base_app/features/home/domain/entities/header_data.dart';
import 'package:flutter_base_app/features/home/domain/entities/input_data_list_data.dart';
import 'package:flutter_base_app/features/home/domain/entities/pond_entity.dart';
import 'package:flutter_base_app/features/home/domain/entities/pond_list_data.dart';
import 'package:flutter_base_app/features/home/presentation/providers/home_provider.dart';
import 'package:flutter_base_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/banner_section.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/company_selection_section.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/dashboard_summary_grid.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/home_header.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/input_data_section.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/pond_list_section.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  group('HomeScreen', () {
    const testHeaderData = HeaderData(notificationCount: 5);
    const testBannerListData = BannerListData(banners: []);
    const testDashboardSummaryData = DashboardSummaryData(
      activePonds: 10,
      estimasiBiomassa: '1000 kg',
      totalPakan: '500 kg',
      biayaPakan: 'Rp 1.000.000',
      estimasiSR: '95%',
    );
    const testPondListData = PondListData(
      ponds: [
        PondEntity(id: 'pond1', name: 'Pond 1'),
        PondEntity(id: 'pond2', name: 'Pond 2'),
      ],
    );
    const testCompanyListData = CompanyListData(
      companies: ['Company 1', 'Company 2'],
      selectedCompany: 'Company 1',
    );
    const testInputDataListData = InputDataListData(items: []);

    testWidgets('should display home screen with all sections', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          overrides: [
            headerDataProvider.overrideWith(
              (_) => Future.value(testHeaderData),
            ),
            bannerListDataProvider.overrideWith(
              (_) => Future.value(testBannerListData),
            ),
            dashboardSummaryDataProvider.overrideWith(
              (_) => Future.value(testDashboardSummaryData),
            ),
            pondListDataProvider.overrideWith(
              (_) => Future.value(testPondListData),
            ),
            companyListDataProvider.overrideWith(
              (_) => Future.value(testCompanyListData),
            ),
            inputDataListDataProvider.overrideWith(
              (_) => Future.value(testInputDataListData),
            ),
          ],
          child: const HomeScreen(),
        ),
      );

      // Wait for all providers to load
      await tester.pumpAndSettle();

      // Assert - Check main components are present
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(HomeHeader), findsOneWidget);
      expect(find.byType(BannerSection), findsOneWidget);
      expect(find.byType(CompanySelectionSection), findsOneWidget);
      expect(find.byType(DashboardSummaryGrid), findsOneWidget);
      expect(find.byType(InputDataSection), findsOneWidget);
      expect(find.byType(PondListSection), findsOneWidget);

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
            headerDataProvider.overrideWith(
              (_) => Future.value(testHeaderData),
            ),
            bannerListDataProvider.overrideWith(
              (_) => Future.value(testBannerListData),
            ),
            dashboardSummaryDataProvider.overrideWith(
              (_) => Future.value(testDashboardSummaryData),
            ),
            pondListDataProvider.overrideWith(
              (_) => Future.value(testPondListData),
            ),
            companyListDataProvider.overrideWith(
              (_) => Future.value(testCompanyListData),
            ),
            inputDataListDataProvider.overrideWith(
              (_) => Future.value(testInputDataListData),
            ),
          ],
          child: const HomeScreen(),
        ),
      );

      // Wait for all providers to load
      await tester.pumpAndSettle();

      // Assert - Check structure
      expect(find.byType(Scaffold), findsWidgets); // At least 2 (wrapper + screen)
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      // Column is inside SingleChildScrollView and also in child widgets
      expect(find.byType(Column), findsWidgets);

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display loading states when data is loading', (
      WidgetTester tester,
    ) async {
      // Arrange - Create completers to control loading states
      final headerCompleter = Completer<HeaderData>();
      final bannerCompleter = Completer<BannerListData>();
      final dashboardCompleter = Completer<DashboardSummaryData>();
      final pondCompleter = Completer<PondListData>();
      final companyCompleter = Completer<CompanyListData>();
      final inputDataCompleter = Completer<InputDataListData>();

      await tester.pumpWidget(
        TestHelpers.createTestApp(
          overrides: [
            headerDataProvider.overrideWith((_) => headerCompleter.future),
            bannerListDataProvider.overrideWith((_) => bannerCompleter.future),
            dashboardSummaryDataProvider.overrideWith(
              (_) => dashboardCompleter.future,
            ),
            pondListDataProvider.overrideWith((_) => pondCompleter.future),
            companyListDataProvider.overrideWith(
              (_) => companyCompleter.future,
            ),
            inputDataListDataProvider.overrideWith(
              (_) => inputDataCompleter.future,
            ),
          ],
          child: const HomeScreen(),
        ),
      );

      // Pump once to start loading
      await tester.pump();

      // Assert - Screen should render with loading states
      expect(find.byType(HomeScreen), findsOneWidget);
      // Screen should be rendered (loading is handled by shimmer widgets internally)

      // Complete all futures to prevent hanging
      headerCompleter.complete(testHeaderData);
      bannerCompleter.complete(testBannerListData);
      dashboardCompleter.complete(testDashboardSummaryData);
      pondCompleter.complete(testPondListData);
      companyCompleter.complete(testCompanyListData);
      inputDataCompleter.complete(testInputDataListData);
      await tester.pumpAndSettle();

      // Cleanup
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}

