import 'package:flutter/material.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/form_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';

/// Section widget for partial harvest information.
///
/// Contains button to add harvest plans.
class PartialHarvestSection extends StatelessWidget {
  /// Creates a new instance of [PartialHarvestSection].
  const PartialHarvestSection({
    required this.isActive,
    super.key,
  });

  /// Whether the section is active (visible).
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: SectionFieldPadding.horizontal,
      ),
      child: FormSection(
        title: HarvestCalculatorConstants.labelPartialHarvest,
        isActive: isActive,
        children: isActive
            ? [
                SectionFieldPadding.wrap(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement add harvest plan
                    },
                    icon: const Icon(Icons.add, size: 20),
                    label: const Text('Rencana Panen'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HarvestCalculatorDesignConstants.white,
                      foregroundColor: HarvestCalculatorDesignConstants.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(
                          color: HarvestCalculatorDesignConstants.primary,
                        ),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ]
            : [],
      ),
    );
  }
}



