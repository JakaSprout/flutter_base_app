import 'package:flutter/material.dart';
import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/design_system/theme/app_colors.dart';

/// Information banner component.
///
/// Displays an informational message with an icon in a light blue background.
/// Used to show helpful information or tips to users.
///
/// Example:
/// ```dart
/// STPInfoBanner(
///   message: 'Kisaran Optimal Suhu 26°C - 32°C',
/// )
/// ```
class STPInfoBanner extends StatelessWidget {
  /// Creates a new instance of [STPInfoBanner].
  const STPInfoBanner({required this.message, super.key});

  /// Message text to display
  final String message;

  // Design tokens
  static const double _iconSize = 20;
  static const double _borderRadius = 12;
  static const double _padding = 12;
  static const double _gap = 8;
  static const double _fontSize = 12;
  static const double _lineHeight = 1.4;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_padding),
      decoration: BoxDecoration(
        color: AppColors.infoLight,
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Row(
        children: [
          // Info icon
          Container(
            width: _iconSize,
            height: _iconSize,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.info, size: 14, color: AppColors.white),
          ),
          const SizedBox(width: _gap),
          // Message text
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: _fontSize,
                fontWeight: FontWeight.w400,
                color: AppColors.primary,
                fontFamily: AppConstants.fontFamily,
                height: _lineHeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
