import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/daily_simulation_result.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/harvest_summary.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/simulation_metrics.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/simulation_parameters.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/simulation_result.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/simulation_summary.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/services/biomass_calculator.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/services/feed_calculator.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/services/harvest_calculator.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/services/revenue_calculator.dart';

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

      // AUTO HARVEST: Check if capacity is reached or exceeded (trigger harvest immediately)
      // Panen otomatis terjadi DI HARI YANG SAMA ketika biomassa >= capacity
      // Ini berlaku untuk SEMUA panen (Panen 1, Panen 2, dst)
      if (capacityExceededDoc == 0 &&
          currentBiomass >= parameters.capacityKgPerPond) {
        // Mark and trigger harvest immediately on the same day
        capacityExceededDoc = doc;
      }

      // Trigger harvest immediately when capacity is reached
      if (capacityExceededDoc > 0 && doc >= capacityExceededDoc) {
        // Calculate daily loss percentage from Target SR and Target DOC
        final dailyLossPercentage =
            (100.0 - parameters.targetSR) / parameters.targetDOC;

        // Get harvest percentage from current event (default 50% if no events left)
        final currentEvent = harvestEventIndex < sortedHarvestEvents.length
            ? sortedHarvestEvents[harvestEventIndex]
            : null;
        final harvestPercentage = currentEvent?.percentage ?? 50.0;

        // Determine harvest description
        final harvestDescription = harvestEventIndex == 0
            ? 'Panen 1 Otomatis (Kapasitas Tercapai)'
            : harvestEventIndex == 1
            ? 'Panen 2 Otomatis (Kapasitas Tercapai)'
            : 'Panen ${harvestEventIndex + 1} Otomatis';

        if (harvestEventIndex == 0) {
          automaticHarvestDoc = doc; // Simpan DOC panen pertama
        }

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
            basePopulationReduction * (1.0 - dailyLossPercentage / 100.0);
        harvestPopulationReduction = lossAdjustedReduction;

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
          ),
        );

        harvestEventIndex++; // Move to next harvest event
        capacityExceededDoc = 0; // Reset untuk cek panen berikutnya
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

      // PANEN RAYA: Final harvest always occurs at target DOC (end of cycle)
      // This is the mandatory final harvest that collects any remaining biomass
      if (doc == parameters.targetDOC && currentPopulation > 0) {
        hasHarvest = true;
        harvestAmount = currentBiomass; // Panen semua sisa

        // Calculate daily loss percentage
        final dailyLossPercentage =
            (100.0 - parameters.targetSR) / parameters.targetDOC;

        // Calculate population reduction (100% with loss adjustment)
        final basePopulationReduction = currentPopulation;
        final lossAdjustedReduction =
            basePopulationReduction * (1.0 - dailyLossPercentage / 100.0);
        harvestPopulationReduction = lossAdjustedReduction;

        // Apply harvest
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
          ),
        );
      }

      // Create daily result
      final dailyResult = DailySimulationResult(
        doc: doc,
        weight: currentWeight,
        population: currentPopulation,
        biomass: currentBiomass,
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

    // Calculate final results
    final summary = _calculateSimulationSummary(
      dailyResults,
      parameters,
      harvestSummaries,
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
      harvestSummaries: harvestSummaries,
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
        1000.0;

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
    final halfBiomass = targetBiomass * 0.5;
    final fourFifthBiomass = targetBiomass * 0.8;

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
