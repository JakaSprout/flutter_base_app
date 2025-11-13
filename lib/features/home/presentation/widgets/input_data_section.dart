import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/design_system/components/cards/stp_input_data_item.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/home/presentation/constants/home_constants.dart';
import 'package:flutter_base_app/gen/assets.gen.dart';
import 'package:go_router/go_router.dart';

/// Input Data section for Home screen.
///
/// Displays a grid of 8 input data categories (2 rows x 4 columns)
/// with a header containing title and "Lihat Semua" link.
class InputDataSection extends StatelessWidget {
  /// Creates a new instance of [InputDataSection].
  const InputDataSection({super.key, this.onSeeAllTap, this.onItemTap});

  /// Callback when "Lihat Semua" is tapped
  final VoidCallback? onSeeAllTap;

  /// Callback when an item is tapped
  /// Receives the item label as parameter
  final ValueChanged<String>? onItemTap;

  // Design tokens - exact Figma specs
  static const double _gridSpacing = 8; // Figma: gap 8px
  static const double _headerSpacing = 24;
  static const double _fontSizeTitle =
      16; // Figma: Body/Small/Medium/Semibold - fontSize 16
  static const double _fontSizeSeeAll =
      12; // Figma: Label/Medium/Semibold - fontSize 12
  static const double _lineHeight = 1.5; // Figma: lineHeight 1.5em

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header: Title and "Lihat Semua" link
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Title
            Text(
              HomeConstants.inputDataSectionTitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: _fontSizeTitle,
                fontWeight: FontWeight.w600, // Semibold
                color: AppColors.gray100,
                fontFamily: AppConstants.fontFamily,
                height: _lineHeight,
              ),
            ),
            // "Lihat Semua" link with tap feedback
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap:
                    onSeeAllTap ??
                    () {
                      context.go('/input-data');
                    },
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  child: Text(
                    HomeConstants.inputDataSeeAllLabel,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: _fontSizeSeeAll,
                      fontWeight: FontWeight.w600, // Semibold
                      color: AppColors.secondary, // Secondary/60 (Base)
                      fontFamily: AppConstants.fontFamily,
                      height: _lineHeight,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: _headerSpacing),
        // Grid 2x4
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  // Row 1
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      STPInputDataItem(
                        iconPath: Assets.icons.general.feed,
                        label: HomeConstants.inputDataPakan,
                        backgroundColor: AppColors.inputDataPakanBg,
                        iconColor: AppColors.inputDataPakanIcon,
                        onTap: () =>
                            onItemTap?.call(HomeConstants.inputDataPakan),
                      ),
                      STPInputDataItem(
                        iconPath: Assets.icons.general.waterQuality,
                        label: HomeConstants.inputDataKualitasAir,
                        backgroundColor: AppColors.inputDataKualitasAirBg,
                        iconColor: AppColors.inputDataKualitasAirIcon,
                        onTap: () =>
                            onItemTap?.call(HomeConstants.inputDataKualitasAir),
                      ),
                      STPInputDataItem(
                        iconPath: Assets.icons.general.growth,
                        label: HomeConstants.inputDataPertumbuhan,
                        backgroundColor: AppColors.inputDataPertumbuhanBg,
                        iconColor: AppColors.inputDataPertumbuhanIcon,
                        onTap: () =>
                            onItemTap?.call(HomeConstants.inputDataPertumbuhan),
                      ),
                      STPInputDataItem(
                        iconPath: Assets.icons.general.chemistry,
                        label: HomeConstants.inputDataKimia,
                        backgroundColor: AppColors.inputDataKimiaBg,
                        iconColor: AppColors.inputDataKimiaIcon,
                        onTap: () =>
                            onItemTap?.call(HomeConstants.inputDataKimia),
                      ),
                    ],
                  ),
                  const SizedBox(height: _gridSpacing),
                  // Row 2
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      STPInputDataItem(
                        iconPath: Assets.icons.general.microscope,
                        label: HomeConstants.inputDataPlankton,
                        backgroundColor: AppColors.inputDataPlanktonBg,
                        iconColor: AppColors.inputDataPlanktonIcon,
                        onTap: () =>
                            onItemTap?.call(HomeConstants.inputDataPlankton),
                      ),
                      STPInputDataItem(
                        iconPath: Assets.icons.general.microbiology,
                        label: HomeConstants.inputDataMikrobiologi,
                        backgroundColor: AppColors.inputDataMikrobiologiBg,
                        iconColor: AppColors.inputDataMikrobiologiIcon,
                        onTap: () => onItemTap?.call(
                          HomeConstants.inputDataMikrobiologi,
                        ),
                      ),
                      STPInputDataItem(
                        iconPath: Assets.icons.general.disease,
                        label: HomeConstants.inputDataPenyakit,
                        backgroundColor: AppColors.inputDataPenyakitBg,
                        iconColor: AppColors.inputDataPenyakitIcon,
                        onTap: () =>
                            onItemTap?.call(HomeConstants.inputDataPenyakit),
                      ),
                      STPInputDataItem(
                        iconPath: Assets.icons.general.mortality,
                        label: HomeConstants.inputDataKematian,
                        backgroundColor: AppColors.inputDataKematianBg,
                        iconColor: AppColors.inputDataKematianIcon,
                        onTap: () =>
                            onItemTap?.call(HomeConstants.inputDataKematian),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
