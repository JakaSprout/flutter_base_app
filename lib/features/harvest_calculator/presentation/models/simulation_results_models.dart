/// Data models for simulation results screen.
library;

import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/simulation_parameters.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/simulation_result.dart';

/// Arguments holder for simulation results screen.
class SimulationResultsScreenArgs {
  SimulationResultsScreenArgs({
    required this.simulationName,
    required this.createdAt,
    required this.adg,
    required this.doc,
    required this.commodity,
    required this.cultivationSystem,
    required this.biomassPoints,
    required this.feedVsRevenuePoints,
    required this.tableRows,
    this.isPreview = true,
    this.simulationType = 'cycle',
    this.automaticHarvestDoc,
    this.simulationResult,
    this.parameters,
    // Agent mode specific data
    this.ltvPercentage,
    this.harvestGuaranteePotential,
    this.cultivationProgress,
    this.currentABW,
    this.harvestABW,
    this.feedNeeds,
    this.feedNeedsUntilHarvest,
    this.maxLoanCeiling,
    this.totalCostNeeds,
    this.recommendedLoan,
    this.loanCeilingTaken,
    this.remainingCredit,
    this.creditLimit,
  });

  /// Creates args from actual simulation result
  factory SimulationResultsScreenArgs.fromSimulationResult(
    SimulationResult simulationResult,
    SimulationParameters parameters, {
    String? simulationName,
    String? commodity,
    String? cultivationSystem,
    String? simulationType,
    DateTime? createdAt,
    bool? isPreview,
  }) {
    // Calculate total pond capacity: pondArea × capacityKgPerM2
    final totalPondCapacity = parameters.pondArea * parameters.capacityKgPerM2;

    // Convert daily results to chart points (all days for detailed view)
    final filteredDailyResults = simulationResult.dailyResults;

    // Create map of harvest percentages by DOC for quick lookup
    final harvestPercentages = <int, double>{};
    for (final harvest in simulationResult.harvestSummaries) {
      harvestPercentages[harvest.doc] = harvest.percentage;
    }

    final biomassPoints = filteredDailyResults.map((daily) {
      return BiomassChartPoint(
        doc: daily.doc,
        biomass: daily.biomass,
        capacity: totalPondCapacity, // Use total pond capacity, not per m²
        feedCumulative: daily.cumulativeFeedConsumption,
        harvestPercentage:
            harvestPercentages[daily.doc], // Use actual harvest percentage
      );
    }).toList();

    // Convert to feed vs revenue points (all days for detailed view)
    // Calculate cumulative revenue: biomass × sellingPricePerKg (rounded to match table display)
    final feedVsRevenuePoints = filteredDailyResults.map((daily) {
      final cumulativeRevenue = (daily.biomass * parameters.sellingPricePerKg)
          .roundToDouble();
      return FeedChartPoint(
        doc: daily.doc,
        feed: daily.cumulativeFeedCost.roundToDouble(),
        revenue:
            cumulativeRevenue, // Round to integer to match table currency formatting
      );
    }).toList();

    // Convert to table rows
    final tableRows = simulationResult.dailyResults.map((daily) {
      final cumulativeRevenue = daily.biomass * parameters.sellingPricePerKg;
      final rowData = SimulationTableRowData(
        doc: daily.doc,
        weight: daily.weight,
        population: daily.population,
        biomass: daily.biomass,
        capacityPerPond: totalPondCapacity,
        dailyFeedConsumption: daily.dailyFeedConsumption,
        cumulativeFeedConsumption: daily.cumulativeFeedConsumption,
        sr: daily.survivalRate,
        fcr: daily.fcr,
        adg: daily.adg,
        revenue: cumulativeRevenue, // Use calculated cumulative revenue
        feedCost: daily.cumulativeFeedCost,
        profit:
            cumulativeRevenue - daily.cumulativeFeedCost, // Recalculate profit
      );

      return rowData;
    }).toList();

    // Calculate agent-specific metrics if this is agent mode
    final isAgentMode = simulationType == 'agent';
    double? harvestGuaranteePotential;
    double? cultivationProgress;
    double? currentABW;
    double? harvestABW;
    double? feedNeeds;
    double? feedNeedsUntilHarvest;
    double? maxLoanCeiling;
    double? totalCostNeeds;
    double? recommendedLoan;
    double? loanCeilingTaken;
    double? remainingCredit;
    double? ltvPercentageValue; // Local variable for LTV calculation
    double? creditLimitValue; // Local variable for credit limit

    if (isAgentMode) {
      // Agent mode calculations based on CSV formula
      final currentDOC = parameters.currentDOC ?? 1;
      final currentBiomassValue = parameters.currentBiomass ?? 0;
      final stockingValue = parameters.stocking ?? 0;
      final estimatedHarvestYieldValue = parameters.estimatedHarvestYield ?? 0;
      final totalFeedObligationValue =
          parameters.totalFeedPaymentObligation ?? 0;

      // OUTPUT A: Potensi Jaminan Panen = Estimasi hasil panen × Harga beli panen
      // Formula: I × H = 6500 × 28,000 = 182,000,000
      // For agent mode, use harvest purchase price instead of selling price
      harvestGuaranteePotential =
          estimatedHarvestYieldValue *
          (parameters.harvestPurchasePrice ?? parameters.sellingPricePerKg);

      // OUTPUT C: Progress Budidaya = (DOC saat ini / Target DOC) × 100%
      // Formula: (A / F) × 100 = (90 / 100) × 100 = 90%
      cultivationProgress = ((currentDOC / parameters.targetDOC) * 100).clamp(
        0,
        100,
      );

      // OUTPUT D: Estimasi ABW Saat Ini = (Biomassa saat ini / Jumlah tebaran) × 1000
      // Formula: (B / C) × 1000 = (5000 / 21000) × 1000 = 238.1 gram
      currentABW = stockingValue > 0
          ? (currentBiomassValue / stockingValue) * 1000
          : 0;

      // OUTPUT E: Estimasi ABW Saat Panen = (Hasil panen / (Tebaran × SR%)) × 1000
      // Formula: (I / (C × E/100)) × 1000 = (6500 / (21000 × 0.9)) × 1000 = 343.9 gram
      final survivedPopulation = stockingValue * (parameters.targetSR / 100);
      harvestABW = survivedPopulation > 0
          ? (estimatedHarvestYieldValue / survivedPopulation) * 1000
          : 0;

      // OUTPUT F: Estimasi Kebutuhan Pakan = (Hasil panen - Biomassa saat ini) × FCR
      // Formula: (I - B) × J = (6500 - 5000) × 1.5 = 2250 kg
      final biomassDifference =
          estimatedHarvestYieldValue - currentBiomassValue;
      feedNeeds = biomassDifference * parameters.estimatedFCR;

      // OUTPUT G: Kebutuhan Pakan Hingga Panen = Kebutuhan pakan × Harga pakan
      // Formula: F × K = 2250 × 18,000 = 40,500,000
      feedNeedsUntilHarvest = feedNeeds * parameters.feedPricePerKg;

      // OUTPUT I: Plafon Pinjaman Maksimal = Potensi jaminan - Total kewajiban bayar pakan
      // Formula: A - G = 182,000,000 - 50,000,000 = 132,000,000
      maxLoanCeiling = harvestGuaranteePotential - totalFeedObligationValue;

      // OUTPUT B: LTV Ratio = (Total kewajiban pakan / Potensi jaminan) × 100
      // Formula: (G / A) × 100 = (50,000,000 / 182,000,000) × 100 = 27.5%
      ltvPercentageValue = harvestGuaranteePotential > 0
          ? (totalFeedObligationValue / harvestGuaranteePotential) * 100
          : 0;

      // Total Cost Needs = Total kewajiban bayar pakan + Estimasi kebutuhan pakan hingga panen
      totalCostNeeds = totalFeedObligationValue + feedNeedsUntilHarvest;

      // For agent mode, recommended loan is based on feed needs until harvest
      // Recommended Loan = Kebutuhan pakan hingga panen (business need)
      recommendedLoan = feedNeedsUntilHarvest;

      // Loan ceiling taken = Max loan ceiling (plafon penuh yang diambil)
      loanCeilingTaken = maxLoanCeiling;

      // Remaining credit = Current loan obligation (sisa kredit yang tersedia)
      remainingCredit = totalFeedObligationValue;

      // Credit limit = Harvest guarantee potential (for agent mode)
      creditLimitValue = harvestGuaranteePotential;
    }

    return SimulationResultsScreenArgs(
      simulationName:
          simulationName ??
          'Simulasi ${createdAt?.toString() ?? DateTime.now().toString()}',
      createdAt: createdAt ?? DateTime.now(),
      adg: parameters.estimatedADG,
      doc: parameters.targetDOC,
      commodity: commodity ?? 'Udang',
      cultivationSystem: cultivationSystem ?? 'Intensif',
      simulationType: simulationType ?? 'cycle',
      isPreview:
          isPreview ??
          false, // Default to actual result, can be overridden for preview
      automaticHarvestDoc: simulationResult.automaticHarvestDoc,
      simulationResult: simulationResult,
      parameters: parameters,
      biomassPoints: biomassPoints,
      feedVsRevenuePoints: feedVsRevenuePoints,
      tableRows: tableRows,
      // Agent-specific data
      ltvPercentage: ltvPercentageValue,
      creditLimit: creditLimitValue,
      harvestGuaranteePotential: harvestGuaranteePotential,
      cultivationProgress: cultivationProgress,
      currentABW: currentABW,
      harvestABW: harvestABW,
      feedNeeds: feedNeeds,
      feedNeedsUntilHarvest: feedNeedsUntilHarvest,
      maxLoanCeiling: maxLoanCeiling,
      totalCostNeeds: totalCostNeeds,
      recommendedLoan: recommendedLoan,
      loanCeilingTaken: loanCeilingTaken,
      remainingCredit: remainingCredit,
    );
  }

