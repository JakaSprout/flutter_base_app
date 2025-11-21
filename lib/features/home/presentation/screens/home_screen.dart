import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_app/core/utils/status_bar_config.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/home/presentation/constants/home_constants.dart';
import 'package:flutter_base_app/features/home/presentation/constants/home_design_constants.dart';
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
import 'package:flutter_base_app/router/routes.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch providers per section
    final headerAsync = ref.watch(headerDataProvider);
    final bannerListAsync = ref.watch(bannerListDataProvider);
    final dashboardSummaryAsync = ref.watch(dashboardSummaryDataProvider);
    final pondListAsync = ref.watch(pondListDataProvider);
    final companyListAsync = ref.watch(companyListDataProvider);

    // Set status bar for light background immediately on mount
    // Set immediately and also after frame to ensure it's set correctly
    useEffect(() {
      // Set immediately
      StatusBarConfig.setLightStatusBar();

      // Also set after frame to ensure it overrides any other
      // status bar settings
      WidgetsBinding.instance.addPostFrameCallback((_) {
        StatusBarConfig.setLightStatusBar();
      });

      return null;
    }, []);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false, // Don't add bottom safe area
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: StatusBarConfig.getStatusBarStyleForLightBackground(),
        child: ColoredBox(
          color: AppColors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header Section (redesigned)
                // Header doesn't need shimmer - logo and icons are static
                Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: HomeDesignConstants.screenHorizontalPadding,
                    ),
                  child: HomeHeader(
                    onRefresh: () {
                      // Refresh all sections including header
                      ref
                        ..invalidate(headerDataProvider)
                        ..invalidate(bannerListDataProvider)
                        ..invalidate(dashboardSummaryDataProvider)
                        ..invalidate(pondListDataProvider)
                        ..invalidate(companyListDataProvider)
                        ..invalidate(inputDataListDataProvider);
                    },
                    onNotificationTap: _handleNotificationTap,
                    notificationCount:
                        headerAsync.valueOrNull?.notificationCount,
                  ),
                ),
                  const SizedBox(height: HomeDesignConstants.sectionSpacing),
                // 2. Banner Section (NEW) - Data from API
                bannerListAsync.when(
                  data: (data) => BannerSection(
                    onCardTap: (cardId) => _handleBannerTap(context, cardId),
                  ),
                  loading: () => const BannerSectionShimmer(),
                  error: (error, stackTrace) => const SizedBox.shrink(),
                  skipLoadingOnRefresh: false,
                ),
                  const SizedBox(height: HomeDesignConstants.sectionSpacing),
                // 3. Company Selection Section (NEW - moved from header)
                Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: HomeDesignConstants.screenHorizontalPadding,
                    ),
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
                  const SizedBox(height: HomeDesignConstants.sectionSpacing),
                // 4. Dashboard Summary Cards
                Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: HomeDesignConstants.screenHorizontalPadding,
                    ),
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
                  const SizedBox(height: HomeDesignConstants.sectionSpacing),
                // 5. Input Data Section - Data from API (with custom order)
                const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: HomeDesignConstants.screenHorizontalPadding,
                    ),
                  child: InputDataSection(
                    onSeeAllTap: _handleInputDataSeeAllTap,
                    onItemTap: _handleInputDataItemTap,
                  ),
                ),
                  const SizedBox(height: HomeDesignConstants.sectionSpacing),
                // 6. Pond List Section
                Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: HomeDesignConstants.screenHorizontalPadding,
                    ),
                  child: pondListAsync.when(
                    data: (data) => PondListSection(
                      ponds: data.ponds
                            .map(
                              (pond) => PondData(id: pond.id, name: pond.name),
                            )
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
                  const SizedBox(height: HomeDesignConstants.sectionSpacing),
              ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Handler methods
  static void _handleNotificationTap() {
    // TODO(sproutdigital): Handle notification tap and navigate accordingly.
    debugPrint('Notification tapped');
  }

  static void _handleBannerTap(BuildContext context, String cardId) {
    // Navigate to lab request list screen if banner is "Analisis Lab"
    if (cardId == 'lab_analysis') {
      context.push(Routes.labRequestList);
      return;
    }

    // Navigate to harvest calculator if banner is "Kalkulator Panen"
    if (cardId == 'harvest_calculator' || cardId == 'kalkulator_panen') {
      context.push(Routes.harvestCalculatorHome);
      return;
    }

    // TODO(sproutdigital): Handle other banner card tap navigation.
    debugPrint('Banner card tapped: $cardId');
  }

  static void _handleShowAllTap() {
    // TODO(sproutdigital): Handle show all tap when navigation is added.
    debugPrint('Show all tapped');
  }

  static void _handleInputDataSeeAllTap() {
    // TODO(sproutdigital): Handle see all tap to navigate to Input Data screen.
    debugPrint('See all input data tapped');
  }

  static void _handleInputDataItemTap(String itemLabel) {
    // TODO(sproutdigital): Handle item tap to navigate to specific input form.
    debugPrint('Input data item tapped: $itemLabel');
  }

  static void _handlePondListSeeAllTap() {
    // TODO(sproutdigital): Handle see all tap to navigate to Pond screen.
    debugPrint('See all ponds tapped');
  }

  static void _handlePondTap(String pondId) {
    // TODO(sproutdigital): Handle pond tap to navigate to pond detail screen.
    debugPrint('Pond tapped: $pondId');
  }
}
