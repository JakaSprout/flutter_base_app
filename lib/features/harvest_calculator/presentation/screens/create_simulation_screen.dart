import 'package:app_mobile_afms/design_system/components/banners/stp_status_banner.dart';
import 'package:app_mobile_afms/design_system/components/navigation/stp_app_bar.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_form_controls.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/hooks/use_create_simulation_form.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/buttons/create_simulation_bottom_button.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/sections/use_registered_pond_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/shared/conditional_sections_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Screen for creating a new simulation.
///
/// Allows users to input all simulation parameters including:
/// - Basic info (name, commodity, cultivation system)
/// - Pond capacity (only for Cycle mode)
/// - Growth targets (different fields for Cycle vs Agent)
/// - Price information (different fields for Cycle vs Agent)
///
/// Supports two simulation types:
/// - Cycle: Full simulation with pond capacity
/// - Agent: Simplified simulation without pond capacity
class CreateSimulationScreen extends HookWidget {
  /// Creates a new instance of [CreateSimulationScreen].
  ///
  /// [simulationType] determines which sections and fields to show:
  /// - 'cycle': Shows all sections including pond capacity
  /// - 'agent': Hides pond capacity, shows agent-specific fields
  const CreateSimulationScreen({this.simulationType, super.key});

  /// Simulation type: 'cycle' or 'agent'
  /// Defaults to 'cycle' if not provided
  final String? simulationType;

