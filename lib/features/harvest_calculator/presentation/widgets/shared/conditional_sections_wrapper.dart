import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_form_controls.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/utils/form_validation_helper.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/sections/cultivation_info_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/sections/cycle_type_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/sections/growth_target_agent_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/sections/growth_target_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/sections/pond_capacity_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/sections/price_info_agent_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/sections/price_info_section.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Wrapper for conditional sections after basic info is filled.
/// Shows sections based on simulation type (Cycle or Agent):
/// - Cultivation Info (always shown)
/// - Pond Capacity (only for Cycle mode)
/// - Cycle Type (always shown)
/// - Growth Target (different fields for Cycle vs Agent)
/// - Price Info (different fields for Cycle vs Agent)
class ConditionalSectionsWrapper extends StatelessWidget {
  /// Creates a new instance of [ConditionalSectionsWrapper].
  const ConditionalSectionsWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      key: const ValueKey('conditional_sections_wrapper_consumer'),
      builder: (context, form, child) {
        // Get simulation type (default to cycle)
        final simulationTypeControl =
            form.control(HarvestCalculatorFormControls.simulationType)
                as FormControl<String>;
        final simulationType =
            simulationTypeControl.value ??
            HarvestCalculatorConstants.simulationTypeCycle;
        final isAgentMode =
            simulationType == HarvestCalculatorConstants.simulationTypeAgent;

        final isBasicInfoValid = FormValidationHelper.isBasicInfoValid(form);
        // For agent mode, sections activate after basic info is valid
        // For cycle mode, sections activate after basic info AND pond selection is valid
        final useRegisteredPond =
            form
                .control(HarvestCalculatorFormControls.useRegisteredPond)
                .value ??
            true;
        final selectedPond = form
            .control(HarvestCalculatorFormControls.selectedPond)
            .value;
        final isPondSelectionValid =
            (useRegisteredPond == false) || selectedPond != null;

        final isActive = isAgentMode
            ? isBasicInfoValid // Agent mode: only need basic info
            : isBasicInfoValid &&
                  isPondSelectionValid; // Cycle mode: need basic info + pond selection

        return Column(
          key: const ValueKey('conditional_sections_column'),
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CultivationInfoSection(
              key: ValueKey('cultivation_info_section'),
            ),
            const SizedBox(height: 16),
            // Pond Capacity - only shown for Cycle mode
            if (!isAgentMode) ...[
              PondCapacitySection(
                key: const ValueKey('pond_capacity_section'),
                isActive: isActive,
              ),
              const SizedBox(height: 16),
            ],
            // Cycle Type - shown for both modes (agent also needs DOC inputs)
            CycleTypeSection(
              key: const ValueKey('cycle_type_section'),
              isActive: isActive,
            ),
            const SizedBox(height: 16),
            // Growth Target - different section for Agent vs Cycle
            if (isAgentMode)
              GrowthTargetAgentSection(
                key: const ValueKey('growth_target_agent_section'),
                isActive: isActive,
              )
            else
              GrowthTargetSection(
                key: const ValueKey('growth_target_section'),
                isActive: isActive,
              ),
            const SizedBox(height: 16),
            // Price Info - different section for Agent vs Cycle
            if (isAgentMode)
              PriceInfoAgentSection(
                key: const ValueKey('price_info_agent_section'),
                isActive: isActive,
              )
            else
              PriceInfoSection(
                key: const ValueKey('price_info_section'),
                isActive: isActive,
              ),
          ],
        );
      },
    );
  }
}
