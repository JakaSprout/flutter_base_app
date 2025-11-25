import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_form_controls.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/field_builder.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/form_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/reactive_text_field.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
      child: ReactiveFormConsumer(
        builder: (BuildContext context, FormGroup form, Widget? child) {
          // Calculate Estimated ADG automatically
          final currentWeight =
              form
                      .control(
                        HarvestCalculatorFormControls.currentCommodityWeight,
                      )
                      .value
                  as String?;
          final targetWeight =
              form
                      .control(
                        HarvestCalculatorFormControls.targetCommodityWeight,
                      )
                      .value
                  as String?;
          final targetDOC =
              form.control(HarvestCalculatorFormControls.targetDOC).value
                  as String?;

          // Auto-calculate ADG: (targetWeight - currentWeight) / targetDOC
          if (currentWeight != null &&
              currentWeight.isNotEmpty &&
              targetWeight != null &&
              targetWeight.isNotEmpty &&
              targetDOC != null &&
              targetDOC.isNotEmpty) {
            try {
              final current = double.parse(currentWeight);
              final target = double.parse(targetWeight);
              final doc = double.parse(targetDOC);

              if (doc > 0) {
                final adg = (target - current) / doc;
                final adgStr = adg.toStringAsFixed(9); // More decimal precision
                final adgControl = form.control(
                  HarvestCalculatorFormControls.estimatedADG,
                );

                if (adgControl.value != adgStr) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    adgControl.value = adgStr;
                  });
                }
              }
            } catch (e) {
              // Invalid number format - don't update
            }
          }

          return ReactiveValueListenableBuilder<String>(
            formControlName:
                HarvestCalculatorFormControls.currentCommodityWeight,
            builder: (context, currentWeightControl, child) {
              return ReactiveValueListenableBuilder<String>(
                formControlName:
                    HarvestCalculatorFormControls.targetCommodityWeight,
                builder: (context, targetWeightControl, child) {
                  return ReactiveValueListenableBuilder<String>(
                    formControlName: HarvestCalculatorFormControls.targetDOC,
                    builder: (context, targetDOCControl, child) {
                      // This will trigger rebuild when any input field changes
                      return FormSection(
                        key: const ValueKey('growth_target_form_section'),
                        title: HarvestCalculatorConstants.sectionGrowthTarget,
                        isActive: isActive,
                        children: isActive
                            ? [
                                // Jumlah Tebar (can be manually input or auto-calculated from pond dimensions)
                                ReactiveFormConsumer(
                                  builder: (context, form, child) {
                                    return ReactiveValueListenableBuilder<
                                      String
                                    >(
                                      formControlName:
                                          HarvestCalculatorFormControls
                                              .pondArea,
                                      builder: (context, pondAreaControl, child) {
                                        return ReactiveValueListenableBuilder<
                                          String
                                        >(
                                          formControlName:
                                              HarvestCalculatorFormControls
                                                  .pondDepth,
                                          builder: (context, pondDepthControl, child) {
                                            // Calculate total stocking automatically
                                            final pondArea =
                                                pondAreaControl.value;
                                            final pondDepth =
                                                pondDepthControl.value;

                                            if (pondArea != null &&
                                                pondArea.isNotEmpty &&
                                                pondDepth != null &&
                                                pondDepth.isNotEmpty) {
                                              try {
                                                // Clean thousand separators before parsing
                                                final area = double.parse(
                                                  NumberTextInputFormatter.cleanNumberString(
                                                    pondArea,
                                                  ),
                                                );
                                                final depth = double.parse(
                                                  NumberTextInputFormatter.cleanNumberString(
                                                    pondDepth,
                                                  ),
                                                );
                                                final totalStocking =
                                                    (area * depth).round();
                                                final stockingControl = form
                                                    .control(
                                                      HarvestCalculatorFormControls
                                                          .stocking,
                                                    );
                                                if (stockingControl.value !=
                                                    totalStocking.toString()) {
                                                  WidgetsBinding.instance
                                                      .addPostFrameCallback((
                                                        _,
                                                      ) {
                                                        stockingControl.value =
                                                            totalStocking
                                                                .toString();
                                                      });
                                                }
                                              } catch (e) {
                                                // Invalid number format - don't update
                                              }
                                            }
                                            return SectionFieldPadding.wrap(
                                              child: FieldBuilder.number(
                                                key: const ValueKey(
                                                  'stocking_field',
                                                ),
                                                formControlName:
                                                    HarvestCalculatorFormControls
                                                        .stocking,
                                                label: 'Jumlah Tebar',
                                                hint: '750',
                                                isRequired: true,
                                                validationMessages: {
                                                  'required': (_) =>
                                                      'Jumlah tebar harus diisi',
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: SectionFieldPadding.fieldSpacing,
                                ),
                                // Estimasi Feeding Rate (%)
                                SectionFieldPadding.wrap(
                                  child: FieldBuilder.number(
                                    key: const ValueKey('feedingRate_field'),
                                    formControlName:
                                        HarvestCalculatorFormControls
                                            .feedingRate,
                                    label: 'Estimasi Feeding Rate (%)',
                                    hint: '2',
                                    suffix: '%',
                                    isRequired: true,
                                    validationMessages: {
                                      'required': (_) =>
                                          'Feeding rate harus diisi',
                                      'min': (_) =>
                                          'Feeding rate harus lebih besar dari 0',
                                      'max': (_) =>
                                          'Feeding rate tidak boleh lebih dari 100%',
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: SectionFieldPadding.fieldSpacing,
                                ),
                                // Estimasi SR (%)
                                SectionFieldPadding.wrap(
                                  child: FieldBuilder.number(
                                    key: const ValueKey('targetSR_field'),
                                    formControlName:
                                        HarvestCalculatorFormControls.targetSR,
                                    label: 'Estimasi SR (%)',
                                    hint: '80',
                                    suffix: '%',
                                    isRequired: true,
                                    validationMessages: {
                                      'required': (_) =>
                                          'Target SR harus diisi',
                                      'min': (_) =>
                                          'Target SR harus antara 0-100%',
                                      'max': (_) =>
                                          'Target SR harus antara 0-100%',
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: SectionFieldPadding.fieldSpacing,
                                ),
                                // Estimasi FCR
                                SectionFieldPadding.wrap(
                                  child: FieldBuilder.number(
                                    key: const ValueKey('estimatedFCR_field'),
                                    formControlName:
                                        HarvestCalculatorFormControls
                                            .estimatedFCR,
                                    label: HarvestCalculatorConstants
                                        .labelEstimatedFCR,
                                    hint: '1.2',
                                    isRequired: true,
                                    validationMessages: {
                                      'required': (_) =>
                                          'Estimasi FCR harus diisi',
                                      'min': (_) =>
                                          'Estimasi FCR harus lebih besar dari 0',
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: SectionFieldPadding.fieldSpacing,
                                ),
                                // Berat Komoditas Saat Ini (g)
                                SectionFieldPadding.wrap(
                                  child: FieldBuilder.number(
                                    key: const ValueKey(
                                      'currentCommodityWeight_field',
                                    ),
                                    formControlName:
                                        HarvestCalculatorFormControls
                                            .currentCommodityWeight,
                                    label: 'Berat Komoditas Saat Ini (g)',
                                    hint: '2',
                                    suffix: 'g',
                                    isRequired: true,
                                    validationMessages: {
                                      'required': (_) =>
                                          'Berat komoditas saat ini harus diisi',
                                      'min': (_) =>
                                          'Berat komoditas saat ini harus lebih besar dari 0',
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: SectionFieldPadding.fieldSpacing,
                                ),
                                // Target Berat Komoditas (g)
                                SectionFieldPadding.wrap(
                                  child: FieldBuilder.number(
                                    key: const ValueKey(
                                      'targetCommodityWeight_field',
                                    ),
                                    formControlName:
                                        HarvestCalculatorFormControls
                                            .targetCommodityWeight,
                                    label: 'Target Berat Komoditas (g)',
                                    hint: '30',
                                    suffix: 'g',
                                    isRequired: true,
                                    validationMessages: {
                                      'required': (_) =>
                                          'Target berat komoditas harus diisi',
                                      'min': (_) =>
                                          'Target berat komoditas harus lebih besar dari 0',
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: SectionFieldPadding.fieldSpacing,
                                ),
                                SectionFieldPadding.wrap(
                                  child: FieldBuilder.number(
                                    key: const ValueKey('estimatedADG_field'),
                                    formControlName:
                                        HarvestCalculatorFormControls
                                            .estimatedADG,
                                    label: HarvestCalculatorConstants
                                        .labelEstimatedADG,
                                    hint: '0',
                                    suffix: 'g',
                                    isRequired: true,
                                    readOnly: true,
                                  ),
                                ),
                              ]
                            : [],
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
