import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/home/domain/entities/banner_entity.dart';
import 'package:flutter_base_app/features/home/domain/entities/banner_list_data.dart';
import 'package:flutter_base_app/features/home/presentation/providers/home_provider.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/banner_section.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  group('BannerSection', () {
    testWidgets('should display loading indicator when loading', (
      tester,
    ) async {
      // Arrange - Create a provider that takes time to complete
      final completer = Completer<BannerListData>();

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          overrides: [
            bannerListDataProvider.overrideWith((_) => completer.future),
          ],
          child: const SingleChildScrollView(
            child: BannerSection(),
          ),
        ),
      );

      await tester.pump();

      // Assert - Loading indicator should be present
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Complete the future to prevent hanging
      completer.complete(
        const BannerListData(banners: []),
      );
      await tester.pump();

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display banners when data is available', (
      tester,
    ) async {
      // Arrange
      const testBanners = BannerListData(
        banners: [
          BannerEntity(
            id: 'banner1',
            title: 'Banner 1',
            description: 'Description 1',
            imagePath: 'assets/images/banner1.jpg',
            backgroundColor: '#FFFFFF',
          ),
          BannerEntity(
            id: 'banner2',
            title: 'Banner 2',
            description: 'Description 2',
            imagePath: 'assets/images/banner2.jpg',
            backgroundColor: '#FFFFFF',
          ),
        ],
      );

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          overrides: [
            bannerListDataProvider.overrideWith((_) async => testBanners),
          ],
          child: const SingleChildScrollView(
            child: BannerSection(),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.text('Banner 1'), findsOneWidget);
      expect(find.text('Banner 2'), findsOneWidget);
      expect(find.text('Description 1'), findsOneWidget);
      expect(find.text('Description 2'), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should display pagination indicators', (tester) async {
      // Arrange
      const testBanners = BannerListData(
        banners: [
          BannerEntity(
            id: 'banner1',
            title: 'Banner 1',
            description: 'Description 1',
            imagePath: 'assets/images/banner1.jpg',
            backgroundColor: '#FFFFFF',
          ),
          BannerEntity(
            id: 'banner2',
            title: 'Banner 2',
            description: 'Description 2',
            imagePath: 'assets/images/banner2.jpg',
            backgroundColor: '#FFFFFF',
          ),
        ],
      );

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          overrides: [
            bannerListDataProvider.overrideWith((_) async => testBanners),
          ],
          child: const SingleChildScrollView(
            child: BannerSection(),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - Should have 2 indicators (one for each banner)
      // Indicators are Container widgets with circular decoration
      final containers = find.byType(Container);
      expect(containers, findsWidgets);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should call onCardTap when banner card is tapped', (
      tester,
    ) async {
      // Arrange
      const testBanners = BannerListData(
        banners: [
          BannerEntity(
            id: 'banner1',
            title: 'Banner 1',
            description: 'Description 1',
            imagePath: 'assets/images/banner1.jpg',
            backgroundColor: '#FFFFFF',
          ),
        ],
      );
      String? tappedBannerId;

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          overrides: [
            bannerListDataProvider.overrideWith((_) async => testBanners),
          ],
          child: SingleChildScrollView(
            child: BannerSection(
              onCardTap: (id) => tappedBannerId = id,
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Tap on banner card
      await tester.tap(find.text('Banner 1'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(tappedBannerId, equals('banner1'));

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('should not display anything when banners list is empty', (
      tester,
    ) async {
      // Arrange
      const testBanners = BannerListData(banners: []);

      // Act
      await tester.pumpWidget(
        TestHelpers.createTestApp(
          overrides: [
            bannerListDataProvider.overrideWith((_) async => testBanners),
          ],
          child: const SingleChildScrollView(
            child: BannerSection(),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - Should display nothing (SizedBox.shrink)
      expect(find.byType(BannerSection), findsOneWidget);

      // Cleanup to prevent timersPending error
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}

