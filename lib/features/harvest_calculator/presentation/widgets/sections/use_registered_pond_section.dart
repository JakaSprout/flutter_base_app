import 'package:app_mobile_afms/design_system/components/buttons/stp_choice_chip_button.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_form_controls.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/modals/select_registered_pond_modal.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/pond_option.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/utils/form_validation_helper.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Section widget for selecting whether to use registered pond.
///
/// Contains:
/// - Question "Gunakan Kolam Terdaftar?"
/// - Two options: "Ya, Gunakan" and "Isi Manual"
/// - Dropdown "Pilih Kolam" (shown when "Ya, Gunakan" is selected)
class UseRegisteredPondSection extends StatefulWidget {
  /// Creates a new instance of [UseRegisteredPondSection].
  const UseRegisteredPondSection({super.key});

  @override
  State<UseRegisteredPondSection> createState() =>
      _UseRegisteredPondSectionState();
}

class _UseRegisteredPondSectionState extends State<UseRegisteredPondSection> {
  bool _hasPreFilled = false;

  /// Pre-fills pond capacity fields with data from selected pond.
  ///
  /// Only fills fields that are empty to avoid overwriting user input.
  void _preFillPondCapacityData(FormGroup form, PondOption pond) {
    try {
      // Only pre-fill if cultivation info is complete (basic info valid)
      if (!FormValidationHelper.isBasicInfoValid(form)) {
        return;
      }

      // Pre-fill pond area if available and field is empty
      final pondAreaControl = form.control(
        HarvestCalculatorFormControls.pondArea,
      );
      final currentValue = pondAreaControl.value as String?;
      if (pond.areaSqm != null &&
          (currentValue == null || currentValue.isEmpty)) {
        pondAreaControl.value = pond.areaSqm!.toCleanString();
      }

      // Note: Other fields like pondDepth, capacityKgPerM2 are not pre-filled
      // as they depend on commodity/cultivation system recommendations
    } catch (e) {
      // Silently handle errors to prevent crashes
      // In development, you might want to log this
      debugPrint('Error in _preFillPondCapacityData: $e');
    }
  }

  /// Resets form fields to CSV test values when switching to manual input.
  void _resetFormForManualInput(FormGroup form) {
    // Clear all form fields when switching to manual input (remove pre-defined test data)
    // Basic Info - keep simulationName as auto-generated, clear others
    form.control(HarvestCalculatorFormControls.commodity).value = '';
    form.control(HarvestCalculatorFormControls.cultivationSystem).value = '';

    // Pond Capacity - clear all
    form.control(HarvestCalculatorFormControls.pondArea).value = '';
    form.control(HarvestCalculatorFormControls.pondDepth).value = '';
    form.control(HarvestCalculatorFormControls.capacityKgPerM2).value = '';
    form.control(HarvestCalculatorFormControls.capacityGrams).value = '';
    form.control(HarvestCalculatorFormControls.pondCapacityKgPerPond).value =
        '';
    form.control(HarvestCalculatorFormControls.fryCount).value = '';

    // Growth Target - clear all
    form.control(HarvestCalculatorFormControls.targetHarvest).value = '';
    form.control(HarvestCalculatorFormControls.estimatedADG).value = '';
    form.control(HarvestCalculatorFormControls.targetDOC).value = '';
    form.control(HarvestCalculatorFormControls.targetSR).value = '';
    form.control(HarvestCalculatorFormControls.estimatedFCR).value = '';
    form.control(HarvestCalculatorFormControls.targetBiomass).value = '';

    // Price Info - clear all
    form.control(HarvestCalculatorFormControls.targetSellingPrice).value = '';
    form.control(HarvestCalculatorFormControls.targetFeedPrice).value = '';
    form.control(HarvestCalculatorFormControls.sellingPrice).value = '';
    form.control(HarvestCalculatorFormControls.feedPrice).value = '';

    // Cycle type and related fields - clear all
    form.control(HarvestCalculatorFormControls.cycleType).value = '';
    form.control(HarvestCalculatorFormControls.currentDOC).value = '';

    // Feeding - clear all
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
            key: const ValueKey('registered_pond_selector_consumer'),
            builder: (context, form, child) {
              final useRegisteredPondControl =
                  form.control(HarvestCalculatorFormControls.useRegisteredPond)
                      as FormControl<bool>;
              final useRegisteredPond = useRegisteredPondControl.value ?? false;

              if (!useRegisteredPond) {
                return const SizedBox.shrink();
              }

              // Check if pond capacity section should be active now
              final isBasicInfoValid = FormValidationHelper.isBasicInfoValid(
                form,
              );
              final isPondSelectionValid =
                  FormValidationHelper.isPondSelectionValid(form);
              final shouldEnablePondCapacity =
                  isBasicInfoValid && isPondSelectionValid;

              // Pre-fill pond capacity data when conditions are met and not already done
              if (shouldEnablePondCapacity && !_hasPreFilled) {
                final selectedPondControl =
                    form.control(HarvestCalculatorFormControls.selectedPond)
                        as FormControl<PondOption?>;
                final selectedPond = selectedPondControl.value;
                if (selectedPond != null) {
                  // Use post frame callback to avoid calling setState during build
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      _preFillPondCapacityData(form, selectedPond);
                      setState(() {
                        _hasPreFilled = true;
                      });
                    }
                  });
                }
              } else if (!shouldEnablePondCapacity && _hasPreFilled) {
                // Reset pre-fill flag if conditions no longer met
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      _hasPreFilled = false;
                    });
                  }
                });
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

                      // Pre-fill pond capacity data if conditions are met
                      _preFillPondCapacityData(form, pond);

                      // Mark as pre-filled since we just selected a pond
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted) {
                          setState(() {
                            _hasPreFilled = true;
                          });
                        }
                      });

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
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: HarvestCalculatorDesignConstants.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: hasError
                              ? HarvestCalculatorDesignConstants.errorColor
                              : HarvestCalculatorDesignConstants.gray20,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: selectedPond != null
                                ? Text(
                                    '${selectedPond.code ?? selectedPond.id} - ${selectedPond.name}',
                                    style: HarvestCalculatorDesignConstants
                                        .bodyTextStyle
                                        .copyWith(
                                          color:
                                              HarvestCalculatorDesignConstants
                                                  .gray100,
                                        ),
                                  )
                                : Text(
                                    HarvestCalculatorConstants.hintSelectPond,
                                    style: HarvestCalculatorDesignConstants
                                        .bodyTextStyle
                                        .copyWith(
                                          color:
                                              HarvestCalculatorDesignConstants
                                                  .gray70,
                                        ),
                                  ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: HarvestCalculatorDesignConstants.gray100,
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
