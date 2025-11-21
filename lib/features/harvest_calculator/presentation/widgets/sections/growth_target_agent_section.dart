import 'package:flutter/material.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_form_controls.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/field_builder.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/form_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';

/// Section widget for growth target information (Agent mode).
///
/// Contains fields for:
/// - Current biomass (kg)
/// - Stocking (Tebar)
/// - Estimated SR (%)
/// - Estimated FCR
class GrowthTargetAgentSection extends StatelessWidget {
  /// Creates a new instance of [GrowthTargetAgentSection].
  const GrowthTargetAgentSection({required this.isActive, super.key});

  /// Whether the section is active (visible).
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: SectionFieldPadding.horizontal),
      child: FormSection(
        title: HarvestCalculatorConstants.sectionGrowthTarget,
        isActive: isActive,
        children: isActive
            ? [
                // 1. Estimasi Biomassa Saat Ini (kg)
                SectionFieldPadding.wrap(
                  child: FieldBuilder.number(
                    formControlName:
                        HarvestCalculatorFormControls.currentBiomass,
                    label: HarvestCalculatorConstants.labelCurrentBiomass,
                    hint: 'Cth: 2',
                    suffix: 'kg',
                    isRequired: true,
                  ),
                ),
                const SizedBox(height: SectionFieldPadding.fieldSpacing),
                // 2. Jumlah Tebar
                SectionFieldPadding.wrap(
                  child: FieldBuilder.number(
                    formControlName: HarvestCalculatorFormControls.stocking,
                    label: 'Jumlah Tebar',
                    hint: 'Cth: 150',
                    isRequired: true,
                  ),
                ),
                const SizedBox(height: SectionFieldPadding.fieldSpacing),
                // 3. Estimasi SR (%)
                SectionFieldPadding.wrap(
                  child: FieldBuilder.number(
                    formControlName: HarvestCalculatorFormControls.targetSR,
                    label: 'Estimasi SR (%)',
                    hint: 'Cth: 80',
                    suffix: '%',
                    isRequired: true,
                  ),
                ),
                const SizedBox(height: SectionFieldPadding.fieldSpacing),
                // 4. Estimasi FCR
                SectionFieldPadding.wrap(
                  child: FieldBuilder.number(
                    formControlName: HarvestCalculatorFormControls.estimatedFCR,
                    label: HarvestCalculatorConstants.labelEstimatedFCR,
                    hint: 'Cth: 1,2',
                    isRequired: true,
                  ),
                ),
              ]
            : [],
      ),
    );
  }
}
