import 'package:app_mobile_afms/design_system/theme/app_colors.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Status banner types for different notification states.
enum STPStatusBannerType {
  /// Information banner with blue styling.
  info,

  /// Success banner with green styling.
  success,
}

/// Status banner component for displaying notifications and feedback.
///
/// A banner component that displays information or success messages with
/// appropriate icons and colors. Extends Material Design 3 Card component.
///
/// Example:
/// ```dart
/// STPStatusBanner(
///   type: STPStatusBannerType.info,
///   child: Text('Pastikan semua data sudah benar'),
/// )
/// ```
///
/// ```dart
/// STPStatusBanner(
///   type: STPStatusBannerType.success,
///   child: Text('Data berhasil disimpan'),
/// )
/// ```
class STPStatusBanner extends StatelessWidget {
  const STPStatusBanner({
    required this.type,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.iconSize = 20,
    this.iconAssetOverride,
    this.backgroundColorOverride,
    this.borderColorOverride,
    super.key,
  });

  final STPStatusBannerType type;
  final Widget child;
  final EdgeInsets padding;
  final double iconSize;
  final String? iconAssetOverride;
  final Color? backgroundColorOverride;
  final Color? borderColorOverride;

  @override
  Widget build(BuildContext context) {
    final style = _STPStatusBannerStyle.fromType(type);
    final backgroundColor = backgroundColorOverride ?? style.backgroundColor;
    final borderColor = borderColorOverride ?? style.borderColor;
    final iconAsset = iconAssetOverride ?? style.iconAsset;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          SvgPicture.asset(iconAsset, width: iconSize, height: iconSize),
          const SizedBox(width: 8),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _STPStatusBannerStyle {
  const _STPStatusBannerStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.iconAsset,
  });

  factory _STPStatusBannerStyle.fromType(STPStatusBannerType type) {
    switch (type) {
      case STPStatusBannerType.success:
        return _STPStatusBannerStyle(
          backgroundColor: AppColors.successLight,
          borderColor: AppColors.success,
          iconAsset: Assets.icons.general.circleChecklist,
        );
      case STPStatusBannerType.info:
        return _STPStatusBannerStyle(
          backgroundColor: const Color(0xFFE6ECFF),
          borderColor: const Color(0xFFB5C3FF),
          iconAsset: Assets.icons.general.signInfo,
        );
    }
  }

  final Color backgroundColor;
  final Color borderColor;
  final String iconAsset;
}