  factory SimulationResultsScreenArgs.preview() {
    const docs = [0, 20, 40, 60, 80, 100, 120];
    final biomassPoints = [
      BiomassChartPoint(doc: 0, biomass: 0, capacity: 8, feedCumulative: 0),
      BiomassChartPoint(doc: 20, biomass: 3.2, capacity: 8, feedCumulative: 1),
      BiomassChartPoint(
        doc: 40,
        biomass: 6,
        capacity: 8,
        feedCumulative: 2.1,
        harvestPercentage: 30,
      ),
      BiomassChartPoint(
        doc: 60,
        biomass: 5.5,
        capacity: 8,
        feedCumulative: 3.2,
      ),
      BiomassChartPoint(doc: 80, biomass: 7, capacity: 8, feedCumulative: 4.1),
      BiomassChartPoint(
        doc: 100,
        biomass: 6.5,
        capacity: 8,
        feedCumulative: 5.1,
      ),
      BiomassChartPoint(doc: 120, biomass: 8, capacity: 8, feedCumulative: 6.3),
    ];

    final feedVsRevenuePoints = docs
        .map(
          (doc) => FeedChartPoint(
            doc: doc,
            revenue: doc.toDouble() * 120000,
            feed: doc.toDouble() * 90000,
          ),
        )
        .toList();

    final tableRows = [
      SimulationTableRowData(
        doc: 10,
        weight: 0.1,
        population: 0.1,
        biomass: 0.1,
        capacityPerPond: 7.5,
        dailyFeedConsumption: 0.001,
        cumulativeFeedConsumption: 0.01,
        sr: 96,
        fcr: 1.6,
        adg: 0.1,
        revenue: 100000,
        feedCost: 60000,
        profit: 40000,
      ),
      SimulationTableRowData(
        doc: 20,
        weight: 0.9,
        population: 0.9,
        biomass: 0.9,
        capacityPerPond: 7.5,
        dailyFeedConsumption: 0.018,
        cumulativeFeedConsumption: 0.036,
        sr: 94,
        fcr: 1.5,
        adg: 0.2,
        revenue: 180000,
        feedCost: 90000,
        profit: 90000,
      ),
      SimulationTableRowData(
        doc: 40,
        weight: 2,
        population: 2,
        biomass: 2,
        capacityPerPond: 7.5,
        dailyFeedConsumption: 0.04,
        cumulativeFeedConsumption: 0.08,
        sr: 92,
        fcr: 1.4,
        adg: 0.3,
        revenue: 260000,
        feedCost: 130000,
        profit: 130000,
      ),
      SimulationTableRowData(
        doc: 60,
        weight: 3,
        population: 3,
        biomass: 3,
        capacityPerPond: 7.5,
        dailyFeedConsumption: 0.06,
        cumulativeFeedConsumption: 0.12,
        sr: 90,
        fcr: 1.3,
        adg: 0.35,
        revenue: 360000,
        feedCost: 180000,
        profit: 180000,
      ),
      SimulationTableRowData(
        doc: 80,
        weight: 4.1,
        population: 4.1,
        biomass: 4.1,
        capacityPerPond: 7.5,
        dailyFeedConsumption: 0.082,
        cumulativeFeedConsumption: 0.164,
        sr: 89,
        fcr: 1.25,
        adg: 0.4,
        revenue: 480000,
        feedCost: 230000,
        profit: 250000,
      ),
      SimulationTableRowData(
        doc: 100,
        weight: 6.1,
        population: 6.1,
        biomass: 6.1,
        capacityPerPond: 7.5,
        dailyFeedConsumption: 0.122,
        cumulativeFeedConsumption: 0.244,
        sr: 88,
        fcr: 1.2,
        adg: 0.45,
        revenue: 620000,
        feedCost: 300000,
        profit: 320000,
      ),
      SimulationTableRowData(
        doc: 120,
        weight: 8,
        population: 8,
        biomass: 8,
        capacityPerPond: 7.5,
        dailyFeedConsumption: 0.16,
        cumulativeFeedConsumption: 0.32,
        sr: 87,
        fcr: 1.2,
        adg: 0.5,
        revenue: 780000,
        feedCost: 360000,
        profit: 420000,
      ),
    ];

    return SimulationResultsScreenArgs(
      simulationName: 'Simulasi 2026',
      createdAt: DateTime(2025, 11, 17),
      adg: 1.5,
      doc: 120,
      commodity: 'Udang',
      cultivationSystem: 'RAS',
      biomassPoints: biomassPoints,
      feedVsRevenuePoints: feedVsRevenuePoints,
      tableRows: tableRows,
    );
  }

