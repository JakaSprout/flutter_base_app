import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/core/config/navigation_constants.dart';
import 'package:flutter_base_app/gen/assets.gen.dart';
import 'package:flutter_base_app/router/routes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

/// Bottom navigation bar component based on Figma design.
///
/// Features:
/// - 5 navigation items: Beranda, Monitoring, Input Data, Kolam, Profil
/// - Center button (Input Data) with special styling
/// - Active state indication
/// - Material 3 design
class STPBottomNavBar extends StatelessWidget {
  /// Creates a new instance of [STPBottomNavBar].
  ///
  /// [currentLocation] is the current route path to determine active state.
  const STPBottomNavBar({required this.currentLocation, super.key});

  /// Current route location path.
  final String currentLocation;

  /// Primary color for selected state (from Figma: Primary/60 Base)
  static const Color _primaryColor = Color(0xFF122E7A);

  /// Gray color for unselected state (from Figma: Gray/70)
  static const Color _grayColor = Color(0xFF6D6D6D);

  /// White color
  static const Color _whiteColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: _whiteColor,
        border: Border(
          top: BorderSide(color: Color(0xFFEEEEEE)), // Fixed 1px
        ),
      ),
      child: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        height: 70,
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: _buildNavItem(
                  context: context,
                  outlinePath: Assets.icons.outline.home,
                  solidPath: Assets.icons.solid.home,
                  label: NavigationConstants.navHome,
                  route: Routes.home,
                  isActive: currentLocation == Routes.home,
                ),
              ),
              Expanded(
                child: _buildNavItem(
                  context: context,
                  outlinePath: Assets.icons.outline.chart,
                  solidPath: Assets.icons.solid.chart,
                  label: NavigationConstants.navMonitoring,
                  route: Routes.monitoring,
                  isActive: currentLocation == Routes.monitoring,
                ),
              ),
              // Input Data text below FAB
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Text aligned with other nav items
                    // Exact Figma: fontSize 12px, lineHeight 18px (1.5em)
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        NavigationConstants.navInputData,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              fontSize: 12, // Fixed 12px
                              fontWeight: currentLocation == Routes.inputData
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: currentLocation == Routes.inputData
                                  ? _primaryColor
                                  : _grayColor,
                              fontFamily: AppConstants.fontFamily,
                              height: 1.5,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _buildNavItem(
                  context: context,
                  outlinePath: Assets.icons.outline.grid,
                  solidPath: Assets.icons.solid.grid,
                  label: NavigationConstants.navPond,
                  route: Routes.pond,
                  isActive: currentLocation == Routes.pond,
                ),
              ),
              Expanded(
                child: _buildNavItem(
                  context: context,
                  outlinePath: Assets.icons.outline.profile,
                  solidPath: Assets.icons.solid.profile,
                  label: NavigationConstants.navProfile,
                  route: Routes.profile,
                  isActive: currentLocation == Routes.profile,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a regular navigation item.
  Widget _buildNavItem({
    required BuildContext context,
    required String outlinePath,
    required String solidPath,
    required String label,
    required String route,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () => context.go(route),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // SVG Icon - use solid when active, outline when inactive
          // ColorFilter for tinting - exact Figma: 20x20px
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              isActive ? _primaryColor : _grayColor,
              BlendMode.srcIn,
            ),
            child: SvgPicture.asset(
              isActive ? solidPath : outlinePath,
              width: 20, // Fixed 20px
              height: 20, // Fixed 20px
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            child: Text(
              label,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: 12, // Fixed 12px
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? _primaryColor : _grayColor,
                fontFamily: AppConstants.fontFamily,
                height: 1.5,
                letterSpacing: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the Floating Action Button (FAB) for center docked position.
  /// This is a static method to be used in Scaffold's floatingActionButton.
  /// Exact Figma specs: 54x54px circle, icon 24px (or 30px if specified)
  static Widget buildFAB(BuildContext context) {
    return SizedBox(
      width: 54, // Fixed 54px
      height: 54, // Fixed 54px
      child: FloatingActionButton(
        onPressed: () => context.go(Routes.inputData),
        backgroundColor: _primaryColor,
        elevation: 4, // Fixed elevation
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: _whiteColor,
          size: 24, // Fixed 24px icon (standard FAB icon size)
        ),
      ),
    );
  }
}
