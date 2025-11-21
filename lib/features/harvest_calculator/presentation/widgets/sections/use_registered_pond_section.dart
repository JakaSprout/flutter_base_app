import 'package:flutter/material.dart';
import 'package:app_mobile_afms/design_system/components/buttons/stp_choice_chip_button.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_form_controls.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/modals/select_registered_pond_modal.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/pond_option.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Section widget for selecting whether to use registered pond.
///
/// Contains:
/// - Question "Gunakan Kolam Terdaftar?"
/// - Two options: "Ya, Gunakan" and "Isi Manual"
/// - Dropdown "Pilih Kolam" (shown when "Ya, Gunakan" is selected)
class UseRegisteredPondSection extends StatelessWidget {
  /// Creates a new instance of [UseRegisteredPondSection].
  const UseRegisteredPondSection({super.key});

  /// Resets form fields to their default values when switching to manual input.
  void _resetFormForManualInput(FormGroup form) {
    // Reset Basic Info (except simulationName to keep auto-generated value)
    // form.control(HarvestCalculatorFormControls.simulationName).value = '';
    form.control(HarvestCalculatorFormControls.commodity).value = null;
    form.control(HarvestCalculatorFormControls.cultivationSystem).value = null;

    // Reset Pond Capacity
    form.control(HarvestCalculatorFormControls.pondArea).value = '';
    form.control(HarvestCalculatorFormControls.pondDepth).value = '';
    form.control(HarvestCalculatorFormControls.capacityKgPerM2).value = '';
    form.control(HarvestCalculatorFormControls.capacityGrams).value = '';
    form.control(HarvestCalculatorFormControls.pondCapacityKgPerPond).value =
        '';
    form.control(HarvestCalculatorFormControls.fryCount).value = '';

    // Reset Growth Target
    form.control(HarvestCalculatorFormControls.targetHarvest).value = '';
    form.control(HarvestCalculatorFormControls.estimatedADG).value = '';
    form.control(HarvestCalculatorFormControls.targetDOC).value = '';
    form.control(HarvestCalculatorFormControls.targetSR).value = '';
    form.control(HarvestCalculatorFormControls.estimatedFCR).value = '';
    form.control(HarvestCalculatorFormControls.targetBiomass).value = '';

    // Reset Price Info
    form.control(HarvestCalculatorFormControls.targetSellingPrice).value = '';
    form.control(HarvestCalculatorFormControls.targetFeedPrice).value = '';
    form.control(HarvestCalculatorFormControls.sellingPrice).value = '';
    form.control(HarvestCalculatorFormControls.feedPrice).value = '';

    // Reset Cycle type and related fields
    form.control(HarvestCalculatorFormControls.cycleType).value =
        HarvestCalculatorConstants.cycleTypeFull;
    form.control(HarvestCalculatorFormControls.currentDOC).value = '';

    // Reset Stocking and feeding
    form.control(HarvestCalculatorFormControls.stocking).value = '';
    form.control(HarvestCalculatorFormControls.feedingRate).value = '';
    form.control(HarvestCalculatorFormControls.currentCommodityWeight).value =
        '';
    form.control(HarvestCalculatorFormControls.targetCommodityWeight).value =
        '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SectionFieldPadding.horizontal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question
          const Text(
            HarvestCalculatorConstants.questionUseRegisteredPond,
            style: HarvestCalculatorDesignConstants.bodyTextStyle,
          ),
          const SizedBox(height: 12),
          // Options
          ReactiveFormConsumer(
            builder: (context, form, child) {
              final useRegisteredPondControl =
                  form.control(HarvestCalculatorFormControls.useRegisteredPond)
                      as FormControl<bool>;
              final useRegisteredPond = useRegisteredPondControl.value ?? false;

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  STPChoiceChipButton(
                    label: HarvestCalculatorConstants.optionUseRegisteredPond,
                    isSelected: useRegisteredPond,
                    onTap: () {
                      useRegisteredPondControl.value = true;
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
                    label: HarvestCalculatorConstants.optionFillManual,
                    isSelected: !useRegisteredPond,
                    onTap: () {
                      useRegisteredPondControl.value = false;
                      // Clear selected pond when switching to manual
                      (form.control(HarvestCalculatorFormControls.selectedPond)
                            as FormControl<PondOption?>)
                        ..value = null
                        ..markAsPristine()
                        ..markAsUntouched();

                      // Reset all form fields when switching to manual input
                      _resetFormForManualInput(form);
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
          // Registered pond selector (shown when "Ya, Gunakan" is selected)
          ReactiveFormConsumer(
            builder: (context, form, child) {
              final useRegisteredPondControl =
                  form.control(HarvestCalculatorFormControls.useRegisteredPond)
                      as FormControl<bool>;
              final useRegisteredPond = useRegisteredPondControl.value ?? false;

              if (!useRegisteredPond) {
                return const SizedBox.shrink();
              }

              final selectedPondControl =
                  form.control(HarvestCalculatorFormControls.selectedPond)
                      as FormControl<PondOption?>;
              final hasError =
                  selectedPondControl.invalid &&
                  (selectedPondControl.dirty || selectedPondControl.touched);
              final selectedPond = selectedPondControl.value;

              Future<void> openPicker() async {
                FocusScope.of(context).unfocus();
                await showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => SelectRegisteredPondModal(
                    initialValue: selectedPondControl.value,
                    onSave: (pond) {
                      selectedPondControl
                        ..value = pond
                        ..markAsDirty()
                        ..markAsTouched();
                      form.markAsDirty();
                    },
                  ),
                );
                selectedPondControl.markAsTouched();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: SectionFieldPadding.fieldSpacing),
                  const Row(
                    children: [
                      Text(
                        HarvestCalculatorConstants.labelSelectPond,
                        style: HarvestCalculatorDesignConstants.smallTextStyle,
                      ),
                      SizedBox(width: 2),
                      Text(
                        '*',
                        style: TextStyle(
                          color: HarvestCalculatorDesignConstants.errorColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: openPicker,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: HarvestCalculatorDesignConstants.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: hasError
                              ? HarvestCalculatorDesignConstants.errorColor
                              : HarvestCalculatorDesignConstants.gray20,
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: selectedPond != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        selectedPond.name,
                                        style: HarvestCalculatorDesignConstants
                                            .bodyTextStyle
                                            .copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'ID: ${selectedPond.id}',
                                        style: HarvestCalculatorDesignConstants
                                            .smallTextSecondaryStyle,
                                      ),
                                    ],
                                  )
                                : Text(
                                    HarvestCalculatorConstants.hintSelectPond,
                                    style: HarvestCalculatorDesignConstants
                                        .bodyTextStyle
                                        .copyWith(
                                          color:
                                              HarvestCalculatorDesignConstants
                                                  .placeholderColor,
                                    ),
                                  ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: HarvestCalculatorDesignConstants.gray60,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (hasError) ...[
                    const SizedBox(height: 6),
                    const Text(
                      'Kolam harus dipilih',
                      style:
                          HarvestCalculatorDesignConstants.formErrorTextStyle,
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
