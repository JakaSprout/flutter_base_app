import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/home/presentation/constants/home_constants.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/banner_section.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/company_selection_section.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/dashboard_summary_grid.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/home_header.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/input_data_section.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/pond_list_section.dart';

/// Home screen (Beranda).
///
/// This screen displays the main dashboard with:
/// - Header section (STP logo, refresh & notification icons)
/// - Banner section (horizontal scrollable cards)
/// - Company Selection section
/// - Dashboard summary cards
/// - Input data section
/// - Pond list
class HomeScreen extends StatelessWidget {
  /// Creates a new instance of [HomeScreen].
  const HomeScreen({super.key});

  // Spacing constants - exact Figma specs
  static const double _screenPadding = 20; // Figma: padding 20px
  static const double _sectionSpacing = 24; // Figma: gap 24px

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: ColoredBox(
          color: AppColors.white,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(_screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header Section (redesigned)
                HomeHeader(
                  onRefresh: _handleRefresh,
                  onNotificationTap: _handleNotificationTap,
                ),
                SizedBox(height: _sectionSpacing),
                // 2. Banner Section (NEW)
                BannerSection(onCardTap: _handleBannerTap),
                SizedBox(height: _sectionSpacing),
                // 3. Company Selection Section (NEW - moved from header)
                CompanySelectionSection(
                  selectedCompany: HomeConstants.defaultCompanyName,
                  companies: [
                    HomeConstants.defaultCompanyName,
                    'PT. Company Lain',
                    'PT. Company Lain Lagi',
                  ],
                  onCompanyChanged: _handleCompanyChanged,
                ),
                SizedBox(height: _sectionSpacing),
                // 4. Dashboard Summary Cards (UNCHANGED)
                DashboardSummaryGrid(
                  activePonds: HomeConstants.defaultActivePonds,
                  onShowAllTap: _handleShowAllTap,
                ),
                SizedBox(height: _sectionSpacing),
                // 5. Input Data Section (UNCHANGED)
                InputDataSection(
                  onSeeAllTap: _handleInputDataSeeAllTap,
                  onItemTap: _handleInputDataItemTap,
                ),
                SizedBox(height: _sectionSpacing),
                // 6. Pond List Section (UNCHANGED - redesign later)
                PondListSection(
                  onSeeAllTap: _handlePondListSeeAllTap,
                  onPondTap: _handlePondTap,
                ),
                SizedBox(height: _sectionSpacing),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Handler methods
  static void _handleRefresh() {
    // TODO: Handle refresh tap
    // This will refresh the home screen data
    debugPrint('Refresh tapped');
  }

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

  static void _handleCompanyChanged(String selectedCompany) {
    // TODO: Handle company change
    // This will be implemented when state management is added
    debugPrint('Selected company: $selectedCompany');
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
