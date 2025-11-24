import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/daily_simulation_result.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/harvest_summary.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/simulation_metrics.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/simulation_parameters.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/simulation_result.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/simulation_summary.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/services/biomass_calculator.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/services/calculation_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/services/feed_calculator.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/services/harvest_calculator.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/services/revenue_calculator.dart';
import 'package:flutter/foundation.dart';

/// Main orchestrator for running harvest simulations.
///
/// This service coordinates all calculation services to run a complete
/// harvest simulation from DOC 1 to target DOC, including partial harvests.
class SimulationOrchestrator {
  const SimulationOrchestrator._();

  /// Runs a complete harvest simulation with the given parameters.
  ///
  /// This method orchestrates the entire simulation process:
  /// 1. Initializes simulation state
  /// 2. Runs daily calculations from DOC 1 to target DOC
  /// 3. Handles partial harvests at specified DOCs
  /// 4. Calculates final results and metrics
  ///
  /// [parameters]: Simulation parameters including pond specs, harvest events, etc.
  /// Returns complete simulation result with daily data and summaries
  static SimulationResult runSimulation(SimulationParameters parameters) {
    debugPrint('🚀 [SimulationOrchestrator] Starting simulation');
    debugPrint('   - Target DOC: ${parameters.targetDOC}');
    debugPrint('   - Harvest events: ${parameters.harvestEvents.length}');
    for (final event in parameters.harvestEvents) {
      debugPrint('      * DOC ${event.doc} - ${event.percentage}%');
    }

    final dailyResults = <DailySimulationResult>[];
    final harvestSummaries = <HarvestSummary>[];
    int? automaticHarvestDoc;

    // Determine starting DOC (1 for full cycle, currentDOC for mid cycle)
    final startingDOC = parameters.currentDOC ?? 1;

    // Initial values for starting DOC
    var currentWeight = parameters.initialWeight;
    var currentPopulation = parameters.pondArea * parameters.stockingDensity;
    var cumulativeFeedConsumption = 0.0;
    var cumulativeFeedCost = 0.0;

    // If starting from mid-cycle, calculate weight and population for starting DOC
    if (startingDOC > 1) {
      for (var doc = 1; doc < startingDOC; doc++) {
        currentWeight = BiomassCalculator.calculateWeight(
          currentWeight,
          parameters.estimatedADG,
        );
        currentPopulation = BiomassCalculator.calculatePopulation(
          currentPopulation,
          parameters.dailyLossPercentage,
        );
      }
    }

    // Track harvest events
    final sortedHarvestEvents = _sortHarvestEvents(parameters.harvestEvents);
    var harvestEventIndex = 0;

    // Track automatic harvest trigger
    var capacityExceededDoc = 0; // DOC when capacity was first exceeded

    // Debug: Log harvest events configuration

    // Track peak biomass for metrics
    var peakBiomass = 0.0;
    var peakBiomassDay = startingDOC;

    // Run simulation day by day from starting DOC to target DOC
    for (var doc = startingDOC; doc <= parameters.targetDOC; doc++) {
      // Calculate weight for current day (grow from previous day)
      if (doc > startingDOC) {
        currentWeight = BiomassCalculator.calculateWeight(
          currentWeight,
          parameters.estimatedADG,
        );
      }

      // Calculate population with mortality (apply mortality from previous day)
      if (doc > startingDOC) {
        currentPopulation = BiomassCalculator.calculatePopulation(
          currentPopulation,
          parameters.dailyLossPercentage,
        );
      }

      // Calculate biomass
      var currentBiomass = BiomassCalculator.calculateBiomass(
        currentWeight,
        currentPopulation,
      );

      // Update peak biomass tracking
      if (currentBiomass > peakBiomass) {
        peakBiomass = currentBiomass;
        peakBiomassDay = doc;
      }

      // Check for harvest events
      var hasHarvest = false;
      double? harvestAmount;
      double? harvestPopulationReduction;

      // HARVEST LOGIC: Prioritize manual harvest events, fallback to auto-harvest
      var shouldHarvest = false;
      var harvestPercentage = CalculationConstants.defaultHarvestPercentage;
      var harvestDescription = '';
      var isManualHarvest = false;

      // MANUAL HARVEST: Check if current DOC matches any scheduled harvest event
      if (harvestEventIndex < sortedHarvestEvents.length) {
        final currentEvent = sortedHarvestEvents[harvestEventIndex];
        if (doc == currentEvent.doc) {
          // DOC matches manual harvest plan
          shouldHarvest = true;
          harvestPercentage = currentEvent.percentage;
          harvestDescription =
              'Panen ${harvestEventIndex + 1} (Manual - DOC $doc)';
          isManualHarvest = true;
          debugPrint('🌾 MANUAL HARVEST at DOC $doc with $harvestPercentage%');
        }
      }

      // AUTO HARVEST: Fallback if no manual events or all manual events completed
      if (!shouldHarvest && sortedHarvestEvents.isEmpty) {
        // Only use auto-harvest if no manual harvest events are defined
        if (capacityExceededDoc == 0 &&
            currentBiomass >= parameters.capacityKgPerPond) {
          // Mark and trigger harvest immediately on the same day
          capacityExceededDoc = doc;
        }

        if (capacityExceededDoc > 0 && doc >= capacityExceededDoc) {
          shouldHarvest = true;
          harvestDescription = harvestEventIndex == 0
              ? 'Panen 1 Otomatis (Kapasitas Tercapai)'
              : harvestEventIndex == 1
              ? 'Panen 2 Otomatis (Kapasitas Tercapai)'
              : 'Panen ${harvestEventIndex + 1} Otomatis';

          if (harvestEventIndex == 0) {
            automaticHarvestDoc = doc; // Simpan DOC panen pertama
          }

          debugPrint(
            '🌾 AUTO HARVEST at DOC $doc with $harvestPercentage% (capacity exceeded)',
          );
        }
      }

      // Execute harvest if conditions are met
      if (shouldHarvest) {
        // Calculate daily loss percentage from Target SR and Target DOC
        final dailyLossPercentage =
            (CalculationConstants.percentageFactor - parameters.targetSR) /
            parameters.targetDOC;

        hasHarvest = true;
        harvestAmount = HarvestCalculator.calculateHarvestAmount(
          currentBiomass,
          harvestPercentage,
        );

        // Calculate population reduction with loss adjustment
        final basePopulationReduction =
            HarvestCalculator.calculatePopulationReduction(
              currentPopulation,
              harvestPercentage,
            );

        final lossAdjustedReduction =
            basePopulationReduction *
            (1.0 - dailyLossPercentage / CalculationConstants.percentageFactor);
        harvestPopulationReduction = lossAdjustedReduction;

        // Calculate harvest data before applying harvest
        final biomassBeforeHarvest = currentBiomass;
        final populationBeforeHarvest = currentPopulation;
        final harvestKg = harvestAmount;
        final harvestSize =
            populationBeforeHarvest / biomassBeforeHarvest; // individuals/kg
        final harvestValueRp = harvestKg * parameters.sellingPricePerKg;

        // Apply harvest
        currentBiomass = HarvestCalculator.calculateRemainingBiomass(
          currentBiomass,
          harvestAmount,
        );

        currentPopulation = HarvestCalculator.calculateRemainingPopulation(
          currentPopulation,
          harvestPopulationReduction,
        );

        // Create harvest summary
        final harvestRevenue = RevenueCalculator.calculateHarvestRevenue(
          harvestAmount,
          parameters.sellingPricePerKg,
        );

        harvestSummaries.add(
          HarvestSummary(
            doc: doc,
            weight: harvestAmount,
            revenue: harvestRevenue,
            percentage: harvestPercentage,
            description: harvestDescription,
            harvestKg: harvestKg,
            harvestSize: harvestSize,
            harvestValueRp: harvestValueRp,
          ),
        );

        harvestEventIndex++; // Move to next harvest event

        // Reset capacity exceeded flag only for auto-harvest
        if (!isManualHarvest) {
          capacityExceededDoc = 0; // Reset untuk cek panen berikutnya
        }
      }

      // Calculate feed consumption
      final dailyFeedConsumption = FeedCalculator.calculateDailyFeedConsumption(
        currentBiomass,
        parameters.feedingRatePercentage,
      );

      cumulativeFeedConsumption =
          FeedCalculator.calculateCumulativeFeedConsumption(
            cumulativeFeedConsumption,
            dailyFeedConsumption,
          );

      cumulativeFeedCost = FeedCalculator.calculateCumulativeFeedCost(
        cumulativeFeedConsumption,
        parameters.feedPricePerKg,
      );

      // Calculate survival rate and other metrics
      final survivalRate = BiomassCalculator.calculateSurvivalRate(
        currentPopulation,
        parameters.pondArea * parameters.stockingDensity,
      );

      final adg = doc == startingDOC
          ? parameters.estimatedADG
          : BiomassCalculator.calculateADG(
              currentWeight,
              dailyResults.last.weight,
            );

      // Calculate potential revenue
      final potentialRevenue = RevenueCalculator.calculatePotentialRevenue(
        currentBiomass,
        parameters.sellingPricePerKg,
      );

      final potentialProfit = RevenueCalculator.calculateProfit(
        potentialRevenue,
        cumulativeFeedCost,
      );

      // Store values before harvest for display purposes
      final displayWeight = currentWeight;
      final displayPopulation = currentPopulation;
      final displayBiomass = currentBiomass;

      // PANEN RAYA: Final harvest always occurs at target DOC (end of cycle)
      // This is the mandatory final harvest that collects any remaining biomass
      if (doc == parameters.targetDOC && currentPopulation > 0) {
        hasHarvest = true;
        harvestAmount = currentBiomass; // Panen semua sisa

        // Calculate daily loss percentage
        final dailyLossPercentage =
            (CalculationConstants.percentageFactor - parameters.targetSR) /
            parameters.targetDOC;

        // Calculate population reduction (100% with loss adjustment)
        final basePopulationReduction = currentPopulation;
        final lossAdjustedReduction =
            basePopulationReduction *
            (1.0 - dailyLossPercentage / CalculationConstants.percentageFactor);
        harvestPopulationReduction = lossAdjustedReduction;

        // Calculate harvest data before applying harvest
        final biomassBeforeHarvest = displayBiomass;
        final populationBeforeHarvest = displayPopulation;
        final harvestKg = harvestAmount;
        final harvestSize =
            populationBeforeHarvest / biomassBeforeHarvest; // individuals/kg
        final harvestValueRp = harvestKg * parameters.sellingPricePerKg;

        // Apply harvest (only for internal calculations, display values remain unchanged)
        currentBiomass = 0;
        currentPopulation = 0;

        // Create harvest summary
        final harvestRevenue = RevenueCalculator.calculateHarvestRevenue(
          harvestAmount,
          parameters.sellingPricePerKg,
        );

        harvestSummaries.add(
          HarvestSummary(
            doc: doc,
            weight: harvestAmount,
            revenue: harvestRevenue,
            percentage: 100,
            description: 'Panen Raya (Akhir Siklus)',
            harvestKg: harvestKg,
            harvestSize: harvestSize,
            harvestValueRp: harvestValueRp,
          ),
        );
      }

      // Create daily result using values BEFORE harvest (for final harvest display)
      final dailyResult = DailySimulationResult(
        doc: doc,
        weight: displayWeight,
        population: displayPopulation,
        biomass: displayBiomass,
        dailyFeedConsumption: dailyFeedConsumption,
        cumulativeFeedConsumption: cumulativeFeedConsumption,
        potentialRevenue: potentialRevenue,
        cumulativeFeedCost: cumulativeFeedCost,
        potentialProfit: potentialProfit,
        survivalRate: survivalRate,
        fcr: _calculateCurrentFCR(
          cumulativeFeedConsumption,
          currentBiomass,
          parameters,
        ),
        adg: adg,
        hasHarvest: hasHarvest,
        harvestAmount: harvestAmount,
        harvestPopulationReduction: harvestPopulationReduction,
      );

      dailyResults.add(dailyResult);
    }

    // Calculate feed consumption between harvests for cycle mode
    final updatedHarvestSummaries = _calculateFeedConsumptionBetweenHarvests(
      harvestSummaries,
      dailyResults,
      parameters,
    );

    // Calculate final results
    final summary = _calculateSimulationSummary(
      dailyResults,
      parameters,
      updatedHarvestSummaries,
    );
    final metrics = _calculateSimulationMetrics(
      dailyResults,
      parameters,
      peakBiomass,
      peakBiomassDay,
    );

    return SimulationResult(
      dailyResults: dailyResults,
      summary: summary,
      harvestSummaries: updatedHarvestSummaries,
      metrics: metrics,
      automaticHarvestDoc: automaticHarvestDoc,
    );
  }

