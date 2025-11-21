import 'package:flutter/material.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_form_controls.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/field_builder.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/form_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';

/// Section widget for growth target information.
///
/// Contains fields for:
/// - Stocking (Tebar)
/// - Estimated Feeding Rate (%)
/// - Estimated SR (%)
/// - Estimated FCR
/// - Current commodity weight (g)
/// - Target commodity weight (g)
/// - Estimated ADG (g)
class GrowthTargetSection extends StatelessWidget {
  /// Creates a new instance of [GrowthTargetSection].
  const GrowthTargetSection({required this.isActive, super.key});

  /// Whether the section is active (visible).
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const ValueKey('growth_target_section_padding'),
      padding: const EdgeInsets.only(right: SectionFieldPadding.horizontal),
      child: FormSection(
        key: const ValueKey('growth_target_form_section'),
        title: HarvestCalculatorConstants.sectionGrowthTarget,
        isActive: isActive,
        children: isActive
            ? [
                // Jumlah Tebar
                SectionFieldPadding.wrap(
                  child: FieldBuilder.number(
                    key: const ValueKey('stocking_field'),
                    formControlName: HarvestCalculatorFormControls.stocking,
                    label: 'Jumlah Tebar',
                    hint: '150',
                    isRequired: true,
                  ),
                ),
                const SizedBox(height: SectionFieldPadding.fieldSpacing),
                // Estimasi Feeding Rate (%)
                SectionFieldPadding.wrap(
                  child: FieldBuilder.number(
                    key: const ValueKey('feedingRate_field'),
                    formControlName: HarvestCalculatorFormControls.feedingRate,
                    label: 'Estimasi Feeding Rate (%)',
                    hint: '2',
                    suffix: '%',
                    isRequired: true,
                  ),
                ),
                const SizedBox(height: SectionFieldPadding.fieldSpacing),
                // Estimasi SR (%)
                SectionFieldPadding.wrap(
                  child: FieldBuilder.number(
                    key: const ValueKey('targetSR_field'),
                    formControlName: HarvestCalculatorFormControls.targetSR,
                    label: 'Estimasi SR (%)',
                    hint: '80',
                    suffix: '%',
                    isRequired: true,
                  ),
                ),
                const SizedBox(height: SectionFieldPadding.fieldSpacing),
                // Estimasi FCR
                SectionFieldPadding.wrap(
                  child: FieldBuilder.number(
                    key: const ValueKey('estimatedFCR_field'),
                    formControlName: HarvestCalculatorFormControls.estimatedFCR,
                    label: HarvestCalculatorConstants.labelEstimatedFCR,
                    hint: '1,2',
                    isRequired: true,
                  ),
                ),
                const SizedBox(height: SectionFieldPadding.fieldSpacing),
                // Berat Komoditas Saat Ini (g)
                SectionFieldPadding.wrap(
                  child: FieldBuilder.number(
                    key: const ValueKey('currentCommodityWeight_field'),
                    formControlName:
                        HarvestCalculatorFormControls.currentCommodityWeight,
                    label: 'Berat Komoditas Saat Ini (g)',
                    hint: '2',
                    suffix: 'g',
                    isRequired: true,
                  ),
                ),
                const SizedBox(height: SectionFieldPadding.fieldSpacing),
                // Target Berat Komoditas (g)
                SectionFieldPadding.wrap(
                  child: FieldBuilder.number(
                    key: const ValueKey('targetCommodityWeight_field'),
                    formControlName:
                        HarvestCalculatorFormControls.targetCommodityWeight,
                    label: 'Target Berat Komoditas (g)',
                    hint: '30',
                    suffix: 'g',
                    isRequired: true,
                  ),
                ),
                const SizedBox(height: SectionFieldPadding.fieldSpacing),
                SectionFieldPadding.wrap(
                  child: FieldBuilder.number(
                    key: const ValueKey('estimatedADG_field'),
                    formControlName: HarvestCalculatorFormControls.estimatedADG,
                    label: HarvestCalculatorConstants.labelEstimatedADG,
                    hint: '0',
                    suffix: 'g',
                    isRequired: true,
                    readOnly: true,
                  ),
                ),
              ]
            : [],
      ),
    );
  }
}
