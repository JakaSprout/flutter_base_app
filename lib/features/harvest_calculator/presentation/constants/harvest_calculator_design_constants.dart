import 'package:flutter/material.dart';

/// Design constants for Harvest Calculator feature.
///
/// Contains all design tokens (spacing, sizes, colors, etc.)
/// to avoid hardcoded values throughout the harvest calculator screens.
class HarvestCalculatorDesignConstants {
  // Private constructor to prevent instantiation
  HarvestCalculatorDesignConstants._();

  // Border Radius
  /// Card border radius
  static const double cardBorderRadius = 16;

  /// Input border radius
  static const double inputBorderRadius = 8;

  /// Button border radius
  static const double buttonBorderRadius = 8;

  // Spacing
  /// Small spacing (4px)
  static const double spacing4 = 4;

  /// Medium spacing (8px)
  static const double spacing8 = 8;

  /// Large spacing (12px)
  static const double spacing12 = 12;

  /// Extra large spacing (16px)
  static const double spacing16 = 16;

  /// Double extra large spacing (24px)
  static const double spacing24 = 24;

  /// Triple extra large spacing (32px)
  static const double spacing32 = 32;

  /// Screen padding horizontal (16px)
  static const double screenPaddingHorizontal = 16;

  /// Screen padding vertical (16px)
  static const double screenPaddingVertical = 16;

  /// Medium spacing (16px) - alias for spacing16
  static const double spacingMedium = 16;

  /// Small spacing (8px) - alias for spacing8
  static const double spacingSmall = 8;

  /// Extra small spacing (4px) - alias for spacing4
  static const double spacingXSmall = 4;

  /// Section spacing (24px)
  static const double sectionSpacing = 24;

  /// Card padding (16px)
  static const double cardPadding = 16;

  /// Button height (56px)
  static const double buttonHeight = 56;

  /// Button height large (64px)
  static const double buttonHeightLarge = 64;

  /// Body font size (14px)
  static const double bodyFontSize = 14;

  /// Chart height (200px)
  static const double chartHeight = 200;

  /// Input padding horizontal (16px)
  static const double inputPaddingHorizontal = 16;

  /// Input padding vertical (12px)
  static const double inputPaddingVertical = 12;

  // Font Sizes
  /// Extra small font size (10px)
  static const double fontSize10 = 10;

  /// Small font size (12px)
  static const double fontSize12 = 12;

  /// Medium font size (14px)
  static const double fontSize14 = 14;

  /// Large font size (16px)
  static const double fontSize16 = 16;

  /// Extra large font size (18px)
  static const double fontSize18 = 18;

  /// Double extra large font size (20px)
  static const double fontSize20 = 20;

  /// Triple extra large font size (24px)
  static const double fontSize24 = 24;

  // Font Weights
  /// Regular font weight (400)
  static const FontWeight fontWeightRegular = FontWeight.w400;

  /// Medium font weight (500)
  static const FontWeight fontWeightMedium = FontWeight.w500;

  /// Semibold font weight (600)
  static const FontWeight fontWeightSemibold = FontWeight.w600;

  /// Bold font weight (700)
  static const FontWeight fontWeightBold = FontWeight.w700;

  // Colors
  /// Primary blue color (Brand primary)
  static const Color primaryBlue = Color(0xFF122E7A);

  /// Secondary orange color (Brand secondary)
  static const Color secondaryOrange = Color(0xFFFA6619);

  /// Background white color
  static const Color backgroundWhite = Color(0xFFFFFFFF);

  /// Background gray color (Neutral/5)
  static const Color backgroundGray = Color(0xFFF5F5F5);

  /// Border gray color (Neutral/20)
  static const Color borderGray = Color(0xFFE3E3E3);

  /// Primary text color (Neutral/90)
  static const Color textPrimary = Color(0xFF1E1E1E);

  /// Secondary text color (Neutral/50)
  static const Color textSecondary = Color(0xFF464445);

  /// Disabled field background color
  static const Color disabledFieldBackgroundColor = Color(0xFFF5F5F5);

  /// Disabled text color
  static const Color disabledTextColor = Color(0xFF6D6D6D);

  /// Error color (Destructive/60)
  static const Color errorColor = Color(0xFFD84639);

  /// Success color (Success/60)
  static const Color successColor = Color(0xFF1BAA69);

  /// Placeholder color (Neutral/40)
  static const Color placeholderColor = Color(0xFF8A8A8A);

  /// Action chip background color
  static const Color actionChipBackgroundColor = Color(0xFFF7F7F7);

  /// Simulation card icon background blue
  static const Color simulationCardIconBackgroundBlue = Color(0xFFE7ECFA);

  /// Simulation card icon background orange
  static const Color simulationCardIconBackgroundOrange = Color(0xFFFFF4E6);

  /// Divider color
  static const Color dividerColor = Color(0xFFEBEBEB);

  /// Success banner background color (Light green)
  static const Color successBannerBackgroundColor = Color(0xFFD7F5DF);

  /// Neutral/80 color (Dark gray)
  static const Color neutral80 = Color(0xFF2F2D2E);

  /// Neutral/50 color (Medium gray)
  static const Color neutral50 = Color(0xFF464445);

  /// Warning color (Orange)
  static const Color warningColor = Color(0xFFFDBA74);

  /// Action chip background (Light gray)
  static const Color actionChipBackground = Color(0xFFF7F7F7);

  /// Light background gray
  static const Color lightBackgroundGray = Color(0xFFF4F4F4);

  /// Light background gray variant
  static const Color lightBackgroundGrayAlt = Color(0xFFF4F4F6);

  /// Blue background variant
  static const Color blueBackground = Color(0xFFE6ECFF);