  /// Sorts harvest events by DOC ascending
  static List<HarvestEvent> _sortHarvestEvents(List<HarvestEvent> events) {
    return events.toList()..sort((a, b) => a.doc.compareTo(b.doc));
  }

  /// Calculates current FCR for the day
  static double _calculateCurrentFCR(
    double cumulativeFeed,
    double currentBiomass,
    SimulationParameters parameters,
  ) {
    final initialBiomass =
        parameters.initialWeight *
        parameters.pondArea *
        parameters.stockingDensity /
        CalculationConstants.gramsToKilograms;

    final biomassGain = currentBiomass - initialBiomass;
    return BiomassCalculator.calculateFCR(cumulativeFeed, biomassGain);
  }

  /// Calculates simulation summary statistics
  static SimulationSummary _calculateSimulationSummary(
    List<DailySimulationResult> dailyResults,
    SimulationParameters parameters,
    List<HarvestSummary> harvestSummaries,
  ) {
    if (dailyResults.isEmpty) {
      return const SimulationSummary(
        finalBiomass: 0,
        totalFeedConsumption: 0,
        totalRevenue: 0,
        totalFeedCost: 0,
        netProfit: 0,
        finalSurvivalRate: 0,
        averageFCR: 0,
        totalHarvestWeight: 0,
        simulationDays: 0,
      );
    }

    final lastDay = dailyResults.last;
    final totalRevenue = harvestSummaries.fold<double>(
      0,
      (sum, h) => sum + h.revenue,
    );
    final averageFCR = dailyResults
        .map((d) => d.fcr)
        .where((fcr) => fcr.isFinite)
        .average();

    return SimulationSummary(
      finalBiomass: lastDay.biomass,
      totalFeedConsumption: lastDay.cumulativeFeedConsumption,
      totalRevenue: totalRevenue,
      totalFeedCost: lastDay.cumulativeFeedCost,
      netProfit: totalRevenue - lastDay.cumulativeFeedCost,
      finalSurvivalRate: lastDay.survivalRate,
      averageFCR: averageFCR,
      totalHarvestWeight: harvestSummaries.fold<double>(
        0,
        (sum, h) => sum + h.weight,
      ),
      simulationDays: parameters.targetDOC,
    );
  }

