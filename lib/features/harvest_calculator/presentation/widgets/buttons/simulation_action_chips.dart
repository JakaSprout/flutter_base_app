import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/buttons/action_chip_button.dart';
import 'package:flutter_base_app/gen/assets.gen.dart';

/// Action chips for filtering and sorting simulations.
class SimulationActionChips extends StatelessWidget {
  /// Creates a new instance of [SimulationActionChips].
  const SimulationActionChips({
    super.key,
    this.onFilterTap,
    this.onSortTap,
  });

  /// Callback when filter chip is tapped.
  final VoidCallback? onFilterTap;

  /// Callback when sort chip is tapped.
  final VoidCallback? onSortTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: HarvestCalculatorDesignConstants.cardPadding,
      ),
      child: Wrap(
        spacing: 12,
        runSpacing: 8,
        children: [
          ActionChipButton(
            iconAsset: Assets.icons.outline.filter,
            label: HarvestCalculatorConstants.buttonFilter,
            onTap: onFilterTap ?? () {},
            showChevronDown: true,
          ),
          ActionChipButton(
            iconAsset: Assets.icons.outline.sort,
            label: HarvestCalculatorConstants.buttonSort,
            onTap: onSortTap ?? () {},
            showChevronDown: true,
          ),
        ],
      ),
    );
  }
}
