import 'package:app_mobile_afms/design_system/components/buttons/stp_choice_chip_button.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:flutter/material.dart';

/// Segmented toggle widget for switching between chart and table views.
class SegmentedToggle extends StatelessWidget {
  /// Creates a new instance of [SegmentedToggle].
  const SegmentedToggle({
    required this.isChartSelected,
    required this.onChanged,
    super.key,
  });

  /// Whether chart view is selected.
  final bool isChartSelected;

  /// Callback when selection changes.
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      children: [
        STPChoiceChipButton(
          label: HarvestCalculatorConstants.toggleChart,
          isSelected: isChartSelected,
          onTap: () => onChanged(true),
          width: 92,
        ),
        STPChoiceChipButton(
          label: HarvestCalculatorConstants.toggleTable,
          isSelected: !isChartSelected,
          onTap: () => onChanged(false),
          width: 92,
        ),
      ],
    );
  }
}
