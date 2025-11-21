import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_form_controls.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/forms/field_builder.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/forms/form_section.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';

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
                  hint: 'Rp 80.000',
                  prefix: 'Rp',
                  isRequired: true,
                ),
              ),
              const SizedBox(height: SectionFieldPadding.fieldSpacing),
              // 2. Harga Pakan/kg
              SectionFieldPadding.wrap(
                child: FieldBuilder.number(
                  formControlName: HarvestCalculatorFormControls.feedPrice,
                  label: HarvestCalculatorConstants.labelFeedPrice,
                  hint: 'Rp 34.000',
                  prefix: 'Rp',
                  suffix: 'kg',
                  isRequired: true,
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
                  label: HarvestCalculatorConstants.labelHarvestPurchasePrice,
                  hint: 'Rp 80.000',
                  prefix: 'Rp',
                  suffix: 'kg',
                  isRequired: true,
                ),
              ),
              const SizedBox(height: SectionFieldPadding.fieldSpacing),
              // 2. Estimasi Hasil Panen
              SectionFieldPadding.wrap(
                child: FieldBuilder.number(
                  formControlName:
                      HarvestCalculatorFormControls.estimatedHarvestYield,
                  label: HarvestCalculatorConstants.labelEstimatedHarvestYield,
                  hint: '0',
                  suffix: 'kg',
                  isRequired: true,
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


