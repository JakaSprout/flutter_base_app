import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';

/// Design constants for Home feature.
///
/// Contains all design tokens (spacing, sizes, colors, etc.)
/// to avoid hardcoded values throughout the home feature.
class HomeDesignConstants {
  // Private constructor to prevent instantiation
  HomeDesignConstants._();

  // ==================== Screen Level ====================
  /// Section spacing between major sections
  static const double sectionSpacing = 24;

  /// Horizontal padding for screen content
  static const double screenHorizontalPadding = 20;

  // ==================== Header Section ====================
  /// Header icon size
  static const double headerIconSize = 24;

  /// Header spacing between icons
  static const double headerIconSpacing = 12;

  /// Header logo height
  static const double headerLogoHeight = 28;

  /// Header badge size for notification count
  static const double headerBadgeSize = 16;

  /// Header badge font size
  static const double headerBadgeFontSize = 10;

  /// Header badge color (red)
  static const Color headerBadgeColor = Color(0xFFD84639);

  /// Header tap area padding
  static const double headerTapPadding = 8;

  /// Header tap area border radius
  static const double headerTapBorderRadius = 20;

  // ==================== Banner Section ====================
  /// Banner card width
  static const double bannerCardWidth = 300;

  /// Banner card height
  static const double bannerCardHeight = 88;

  /// Banner card spacing
  static const double bannerCardSpacing = 12;

  /// Banner card border radius
  static const double bannerCardBorderRadius = 12;

  /// Banner card padding
  static const double bannerCardPadding = 12;

  /// Banner card image width
  static const double bannerCardImageWidth = 52;

  /// Banner card image height
  static const double bannerCardImageHeight = 52;

  /// Banner card gap between image and text
  static const double bannerCardGap = 12;

  /// Banner card image border radius
  static const double bannerCardImageBorderRadius = 8;

  /// Banner card image error icon size
  static const double bannerCardImageErrorIconSize = 40;

  /// Banner card title font size
  static const double bannerCardTitleFontSize = 14;

  /// Banner card description font size
  static const double bannerCardDescriptionFontSize = 12;

  /// Banner card title line height
  static const double bannerCardTitleLineHeight = 1.4285714285714286;

  /// Banner card description line height
  static const double bannerCardDescriptionLineHeight = 1.5;

  /// Banner card title color (Neutral/80)
  static const Color bannerCardTitleColor = Color(0xFF2F2D2E);

  /// Banner card description color (Neutral/50)
  static const Color bannerCardDescriptionColor = Color(0xFF464445);

  /// Banner card border color
  static const Color bannerCardBorderColor = AppColors.gray20;

  /// Banner indicator spacing
  static const double bannerIndicatorSpacing = 4;

  /// Banner indicator size
  static const double bannerIndicatorSize = 6;

  /// Banner indicator active size
  static const double bannerIndicatorActiveSize = 6;

  /// Banner indicator active color
  static const Color bannerIndicatorActiveColor = AppColors.secondary;

  /// Banner indicator inactive color
  static const Color bannerIndicatorInactiveColor = AppColors.gray20;

  /// Banner peek width (for next card preview)
  static const double bannerPeekWidth = 16;

  /// Banner spacing between cards and indicators
  static const double bannerCardsIndicatorsSpacing = 12;

  // ==================== Company Selection Section ====================
  /// Company selection label spacing
  static const double companySelectionLabelSpacing = 8;

  /// Company selection label font size
  static const double companySelectionLabelFontSize = 12;

  /// Company selection line height
  static const double companySelectionLineHeight = 1.5;

  // ==================== Dashboard Summary Section ====================
  /// Dashboard grid spacing
  static const double dashboardGridSpacing = 8;

  /// Dashboard card spacing
  static const double dashboardCardSpacing = 12;

  /// Dashboard card padding vertical
  static const double dashboardCardPaddingVertical = 12;

  /// Dashboard card padding horizontal
  static const double dashboardCardPaddingHorizontal = 16;

  /// Dashboard card border radius
  static const double dashboardCardBorderRadius = 12;

  /// Dashboard icon size
  static const double dashboardIconSize = 16;

  /// Dashboard spacing tiny
  static const double dashboardSpacingTiny = 4;

  /// Dashboard spacing small
  static const double dashboardSpacingSmall = 8;

  /// Dashboard title height (approximate)
  static const double dashboardTitleHeight = 18;

  /// Dashboard title width (approximate)
  static const double dashboardTitleWidth = 80;

  /// Dashboard value height (approximate)
  static const double dashboardValueHeight = 28;