  /// Calculates simulation performance metrics
  static SimulationMetrics _calculateSimulationMetrics(
    List<DailySimulationResult> dailyResults,
    SimulationParameters parameters,
    double peakBiomass,
    int peakBiomassDay,
  ) {
    if (dailyResults.isEmpty) {
      return const SimulationMetrics(
        peakBiomass: 0,
        peakBiomassDay: 0,
        averageDailyFeedConsumption: 0,
        feedEfficiency: 0,
        biomassGrowthRate: 0,
        daysToHalfBiomass: 0,
        daysToFourFifthBiomass: 0,
      );
    }

    final totalFeedConsumption = dailyResults.last.cumulativeFeedConsumption;
    final simulationDays = parameters.targetDOC;

    final averageDailyFeedConsumption =
        FeedCalculator.calculateAverageDailyFeedConsumption(
          totalFeedConsumption,
          simulationDays,
        );

    final totalRevenue = dailyResults.last.potentialRevenue;
    final feedEfficiency = FeedCalculator.calculateFeedEfficiency(
      totalRevenue,
      totalFeedConsumption,
    );

    final biomassGrowthRate = peakBiomass / simulationDays;

    final targetBiomass = parameters.capacityKgPerPond;
    final halfBiomass = targetBiomass * CalculationConstants.halfBiomass;
    final fourFifthBiomass =
        targetBiomass * CalculationConstants.fourFifthBiomass;

    final daysToHalfBiomass = _findDaysToReachBiomass(
      dailyResults,
      halfBiomass,
    );
    final daysToFourFifthBiomass = _findDaysToReachBiomass(
      dailyResults,
      fourFifthBiomass,
    );

    return SimulationMetrics(
      peakBiomass: peakBiomass,
      peakBiomassDay: peakBiomassDay,
      averageDailyFeedConsumption: averageDailyFeedConsumption,
      feedEfficiency: feedEfficiency,
      biomassGrowthRate: biomassGrowthRate,
      daysToHalfBiomass: daysToHalfBiomass,
      daysToFourFifthBiomass: daysToFourFifthBiomass,
    );
  }

