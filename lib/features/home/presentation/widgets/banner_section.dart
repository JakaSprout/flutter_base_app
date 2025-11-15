import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/home/domain/entities/banner_entity.dart';
import 'package:flutter_base_app/features/home/presentation/constants/home_design_constants.dart';
import 'package:flutter_base_app/features/home/presentation/providers/home_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Banner section for Home screen.
///
/// Displays horizontal scrollable cards with pagination indicators.
class BannerSection extends HookConsumerWidget {
  /// Creates a new instance of [BannerSection].
  const BannerSection({super.key, this.onCardTap});

  /// Callback when a card is tapped.
  /// Receives the card ID as parameter.
  final ValueChanged<String>? onCardTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannerListAsync = ref.watch(bannerListDataProvider);
    final scrollController = useScrollController();
    final currentPage = useState(0);

    useEffect(() {
      void onScroll() {
        if (!scrollController.hasClients) return;

        final scrollOffset = scrollController.offset;
        final newPage =
            (scrollOffset /
                    (HomeDesignConstants.bannerCardWidth +
                        HomeDesignConstants.bannerCardSpacing))
                .round();

        bannerListAsync.whenData((data) {
          final cardsLength = data.banners.length;
          if (newPage != currentPage.value &&
              newPage >= 0 &&
              newPage < cardsLength) {
            currentPage.value = newPage;
          }
        });
      }

      scrollController.addListener(onScroll);
      return () {
        scrollController.removeListener(onScroll);
      };
    }, [scrollController]);

    return bannerListAsync.when(
      data: (data) {
        final banners = data.banners;

        if (banners.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Horizontal scrollable cards with peek
            // Use negative margin to allow full scroll to left edge
            SizedBox(
              height: HomeDesignConstants.bannerCardHeight,
              child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(
                  left: HomeDesignConstants.screenHorizontalPadding,
                  right:
                      HomeDesignConstants.bannerPeekWidth +
                      HomeDesignConstants.screenHorizontalPadding,
                ),
                itemCount: banners.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index < banners.length - 1
                          ? HomeDesignConstants.bannerCardSpacing
                          : 0,
                    ),
                    child: SizedBox(
                      width: HomeDesignConstants.bannerCardWidth,
                      child: BannerCard(
                        banner: banners[index],
                        onTap: () => onCardTap?.call(banners[index].id),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: HomeDesignConstants.bannerCardsIndicatorsSpacing,
            ),
            // Pagination indicators with horizontal padding
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: HomeDesignConstants.screenHorizontalPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  banners.length,
                  (index) => _buildIndicator(index == currentPage.value),
                ),
              ),
            ),
          ],
        );
      },
      loading: () => const SizedBox(
        height:
            HomeDesignConstants.bannerCardHeight +
            HomeDesignConstants.bannerCardsIndicatorsSpacing +
            HomeDesignConstants.bannerIndicatorSize,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => const SizedBox.shrink(),
      skipLoadingOnRefresh: false,
    );
  }

  static Widget _buildIndicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.only(
        right: HomeDesignConstants.bannerIndicatorSpacing,
      ),
      width: isActive
          ? HomeDesignConstants.bannerIndicatorActiveSize
          : HomeDesignConstants.bannerIndicatorSize,
      height: HomeDesignConstants.bannerIndicatorSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? HomeDesignConstants.bannerIndicatorActiveColor
            : HomeDesignConstants.bannerIndicatorInactiveColor,
      ),
    );
  }
}

/// Banner Card widget.
class BannerCard extends StatelessWidget {
  /// Creates a new instance of [BannerCard].
  const BannerCard({required this.banner, super.key, this.onTap});

  /// Banner entity data
  final BannerEntity banner;

  /// Callback when card is tapped
  final VoidCallback? onTap;

  /// Convert hex color string to Color
  static Color _hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    }
    return AppColors.white; // Default to white if invalid
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _hexToColor(banner.backgroundColor);

    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
            HomeDesignConstants.bannerCardBorderRadius,
          ),
          border: Border.all(color: HomeDesignConstants.bannerCardBorderColor),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(
            HomeDesignConstants.bannerCardBorderRadius,
          ),
          splashColor: AppColors.gray20.withOpacity(0.3),
          highlightColor: AppColors.gray20.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(
              HomeDesignConstants.bannerCardPadding,
            ),
            child: Row(
              children: [
                // Image/Icon
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    HomeDesignConstants.bannerCardImageBorderRadius,
                  ),
                  child: Image.asset(
                    banner.imagePath,
                    width: HomeDesignConstants.bannerCardImageWidth,
                    height: HomeDesignConstants.bannerCardImageHeight,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: HomeDesignConstants.bannerCardImageWidth,
                        height: HomeDesignConstants.bannerCardImageHeight,
                        decoration: BoxDecoration(
                          color: AppColors.gray05,
                          borderRadius: BorderRadius.circular(
                            HomeDesignConstants.bannerCardImageBorderRadius,
                          ),
                        ),
                        child: const Icon(
                          Icons.image,
                          size:
                              HomeDesignConstants.bannerCardImageErrorIconSize,
                          color: AppColors.gray70,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: HomeDesignConstants.bannerCardGap),
                // Title and Description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        banner.title,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: HomeDesignConstants.bannerCardTitleFontSize,
                          fontWeight: FontWeight.w700,
                          color: HomeDesignConstants.titleColor,
                          fontFamily: AppConstants.fontFamily,
                          height: HomeDesignConstants.bannerCardTitleLineHeight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: HomeDesignConstants.dashboardSpacingTiny,
                      ),
                      Text(
                        banner.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize:
                              HomeDesignConstants.bannerCardDescriptionFontSize,
                          fontWeight: FontWeight.w400,
                          color: HomeDesignConstants.descriptionColor,
                          fontFamily: AppConstants.fontFamily,
                          height: HomeDesignConstants
                              .bannerCardDescriptionLineHeight,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
