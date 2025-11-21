import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_form_controls.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/utils/capacity_recommendation_helper.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/field_builder.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/form_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Section widget for pond capacity information.
///
/// Contains fields for:
/// - Pond area (m²)
/// - Stocking density (ind/m²)
/// - Capacity (kg/m²) with recommendation system
/// - Pond capacity (kg/m²)
class PondCapacitySection extends StatefulWidget {
  /// Creates a new instance of [PondCapacitySection].
  const PondCapacitySection({required this.isActive, super.key});

  /// Whether the section is active (visible).
  final bool isActive;

  @override
  State<PondCapacitySection> createState() => _PondCapacitySectionState();
}

class _PondCapacitySectionState extends State<PondCapacitySection> {
  String? _recommendedCapacity;
  bool _hasRecommendation = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: SectionFieldPadding.horizontal),
      child: FormSection(
        title: HarvestCalculatorConstants.sectionPondCapacity,
        isActive: widget.isActive,
        children: widget.isActive
            ? [
                // 1. Luas Kolam (m²)
                SectionFieldPadding.wrap(
                  child: FieldBuilder.number(
                    formControlName: HarvestCalculatorFormControls.pondArea,
                    label: HarvestCalculatorConstants.labelPondArea,
                    hint: '100.000',
                    suffix: 'm²',
                    isRequired: true,
                  ),
                ),
                const SizedBox(height: SectionFieldPadding.fieldSpacing),
                // 2. Kepadatan Tebar (ind/m²)
                SectionFieldPadding.wrap(
                  child: FieldBuilder.number(
                    formControlName: HarvestCalculatorFormControls.pondDepth,
                    label: HarvestCalculatorConstants.labelStockingDensity,
                    hint: '150',
                    suffix: 'ind/m²',
                    isRequired: true,
                  ),
                ),
                const SizedBox(height: SectionFieldPadding.fieldSpacing),
                // 3. Kapasitas (kg/m²) with info icon and recommendation system
                ReactiveFormConsumer(
                  builder: (context, form, child) {
                    // Listen to commodity and cultivation system changes
                    final commodity =
                        form
                                .control(
                                  HarvestCalculatorFormControls.commodity,
                                )
                                .value
                            as String?;
                    final cultivationSystem =
                        form
                                .control(
                                  HarvestCalculatorFormControls
                                      .cultivationSystem,
                                )
                                .value
                            as String?;
                    final capacityControl = form.control(
                      HarvestCalculatorFormControls.capacityKgPerM2,
                    );
                    final currentCapacity = capacityControl.value as String?;

                    // Get recommendation when commodity or cultivation system changes
                    final recommendedCapacity =
                        CapacityRecommendationHelper.getRecommendedCapacity(
                          commodity: commodity,
                          cultivationSystem: cultivationSystem,
                        );

                    // Update recommendation if available and not set yet
                    if (recommendedCapacity != null &&
                        _recommendedCapacity != recommendedCapacity) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          _recommendedCapacity = recommendedCapacity;
                          _hasRecommendation = true;
                          // Auto-fill recommendation if field is empty
                          if (currentCapacity == null ||
                              currentCapacity.isEmpty) {
                            capacityControl.value = recommendedCapacity;
                          }
                        });
                      });
                    } else if (recommendedCapacity == null) {
                      // Reset recommendation if commodity/system is not selected
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          _recommendedCapacity = null;
                          _hasRecommendation = false;
                        });
                      });
                    }

                    // Check if current value matches recommendation
                    final isValueChanged =
                        _hasRecommendation &&
                        recommendedCapacity != null &&
                        currentCapacity != null &&
                        currentCapacity.isNotEmpty &&
                        currentCapacity != recommendedCapacity;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionFieldPadding.wrap(
                          child: FieldBuilder.number(
                            formControlName:
                                HarvestCalculatorFormControls.capacityKgPerM2,
                            label: HarvestCalculatorConstants.labelCapacity,
                            hint: '5',
                            suffix: Text(
                              'kg/m²',
                              style: HarvestCalculatorDesignConstants
                                  .bodyTextStyle
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                            isRequired: true,
                          ),
                        ),
                        // Info text below field (doesn't interfere with error message)
                        ReactiveValueListenableBuilder<String>(
                          formControlName:
                              HarvestCalculatorFormControls.capacityKgPerM2,
                          builder: (context, control, child) {
                            final errorText =
                                control.errors.isNotEmpty &&
                                    (control.dirty || control.touched)
                                ? null
                                : _buildInfoText(
                                    isValueChanged,
                                    recommendedCapacity,
                                  );

                            if (errorText == null) {
                              return const SizedBox.shrink();
                            }

                            return Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: SectionFieldPadding.wrap(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      Assets.icons.general.signInfo,
                                      width: 16,
                                      height: 16,
                                      color: HarvestCalculatorDesignConstants
                                          .textSecondary,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        errorText,
                                        style: HarvestCalculatorDesignConstants
                                            .smallTextSecondaryStyle
                                            .copyWith(height: 1.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        // Button "Balik ke Rekomendasi" - appears when value is changed
                        if (isValueChanged && _hasRecommendation)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: SectionFieldPadding.wrap(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  // Restore recommendation value
                                  final capacityControl = form.control(
                                    HarvestCalculatorFormControls
                                        .capacityKgPerM2,
                                  );
                                  capacityControl.value = recommendedCapacity;
                                },
                                icon: ColorFiltered(
                                  colorFilter: const ColorFilter.mode(
                                    HarvestCalculatorDesignConstants.gray60,
                                    BlendMode.srcIn,
                                  ),
                                  child: SvgPicture.asset(
                                    Assets.icons.outline.refresh,
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                                label: const Text(
                                  HarvestCalculatorConstants
                                      .buttonReturnToRecommendation,
                                  style: HarvestCalculatorDesignConstants
                                      .bodyTextStyle,
                                ),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  backgroundColor:
                                      HarvestCalculatorDesignConstants.white,
                                  foregroundColor:
                                      HarvestCalculatorDesignConstants
                                          .textPrimary,
                                  side: const BorderSide(
                                    color:
                                        HarvestCalculatorDesignConstants.gray20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 0,
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: SectionFieldPadding.fieldSpacing),
                // 4. Kapasitas Kolam (kg/kolam)
                SectionFieldPadding.wrap(
                  child: FieldBuilder.number(
                    formControlName:
                        HarvestCalculatorFormControls.pondCapacityKgPerPond,
                    label: HarvestCalculatorConstants.labelPondCapacity,
                    hint: '15',
                    suffix: 'kg/kolam',
                    isRequired: true,
                    readOnly: true,
                  ),
                ),
              ]
            : [],
      ),
    );
  }

  String? _buildInfoText(bool isValueChanged, String? recommendedCapacity) {
    if (isValueChanged && recommendedCapacity != null) {
      return HarvestCalculatorConstants.infoCapacityNotMatchRecommendation;
    } else if (_hasRecommendation) {
      return HarvestCalculatorConstants.infoCapacityAdjustedByCommodity;
    }
    return null;
  }
}
