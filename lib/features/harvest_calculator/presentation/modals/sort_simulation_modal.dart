import 'package:app_mobile_afms/design_system/components/buttons/stp_choice_chip_button.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter/material.dart';

/// Modal bottom sheet for sorting simulations.
class SortSimulationModal extends StatefulWidget {
  const SortSimulationModal({
    required this.currentSort,
    super.key,
  });

  final String currentSort;

  @override
  State<SortSimulationModal> createState() => _SortSimulationModalState();
}

class _SortSimulationModalState extends State<SortSimulationModal> {
  late String _selectedSort;

  @override
  void initState() {
    super.initState();
    _selectedSort = widget.currentSort;
  }

  @override
  Widget build(BuildContext context) {
    final options = [
      HarvestCalculatorConstants.sortDateNewest,
      HarvestCalculatorConstants.sortDateOldest,
      HarvestCalculatorConstants.sortNameAZ,
      HarvestCalculatorConstants.sortNameZA,
    ];

    return Container(
      decoration: const BoxDecoration(
        color: HarvestCalculatorDesignConstants.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Handle bar
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: HarvestCalculatorDesignConstants.gray20,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      HarvestCalculatorConstants.buttonSort,
                      style:
                          HarvestCalculatorDesignConstants.cardTitleTextStyle,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: HarvestCalculatorDesignConstants.gray60,
                      size: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            // Options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: options.map((option) {
                  return STPChoiceChipButton(
                    label: option,
                    isSelected: _selectedSort == option,
                    onTap: () {
                      setState(() {
                        _selectedSort = option;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            
            const SizedBox(height: 24),
            // Save Button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, _selectedSort);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HarvestCalculatorDesignConstants.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  HarvestCalculatorConstants.buttonSave,
                  style: HarvestCalculatorDesignConstants.buttonTextStyle.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
