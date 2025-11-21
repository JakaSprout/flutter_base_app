import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/modals/partial_harvest_modal.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/models/simulation_results_models.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/utils/chart_builder.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/forms/form_section.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/cards/chart_stat_card.dart';
import 'package:flutter_base_app/gen/assets.gen.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

/// Section widget for biomass and partial harvest chart.
class BiomassSection extends StatelessWidget {
  /// Creates a new instance of [BiomassSection].
  const BiomassSection({
    required this.simulation,
    required this.latestPoint,
    super.key,
  });

  /// Simulation data.
  final SimulationResultsScreenArgs simulation;

  /// Latest biomass chart point.
  final BiomassChartPoint? latestPoint;

  @override
  Widget build(BuildContext context) {
    final weightFormat = NumberFormat('0.0');

    return SectionFieldPadding.wrapSection(
      child: FormSection(
        title: HarvestCalculatorConstants.chartBiomassAndPartialHarvest,
        children: [
          SectionFieldPadding.wrap(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: 32,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          builder: (context) => const PartialHarvestModal(),
                        );
                      },
                      icon: SvgPicture.asset(
                        Assets.icons.general.settings,
                        width: 20,
                        height: 20,
                      ),
                      label: Text(
                        HarvestCalculatorConstants.actionAdjustPartialHarvest,
                        style: HarvestCalculatorDesignConstants.bodyTextStyle.copyWith(
                          height: 20 / 14,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        backgroundColor: AppColors.white,
                        foregroundColor:
                            HarvestCalculatorDesignConstants.textPrimary,
                        side: const BorderSide(color: AppColors.gray20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: HarvestCalculatorDesignConstants.spacingMedium,
                ),
                SizedBox(
                  height: HarvestCalculatorDesignConstants.chartHeight,
                  child: Echarts(
                    option: ChartBuilder.buildBiomassChartOption(
                      simulation.biomassPoints,
                    ),
                    reloadAfterInit: true,
                  ),
                ),
                const SizedBox(
                  height: HarvestCalculatorDesignConstants.spacingMedium,
                ),
                ChartStatCard(
                  doc: latestPoint?.doc ?? 0,
                  stats: [
                    ChartStatValue(
                      label: 'Biomassa',
                      value:
                          '${weightFormat.format(latestPoint?.biomass ?? 0)} kg',
                      color: HarvestCalculatorDesignConstants.darkBlueAccent,
                    ),
                    ChartStatValue(
                      label: 'Kapasitas Maks. Kolam',
                      value:
                          '${weightFormat.format(latestPoint?.capacity ?? 0)} kg',
                      color: HarvestCalculatorDesignConstants.orangeAccent,
                    ),
                    ChartStatValue(
                      label: 'Pakan Kumulatif',
                      value:
                          '${weightFormat.format(latestPoint?.feedCumulative ?? 0)} kg',
                      color: HarvestCalculatorDesignConstants.greenAccent,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

