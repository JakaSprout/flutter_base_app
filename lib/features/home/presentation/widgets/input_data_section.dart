import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/design_system/components/cards/stp_input_data_item.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/home/presentation/constants/home_constants.dart';
import 'package:flutter_base_app/features/home/presentation/providers/home_provider.dart';
import 'package:flutter_base_app/features/home/presentation/widgets/shimmer_loaders/input_data_shimmer.dart';
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

  // Design tokens - exact Figma specs
  static const double _gridSpacing = 8; // Figma: gap 8px
  static const double _headerSpacing = 24;
  static const double _fontSizeTitle =
      16; // Figma: Body/Small/Medium/Semibold - fontSize 16
  static const double _fontSizeSeeAll =
      12; // Figma: Label/Medium/Semibold - fontSize 12
  static const double _lineHeight = 1.5; // Figma: lineHeight 1.5em

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
    
    return AppColors.gray05; // Default if invalid
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
                          if (!isLast) const SizedBox(height: _gridSpacing),
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