  /// Factory method for agent mode preview.
  factory SimulationResultsScreenArgs.previewAgent() {
    return SimulationResultsScreenArgs(
      simulationName: 'Simulasi Agen 2026',
      createdAt: DateTime(2025, 11, 17),
      adg: 1.5,
      doc: 120,
      commodity: 'Udang',
      cultivationSystem: 'RAS',
      biomassPoints: [],
      feedVsRevenuePoints: [],
      tableRows: [],
      simulationType: 'agent',
      ltvPercentage: 27.5,
      harvestGuaranteePotential: 182000000,
      cultivationProgress: 90,
      currentABW: 238.1,
      harvestABW: 343.9,
      feedNeeds: 2250,
      feedNeedsUntilHarvest: 40500000,
      maxLoanCeiling: 132000000,
      totalCostNeeds: 90500000, // 50M + 40.5M
      recommendedLoan: 40500000, // feedNeedsUntilHarvest (business need)
      loanCeilingTaken: 132000000, // maxLoanCeiling (plafon penuh yang diambil)
      remainingCredit: 50000000, // current obligation (sisa kredit tersedia)
      creditLimit: 182000000, // harvestGuaranteePotential
    );
  }

  final String simulationName;
  final DateTime createdAt;
  final double adg;
  final int doc;
  final String commodity;
  final String cultivationSystem;
  final bool isPreview;
  final String simulationType;
  final int? automaticHarvestDoc;
  final SimulationResult? simulationResult;
  final SimulationParameters? parameters;
  // Agent mode specific data
  final double? ltvPercentage;
  final double? harvestGuaranteePotential;
  final double? cultivationProgress;
  final double? currentABW;
  final double? harvestABW;
  final double? feedNeeds;
  final double? feedNeedsUntilHarvest;
  final double? maxLoanCeiling;
  final double? totalCostNeeds;
  final double? recommendedLoan;
  final double? loanCeilingTaken;
  final double? remainingCredit;
  final double? creditLimit;
  final List<BiomassChartPoint> biomassPoints;
  final List<FeedChartPoint> feedVsRevenuePoints;
  final List<SimulationTableRowData> tableRows;

