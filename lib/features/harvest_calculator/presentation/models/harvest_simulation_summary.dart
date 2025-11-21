import 'package:flutter/material.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/harvest_simulation.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';

/// Extension to convert domain entities to presentation models
extension HarvestSimulationMapping on HarvestSimulation {
  HarvestSimulationSummary toSummary() {
    // Calculate totals from results if available
    final totalHarvestMt = results.biomassPoints.isNotEmpty
        ? results.biomassPoints.last.biomass
        : 0.0;
    final feedCost = results.tableRows.isNotEmpty
        ? results.tableRows.last.feedCost.toInt()
        : 0;
    final potentialRevenue = results.tableRows.isNotEmpty
        ? results.tableRows.last.revenue.toInt()
        : 0;

    return HarvestSimulationSummary(
      name: name,
      date: createdAt,
      commodity: commodity,
      totalHarvestMt: totalHarvestMt,
      feedCost: feedCost,
      potentialRevenue: potentialRevenue,
      iconAsset: Assets.icons.general.pieChart, // Default icon
      iconBackgroundColor:
          HarvestCalculatorDesignConstants.simulationCardIconBackgroundBlue,
    );
  }
}

/// Presentation model for harvest simulation summary data.
class HarvestSimulationSummary {
  const HarvestSimulationSummary({
    required this.name,
    required this.date,
    required this.commodity,
    required this.totalHarvestMt,
    required this.feedCost,
    required this.potentialRevenue,
    required this.iconAsset,
    required this.iconBackgroundColor,
  });

  final String name;
  final DateTime date;
  final String commodity;
  final double totalHarvestMt;
  final int feedCost;
  final int potentialRevenue;
  final String iconAsset;
  final Color iconBackgroundColor;
}
