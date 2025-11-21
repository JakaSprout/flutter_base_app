import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Standard AppBar component for the application.
///
/// Extends Material 3 AppBar with consistent styling based on Figma design
/// system. Provides a reusable AppBar with:
/// - Centered title with bold, 16px font
/// - White background with gray divider
/// - No elevation or color changes on scroll
/// - Consistent styling across the app
/// - Custom back button using arrow-back.svg icon when navigating inward
///
/// Example:
/// ```dart
/// STPAppBar(
///   title: 'My Screen',
/// )
/// ```
///
/// With actions:
/// ```dart
/// STPAppBar(
///   title: 'My Screen',
///   actions: [
///     IconButton(
///       icon: Icon(Icons.search),
///       onPressed: () {},
///     ),
///   ],
/// )
/// ```
class STPAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a new instance of [STPAppBar].
  const STPAppBar({
    required this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    super.key,
  });

  /// Title text to display in the AppBar
  final String title;

  /// Optional list of widgets to display after the title
  final List<Widget>? actions;

  /// Optional leading widget (defaults to back button if
  /// [automaticallyImplyLeading] is true)
  final Widget? leading;

  /// Whether to automatically show a back button
  final bool automaticallyImplyLeading;

  // Design tokens
  static const double _titleFontSize = 16;
  static const double _dividerHeight = 1;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontSize: _titleFontSize,
          fontWeight: FontWeight.bold,
          color: AppColors.gray100,
          fontFamily: AppConstants.fontFamily,
        ),
      ),
      centerTitle: true,
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.gray100,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading:
          leading ??
          (automaticallyImplyLeading && Navigator.canPop(context)
              ? IconButton(
                  icon: SvgPicture.asset(
                    Assets.icons.general.arrowBack,
                    width: 24,
                    height: 24,
                    color: AppColors.gray70,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : null),
      actions: actions,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(_dividerHeight),
        child: Container(height: _dividerHeight, color: AppColors.gray20),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + _dividerHeight);
}
