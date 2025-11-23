import 'package:app_mobile_afms/design_system/components/buttons/stp_choice_chip_button.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_form_controls.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/modals/cycle_type_info_bottom_sheet.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/field_builder.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/form_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Section widget for cycle type selection.
///
/// Contains:
/// - Cycle type selection (Full Cycle or Mid Cycle)
/// - Current DOC field (always enabled for agent mode, enabled when Mid Cycle for cycle mode)
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
                          (cycleTypeControl.value?.isEmpty ?? true)
                              ? HarvestCalculatorConstants.cycleTypeFull
                              : cycleTypeControl.value!;

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
                        (cycleTypeControl.value?.isEmpty ?? true)
                            ? HarvestCalculatorConstants.cycleTypeFull
                            : cycleTypeControl.value!;
                    final isMidCycle =
                        selectedCycleType ==
                        HarvestCalculatorConstants.cycleTypeMid;

                    // Check if this is agent mode
                    final simulationTypeControl =
                        form.control(
                              HarvestCalculatorFormControls.simulationType,
                            )
                            as FormControl<String>;
                    final simulationType =
                        simulationTypeControl.value ??
                        HarvestCalculatorConstants.simulationTypeCycle;
                    final isAgentMode =
                        simulationType ==
                        HarvestCalculatorConstants.simulationTypeAgent;

                    // Current DOC is always enabled for agent mode, enabled when Mid Cycle for cycle mode
                    // Current DOC logic:
                    // - Always enabled for Mid Cycle (both agent and cycle mode)
                    // - Disabled for Full Cycle (both agent and cycle mode, auto-set = 1)
                    final isCurrentDOCEnabled = isMidCycle;

                    // For full cycle (both agent and cycle mode), set currentDOC to 1 automatically
                    if (!isMidCycle) {
                      final currentDOCControl = form.control(
                        HarvestCalculatorFormControls.currentDOC,
                      );
                      if (currentDOCControl.value == null ||
                          currentDOCControl.value == '') {
                        currentDOCControl.value = '1';
                      }
                    }

                    return SectionFieldPadding.wrap(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                minHeight: 80, // Reserve space for label + field + error message
                              ),
                              child: FieldBuilder.number(
                                formControlName:
                                    HarvestCalculatorFormControls.currentDOC,
                                label: HarvestCalculatorConstants.labelCurrentDOC,
                                hint: '1', // Full cycle always shows 1
                                suffix: 'hari',
                                readOnly: !isCurrentDOCEnabled,
                                isRequired:
                                    isAgentMode &&
                                    isMidCycle, // Required only for agent + mid cycle
                                validationMessages: {
                                  'required': (_) => 'DOC Saat Ini harus diisi untuk mode mid-cycle',
                                  'min': (_) => 'DOC Saat Ini harus lebih besar dari 0',
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: SectionFieldPadding.fieldSpacing,
                          ),
                          Expanded(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                minHeight: 80, // Reserve space for label + field + error message
                              ),
                              child: FieldBuilder.number(
                                formControlName:
                                    HarvestCalculatorFormControls.targetDOC,
                                label: HarvestCalculatorConstants.labelTargetDOC,
                                hint: '120',
                                suffix: 'hari',
                                isRequired: true,
                                validationMessages: {
                                  'required': (_) => 'Target DOC harus diisi',
                                  'min': (_) => 'Target DOC harus lebih besar dari 0',
                                },
                              ),
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
