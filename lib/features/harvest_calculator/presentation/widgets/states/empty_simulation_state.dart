import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/modals/select_simulation_type_modal.dart';
import 'package:flutter_base_app/gen/assets.gen.dart';

/// Empty state widget when no simulation exists.
///
/// Displays calculator icon, primary and secondary messages, and button
/// according to Figma design.
class EmptySimulationState extends StatelessWidget {
  /// Creates a new instance of [EmptySimulationState].
  const EmptySimulationState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Visual (Icon) - 129x129
        // Figma: layout_1KBU6Y - width: 129, height: 129
        Assets.images.calculator.image(
          width: HarvestCalculatorDesignConstants.emptyStateIconSize,
          height: HarvestCalculatorDesignConstants.emptyStateIconSize,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            // Fallback jika image tidak ditemukan
            return Container(
              width: HarvestCalculatorDesignConstants.emptyStateIconSize,
              height: HarvestCalculatorDesignConstants.emptyStateIconSize,
              color: Colors.grey[200],
              child: const Icon(Icons.calculate, size: 64),
            );
          },
        ),
        // Gap between icon and text: 16px
        // Figma: gap: 16px in Content Container
        const SizedBox(height: HarvestCalculatorDesignConstants.spacingMedium),
        // Text Container - alignSelf: stretch, gap: 4px
        // Figma: layout_SLOAZ6 - column, alignItems: center, alignSelf: stretch, gap: 4px
        const SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Primary Message - Body/Medium/Bold
              // Figma: fontSize: 16, fontWeight: 700, lineHeight: 1.5em, textAlign: CENTER
              Text(
                HarvestCalculatorConstants.emptyStateMessage,
                textAlign: TextAlign.center,
                style: HarvestCalculatorDesignConstants.emptyStatePrimaryTextStyle,
              ),
              // Gap within text container: 4px
              // Figma: gap: 4px in Text Container
              SizedBox(height: 4),
              // Secondary Message - Label/Medium/Regular
              // Figma: fontSize: 12, fontWeight: 400, lineHeight: 1.5em, textAlign: CENTER
              SizedBox(
                width: 284,
                child:                   Text(
                    HarvestCalculatorConstants.emptyStateSecondaryMessage,
                    textAlign: TextAlign.center,
                    style: HarvestCalculatorDesignConstants.emptyStateSecondaryTextStyle,
                  ),
              ),
            ],
          ),
        ),
        // Gap between text and button: 16px
        const SizedBox(height: HarvestCalculatorDesignConstants.spacingMedium),
        // Button - Simulasi Panen with plus icon
        // Figma: Dark blue button with white text and plus icon
        ElevatedButton.icon(
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => const SelectSimulationTypeModal(),
            );
          },
          icon: const Icon(Icons.add, size: 20, color: AppColors.white),
          label: Text(
            HarvestCalculatorConstants.buttonSimulasiPanen,
            style: HarvestCalculatorDesignConstants.buttonTextStyle.copyWith(
              color: AppColors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: HarvestCalculatorDesignConstants.primaryBlue,
            foregroundColor: AppColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            minimumSize: const Size(0, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                HarvestCalculatorDesignConstants.buttonBorderRadius,
              ),
            ),
            elevation: 0,
          ),
        ),
      ],
    );
  }
}
