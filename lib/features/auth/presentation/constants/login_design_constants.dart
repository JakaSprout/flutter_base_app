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
  static const Color backgroundBlue = Color(0xFF122E7A);

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
