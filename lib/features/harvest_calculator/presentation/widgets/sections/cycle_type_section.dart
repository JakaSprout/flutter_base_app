import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/components/buttons/stp_choice_chip_button.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_form_controls.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/modals/cycle_type_info_bottom_sheet.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/forms/field_builder.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/forms/form_section.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:flutter_base_app/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Section widget for cycle type selection.
///
/// Contains:
/// - Cycle type selection (Full Cycle or Mid Cycle)
/// - Current DOC field (enabled when Mid Cycle is selected)
/// - Target DOC field
class CycleTypeSection extends StatelessWidget {
  /// Creates a new instance of [CycleTypeSection].
  const CycleTypeSection({required this.isActive, super.key});

  /// Whether the section is active (visible).
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: SectionFieldPadding.horizontal),
      child: FormSection(
        title: HarvestCalculatorConstants.sectionCycleType,
        isActive: isActive,
        children: isActive
            ? [
                // Subtitle with info icon
                SectionFieldPadding.wrap(
                  child: Row(
                    children: [
                      const Text(
                        HarvestCalculatorConstants.subtitleCycleType,
                        style: HarvestCalculatorDesignConstants.bodyTextStyle,
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (_) => const CycleTypeInfoBottomSheet(),
                          );
                        },
                        child: SvgPicture.asset(
                          Assets.icons.general.signInfo,
                          width: 16,
                          height: 16,
                          color:
                              HarvestCalculatorDesignConstants.secondaryOrange,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: SectionFieldPadding.fieldSpacing),
                // Cycle type selection buttons
                SectionFieldPadding.wrap(
                  child: ReactiveFormConsumer(
                    builder: (context, form, child) {
                      final cycleTypeControl =
                          form.control(HarvestCalculatorFormControls.cycleType)
                              as FormControl<String>;
                      final selectedCycleType =
                          cycleTypeControl.value ??
                          HarvestCalculatorConstants.cycleTypeFull;

                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          STPChoiceChipButton(
                            label: HarvestCalculatorConstants.cycleTypeFull,
                            isSelected:
                                selectedCycleType ==
                                HarvestCalculatorConstants.cycleTypeFull,
                            onTap: () {
                              cycleTypeControl.value =
                                  HarvestCalculatorConstants.cycleTypeFull;
                            },
                            padding: const EdgeInsets.only(
                              top: 8,
                              right: 12,
                              bottom: 8,
                              left: 12,
                            ),
                          ),
                          const SizedBox(width: 10),
                          STPChoiceChipButton(
                            label: HarvestCalculatorConstants.cycleTypeMid,
                            isSelected:
                                selectedCycleType ==
                                HarvestCalculatorConstants.cycleTypeMid,
                            onTap: () {
                              cycleTypeControl.value =
                                  HarvestCalculatorConstants.cycleTypeMid;
                            },
                            padding: const EdgeInsets.only(
                              top: 8,
                              right: 12,
                              bottom: 8,
                              left: 12,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: SectionFieldPadding.fieldSpacing),
                // DOC fields side by side
                ReactiveFormConsumer(
                  builder: (context, form, child) {
                    final cycleTypeControl =
                        form.control(HarvestCalculatorFormControls.cycleType)
                            as FormControl<String>;
                    final selectedCycleType =
                        cycleTypeControl.value ??
                        HarvestCalculatorConstants.cycleTypeFull;
                    final isMidCycle =
                        selectedCycleType ==
                        HarvestCalculatorConstants.cycleTypeMid;

                    return SectionFieldPadding.wrap(
                      child: Row(
                        children: [
                          Expanded(
                            child: FieldBuilder.number(
                              formControlName:
                                  HarvestCalculatorFormControls.currentDOC,
                              label: HarvestCalculatorConstants.labelCurrentDOC,
                              hint: '0',
                              suffix: 'hari',
                              readOnly: !isMidCycle,
                            ),
                          ),
                          const SizedBox(
                            width: SectionFieldPadding.fieldSpacing,
                          ),
                          Expanded(
                            child: FieldBuilder.number(
                              formControlName:
                                  HarvestCalculatorFormControls.targetDOC,
                              label: HarvestCalculatorConstants.labelTargetDOC,
                              hint: '120',
                              suffix: 'hari',
                              isRequired: true,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ]
            : [],
      ),
    );
  }
}
