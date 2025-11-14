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
  const HomeHeader({
    super.key,
    this.onRefresh,
    this.onNotificationTap,
    this.notificationCount,
  });

  /// Callback when refresh icon is tapped.
  final VoidCallback? onRefresh;

  /// Callback when notification icon is tapped.
  final VoidCallback? onNotificationTap;

  /// Number of unread notifications (optional, shows badge if > 0)
  final int? notificationCount;

  // Design tokens - using shared colors from design system
  static const Color _black = AppColors.black;

  // Widget-specific spacing constants
  static const double _iconSize = 24; // Figma: 24x24px
  static const double _spacingMedium = 12; // Figma: gap 12px between icons
  static const double _logoHeight = 28; // Figma: logo height 28px
  static const double _badgeSize = 16; // Badge size for notification count
  static const double _badgeFontSize = 10; // Font size for badge text
  static const Color _badgeColor = Color(
    0xFFD84639,
  ); // Red badge color (same as inputDataKematianIcon)

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
            // Notification Icon - with tap feedback and badge
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onNotificationTap,
                borderRadius: BorderRadius.circular(20), // Circular tap area
                child: Padding(
                  padding: const EdgeInsets.all(8), // Tap padding area
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ColorFiltered(
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
                      // Notification badge
                      if (notificationCount != null && notificationCount! > 0)
                        Positioned(
                          right: -4,
                          top: -4,
                          child: Container(
                            width: _badgeSize,
                            height: _badgeSize,
                            decoration: const BoxDecoration(
                              color: _badgeColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                notificationCount! > 9
                                    ? '9+'
                                    : '${notificationCount!}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: _badgeFontSize,
                                  fontWeight: FontWeight.w700,
                                  height: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
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
