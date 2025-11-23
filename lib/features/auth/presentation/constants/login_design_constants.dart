import 'package:app_mobile_afms/design_system/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Design constants for Login screen.
///
/// Contains all design tokens (spacing, sizes, colors, etc.)
/// to avoid hardcoded values throughout the login screen.
class LoginDesignConstants {
  // Private constructor to prevent instantiation
  LoginDesignConstants._();

  // Border Radius
  /// Card border radius
  static const double cardBorderRadius = 16;

  /// Input border radius
  static const double inputBorderRadius = 8;

  // Padding & Spacing
  /// Card padding
  static const double cardPadding = 24;

  /// Small spacing (8px)
  static const double spacingSmall = 8;

  /// Medium spacing (16px)
  static const double spacingMedium = 16;

  /// Large spacing (24px)
  static const double spacingLarge = 24;

  /// Extra large spacing (32px)
  static const double spacingXLarge = 32;

  // Sizes
  /// Logo height
  static const double logoHeight = 28;

  /// Button height
  static const double buttonHeight = 48;

  /// Loading indicator size
  static const double loadingIndicatorSize = 20;

  /// Loading indicator stroke width
  static const double loadingIndicatorStrokeWidth = 2;

  // Colors
  /// Background blue color (Primary color)
  /// Source: AppColors.primary
  static const Color backgroundBlue = AppColors.primary;

  /// Primary color
  /// Source: AppColors.primary
  static const Color primary = AppColors.primary;

  /// White color
  /// Source: AppColors.white
  static const Color white = AppColors.white;

  /// Gray 100 color
  /// Source: AppColors.gray100
  static const Color gray100 = AppColors.gray100;

  /// Gray 70 color
  /// Source: AppColors.gray70
  static const Color gray70 = AppColors.gray70;

  /// Gray 20 color
  /// Source: AppColors.gray20
  static const Color gray20 = AppColors.gray20;

  /// Overlay scrim color
  /// Source: AppColors.scrim
  static const Color overlayScrim = AppColors.scrim;

  /// Overlay indicator size
  static const double overlayIndicatorSize = 32;

  /// Overlay message text style
  static const TextStyle overlayMessageTextStyle = TextStyle(
    color: AppColors.white,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  // Input Padding
  /// Input content padding horizontal
  static const double inputPaddingHorizontal = 16;

  /// Input content padding vertical
  static const double inputPaddingVertical = 16;

  // Shadow
  /// Box shadow opacity
  static const double boxShadowOpacity = 0.1;

  /// Box shadow blur radius
  static const double boxShadowBlurRadius = 10;

  /// Box shadow offset Y
  static const double boxShadowOffsetY = 4;

  // Constraints
  /// Maximum card width
  static const double maxCardWidth = 400;
}
