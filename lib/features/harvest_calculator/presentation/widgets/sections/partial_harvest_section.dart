import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_form_controls.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/field_builder.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/form_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Section widget for automatic harvest configuration.
///
/// Contains percentage fields for automatic harvests (Panen 1, Panen 2, Panen Raya).
/// DOC timing is determined automatically when capacity is reached.
class PartialHarvestSection extends StatelessWidget {
  /// Creates a new instance of [PartialHarvestSection].
  const PartialHarvestSection({required this.isActive, super.key});

  /// Whether the section is active (visible).
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: SectionFieldPadding.horizontal),
      child: ReactiveFormConsumer(
        builder: (BuildContext context, FormGroup form, Widget? child) {
          return ReactiveValueListenableBuilder<String>(
            formControlName: HarvestCalculatorFormControls.targetDOC,
            builder: (context, targetDOCControl, child) {
              // Get targetDOC value to use as hint for Panen Raya
              final targetDOCValue = targetDOCControl.value ?? '120';

              return FormSection(
                title: HarvestCalculatorConstants.labelPartialHarvest,
                isActive: isActive,
        children: isActive
            ? [
                // Info text about automatic harvest
                SectionFieldPadding.wrap(
                  child: Text(
                    'Panen dilakukan otomatis saat biomassa mencapai kapasitas kolam.\nHanya persentase yang perlu diatur.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(height: SectionFieldPadding.fieldSpacing),

                // Panen 1 (Automatic - Percentage only)
                SectionFieldPadding.wrap(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldBuilder.number(
                        formControlName: HarvestCalculatorFormControls.harvest1Percentage,
                        label: 'Panen 1 Otomatis (%)',
                        hint: '50',
                        suffix: '%',
                        isRequired: false,
                        validationMessages: {
                          'min': (_) => 'Persentase panen harus antara 0-100%',
                          'max': (_) => 'Persentase panen harus antara 0-100%',
                        },
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Persentase panen saat biomassa mencapai kapasitas pertama',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: SectionFieldPadding.fieldSpacing),

                // Panen 2 (Automatic - Percentage only)
                SectionFieldPadding.wrap(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldBuilder.number(
                        formControlName: HarvestCalculatorFormControls.harvest2Percentage,
                        label: 'Panen 2 Otomatis (%)',
                        hint: '50',
                        suffix: '%',
                        isRequired: false,
                        validationMessages: {
                          'min': (_) => 'Persentase panen harus antara 0-100%',
                          'max': (_) => 'Persentase panen harus antara 0-100%',
                        },
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Persentase panen saat biomassa mencapai kapasitas kedua',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: SectionFieldPadding.fieldSpacing),

                // Panen Raya (Final - Percentage only, DOC always = targetDOC)
                SectionFieldPadding.wrap(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldBuilder.number(
                        formControlName: HarvestCalculatorFormControls.finalHarvestPercentage,
                        label: 'Panen Raya (%)',
                        hint: '100',
                        suffix: '%',
                        isRequired: false,
                        validationMessages: {
                          'min': (_) => 'Persentase panen harus antara 0-100%',
                          'max': (_) => 'Persentase panen harus antara 0-100%',
                        },
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Persentase panen akhir di DOC $targetDOCValue (otomatis)',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ]
                    : [],
              );
            },
          );
        },
      ),
    );
  }
}
