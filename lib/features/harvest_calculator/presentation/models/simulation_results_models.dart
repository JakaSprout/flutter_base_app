/// Data models for simulation results screen.
library;

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
      simulationType: 'cycle',
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
      totalCostNeeds: 90500000,
      recommendedLoan: 80000000,
      loanCeilingTaken: 132000000,
      remainingCredit: 50000000,
      creditLimit: 182000000,
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
  final double sr;
  final double fcr;
  final double adg;
  final double revenue;
  final double feedCost;
  final double profit;
}
