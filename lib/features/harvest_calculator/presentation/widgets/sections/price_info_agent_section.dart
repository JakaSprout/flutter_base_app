import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_form_controls.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/field_builder.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/form_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:flutter/material.dart';

/// Section widget for price information (Agent mode).
///
/// Contains two subsections:
/// - Feed Price: Total feed payment obligation and feed price per kg
/// - Harvest Price: Harvest purchase price and estimated harvest yield
class PriceInfoAgentSection extends StatelessWidget {
  /// Creates a new instance of [PriceInfoAgentSection].
  const PriceInfoAgentSection({required this.isActive, super.key});

  /// Whether the section is active (visible).
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Harga Pakan Section
        Padding(
          padding: const EdgeInsets.only(right: SectionFieldPadding.horizontal),
          child: FormSection(
            title: HarvestCalculatorConstants.sectionFeedPrice,
            isActive: isActive,
            children: isActive
                ? [
                    // 1. Total Kewajiban Bayar Pakan
                    SectionFieldPadding.wrap(
                      child: FieldBuilder.number(
                        formControlName: HarvestCalculatorFormControls
                            .totalFeedPaymentObligation,
                        label: HarvestCalculatorConstants
                            .labelTotalFeedPaymentObligation,
                        hint: '50.000.000',
                        prefix: 'Rp',
                        isRequired: true,
                        validationMessages: {
                          'required': (_) => 'Total kewajiban bayar pakan harus diisi',
                          'min': (_) => 'Total kewajiban bayar pakan harus lebih besar dari 0',
                        },
                      ),
                    ),
                    const SizedBox(height: SectionFieldPadding.fieldSpacing),
                    // 2. Harga Pakan/kg
                    SectionFieldPadding.wrap(
                      child: FieldBuilder.number(
                        formControlName:
                            HarvestCalculatorFormControls.feedPrice,
                        label: HarvestCalculatorConstants.labelFeedPrice,
                        hint: '18.000',
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
        ),
        const SizedBox(height: 16),
        // Harga Panen Section
        Padding(
          padding: const EdgeInsets.only(right: SectionFieldPadding.horizontal),
          child: FormSection(
            title: HarvestCalculatorConstants.sectionHarvestPrice,
            isActive: isActive,
            children: isActive
                ? [
                    // 1. Harga Beli Panen/kg
                    SectionFieldPadding.wrap(
                      child: FieldBuilder.number(
                        formControlName:
                            HarvestCalculatorFormControls.harvestPurchasePrice,
                        label: HarvestCalculatorConstants
                            .labelHarvestPurchasePrice,
                        hint: '28.000',
                        prefix: 'Rp',
                        suffix: 'kg',
                        isRequired: true,
                        validationMessages: {
                          'required': (_) => 'Harga beli panen harus diisi',
                          'min': (_) => 'Harga beli panen harus lebih besar dari 0',
                        },
                      ),
                    ),
                    const SizedBox(height: SectionFieldPadding.fieldSpacing),
                    // 2. Estimasi Hasil Panen
                    SectionFieldPadding.wrap(
                      child: FieldBuilder.number(
                        formControlName:
                            HarvestCalculatorFormControls.estimatedHarvestYield,
                        label: HarvestCalculatorConstants
                            .labelEstimatedHarvestYield,
                        hint: '6.500',
                        suffix: 'kg',
                        isRequired: true,
                        validationMessages: {
                          'required': (_) => 'Estimasi hasil panen harus diisi',
                          'min': (_) => 'Estimasi hasil panen harus lebih besar dari 0',
                        },
                      ),
                    ),
                  ]
                : [],
          ),
        ),
      ],
    );
  }
}
