import 'package:flutter/material.dart';
import 'package:app_mobile_afms/features/home/presentation/constants/home_design_constants.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';
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
  static const Color _black = HomeDesignConstants.black;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // STP Logo
        SvgPicture.asset(
          Assets.icons.general.logo,
          height: HomeDesignConstants.headerLogoHeight,
          placeholderBuilder: (context) => const SizedBox(
            height: HomeDesignConstants.headerLogoHeight,
            child: Icon(
              Icons.image,
              size: HomeDesignConstants.headerLogoHeight,
            ),
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
                borderRadius: BorderRadius.circular(
                  HomeDesignConstants.headerTapBorderRadius,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(
                    HomeDesignConstants.headerTapPadding,
                  ),
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      _black,
                      BlendMode.srcIn,
                    ),
                    child: SvgPicture.asset(
                      Assets.icons.outline.refresh,
                      width: HomeDesignConstants.headerIconSize,
                      height: HomeDesignConstants.headerIconSize,
                      placeholderBuilder: (context) => const Icon(
                        Icons.refresh,
                        size: HomeDesignConstants.headerIconSize,
                        color: _black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: HomeDesignConstants.headerIconSpacing),
            // Notification Icon - with tap feedback and badge
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onNotificationTap,
                borderRadius: BorderRadius.circular(
                  HomeDesignConstants.headerTapBorderRadius,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(
                    HomeDesignConstants.headerTapPadding,
                  ),
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
                          width: HomeDesignConstants.headerIconSize,
                          height: HomeDesignConstants.headerIconSize,
                          placeholderBuilder: (context) => const Icon(
                            Icons.notifications_outlined,
                            size: HomeDesignConstants.headerIconSize,
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
                            width: HomeDesignConstants.headerBadgeSize,
                            height: HomeDesignConstants.headerBadgeSize,
                            decoration: const BoxDecoration(
                              color: HomeDesignConstants.headerBadgeColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                notificationCount! > 9
                                    ? '9+'
                                    : '${notificationCount!}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      HomeDesignConstants.headerBadgeFontSize,
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
