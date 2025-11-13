import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/home/domain/entities/banner_entity.dart';
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

  // Design tokens - exact Figma specs
  static const double _cardWidth = 300; // Figma: card width 300px (fixed)
  static const double _cardHeight =
      88; // Calculated: padding 12px*2 + image 52px + text space = 88px
  static const double _cardSpacing = 12; // Figma: gap between cards
  static const double _indicatorSpacing = 4; // Figma: gap between indicators
  static const double _indicatorSize = 6; // Figma: indicator dot size
  static const double _indicatorActiveSize = 6; // Active indicator size
  static const Color _indicatorActiveColor = AppColors.secondary; // Orange
  static const Color _indicatorInactiveColor = AppColors.gray20; // Gray/20
  static const double _peekWidth = 16; // Width of peek for next card

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannerListAsync = ref.watch(bannerListDataProvider);
    final scrollController = useScrollController();
    final currentPage = useState(0);

    useEffect(() {
      void onScroll() {
        if (!scrollController.hasClients) return;

        final scrollOffset = scrollController.offset;
        final newPage = (scrollOffset / (_cardWidth + _cardSpacing)).round();

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
              height: _cardHeight,
              child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(
                  left: 20, // Left padding for first card
                  right: _peekWidth + 20, // Right padding + peek width
                ),
                itemCount: banners.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index < banners.length - 1 ? _cardSpacing : 0,
                    ),
                    child: SizedBox(
                      width: _cardWidth,
                      child: BannerCard(
                        banner: banners[index],
                        onTap: () => onCardTap?.call(banners[index].id),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12), // Spacing between cards and indicators
            // Pagination indicators with horizontal padding
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
        height: _cardHeight + 12 + _indicatorSize,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => const SizedBox.shrink(),
      skipLoadingOnRefresh: false,
    );
  }

  static Widget _buildIndicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.only(right: _indicatorSpacing),
      width: isActive ? _indicatorActiveSize : _indicatorSize,
      height: _indicatorSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? _indicatorActiveColor : _indicatorInactiveColor,
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

  // Design tokens - exact Figma specs
  static const double _borderRadius = 12; // Figma: borderRadius 12px
  static const double _padding = 12; // Figma: padding 12px
  static const double _imageWidth = 52; // Figma: image width 52px
  static const double _imageHeight = 52; // Figma: image height 52px
  static const double _gap = 12; // Figma: gap 12px between image and text
  static const double _fontSizeTitle =
      14; // Figma: Body/Small/Bold - fontSize 14
  static const double _fontSizeDescription =
      12; // Figma: Label/Medium/Regular - fontSize 12
  static const double _lineHeightTitle =
      1.4285714285714286; // Figma: lineHeight 1.4285714285714286em
  static const double _lineHeightDescription = 1.5; // Figma: lineHeight 1.5em
  static const Color _borderColor = AppColors.gray20; // Border color Gray/20
  static const Color _titleColor = Color(0xFF2F2D2E); // Neutral/80
  static const Color _descriptionColor = Color(0xFF464445); // Neutral/50

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
          borderRadius: BorderRadius.circular(_borderRadius),
          border: Border.all(color: _borderColor),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(_borderRadius),
          splashColor: AppColors.gray20.withOpacity(0.3), // Ripple effect color
          highlightColor: AppColors.gray20.withOpacity(
            0.1,
          ), // Highlight color on tap
          child: Padding(
            padding: const EdgeInsets.all(_padding),
            child: Row(
              children: [
                // Image/Icon
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    banner.imagePath,
                    width: _imageWidth,
                    height: _imageHeight,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: _imageWidth,
                        height: _imageHeight,
                        decoration: BoxDecoration(
                          color: AppColors.gray05,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.image,
                          size: 40,
                          color: AppColors.gray70,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: _gap),
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
                          fontSize: _fontSizeTitle,
                          fontWeight: FontWeight.w700, // Bold
                          color: _titleColor,
                          fontFamily: AppConstants.fontFamily,
                          height: _lineHeightTitle,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        banner.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: _fontSizeDescription,
                          fontWeight: FontWeight.w400, // Regular
                          color: _descriptionColor,
                          fontFamily: AppConstants.fontFamily,
                          height: _lineHeightDescription,
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
