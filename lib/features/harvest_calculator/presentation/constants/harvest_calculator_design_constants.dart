import 'package:app_mobile_afms/design_system/theme/app_colors.dart';
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
  static const double cardPadding = 12;

  /// Button height (56px)
  static const double buttonHeight = 56;

  /// Button height large (64px)
  static const double buttonHeightLarge = 64;

  /// Body font size (14px)
  static const double bodyFontSize = 14;

  /// Chart height (200px)
  static const double chartHeight = 200;

  // Icon Sizes
  /// Info icon size (16px)
  static const double infoIconSize = 16;

  /// Section indicator width (8px)
  static const double sectionIndicatorWidth = 8;

  /// Section indicator height (14px)
  static const double sectionIndicatorHeight = 14;

  /// Section header gap between indicator and title (12px)
  static const double sectionHeaderGap = 12;

  /// Section header gap between title and icon (8px)
  static const double sectionHeaderIconGap = 8;

  /// Legend item size (12px)
  static const double legendItemSize = 12;

  /// Legend item border radius (4px)
  static const double legendItemBorderRadius = 4;

  /// Legend item gap (6px)
  static const double legendItemGap = 6;

  /// Legend container border radius (12px)
  static const double legendContainerBorderRadius = 12;

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
  /// Source: AppColors.primary
  static const Color primaryBlue = AppColors.primary;

  /// Secondary orange color (Brand secondary)
  /// Source: AppColors.secondary
  static const Color secondaryOrange = AppColors.secondary;

  /// White color
  /// Source: AppColors.white
  static const Color white = AppColors.white;

  /// Black color
  /// Source: AppColors.black
  static const Color black = AppColors.black;

  /// Background white color
  /// Source: AppColors.white
  static const Color backgroundWhite = AppColors.white;

  /// Background gray color (Neutral/5)
  /// Source: AppColors.gray05
  static const Color backgroundGray = AppColors.gray05;

  /// Border gray color (Neutral/20)
  /// Source: AppColors.gray20
  static const Color borderGray = AppColors.gray20;

  /// Gray 20 color
  /// Source: AppColors.gray20
  static const Color gray20 = AppColors.gray20;

  /// Gray 60 color
  /// Source: AppColors.gray60
  static const Color gray60 = AppColors.gray60;

  /// Gray 70 color
  /// Source: AppColors.gray70
  static const Color gray70 = AppColors.gray70;

  /// Gray 100 color
  /// Source: AppColors.gray100
  static const Color gray100 = AppColors.gray100;

  /// Gray 40 color
  /// Source: AppColors.gray40
  static const Color gray40 = AppColors.gray40;

  /// Gray 05 color
  /// Source: AppColors.gray05
  static const Color gray05 = AppColors.gray05;

  /// Primary color
  /// Source: AppColors.primary
  static const Color primary = AppColors.primary;

  /// Primary text color (Neutral/90)
  /// Source: AppColors.textPrimary
  static const Color textPrimary = AppColors.textPrimary;

  /// Secondary text color (Neutral/50)
  /// Source: AppColors.textSecondary
  static const Color textSecondary = AppColors.textSecondary;

  /// Disabled field background color
  /// Source: AppColors.gray05
  static const Color disabledFieldBackgroundColor = AppColors.gray05;

  /// Disabled text color
  /// Source: AppColors.gray70
  static const Color disabledTextColor = AppColors.gray70;

  /// Error color (Destructive/60)
  /// Source: AppColors.error
  static const Color errorColor = AppColors.error;

  /// Error color (alias)
  /// Source: AppColors.error
  static const Color error = AppColors.error;

  /// Success color (Success/60)
  /// Source: AppColors.success
  static const Color successColor = AppColors.success;

  /// Success color (alias)
  /// Source: AppColors.success
  static const Color success = AppColors.success;

  /// Placeholder color (Neutral/40)
  /// Source: AppColors.gray60
  static const Color placeholderColor = AppColors.gray60;

  /// Action chip background color
  /// Source: AppColors.actionChipBackground
  static const Color actionChipBackgroundColor = AppColors.actionChipBackground;

  /// Simulation card icon background blue
  /// Source: AppColors.simulationCardIconBackgroundBlue
  static const Color simulationCardIconBackgroundBlue =
      AppColors.simulationCardIconBackgroundBlue;

  /// Simulation card icon background orange
  /// Source: AppColors.simulationCardIconBackgroundOrange
  static const Color simulationCardIconBackgroundOrange =
      AppColors.simulationCardIconBackgroundOrange;

  /// Divider color
  /// Source: AppColors.gray10
  static const Color dividerColor = AppColors.gray10;

  /// Success banner background color (Light green)
  /// Source: AppColors.successBannerBackground
  static const Color successBannerBackgroundColor =
      AppColors.successBannerBackground;

  /// Neutral/80 color (Dark gray)
  /// Source: AppColors.neutral80
  static const Color neutral80 = AppColors.neutral80;

  /// Neutral/50 color (Medium gray)
  /// Source: AppColors.neutral50
  static const Color neutral50 = AppColors.neutral50;

  /// Warning color (Orange)
  /// Source: AppColors.warning
  static const Color warningColor = AppColors.warning;

  /// Action chip background (Light gray)
  /// Source: AppColors.actionChipBackground
  static const Color actionChipBackground = AppColors.actionChipBackground;

  /// Light background gray
  /// Source: AppColors.lightBackgroundGray
  static const Color lightBackgroundGray = AppColors.lightBackgroundGray;

  /// Light background gray variant
  /// Source: AppColors.lightBackgroundGrayAlt
  static const Color lightBackgroundGrayAlt = AppColors.lightBackgroundGrayAlt;

  /// Blue background variant
  /// Source: AppColors.blueBackground
  static const Color blueBackground = AppColors.blueBackground;

  /// Light blue background
  /// Source: AppColors.lightBlueBackground
  static const Color lightBlueBackground = AppColors.lightBlueBackground;

  /// Border gray variant
  /// Source: AppColors.gray20
  static const Color borderGrayAlt = AppColors.gray20;

  /// Disabled text color variant
  /// Source: AppColors.gray70
  static const Color disabledTextColorAlt = AppColors.gray70;

  /// Blue accent color
  /// Source: AppColors.blueAccent
  static const Color blueAccent = AppColors.blueAccent;

  /// Orange accent color
  /// Source: AppColors.orangeAccent
  static const Color orangeAccent = AppColors.orangeAccent;

  /// Green accent color
  /// Source: AppColors.greenAccent
  static const Color greenAccent = AppColors.greenAccent;

  /// Dark blue accent color
  /// Source: AppColors.darkBlueAccent
  static const Color darkBlueAccent = AppColors.darkBlueAccent;

  // Chart Colors - Loan Analysis
  /// Chart purple color for Total Cost Needs
  /// Source: AppColors.chartPurple
  static const Color chartPurple = AppColors.chartPurple;

  /// Chart blue-500 color for Loan Ceiling Taken
  /// Source: AppColors.chartBlue500
  static const Color chartBlue500 = AppColors.chartBlue500;

  /// Chart blue-300 color for Remaining Credit
  /// Source: AppColors.chartBlue300
  static const Color chartBlue300 = AppColors.chartBlue300;

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
  static const double emptyStateIconSize = 129;

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
