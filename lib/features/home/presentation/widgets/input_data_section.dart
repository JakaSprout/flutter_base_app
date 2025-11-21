import 'package:flutter/material.dart';
import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/design_system/components/cards/stp_input_data_item.dart';
import 'package:app_mobile_afms/features/home/presentation/constants/home_constants.dart';
import 'package:app_mobile_afms/features/home/presentation/constants/home_design_constants.dart';
import 'package:app_mobile_afms/features/home/presentation/providers/home_provider.dart';
import 'package:app_mobile_afms/features/home/presentation/widgets/shimmer_loaders/input_data_shimmer.dart';
import 'package:app_mobile_afms/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Input Data section for Home screen.
///
/// Displays a grid of input data categories (2 rows x 4 columns)
/// with a header containing title and "Lihat Semua" link.
/// Items are ordered by the `order` field from API.
class InputDataSection extends HookConsumerWidget {
  /// Creates a new instance of [InputDataSection].
  const InputDataSection({super.key, this.onSeeAllTap, this.onItemTap});

  /// Callback when "Lihat Semua" is tapped
  final VoidCallback? onSeeAllTap;

  /// Callback when an item is tapped
  /// Receives the item label as parameter
  final ValueChanged<String>? onItemTap;

  /// Convert hex color string to Color
  /// Supports formats: #RRGGBB, #AARRGGBB
  /// Format AARRGGBB: AA = alpha, RR = red, GG = green, BB = blue
  static Color _hexToColor(String hexString) {
    final cleanHex = hexString.replaceFirst('#', '').toUpperCase();
    
    try {
      if (cleanHex.length == 6) {
        // Format: RRGGBB (no alpha, assume fully opaque)
        return Color(int.parse('FF$cleanHex', radix: 16));
      } else if (cleanHex.length == 8) {
        // Format: AARRGGBB (alpha first, then RGB)
        // Flutter Color uses AARRGGBB format
        return Color(int.parse(cleanHex, radix: 16));
      }
    } catch (e) {
      // If parsing fails, return default
      debugPrint('Failed to parse color: $hexString, error: $e');
    }
    
    return HomeDesignConstants.gray05; // Default if invalid
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputDataListAsync = ref.watch(inputDataListDataProvider);

    return inputDataListAsync.when(
      data: (data) {
        final items = data.items;
        if (items.isEmpty) {
          return const SizedBox.shrink();
        }

        // Split items into rows (4 items per row)
        final rows = <List<Widget>>[];
        for (var i = 0; i < items.length; i += 4) {
          final rowItems = items.skip(i).take(4).toList();
          rows.add(
            rowItems.map((item) {
              return STPInputDataItem(
                iconPath: item.iconPath,
                label: item.label,
                backgroundColor: _hexToColor(item.backgroundColor),
                iconColor: _hexToColor(item.iconColor),
                onTap: () => onItemTap?.call(item.label),
              );
            }).toList(),
          );
        }

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
                    fontSize: HomeDesignConstants.inputDataTitleFontSize,
                    fontWeight: FontWeight.w600,
                    color: HomeDesignConstants.gray100,
                    fontFamily: AppConstants.fontFamily,
                    height: HomeDesignConstants.inputDataLineHeight,
                  ),
                ),
                // "Lihat Semua" link with tap feedback
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap:
                        onSeeAllTap ??
                        () {
                          context.go(Routes.inputData);
                        },
                    borderRadius: BorderRadius.circular(
                      HomeDesignConstants.inputDataLinkBorderRadius,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal:
                            HomeDesignConstants.inputDataLinkPaddingHorizontal,
                        vertical:
                            HomeDesignConstants.inputDataLinkPaddingVertical,
                      ),
                      child: Text(
                        HomeConstants.inputDataSeeAllLabel,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontSize: HomeDesignConstants.inputDataSeeAllFontSize,
                          fontWeight: FontWeight.w600,
                          color: HomeDesignConstants.secondary,
                          fontFamily: AppConstants.fontFamily,
                          height: HomeDesignConstants.inputDataLineHeight,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: HomeDesignConstants.inputDataHeaderSpacing,
            ),
            // Grid - data from API
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: rows.asMap().entries.map((entry) {
                      final isLast = entry.key == rows.length - 1;
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: entry.value,
                          ),
                          if (!isLast)
                            const SizedBox(
                              height: HomeDesignConstants.inputDataGridSpacing,
                            ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        );
      },
      loading: () => const InputDataShimmer(),
      error: (error, stackTrace) => const SizedBox.shrink(),
      skipLoadingOnRefresh: false,
    );
  }
}
