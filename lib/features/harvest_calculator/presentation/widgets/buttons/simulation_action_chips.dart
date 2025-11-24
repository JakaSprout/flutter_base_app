import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/buttons/action_chip_button.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';
import 'package:flutter/material.dart';

/// Action chips for filtering and sorting simulations.
class SimulationActionChips extends StatelessWidget {
  /// Creates a new instance of [SimulationActionChips].
  const SimulationActionChips({
    super.key,
    this.onFilterTap,
    this.onSortTap,
    this.onResetFilterTap,
    this.filterCount = 0,
    this.sortLabel,
  });

  /// Callback when filter chip is tapped.
  final VoidCallback? onFilterTap;

  /// Callback when sort chip is tapped.
  final VoidCallback? onSortTap;

  /// Callback when reset filter button is tapped.
  final VoidCallback? onResetFilterTap;

  /// Number of active filters.
  final int filterCount;

  /// Label for active sort (optional).
  final String? sortLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: HarvestCalculatorDesignConstants.cardPadding,
      ),
      child: Wrap(
        spacing: 12,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (filterCount > 0)
            InkWell(
              onTap: onResetFilterTap,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: HarvestCalculatorDesignConstants.gray20,
                  ),
                ),
                child: const Icon(
                  Icons.close,
                  size: 20,
                  color: HarvestCalculatorDesignConstants.gray60,
                ),
              ),
            ),
          ActionChipButton(
            iconAsset: Assets.icons.outline.filter,
            label: filterCount > 0
                ? '${HarvestCalculatorConstants.buttonFilter}: $filterCount'
                : HarvestCalculatorConstants.buttonFilter,
            onTap: onFilterTap ?? () {},
            showChevronDown: true,
            isActive: filterCount > 0,
          ),
          ActionChipButton(
            iconAsset: Assets.icons.outline.sort,
            label: sortLabel ?? HarvestCalculatorConstants.buttonSort,
            onTap: onSortTap ?? () {},
            showChevronDown: true,
            // Sort is usually always active in some form, but we only highlight if it's not default
            // However, based on design, it seems it just shows "Urutkan" unless changed?
            // The prompt image 3 shows "Urutkan" (not highlighted) and "Filter: 1" (highlighted).
            // So we keep sort as is.
          ),
        ],
      ),
    );
  }
}
