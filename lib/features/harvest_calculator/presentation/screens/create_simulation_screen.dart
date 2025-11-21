import 'package:flutter/material.dart';
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
                  padding: const EdgeInsets.only(
                    top: HarvestCalculatorDesignConstants.screenPaddingVertical,
                    bottom:
                        HarvestCalculatorDesignConstants.screenPaddingVertical,
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

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),

              /// Bottom Button
              CreateSimulationBottomButton(form: form),
            ],
          ),
        ),
      ),
    );
  }
}
