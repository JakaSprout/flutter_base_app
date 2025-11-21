import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';

/// Action buttons for cancel and save operations.
class ActionButtons extends StatelessWidget {
  /// Creates a new instance of [ActionButtons].
  const ActionButtons({
    super.key,
    required this.onCancel,
    required this.onSave,
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
                  side: const BorderSide(color: AppColors.gray40),
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
                  foregroundColor: AppColors.white,
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
