import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/home/presentation/constants/home_constants.dart';
import 'package:flutter_base_app/features/home/presentation/providers/home_provider.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/banner_section.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/company_selection_section.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/dashboard_summary_grid.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/home_header.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/input_data_section.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/pond_list_section.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/shimmer_loaders/banner_section_shimmer.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/shimmer_loaders/company_selection_shimmer.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/shimmer_loaders/dashboard_summary_shimmer.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/shimmer_loaders/pond_list_shimmer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Home screen (Beranda).
///
/// This screen displays the main dashboard with:
/// - Header section (STP logo, refresh & notification icons)
/// - Banner section (horizontal scrollable cards)
/// - Company Selection section
/// - Dashboard summary cards
/// - Input data section
/// - Pond list
class HomeScreen extends HookConsumerWidget {
  /// Creates a new instance of [HomeScreen].
  const HomeScreen({super.key});

  // Spacing constants - exact Figma specs
  static const double _sectionSpacing = 24; // Figma: gap 24px

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch providers per section
    final headerAsync = ref.watch(headerDataProvider);
    final bannerListAsync = ref.watch(bannerListDataProvider);
    final dashboardSummaryAsync = ref.watch(dashboardSummaryDataProvider);
    final pondListAsync = ref.watch(pondListDataProvider);
    final companyListAsync = ref.watch(companyListDataProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: ColoredBox(
          color: AppColors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header Section (redesigned)
                // Header doesn't need shimmer - logo and icons are static
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: HomeHeader(
                    onRefresh: () {
                      // Refresh all sections including header
                      ref.invalidate(headerDataProvider);
                      ref.invalidate(bannerListDataProvider);
                      ref.invalidate(dashboardSummaryDataProvider);
                      ref.invalidate(pondListDataProvider);
                      ref.invalidate(companyListDataProvider);
                      ref.invalidate(inputDataListDataProvider);
                    },
                    onNotificationTap: _handleNotificationTap,
                    notificationCount:
                        headerAsync.valueOrNull?.notificationCount,
                  ),
                ),
                const SizedBox(height: _sectionSpacing),
                // 2. Banner Section (NEW) - Data from API
                bannerListAsync.when(
                  data: (data) =>
                      const BannerSection(onCardTap: _handleBannerTap),
                  loading: () => const BannerSectionShimmer(),
                  error: (error, stackTrace) => const SizedBox.shrink(),
                  skipLoadingOnRefresh: false,
                ),
                const SizedBox(height: _sectionSpacing),
                // 3. Company Selection Section (NEW - moved from header)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: companyListAsync.when(
                    data: (data) => CompanySelectionSection(
                      selectedCompany: data.selectedCompany,
                      companies: data.companies,
                      onCompanyChanged: (company) {
                        ref
                            .read(companyListNotifierProvider.notifier)
                            .updateCompany(company);
                      },
                    ),
                    loading: () => const CompanySelectionShimmer(),
                    error: (error, stackTrace) => const SizedBox.shrink(),
                    skipLoadingOnRefresh:
                        false, // Show loading state on refresh
                  ),
                ),
                const SizedBox(height: _sectionSpacing),
                // 4. Dashboard Summary Cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: dashboardSummaryAsync.when(
                    data: (data) => DashboardSummaryGrid(
                      activePonds: data.activePonds,
                      estimasiBiomassa: data.estimasiBiomassa,
                      totalPakan: data.totalPakan,
                      biayaPakan: data.biayaPakan,
                      estimasiSR: data.estimasiSR,
                      onShowAllTap: _handleShowAllTap,
                    ),
                    loading: () => const DashboardSummaryShimmer(),
                    error: (error, stackTrace) => const SizedBox.shrink(),
                    skipLoadingOnRefresh:
                        false, // Show loading state on refresh
                  ),
                ),
                const SizedBox(height: _sectionSpacing),
                // 5. Input Data Section - Data from API (with custom order)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: InputDataSection(
                    onSeeAllTap: _handleInputDataSeeAllTap,
                    onItemTap: _handleInputDataItemTap,
                  ),
                ),
                const SizedBox(height: _sectionSpacing),
                // 6. Pond List Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: pondListAsync.when(
                    data: (data) => PondListSection(
                      ponds: data.ponds
                          .map((pond) => PondData(id: pond.id, name: pond.name))
                          .toList(),
                      onSeeAllTap: _handlePondListSeeAllTap,
                      onPondTap: _handlePondTap,
                    ),
                    loading: () => const PondListShimmer(),
                    error: (error, stackTrace) => const SizedBox.shrink(),
                    skipLoadingOnRefresh:
                        false, // Show loading state on refresh
                  ),
                ),
                const SizedBox(height: _sectionSpacing),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Handler methods
  static void _handleNotificationTap() {
    // TODO: Handle notification tap
    // This will navigate to notification screen
    debugPrint('Notification tapped');
  }

  static void _handleBannerTap(String cardId) {
    // TODO: Handle banner card tap
    // This will navigate to specific screen based on card ID
    debugPrint('Banner card tapped: $cardId');
  }

  static void _handleShowAllTap() {
    // TODO: Handle show all tap
    // This will be implemented when navigation is added
    debugPrint('Show all tapped');
  }

  static void _handleInputDataSeeAllTap() {
    // TODO: Handle see all tap
    // This will navigate to Input Data screen
    debugPrint('See all input data tapped');
  }

  static void _handleInputDataItemTap(String itemLabel) {
    // TODO: Handle item tap
    // This will navigate to specific input data form
    debugPrint('Input data item tapped: $itemLabel');
  }

  static void _handlePondListSeeAllTap() {
    // TODO: Handle see all tap
    // This will navigate to Pond screen
    debugPrint('See all ponds tapped');
  }

  static void _handlePondTap(String pondId) {
    // TODO: Handle pond tap
    // This will navigate to pond detail screen
    debugPrint('Pond tapped: $pondId');
  }
}
