import 'package:flutter_base_app/design_system/theme/app_colors.dart';

/// Design constants for Lab Request feature.
///
/// Contains design tokens specific to Lab Request screens.
class LabRequestDesignConstants {
  // Private constructor to prevent instantiation
  LabRequestDesignConstants._();

  // Spacing
  /// Large spacing (24px)
  static const double spacingLarge = 24;

  /// Medium spacing (16px)
  static const double spacingMedium = 16;

  /// Small spacing (12px)
  static const double spacingSmall = 12;

  /// Extra small spacing (8px)
  static const double spacingXSmall = 8;

  // Screen Padding
  /// Horizontal padding for screen content
  static const double screenHorizontalPadding = 16;

  /// Vertical padding for screen content
  static const double screenVerticalPadding = 16;

  // Form Fields
  /// Border radius for form fields
  static const double fieldBorderRadius = 12;

  /// Height for form fields
  static const double fieldHeight = 48;

  /// Padding for form fields
  static const double fieldPadding = 12;

  // Radio Buttons
  /// Spacing between radio button options
  static const double radioSpacing = 8;

  /// Size of radio button
  static const double radioSize = 20;

  // Text Area
  /// Minimum height for text area
  static const double textAreaMinHeight = 100;

  /// Maximum height for text area
  static const double textAreaMaxHeight = 200;

  // Colors
  /// Background color for form
  static const backgroundColor = AppColors.white;

  /// Border color for form fields
  static const borderColor = AppColors.gray20;
}
