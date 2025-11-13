import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Header section for Home screen.
///
/// Contains:
/// - STP logo (left)
/// - Refresh & notification icons (right)
class HomeHeader extends StatelessWidget {
  /// Creates a new instance of [HomeHeader].
  const HomeHeader({super.key, this.onRefresh, this.onNotificationTap});

  /// Callback when refresh icon is tapped.
  final VoidCallback? onRefresh;

  /// Callback when notification icon is tapped.
  final VoidCallback? onNotificationTap;

  // Design tokens - using shared colors from design system
  static const Color _black = AppColors.black;

  // Widget-specific spacing constants
  static const double _iconSize = 24; // Figma: 24x24px
  static const double _spacingMedium = 0;
  static const double _logoHeight = 28; // Figma: logo height 28px

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // STP Logo
        SvgPicture.asset(
          Assets.icons.general.logo,
          height: _logoHeight,
          placeholderBuilder: (context) => const SizedBox(
            height: _logoHeight,
            child: Icon(Icons.image, size: _logoHeight),
          ),
        ),
        // Icons Row
        Row(
          children: [
            // Refresh Icon - with tap feedback
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onRefresh,
                borderRadius: BorderRadius.circular(20), // Circular tap area
                child: Padding(
                  padding: const EdgeInsets.all(8), // Tap padding area
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      _black,
                      BlendMode.srcIn,
                    ),
                    child: SvgPicture.asset(
                      Assets.icons.outline.refresh,
                      width: _iconSize,
                      height: _iconSize,
                      placeholderBuilder: (context) => const Icon(
                        Icons.refresh,
                        size: _iconSize,
                        color: _black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: _spacingMedium,
            ), // Figma: gap 12px between icons
            // Notification Icon - with tap feedback
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onNotificationTap,
                borderRadius: BorderRadius.circular(20), // Circular tap area
                child: Padding(
                  padding: const EdgeInsets.all(8), // Tap padding area
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      _black,
                      BlendMode.srcIn,
                    ),
                    child: SvgPicture.asset(
                      Assets.icons.outline.notification,
                      width: _iconSize,
                      height: _iconSize,
                      placeholderBuilder: (context) => const Icon(
                        Icons.notifications_outlined,
                        size: _iconSize,
                        color: _black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