  /// Calculates feed consumption between harvests for cycle mode
  static List<HarvestSummary> _calculateFeedConsumptionBetweenHarvests(
    List<HarvestSummary> harvestSummaries,
    List<DailySimulationResult> dailyResults,
    SimulationParameters parameters,
  ) {
    // Only calculate for cycle mode
    if (parameters.simulationType == 'agent') {
      return harvestSummaries;
    }

    final updatedSummaries = <HarvestSummary>[];

    for (var i = 0; i < harvestSummaries.length; i++) {
      final currentHarvest = harvestSummaries[i];
      final nextHarvestDoc = i < harvestSummaries.length - 1
          ? harvestSummaries[i + 1].doc
          : parameters.targetDOC + 1; // After last harvest, no more feed

      // Calculate feed consumption from current harvest DOC to next harvest DOC (exclusive)
      var feedConsumptionKg = 0.0;
      for (var doc = currentHarvest.doc; doc < nextHarvestDoc; doc++) {
        final dailyResult = dailyResults.firstWhere(
          (result) => result.doc == doc,
          orElse: () => throw StateError('Daily result for DOC $doc not found'),
        );
        feedConsumptionKg += dailyResult.dailyFeedConsumption;
      }

      final feedConsumptionRp = feedConsumptionKg * parameters.feedPricePerKg;

      // Create updated harvest summary with feed consumption data
      final updatedSummary = HarvestSummary(
        doc: currentHarvest.doc,
        weight: currentHarvest.weight,
        revenue: currentHarvest.revenue,
        percentage: currentHarvest.percentage,
        description: currentHarvest.description,
        harvestKg: currentHarvest.harvestKg,
        harvestSize: currentHarvest.harvestSize,
        harvestValueRp: currentHarvest.harvestValueRp,
        feedConsumptionKg: feedConsumptionKg,
        feedConsumptionRp: feedConsumptionRp,
      );

      updatedSummaries.add(updatedSummary);
    }

    return updatedSummaries;
  }

  /// Finds days required to reach specific biomass level
  static int _findDaysToReachBiomass(
    List<DailySimulationResult> results,
    double targetBiomass,
  ) {
    for (var i = 0; i < results.length; i++) {
      if (results[i].biomass >= targetBiomass) {
        return results[i].doc;
      }
    }
    return results.last.doc; // Return last day if target never reached
  }
}

/// Extension for calculating average of numeric list
extension DoubleListAverage on Iterable<double> {
  double average() {
    if (isEmpty) return 0;
    final sum = fold<double>(0, (previous, current) => previous + current);
    return sum / length;
  }
}