  SimulationResultsScreenArgs copyWith({
    String? simulationName,
    DateTime? createdAt,
    double? adg,
    int? doc,
    String? commodity,
    String? cultivationSystem,
    bool? isPreview,
    String? simulationType,
    double? ltvPercentage,
    double? harvestGuaranteePotential,
    double? cultivationProgress,
    double? currentABW,
    double? harvestABW,
    double? feedNeeds,
    double? feedNeedsUntilHarvest,
    double? maxLoanCeiling,
    double? totalCostNeeds,
    double? recommendedLoan,
    double? loanCeilingTaken,
    double? remainingCredit,
    double? creditLimit,
  }) {
    return SimulationResultsScreenArgs(
      simulationName: simulationName ?? this.simulationName,
      createdAt: createdAt ?? this.createdAt,
      adg: adg ?? this.adg,
      doc: doc ?? this.doc,
      commodity: commodity ?? this.commodity,
      cultivationSystem: cultivationSystem ?? this.cultivationSystem,
      isPreview: isPreview ?? this.isPreview,
      simulationType: simulationType ?? this.simulationType,
      ltvPercentage: ltvPercentage ?? this.ltvPercentage,
      harvestGuaranteePotential:
          harvestGuaranteePotential ?? this.harvestGuaranteePotential,
      cultivationProgress: cultivationProgress ?? this.cultivationProgress,
      currentABW: currentABW ?? this.currentABW,
      harvestABW: harvestABW ?? this.harvestABW,
      feedNeeds: feedNeeds ?? this.feedNeeds,
      feedNeedsUntilHarvest:
          feedNeedsUntilHarvest ?? this.feedNeedsUntilHarvest,
      maxLoanCeiling: maxLoanCeiling ?? this.maxLoanCeiling,
      totalCostNeeds: totalCostNeeds ?? this.totalCostNeeds,
      recommendedLoan: recommendedLoan ?? this.recommendedLoan,
      loanCeilingTaken: loanCeilingTaken ?? this.loanCeilingTaken,
      remainingCredit: remainingCredit ?? this.remainingCredit,
      creditLimit: creditLimit ?? this.creditLimit,
      biomassPoints: biomassPoints,
      feedVsRevenuePoints: feedVsRevenuePoints,
      tableRows: tableRows,
    );
  }
}