  @override
  Widget build(BuildContext context) {
    final form = useCreateSimulationForm();
    final scrollController = useScrollController();
    final infoTextStyle = HarvestCalculatorDesignConstants.smallTextStyle
        .copyWith(height: 18 / 12);

    // Set simulation type in form
    final effectiveSimulationType =
        simulationType ?? HarvestCalculatorConstants.simulationTypeCycle;
    final simulationTypeControl =
        form.control(HarvestCalculatorFormControls.simulationType)
            as FormControl<String>;
    if (simulationTypeControl.value != effectiveSimulationType) {
      simulationTypeControl.value = effectiveSimulationType;
    }

    final isAgentMode =
        effectiveSimulationType ==
        HarvestCalculatorConstants.simulationTypeAgent;
    final appBarTitle = isAgentMode
        ? HarvestCalculatorConstants.titleCreateSimulationAgent
        : HarvestCalculatorConstants.titleCreateSimulation;

    // Update stocking default value based on mode
    // Update field validators and defaults based on simulation mode
    useEffect(() {
      final cultivationSystemControl =
          form.control(HarvestCalculatorFormControls.cultivationSystem)
              as FormControl<String>;
      final pondAreaControl =
          form.control(HarvestCalculatorFormControls.pondArea)
              as FormControl<String>;
      final pondDepthControl =
          form.control(HarvestCalculatorFormControls.pondDepth)
              as FormControl<String>;
      final capacityKgPerM2Control =
          form.control(HarvestCalculatorFormControls.capacityKgPerM2)
              as FormControl<String>;
      final feedingRateControl =
          form.control(HarvestCalculatorFormControls.feedingRate)
              as FormControl<String>;
      final currentCommodityWeightControl =
          form.control(HarvestCalculatorFormControls.currentCommodityWeight)
              as FormControl<String>;
      final targetCommodityWeightControl =
          form.control(HarvestCalculatorFormControls.targetCommodityWeight)
              as FormControl<String>;
      final sellingPriceControl =
          form.control(HarvestCalculatorFormControls.sellingPrice)
              as FormControl<String>;
      final stockingControl =
          form.control(HarvestCalculatorFormControls.stocking)
              as FormControl<String>;

      if (isAgentMode) {
        // Agent mode: pond-related fields, feeding rate, and commodity weight fields not used
        cultivationSystemControl.clearValidators();
        pondAreaControl.clearValidators();
        pondDepthControl.clearValidators();
        capacityKgPerM2Control.clearValidators();
        feedingRateControl.clearValidators();
        currentCommodityWeightControl.clearValidators();
        targetCommodityWeightControl.clearValidators();
        sellingPriceControl.clearValidators();
        // For agent mode: empty default for stocking
        if (stockingControl.value == '0') {
          stockingControl.value = '';
        }
      } else {
        // Cycle mode: cultivation system required, pond fields, feeding rate, and commodity weights may be required
        cultivationSystemControl.setValidators([Validators.required]);
        feedingRateControl.setValidators([Validators.required]);
        currentCommodityWeightControl.setValidators([Validators.required]);
        targetCommodityWeightControl.setValidators([Validators.required]);
        sellingPriceControl.setValidators([Validators.required]);
        // pondArea, pondDepth, capacityKgPerM2 validators will be set based on useRegisteredPond
        // For cycle mode: allow user to input stocking value (not auto-calculated)
      }
      return null;
    }, [isAgentMode]);

    // Update pond-related validators based on useRegisteredPond (cycle mode only)
    useEffect(
      () {
        if (!isAgentMode) {
          final useRegisteredPondControl =
              form.control(HarvestCalculatorFormControls.useRegisteredPond)
                  as FormControl<bool>;
          final pondAreaControl =
              form.control(HarvestCalculatorFormControls.pondArea)
                  as FormControl<String>;
          final pondDepthControl =
              form.control(HarvestCalculatorFormControls.pondDepth)
                  as FormControl<String>;
          final capacityKgPerM2Control =
              form.control(HarvestCalculatorFormControls.capacityKgPerM2)
                  as FormControl<String>;

          final useRegisteredPond = useRegisteredPondControl.value ?? true;
          if (!useRegisteredPond) {
            // Manual input: pond fields required
            pondAreaControl.setValidators([Validators.required]);
            pondDepthControl.setValidators([Validators.required]);
            capacityKgPerM2Control.setValidators([Validators.required]);
          } else {
            // Registered pond: pond fields not required
            pondAreaControl.clearValidators();
            pondDepthControl.clearValidators();
            capacityKgPerM2Control.clearValidators();
          }
        }
        return null;
      },
      [
        form.control(HarvestCalculatorFormControls.useRegisteredPond).value,
        isAgentMode,
      ],
    );

    return Scaffold(
      backgroundColor: HarvestCalculatorDesignConstants.white,
      resizeToAvoidBottomInset: false,
      appBar: STPAppBar(title: appBarTitle),
      body: SafeArea(
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.only(
                    top: HarvestCalculatorDesignConstants.screenPaddingVertical,
                    bottom:
                        HarvestCalculatorDesignConstants.screenPaddingVertical +
                        MediaQuery.of(context).viewInsets.bottom +
                        100, // Extra padding for keyboard + safe area
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      /// Info Banner
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: SectionFieldPadding.horizontal,
                        ),
                        child: STPStatusBanner(
                          type: STPStatusBannerType.info,
                          child: Text.rich(
                            TextSpan(
                              text: 'Kalkulator ini menggunakan ',
                              style: infoTextStyle,
                              children: const [
                                TextSpan(
                                  text: 'ADG (Average Daily Gain)',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                TextSpan(text: ' sebagai dasar perhitungan.'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      /// Use Registered Pond Section (only for Cycle mode)
                      if (!isAgentMode) ...[
                        const UseRegisteredPondSection(),
                        const SizedBox(height: 16),
                        const Divider(
                          height: 4,
                          thickness: 4,
                          color: HarvestCalculatorDesignConstants.dividerColor,
                        ),
                        const SizedBox(height: 16),
                      ],

                      /// Conditional Sections (Cultivation Info, Pond Capacity, Cycle Type, Growth Target, Price Info)
                      const ConditionalSectionsWrapper(),
                    ],
                  ),
                ),
              ),

              /// Bottom Button
              CreateSimulationBottomButton(
                form: form,
                scrollController: scrollController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
