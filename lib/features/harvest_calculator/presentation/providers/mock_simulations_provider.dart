import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/harvest_simulation.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/simulation_chart_data.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/simulation_table_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mock_simulations_provider.g.dart';

/// Mock provider for testing simulation list screen with sample data.
/// Use this provider instead of savedSimulationsDataProvider for development/testing.
@riverpod
Future<List<HarvestSimulation>> mockSimulationsData(
  MockSimulationsDataRef ref,
) async {
  // Simulate API delay
  await Future<void>.delayed(const Duration(milliseconds: 500));

  return _mockSimulations;
}

/// Sample mock data for harvest simulations
final _mockSimulations = [
  HarvestSimulation(
    id: 'sim-001',
    name: 'Udang Vaname - Kolam A',
    createdAt: DateTime(2024, 11, 20, 10, 30),
    commodity: 'Udang',
    cultivationSystem: 'Semi-Intensif',
    pondArea: 5000.0, // 5000 m²
    targetHarvest: 15000.0, // 15 ton
    estimatedADG: 0.8,
    targetDOC: 120,
    targetSR: 80.0,
    estimatedFCR: 1.2,
    targetBiomass: 15000.0,
    sellingPrice: 85000.0, // Rp 85,000/kg
    feedPrice: 15000.0, // Rp 15,000/kg
    cycleType: 'Single Batch',
    currentDOC: 95,
    results: SimulationResults(
      potentialRevenue: 1275000000.0, // Rp 1.275M
      potentialFeedCost: 270000000.0, // Rp 270M
      potentialProfit: 1005000000.0, // Rp 1.005M
      biomass: 15000.0,
      biomassPoints: [
        BiomassPoint(doc: 30, biomass: 1250.0, partialHarvest: null),
        BiomassPoint(doc: 60, biomass: 4500.0, partialHarvest: null),
        BiomassPoint(doc: 90, biomass: 9800.0, partialHarvest: 2450.0),
        BiomassPoint(doc: 120, biomass: 15000.0, partialHarvest: null),
      ],
      feedVsRevenuePoints: [
        FeedPoint(doc: 30, feedCost: 45000000.0, revenue: 106250000.0),
        FeedPoint(doc: 60, feedCost: 135000000.0, revenue: 382500000.0),
        FeedPoint(doc: 90, feedCost: 220500000.0, revenue: 833000000.0),
        FeedPoint(doc: 120, feedCost: 270000000.0, revenue: 1275000000.0),
      ],
      tableRows: [
        SimulationTableRow(
          doc: 30,
          weight: 25.0,
          quantity: 50000,
          sr: 80.0,
          fcr: 1.2,
          adg: 0.8,
          biomass: 1250.0,
          sellingPrice: 85000.0,
          feedPrice: 15000.0,
          revenue: 106250000.0,
          feedCost: 45000000.0,
          profit: 61250000.0,
        ),
        SimulationTableRow(
          doc: 60,
          weight: 40.0,
          quantity: 112500,
          sr: 75.0,
          fcr: 1.25,
          adg: 0.75,
          biomass: 4500.0,
          sellingPrice: 85000.0,
          feedPrice: 15000.0,
          revenue: 382500000.0,
          feedCost: 135000000.0,
          profit: 247500000.0,
        ),
        SimulationTableRow(
          doc: 90,
          weight: 55.0,
          quantity: 178200,
          sr: 70.0,
          fcr: 1.3,
          adg: 0.7,
          biomass: 9800.0,
          sellingPrice: 85000.0,
          feedPrice: 15000.0,
          revenue: 833000000.0,
          feedCost: 220500000.0,
          profit: 612500000.0,
        ),
        SimulationTableRow(
          doc: 120,
          weight: 70.0,
          quantity: 214286,
          sr: 65.0,
          fcr: 1.35,
          adg: 0.65,
          biomass: 15000.0,
          sellingPrice: 85000.0,
          feedPrice: 15000.0,
          revenue: 1275000000.0,
          feedCost: 270000000.0,
          profit: 1005000000.0,
        ),
      ],
    ),
  ),
  HarvestSimulation(
    id: 'sim-002',
    name: 'Udang Galah - Kolam B',
    createdAt: DateTime(2024, 11, 18, 14, 15),
    commodity: 'Udang',
    cultivationSystem: 'Intensif',
    pondArea: 3000.0, // 3000 m²
    targetHarvest: 8000.0, // 8 ton
    estimatedADG: 1.2,
    targetDOC: 90,
    targetSR: 85.0,
    estimatedFCR: 1.1,
    targetBiomass: 8000.0,
    sellingPrice: 120000.0, // Rp 120,000/kg
    feedPrice: 18000.0, // Rp 18,000/kg
    cycleType: 'Single Batch',
    currentDOC: 75,
    results: SimulationResults(
      potentialRevenue: 960000000.0, // Rp 960M
      potentialFeedCost: 129600000.0, // Rp 129.6M
      potentialProfit: 830400000.0, // Rp 830.4M
      biomass: 8000.0,
      biomassPoints: [
        BiomassPoint(doc: 20, biomass: 800.0, partialHarvest: null),
        BiomassPoint(doc: 40, biomass: 2800.0, partialHarvest: null),
        BiomassPoint(doc: 60, biomass: 5200.0, partialHarvest: 1300.0),
        BiomassPoint(doc: 90, biomass: 8000.0, partialHarvest: null),
      ],
      feedVsRevenuePoints: [
        FeedPoint(doc: 20, feedCost: 25920000.0, revenue: 96000000.0),
        FeedPoint(doc: 40, feedCost: 77760000.0, revenue: 336000000.0),
        FeedPoint(doc: 60, feedCost: 116640000.0, revenue: 624000000.0),
        FeedPoint(doc: 90, feedCost: 129600000.0, revenue: 960000000.0),
      ],
      tableRows: [
        SimulationTableRow(
          doc: 20,
          weight: 20.0,
          quantity: 40000,
          sr: 85.0,
          fcr: 1.1,
          adg: 1.2,
          biomass: 800.0,
          sellingPrice: 120000.0,
          feedPrice: 18000.0,
          revenue: 96000000.0,
          feedCost: 25920000.0,
          profit: 70080000.0,
        ),
        SimulationTableRow(
          doc: 40,
          weight: 35.0,
          quantity: 80000,
          sr: 80.0,
          fcr: 1.15,
          adg: 1.1,
          biomass: 2800.0,
          sellingPrice: 120000.0,
          feedPrice: 18000.0,
          revenue: 336000000.0,
          feedCost: 77760000.0,
          profit: 258240000.0,
        ),
        SimulationTableRow(
          doc: 60,
          weight: 48.0,
          quantity: 108333,
          sr: 75.0,
          fcr: 1.2,
          adg: 1.0,
          biomass: 5200.0,
          sellingPrice: 120000.0,
          feedPrice: 18000.0,
          revenue: 624000000.0,
          feedCost: 116640000.0,
          profit: 507360000.0,
        ),
        SimulationTableRow(
          doc: 90,
          weight: 60.0,
          quantity: 133333,
          sr: 70.0,
          fcr: 1.25,
          adg: 0.9,
          biomass: 8000.0,
          sellingPrice: 120000.0,
          feedPrice: 18000.0,
          revenue: 960000000.0,
          feedCost: 129600000.0,
          profit: 830400000.0,
        ),
      ],
    ),
  ),
  HarvestSimulation(
    id: 'sim-003',
    name: 'Udang Windu - Kolam C',
    createdAt: DateTime(2024, 11, 15, 9, 45),
    commodity: 'Udang',
    cultivationSystem: 'Tradisional',
    pondArea: 8000.0, // 8000 m²
    targetHarvest: 12000.0, // 12 ton
    estimatedADG: 0.6,
    targetDOC: 150,
    targetSR: 70.0,
    estimatedFCR: 1.4,
    targetBiomass: 12000.0,
    sellingPrice: 95000.0, // Rp 95,000/kg
    feedPrice: 12000.0, // Rp 12,000/kg
    cycleType: 'Multi Batch',
    currentDOC: 110,
    results: SimulationResults(
      potentialRevenue: 1140000000.0, // Rp 1.14B
      potentialFeedCost: 201600000.0, // Rp 201.6M
      potentialProfit: 938400000.0, // Rp 938.4M
      biomass: 12000.0,
      biomassPoints: [
        BiomassPoint(doc: 40, biomass: 960.0, partialHarvest: null),
        BiomassPoint(doc: 80, biomass: 3840.0, partialHarvest: 960.0),
        BiomassPoint(doc: 120, biomass: 7680.0, partialHarvest: 1920.0),
        BiomassPoint(doc: 150, biomass: 12000.0, partialHarvest: null),
      ],
      feedVsRevenuePoints: [
        FeedPoint(doc: 40, feedCost: 46080000.0, revenue: 91200000.0),
        FeedPoint(doc: 80, feedCost: 110592000.0, revenue: 364800000.0),
        FeedPoint(doc: 120, feedCost: 165888000.0, revenue: 729600000.0),
        FeedPoint(doc: 150, feedCost: 201600000.0, revenue: 1140000000.0),
      ],
      tableRows: [
        SimulationTableRow(
          doc: 40,
          weight: 18.0,
          quantity: 53333,
          sr: 70.0,
          fcr: 1.4,
          adg: 0.6,
          biomass: 960.0,
          sellingPrice: 95000.0,
          feedPrice: 12000.0,
          revenue: 91200000.0,
          feedCost: 46080000.0,
          profit: 45120000.0,
        ),
        SimulationTableRow(
          doc: 80,
          weight: 28.0,
          quantity: 137143,
          sr: 65.0,
          fcr: 1.45,
          adg: 0.55,
          biomass: 3840.0,
          sellingPrice: 95000.0,
          feedPrice: 12000.0,
          revenue: 364800000.0,
          feedCost: 110592000.0,
          profit: 254208000.0,
        ),
        SimulationTableRow(
          doc: 120,
          weight: 38.0,
          quantity: 202105,
          sr: 60.0,
          fcr: 1.5,
          adg: 0.5,
          biomass: 7680.0,
          sellingPrice: 95000.0,
          feedPrice: 12000.0,
          revenue: 729600000.0,
          feedCost: 165888000.0,
          profit: 563712000.0,
        ),
        SimulationTableRow(
          doc: 150,
          weight: 45.0,
          quantity: 266667,
          sr: 55.0,
          fcr: 1.55,
          adg: 0.45,
          biomass: 12000.0,
          sellingPrice: 95000.0,
          feedPrice: 12000.0,
          revenue: 1140000000.0,
          feedCost: 201600000.0,
          profit: 938400000.0,
        ),
      ],
    ),
  ),
  HarvestSimulation(
    id: 'sim-004',
    name: 'Udang Vaname - Kolam D (Premium)',
    createdAt: DateTime(2024, 11, 12, 16, 20),
    commodity: 'Udang',
    cultivationSystem: 'Super Intensif',
    pondArea: 2000.0, // 2000 m²
    targetHarvest: 6000.0, // 6 ton
    estimatedADG: 1.5,
    targetDOC: 75,
    targetSR: 90.0,
    estimatedFCR: 0.9,
    targetBiomass: 6000.0,
    sellingPrice: 150000.0, // Rp 150,000/kg (premium price)
    feedPrice: 25000.0, // Rp 25,000/kg (premium feed)
    cycleType: 'Single Batch',
    currentDOC: 65,
    results: SimulationResults(
      potentialRevenue: 900000000.0, // Rp 900M
      potentialFeedCost: 135000000.0, // Rp 135M
      potentialProfit: 765000000.0, // Rp 765M
      biomass: 6000.0,
      biomassPoints: [
        BiomassPoint(doc: 15, biomass: 675.0, partialHarvest: null),
        BiomassPoint(doc: 30, biomass: 2700.0, partialHarvest: null),
        BiomassPoint(doc: 45, biomass: 4860.0, partialHarvest: null),
        BiomassPoint(doc: 75, biomass: 6000.0, partialHarvest: null),
      ],
      feedVsRevenuePoints: [
        FeedPoint(doc: 15, feedCost: 16875000.0, revenue: 101250000.0),
        FeedPoint(doc: 30, feedCost: 50625000.0, revenue: 405000000.0),
        FeedPoint(doc: 45, feedCost: 101250000.0, revenue: 729000000.0),
        FeedPoint(doc: 75, feedCost: 135000000.0, revenue: 900000000.0),
      ],
      tableRows: [
        SimulationTableRow(
          doc: 15,
          weight: 15.0,
          quantity: 45000,
          sr: 90.0,
          fcr: 0.9,
          adg: 1.5,
          biomass: 675.0,
          sellingPrice: 150000.0,
          feedPrice: 25000.0,
          revenue: 101250000.0,
          feedCost: 16875000.0,
          profit: 84375000.0,
        ),
        SimulationTableRow(
          doc: 30,
          weight: 30.0,
          quantity: 90000,
          sr: 85.0,
          fcr: 0.95,
          adg: 1.4,
          biomass: 2700.0,
          sellingPrice: 150000.0,
          feedPrice: 25000.0,
          revenue: 405000000.0,
          feedCost: 50625000.0,
          profit: 354375000.0,
        ),
        SimulationTableRow(
          doc: 45,
          weight: 43.0,
          quantity: 139535,
          sr: 80.0,
          fcr: 1.0,
          adg: 1.3,
          biomass: 4860.0,
          sellingPrice: 150000.0,
          feedPrice: 25000.0,
          revenue: 729000000.0,
          feedCost: 101250000.0,
          profit: 627750000.0,
        ),
        SimulationTableRow(
          doc: 75,
          weight: 55.0,
          quantity: 109091,
          sr: 75.0,
          fcr: 1.05,
          adg: 1.1,
          biomass: 6000.0,
          sellingPrice: 150000.0,
          feedPrice: 25000.0,
          revenue: 900000000.0,
          feedCost: 135000000.0,
          profit: 765000000.0,
        ),
      ],
    ),
  ),
  HarvestSimulation(
    id: 'sim-005',
    name: 'Udang Vaname - Kolam E (Ekstensif)',
    createdAt: DateTime(2024, 11, 10, 11, 00),
    commodity: 'Udang',
    cultivationSystem: 'Ekstensif',
    pondArea: 15000.0, // 15000 m²
    targetHarvest: 9000.0, // 9 ton
    estimatedADG: 0.4,
    targetDOC: 180,
    targetSR: 60.0,
    estimatedFCR: 1.8,
    targetBiomass: 9000.0,
    sellingPrice: 70000.0, // Rp 70,000/kg
    feedPrice: 8000.0, // Rp 8,000/kg
    cycleType: 'Multi Batch',
    currentDOC: 140,
    results: SimulationResults(
      potentialRevenue: 630000000.0, // Rp 630M
      potentialFeedCost: 129600000.0, // Rp 129.6M
      potentialProfit: 500400000.0, // Rp 500.4M
      biomass: 9000.0,
      biomassPoints: [
        BiomassPoint(doc: 50, biomass: 600.0, partialHarvest: null),
        BiomassPoint(doc: 100, biomass: 2400.0, partialHarvest: 600.0),
        BiomassPoint(doc: 150, biomass: 5400.0, partialHarvest: 1350.0),
        BiomassPoint(doc: 180, biomass: 9000.0, partialHarvest: null),
      ],
      feedVsRevenuePoints: [
        FeedPoint(doc: 50, feedCost: 34560000.0, revenue: 42000000.0),
        FeedPoint(doc: 100, feedCost: 69120000.0, revenue: 168000000.0),
        FeedPoint(doc: 150, feedCost: 103680000.0, revenue: 378000000.0),
        FeedPoint(doc: 180, feedCost: 129600000.0, revenue: 630000000.0),
      ],
      tableRows: [
        SimulationTableRow(
          doc: 50,
          weight: 12.0,
          quantity: 50000,
          sr: 60.0,
          fcr: 1.8,
          adg: 0.4,
          biomass: 600.0,
          sellingPrice: 70000.0,
          feedPrice: 8000.0,
          revenue: 42000000.0,
          feedCost: 34560000.0,
          profit: 7440000.0,
        ),
        SimulationTableRow(
          doc: 100,
          weight: 20.0,
          quantity: 120000,
          sr: 55.0,
          fcr: 1.85,
          adg: 0.35,
          biomass: 2400.0,
          sellingPrice: 70000.0,
          feedPrice: 8000.0,
          revenue: 168000000.0,
          feedCost: 69120000.0,
          profit: 98880000.0,
        ),
        SimulationTableRow(
          doc: 150,
          weight: 27.0,
          quantity: 200000,
          sr: 50.0,
          fcr: 1.9,
          adg: 0.3,
          biomass: 5400.0,
          sellingPrice: 70000.0,
          feedPrice: 8000.0,
          revenue: 378000000.0,
          feedCost: 103680000.0,
          profit: 274320000.0,
        ),
        SimulationTableRow(
          doc: 180,
          weight: 32.0,
          quantity: 281250,
          sr: 45.0,
          fcr: 1.95,
          adg: 0.28,
          biomass: 9000.0,
          sellingPrice: 70000.0,
          feedPrice: 8000.0,
          revenue: 630000000.0,
          feedCost: 129600000.0,
          profit: 500400000.0,
        ),
      ],
    ),
  ),
];
