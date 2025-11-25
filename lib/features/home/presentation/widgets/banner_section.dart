import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/features/home/domain/entities/banner_entity.dart';
import 'package:app_mobile_afms/features/home/presentation/constants/home_design_constants.dart';
import 'package:app_mobile_afms/features/home/presentation/providers/home_provider.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Banner section for Home screen.
///
/// Displays vertical list of cards with a gray background.
class BannerSection extends ConsumerWidget {
  /// Creates a new instance of [BannerSection].
  const BannerSection({super.key, this.onCardTap});

  /// Callback when a card is tapped.
  /// Receives the card ID as parameter.
  final ValueChanged<String>? onCardTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannerListAsync = ref.watch(bannerListDataProvider);

    return bannerListAsync.when(
      data: (data) {
        final banners = data.banners;

        if (banners.isEmpty) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: HomeDesignConstants.screenHorizontalPadding,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: HomeDesignConstants.gray05,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: List.generate(banners.length, (index) {
                final banner = banners[index];
                final isLast = index == banners.length - 1;

                return Column(
                  children: [
                    BannerCard(
                      banner: banner,
                      onTap: () => onCardTap?.call(banner.id),
                    ),
                    if (!isLast)
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: HomeDesignConstants.gray20,
                      ),
                  ],
                );
              }),
            ),
          ),
        );
      },
      loading: () => const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => const SizedBox.shrink(),
      skipLoadingOnRefresh: false,
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

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Image/Icon
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  banner.imagePath,
                  width: 52,
                  height: 52,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: HomeDesignConstants.gray05,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.image,
                        size: 24,
                        color: HomeDesignConstants.gray70,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
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
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: HomeDesignConstants.titleColor,
                        fontFamily: AppConstants.fontFamily,
                        height: 1.4,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      banner.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: HomeDesignConstants.descriptionColor,
                        fontFamily: AppConstants.fontFamily,
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SvgPicture.asset(
                Assets.icons.general.arrowRight,
                width: 24,
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
