import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_form_controls.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/field_builder.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/form_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:flutter/material.dart';

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
                    hint: '5.000',
                    suffix: 'kg',
                    isRequired: true,
                    validationMessages: {
                      'required': (_) =>
                          'Estimasi biomassa saat ini harus diisi',
                      'min': (_) =>
                          'Estimasi biomassa saat ini harus lebih besar dari 0',
                    },
                  ),
                ),
                const SizedBox(height: SectionFieldPadding.fieldSpacing),
                // 2. Jumlah Tebar
                SectionFieldPadding.wrap(
                  child: FieldBuilder.number(
                    formControlName: HarvestCalculatorFormControls.stocking,
                    label: 'Jumlah Tebar',
                    hint: '21.000',
                    isRequired: true,
                    validationMessages: {
                      'required': (_) => 'Jumlah tebar harus diisi',
                      'min': (_) => 'Jumlah tebar harus lebih besar dari 0',
                    },
                  ),
                ),
                const SizedBox(height: SectionFieldPadding.fieldSpacing),
                // 3. Target SR (%)
                SectionFieldPadding.wrap(
                  child: FieldBuilder.number(
                    formControlName: HarvestCalculatorFormControls.targetSR,
                    label: 'Target SR (%)',
                    hint: '90',
                    suffix: '%',
                    isRequired: true,
                    validationMessages: {
                      'required': (_) => 'Target SR harus diisi',
                      'min': (_) => 'Target SR harus antara 0-100%',
                      'max': (_) => 'Target SR harus antara 0-100%',
                    },
                  ),
                ),
                const SizedBox(height: SectionFieldPadding.fieldSpacing),
                // 4. Estimasi FCR
                SectionFieldPadding.wrap(
                  child: FieldBuilder.number(
                    formControlName: HarvestCalculatorFormControls.estimatedFCR,
                    label: HarvestCalculatorConstants.labelEstimatedFCR,
                    hint: '1.5',
                    isRequired: true,
                    validationMessages: {
                      'required': (_) => 'Estimasi FCR harus diisi',
                      'min': (_) => 'Estimasi FCR harus lebih besar dari 0',
                    },
                  ),
                ),
              ]
            : [],
      ),
    );
  }
}
