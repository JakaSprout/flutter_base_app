import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/modals/partial_harvest_modal.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/simulation_results_models.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/utils/chart_builder.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/cards/chart_stat_card.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/form_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Section widget for biomass and partial harvest chart.
class BiomassSection extends StatefulWidget {
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
  State<BiomassSection> createState() => _BiomassSectionState();
}

class _BiomassSectionState extends State<BiomassSection> {
  /// Currently selected point from chart interaction
  BiomassChartPoint? _selectedPoint;

  @override
  Widget build(BuildContext context) {
    final displayPoint = _selectedPoint ?? widget.latestPoint;

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
                          builder: (context) => PartialHarvestModal(
                            automaticHarvestDoc:
                                widget.simulation.automaticHarvestDoc,
                            harvestSummaries: widget
                                .simulation
                                .simulationResult
                                ?.harvestSummaries,
                            targetDOC: widget.simulation.doc,
                          ),
                        );
                      },
                      icon: SvgPicture.asset(
                        Assets.icons.general.settings,
                        width: 20,
                        height: 20,
                      ),
                      label: Text(
                        HarvestCalculatorConstants.actionAdjustPartialHarvest,
                        style: HarvestCalculatorDesignConstants.bodyTextStyle
                            .copyWith(height: 20 / 14),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        backgroundColor: HarvestCalculatorDesignConstants.white,
                        foregroundColor:
                            HarvestCalculatorDesignConstants.textPrimary,
                        side: const BorderSide(
                          color: HarvestCalculatorDesignConstants.gray20,
                        ),
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
                      widget.simulation.biomassPoints,
                    ),
                    extraScript: ChartBuilder.getBiomassChartExtraScript(),
                    onMessage: (String message) {
                      // Handle chart interaction messages
                      if (message.startsWith('chart_click:')) {
                        final docIndex = int.tryParse(message.substring(12));
                        if (docIndex != null &&
                            docIndex < widget.simulation.biomassPoints.length) {
                          setState(() {
                            _selectedPoint =
                                widget.simulation.biomassPoints[docIndex];
                          });
                        }
                      } else if (message == 'chart_reset') {
                        setState(() {
                          _selectedPoint = null;
                        });
                      }
                    },
                    reloadAfterInit: true,
                  ),
                ),
                const SizedBox(
                  height: HarvestCalculatorDesignConstants.spacingMedium,
                ),
                ChartStatCard(
                  doc: displayPoint?.doc ?? 0,
                  stats: [
                    ChartStatValue(
                      label: 'Biomassa',
                      value: '',
                      color: HarvestCalculatorDesignConstants.darkBlueAccent,
                    ),
                    ChartStatValue(
                      label: 'Kapasitas Maks. Kolam',
                      value: '',
                      color: HarvestCalculatorDesignConstants.orangeAccent,
                    ),
                    ChartStatValue(
                      label: 'Pakan Kumulatif',
                      value: '',
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
