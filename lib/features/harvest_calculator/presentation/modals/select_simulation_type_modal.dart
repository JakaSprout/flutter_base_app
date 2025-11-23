import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';
import 'package:app_mobile_afms/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

/// Modal bottom sheet for selecting simulation type.
class SelectSimulationTypeModal extends StatelessWidget {
  /// Creates a new instance of [SelectSimulationTypeModal].
  const SelectSimulationTypeModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: HarvestCalculatorDesignConstants.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Handle bar
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: HarvestCalculatorDesignConstants.gray20,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Header with title and close button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      HarvestCalculatorConstants.titleSelectSimulationType,
                      style:
                          HarvestCalculatorDesignConstants.cardTitleTextStyle,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: HarvestCalculatorDesignConstants.gray60,
                      size: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            // Simulation type options
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                children: [
                  _SimulationTypeOption(
                    title: HarvestCalculatorConstants.labelCycle,
                    description: HarvestCalculatorConstants.descriptionCycle,
                    iconAsset: Assets.icons.general.pieChart,
                    iconBackgroundColor:
                        HarvestCalculatorDesignConstants.lightBlueBackground,
                    onTap: () {
                      Navigator.pop(context);
                      context.push(Routes.harvestCalculatorCreate);
                    },
                  ),
                  const SizedBox(height: 12),
                  _SimulationTypeOption(
                    title: HarvestCalculatorConstants.labelDistributorAgent,
                    description:
                        HarvestCalculatorConstants.descriptionDistributorAgent,
                    iconAsset: Assets.icons.general.moneyBag,
                    iconBackgroundColor: HarvestCalculatorDesignConstants
                        .simulationCardIconBackgroundOrange,
                    onTap: () {
                      Navigator.pop(context);
                      context.push(Routes.harvestCalculatorCreateAgent);
                    },
                  ),
                ],
              ),
            ),
            // Bottom padding consistent with STPBottomActionButton
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

/// Option card for simulation type selection.
class _SimulationTypeOption extends StatelessWidget {
  /// Creates a new instance of [_SimulationTypeOption].
  const _SimulationTypeOption({
    required this.title,
    required this.description,
    required this.iconAsset,
    required this.iconBackgroundColor,
    required this.onTap,
  });

  /// Option title.
  final String title;

  /// Option description.
  final String description;

  /// Icon asset path.
  final String iconAsset;

  /// Icon background color.
  final Color iconBackgroundColor;

  /// Callback when option is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: HarvestCalculatorDesignConstants.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: HarvestCalculatorDesignConstants.gray20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          splashColor: HarvestCalculatorDesignConstants.gray20.withOpacity(0.3),
          highlightColor: HarvestCalculatorDesignConstants.gray20.withOpacity(
            0.1,
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Icon with background
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: SvgPicture.asset(iconAsset, width: 24, height: 24),
                  ),
                ),
                const SizedBox(width: 12),
                // Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: HarvestCalculatorDesignConstants.bodyTextStyle
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: HarvestCalculatorDesignConstants
                            .smallTextSecondaryStyle,
                      ),
                    ],
                  ),
                ),
                // Arrow icon
                const Icon(
                  Icons.chevron_right,
                  color: HarvestCalculatorDesignConstants.gray60,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
