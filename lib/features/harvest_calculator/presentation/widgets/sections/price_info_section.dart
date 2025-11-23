import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_form_controls.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/field_builder.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/form_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:flutter/material.dart';

/// Section widget for price information.
///
/// Contains fields for:
/// - Commodity price (Rp/kg)
/// - Feed price (Rp/kg)
class PriceInfoSection extends StatelessWidget {
  /// Creates a new instance of [PriceInfoSection].
  const PriceInfoSection({required this.isActive, super.key});

  /// Whether the section is active (visible).
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: SectionFieldPadding.horizontal),
      child: FormSection(
        title: HarvestCalculatorConstants.sectionPriceInfo,
        isActive: isActive,
        children: isActive
            ? [
                SectionFieldPadding.wrap(
                  child: FieldBuilder.number(
                    formControlName: HarvestCalculatorFormControls.sellingPrice,
                    label: 'Harga Komoditas (Rp/kg)',
                    hint: '80.000',
                    prefix: 'Rp',
                    suffix: 'kg',
                    isRequired: true,
                    validationMessages: {
                      'required': (_) => 'Harga komoditas harus diisi',
                      'min': (_) => 'Harga komoditas harus lebih besar dari 0',
                    },
                  ),
                ),
                const SizedBox(height: SectionFieldPadding.fieldSpacing),
                SectionFieldPadding.wrap(
                  child: FieldBuilder.number(
                    formControlName: HarvestCalculatorFormControls.feedPrice,
                    label: HarvestCalculatorConstants.labelFeedPrice,
                    hint: '34.000',
                    prefix: 'Rp',
                    suffix: 'kg',
                    isRequired: true,
                    validationMessages: {
                      'required': (_) => 'Harga pakan harus diisi',
                      'min': (_) => 'Harga pakan harus lebih besar dari 0',
                    },
                  ),
                ),
              ]
            : [],
      ),
    );
  }
}
