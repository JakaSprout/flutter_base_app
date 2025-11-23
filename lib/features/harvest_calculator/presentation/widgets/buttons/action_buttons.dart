import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:flutter/material.dart';

/// Action buttons for cancel and save operations.
class ActionButtons extends StatelessWidget {
  /// Creates a new instance of [ActionButtons].
  const ActionButtons({
    required this.onCancel, required this.onSave, super.key,
  });

  /// Callback when cancel button is pressed.
  final VoidCallback onCancel;

  /// Callback when save button is pressed.
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SectionFieldPadding.horizontal,
        vertical: 12,
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: onCancel,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: const BorderSide(
                    color: HarvestCalculatorDesignConstants.gray40,
                  ),
                  foregroundColor: HarvestCalculatorDesignConstants.textPrimary,
                ),
                child: const Text(
                  HarvestCalculatorConstants.buttonCancel,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 3,
              child: ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: HarvestCalculatorDesignConstants.primaryBlue,
                  foregroundColor: HarvestCalculatorDesignConstants.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: HarvestCalculatorDesignConstants.sectionTitleTextStyle,
                ),
                child: const Text(
                  HarvestCalculatorConstants.buttonSave,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