/// Chart data holder for biomass chart.
class BiomassChartPoint {
  BiomassChartPoint({
    required this.doc,
    required this.biomass,
    required this.capacity,
    required this.feedCumulative,
    this.harvestPercentage,
  });

  final int doc;
  final double biomass;
  final double capacity;
  final double feedCumulative;
  final double? harvestPercentage;
}

/// Chart data holder for feed vs revenue chart.
class FeedChartPoint {
  FeedChartPoint({
    required this.doc,
    required this.feed,
    required this.revenue,
  });

  final int doc;
  final double feed;
  final double revenue;
}

/// Table row data model.
class SimulationTableRowData {
  SimulationTableRowData({
    required this.doc,
    required this.weight,
    required this.population,
    required this.biomass,
    required this.capacityPerPond,
    required this.dailyFeedConsumption,
    required this.cumulativeFeedConsumption,
    required this.sr,
    required this.fcr,
    required this.adg,
    required this.revenue,
    required this.feedCost,
    required this.profit,
  });

  final int doc;
  final double weight;
  final double population;
  final double biomass;
  final double capacityPerPond;
  final double dailyFeedConsumption;
  final double cumulativeFeedConsumption;
  final double sr;
  final double fcr;
  final double adg;
  final double revenue;
  final double feedCost;
  final double profit;
}
