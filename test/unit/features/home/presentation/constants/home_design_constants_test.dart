import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/home/presentation/constants/home_design_constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeDesignConstants', () {
    test('should have correct screen level constants', () {
      // Assert
      expect(HomeDesignConstants.sectionSpacing, equals(24));
      expect(HomeDesignConstants.screenHorizontalPadding, equals(20));
    });

    test('should have correct header section constants', () {
      // Assert
      expect(HomeDesignConstants.headerIconSize, equals(24));
      expect(HomeDesignConstants.headerIconSpacing, equals(12));
      expect(HomeDesignConstants.headerLogoHeight, equals(28));
      expect(HomeDesignConstants.headerBadgeSize, equals(16));
      expect(HomeDesignConstants.headerBadgeFontSize, equals(10));
      expect(HomeDesignConstants.headerBadgeColor, isA<Color>());
      expect(HomeDesignConstants.headerTapPadding, equals(8));
      expect(HomeDesignConstants.headerTapBorderRadius, equals(20));
    });

    test('should have correct banner section constants', () {
      // Assert
      expect(HomeDesignConstants.bannerCardWidth, equals(300));
      expect(HomeDesignConstants.bannerCardHeight, equals(88));
      expect(HomeDesignConstants.bannerCardSpacing, equals(12));
      expect(HomeDesignConstants.bannerCardBorderRadius, equals(12));
      expect(HomeDesignConstants.bannerCardPadding, equals(12));
      expect(HomeDesignConstants.bannerCardImageWidth, equals(52));
      expect(HomeDesignConstants.bannerCardImageHeight, equals(52));
      expect(HomeDesignConstants.bannerCardGap, equals(12));
      expect(HomeDesignConstants.bannerCardImageBorderRadius, equals(8));
      expect(HomeDesignConstants.bannerCardImageErrorIconSize, equals(40));
    });

    test('should have correct banner typography constants', () {
      // Assert
      expect(HomeDesignConstants.bannerCardTitleFontSize, equals(14));
      expect(HomeDesignConstants.bannerCardDescriptionFontSize, equals(12));
      expect(HomeDesignConstants.bannerCardTitleLineHeight, equals(1.4285714285714286));
      expect(HomeDesignConstants.bannerCardDescriptionLineHeight, equals(1.5));
      expect(HomeDesignConstants.bannerCardTitleColor, isA<Color>());
      expect(HomeDesignConstants.bannerCardDescriptionColor, isA<Color>());
    });

    test('should have correct banner indicator constants', () {
      // Assert
      expect(HomeDesignConstants.bannerIndicatorSpacing, equals(4));
      expect(HomeDesignConstants.bannerIndicatorSize, equals(6));
      expect(HomeDesignConstants.bannerIndicatorActiveSize, equals(6));
      expect(HomeDesignConstants.bannerIndicatorActiveColor, isA<Color>());
      expect(HomeDesignConstants.bannerIndicatorInactiveColor, isA<Color>());
      expect(HomeDesignConstants.bannerPeekWidth, equals(16));
      expect(HomeDesignConstants.bannerCardsIndicatorsSpacing, equals(12));
    });

    test('should have correct company selection constants', () {
      // Assert
      expect(HomeDesignConstants.companySelectionLabelSpacing, equals(8));
      expect(HomeDesignConstants.companySelectionLabelFontSize, equals(12));
      expect(HomeDesignConstants.companySelectionLineHeight, equals(1.5));
    });

    test('should have correct dashboard summary constants', () {
      // Assert
      expect(HomeDesignConstants.dashboardGridSpacing, equals(8));
      expect(HomeDesignConstants.dashboardCardSpacing, equals(12));
      expect(HomeDesignConstants.dashboardCardPaddingVertical, equals(12));
      expect(HomeDesignConstants.dashboardCardPaddingHorizontal, equals(16));
      expect(HomeDesignConstants.dashboardCardBorderRadius, equals(12));
      expect(HomeDesignConstants.dashboardIconSize, equals(16));
      expect(HomeDesignConstants.dashboardCardCount, equals(4));
      expect(HomeDesignConstants.dashboardMaxVisibleCards, equals(4));
    });

    test('should have correct pond list constants', () {
      // Assert
      expect(HomeDesignConstants.pondListHeaderSpacing, equals(24));
      expect(HomeDesignConstants.pondListItemSpacing, equals(12));
      expect(HomeDesignConstants.pondListTitleFontSize, equals(16));
      expect(HomeDesignConstants.pondListCountFontSize, equals(16));
      expect(HomeDesignConstants.pondListSeeAllFontSize, equals(12));
      expect(HomeDesignConstants.pondListLineHeight, equals(1.5));
      expect(HomeDesignConstants.pondListMaxVisibleItems, equals(8));
    });

    test('should have correct typography constants', () {
      // Assert
      expect(HomeDesignConstants.lineHeightBody, equals(1.5));
      expect(HomeDesignConstants.lineHeightTitle, equals(1.4285714285714286));
    });

    test('should have correct color constants', () {
      // Assert
      expect(HomeDesignConstants.secondaryColor, isA<Color>());
      expect(HomeDesignConstants.titleColor, isA<Color>());
      expect(HomeDesignConstants.descriptionColor, isA<Color>());
    });
  });
}

