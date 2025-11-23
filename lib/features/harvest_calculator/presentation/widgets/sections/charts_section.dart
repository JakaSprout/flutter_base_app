import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/simulation_results_models.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/sections/biomass_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/sections/feed_section.dart';
import 'package:flutter/material.dart';

/// Section containing biomass and feed charts.
class ChartsSection extends StatelessWidget {
  /// Creates a new instance of [ChartsSection].
  const ChartsSection({
    required this.simulation, required this.latestBiomassPoint, required this.isFeedChartSelected, required this.onFeedToggle, super.key,
  });

  /// Simulation data.
  final SimulationResultsScreenArgs simulation;

  /// Latest biomass chart point.
  final BiomassChartPoint? latestBiomassPoint;

  /// Whether feed chart is selected.
  final bool isFeedChartSelected;

  /// Callback when feed chart toggle changes.
  final ValueChanged<bool> onFeedToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BiomassSection(
          simulation: simulation,
          latestPoint: latestBiomassPoint,
        ),
        const SizedBox(
          height: HarvestCalculatorDesignConstants.sectionSpacing,
        ),
        FeedSection(
          simulation: simulation,
          isChartSelected: isFeedChartSelected,
          onToggle: onFeedToggle,
        ),
        const SizedBox(
          height: HarvestCalculatorDesignConstants.sectionSpacing,
        ),
      ],
    );
  }
}