  /// Light blue background
  static const Color lightBlueBackground = Color(0xFFE3F2FD);

  /// Border gray variant
  static const Color borderGrayAlt = Color(0xFFE3E3E3);

  /// Disabled text color variant
  static const Color disabledTextColorAlt = Color(0xFF6D6D6D);

  /// Blue accent color
  static const Color blueAccent = Color(0xFF60A5FA);

  /// Orange accent color
  static const Color orangeAccent = Color(0xFFF97316);

  /// Green accent color
  static const Color greenAccent = Color(0xFF22C55E);

  /// Dark blue accent color
  static const Color darkBlueAccent = Color(0xFF1D4ED8);

  // Text Styles
  /// Card title text style (18px, Bold)
  static const TextStyle cardTitleTextStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: fontSize18,
    fontWeight: fontWeightBold,
    color: textPrimary,
  );

  /// Body text style (14px, Regular)
  static const TextStyle bodyTextStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: fontSize14,
    fontWeight: fontWeightRegular,
    color: textPrimary,
  );

  /// Body secondary text style (14px, Regular, Secondary color)
  static const TextStyle bodyTextSecondaryStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: fontSize14,
    fontWeight: fontWeightRegular,
    color: textSecondary,
  );

  /// Small text style (12px, Regular)
  static const TextStyle smallTextStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: fontSize12,
    fontWeight: fontWeightRegular,
    color: textPrimary,
  );

  /// Small secondary text style (12px, Regular, Secondary color)
  static const TextStyle smallTextSecondaryStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: fontSize12,
    fontWeight: fontWeightRegular,
    color: textSecondary,
  );

  /// Button text style (14px, Semibold)
  static const TextStyle buttonTextStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: fontSize14,
    fontWeight: fontWeightSemibold,
    color: textPrimary,
  );

  /// Form label text style (14px, Regular)
  static const TextStyle formLabelTextStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: fontSize14,
    fontWeight: fontWeightRegular,
    color: textPrimary,
  );

  /// Section title text style (16px, Bold)
  static const TextStyle sectionTitleTextStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: fontSize16,
    fontWeight: fontWeightBold,
    color: textPrimary,
  );

  /// Medium bold text style (14px, Bold)
  static const TextStyle bodyMediumBoldTextStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: fontSize14,
    fontWeight: fontWeightBold,
    color: textPrimary,
  );

  /// Label medium regular text style (12px, Regular)
  static const TextStyle labelMediumRegularTextStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: fontSize12,
    fontWeight: fontWeightRegular,
    color: textPrimary,
  );

  /// Card title text style (16px, Bold)
  static const TextStyle cardTitleTextStyle16 = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: fontSize16,
    fontWeight: fontWeightBold,
    color: textPrimary,
  );

  /// Label text style (14px, Regular)
  static const TextStyle labelTextStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: fontSize14,
    fontWeight: fontWeightRegular,
    color: textPrimary,
  );

  /// Title medium bold text style (18px, Bold)
  static const TextStyle titleMediumBoldTextStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: fontSize18,
    fontWeight: fontWeightBold,
    color: textPrimary,
  );

  /// Body medium bold text style (14px, Bold)
  static const TextStyle bodyMediumBoldTextStyle14 = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: fontSize14,
    fontWeight: fontWeightBold,
    color: textPrimary,
  );

  /// Placeholder text style (14px, Regular, Placeholder color)
  static const TextStyle placeholderTextStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: fontSize14,
    fontWeight: fontWeightRegular,
    color: placeholderColor,
  );

  /// Form field text style (14px, Regular)
  static const TextStyle formFieldTextStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: fontSize14,
    fontWeight: fontWeightRegular,
    color: textPrimary,
  );

  /// Form error text style (12px, Regular, Error color)
  static const TextStyle formErrorTextStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: fontSize12,
    fontWeight: fontWeightRegular,
    color: errorColor,
  );

  /// Label text secondary style (12px, Regular, Secondary color)
  static const TextStyle labelTextSecondaryStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: fontSize12,
    fontWeight: fontWeightRegular,
    color: textSecondary,
  );

  /// Form field placeholder text style (14px, Regular, Placeholder color)
  static const TextStyle formFieldPlaceholderTextStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: fontSize14,
    fontWeight: fontWeightRegular,
    color: placeholderColor,
  );

  /// Search field border color
  static const Color searchFieldBorderColor = borderGray;

  /// Empty state icon size (64px)
  static const double emptyStateIconSize = 64;

  /// Empty state primary text style (16px, Bold)
  static const TextStyle emptyStatePrimaryTextStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: fontSize16,
    fontWeight: fontWeightBold,
    color: textPrimary,
  );

  /// Empty state secondary text style (14px, Regular)
  static const TextStyle emptyStateSecondaryTextStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: fontSize14,
    fontWeight: fontWeightRegular,
    color: textSecondary,
  );

  // Shadow
  /// Box shadow opacity
  static const double boxShadowOpacity = 0.1;

  /// Box shadow blur radius
  static const double boxShadowBlurRadius = 10;

  /// Box shadow offset
  static const Offset boxShadowOffset = Offset(0, 4);

  /// Box shadow offset Y (4px)
  static const double boxShadowOffsetY = 4;

  /// Box shadow color - computed at runtime
  static Color get boxShadowColor => Colors.black.withOpacity(boxShadowOpacity);

  /// Box shadow - computed at runtime
  static BoxShadow get boxShadow => BoxShadow(
    color: boxShadowColor,
    blurRadius: boxShadowBlurRadius,
    offset: boxShadowOffset,
  );
}