  /// Dashboard value width (approximate)
  static const double dashboardValueWidth = 60;

  /// Dashboard subtitle height (approximate)
  static const double dashboardSubtitleHeight = 14;

  /// Dashboard subtitle width (approximate)
  static const double dashboardSubtitleWidth = 100;

  /// Dashboard card count (2x2 grid)
  static const int dashboardCardCount = 4;

  /// Dashboard max visible cards when collapsed
  static const int dashboardMaxVisibleCards = 4;

  /// Dashboard toggle button font size
  static const double dashboardToggleFontSize = 12;

  /// Dashboard toggle button line height
  static const double dashboardToggleLineHeight = 1.5;

  /// Dashboard toggle button icon size
  static const double dashboardToggleIconSize = 24;

  /// Dashboard toggle button spacing
  static const double dashboardToggleSpacing = 2;

  /// Dashboard toggle button border radius
  static const double dashboardToggleBorderRadius = 4;

  /// Dashboard toggle button padding horizontal
  static const double dashboardTogglePaddingHorizontal = 8;

  /// Dashboard toggle button padding vertical
  static const double dashboardTogglePaddingVertical = 4;

  /// Dashboard secondary color
  static const Color dashboardSecondaryColor = Color(0xFFFA6619);

  /// Dashboard animation duration (milliseconds)
  static const int dashboardAnimationDurationMs = 300;

  // ==================== Input Data Section ====================
  /// Input data grid spacing
  static const double inputDataGridSpacing = 8;

  /// Input data header spacing
  static const double inputDataHeaderSpacing = 24;

  /// Input data title font size
  static const double inputDataTitleFontSize = 16;

  /// Input data see all font size
  static const double inputDataSeeAllFontSize = 12;

  /// Input data line height
  static const double inputDataLineHeight = 1.5;

  /// Input data link border radius
  static const double inputDataLinkBorderRadius = 4;

  /// Input data link padding horizontal
  static const double inputDataLinkPaddingHorizontal = 4;

  /// Input data link padding vertical
  static const double inputDataLinkPaddingVertical = 2;

  // ==================== Pond List Section ====================
  /// Pond list header spacing
  static const double pondListHeaderSpacing = 24;

  /// Pond list item spacing
  static const double pondListItemSpacing = 12;

  /// Pond list title font size
  static const double pondListTitleFontSize = 16;

  /// Pond list count font size
  static const double pondListCountFontSize = 16;

  /// Pond list see all font size
  static const double pondListSeeAllFontSize = 12;

  /// Pond list line height
  static const double pondListLineHeight = 1.5;

  /// Pond list max visible items
  static const int pondListMaxVisibleItems = 8;

  /// Pond list count spacing
  static const double pondListCountSpacing = 4;

  /// Pond list link border radius
  static const double pondListLinkBorderRadius = 4;

  /// Pond list link padding horizontal
  static const double pondListLinkPaddingHorizontal = 4;

  /// Pond list link padding vertical
  static const double pondListLinkPaddingVertical = 2;

  // ==================== Typography ====================
  /// Common line height for body text
  static const double lineHeightBody = 1.5;

  /// Common line height for title text
  static const double lineHeightTitle = 1.4285714285714286;

  // ==================== Pond List Item ====================
  /// Pond list item border radius
  static const double pondListItemBorderRadius = 12;

  /// Pond list item padding horizontal
  static const double pondListItemPaddingHorizontal = 16;

  /// Pond list item padding vertical
  static const double pondListItemPaddingVertical = 12;

  /// Pond list item gap between name and ID
  static const double pondListItemGap = 8;

  /// Pond list item icon size
  static const double pondListItemIconSize = 24;

  /// Pond list item name font size
  static const double pondListItemNameFontSize = 14;

  /// Pond list item ID font size
  static const double pondListItemIdFontSize = 12;

  /// Pond list item line height
  static const double pondListItemLineHeight = 1.4;

  // ==================== Block Filter ====================
  /// Block filter spacing small
  static const double blockFilterSpacingSmall = 8;

  /// Block filter font size medium
  static const double blockFilterFontSizeMedium = 16;

  /// Block filter line height
  static const double blockFilterLineHeight = 1.5;

  // ==================== Colors ====================
  /// Secondary color (Orange)
  static const Color secondaryColor = Color(0xFFFA6619);

  /// Title color (Neutral/80)
  static const Color titleColor = Color(0xFF2F2D2E);

  /// Description color (Neutral/50)
  static const Color descriptionColor = Color(0xFF464445);
}
