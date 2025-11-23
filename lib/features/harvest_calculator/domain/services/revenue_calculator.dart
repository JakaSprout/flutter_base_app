/// Service for calculating revenue and profit metrics in harvest simulation.
///
/// This service handles income calculations:
/// - Revenue from harvested biomass
/// - Potential revenue at any point
/// - Profit calculations
/// - Financial performance metrics
class RevenueCalculator {
  const RevenueCalculator._();

  /// Calculates revenue from harvested biomass.
  ///
  /// Formula: revenue = biomass_harvested(kg) × price_per_kg
  ///
  /// [biomassHarvested]: Amount of biomass harvested in kg
  /// [pricePerKg]: Selling price per kg in currency units
  /// Returns revenue from harvest
  static double calculateHarvestRevenue(double biomassHarvested, double pricePerKg) {
    return biomassHarvested * pricePerKg;
  }

  /// Calculates potential revenue if all current biomass were harvested.
  ///
  /// Formula: potential_revenue = current_biomass(kg) × price_per_kg
  ///
  /// [currentBiomass]: Current biomass in kg
  /// [pricePerKg]: Selling price per kg in currency units
  /// Returns potential revenue
  static double calculatePotentialRevenue(double currentBiomass, double pricePerKg) {
    return currentBiomass * pricePerKg;
  }

  /// Calculates profit from harvest.
  ///
  /// Formula: profit = harvest_revenue - feed_cost
  ///
  /// [harvestRevenue]: Revenue from harvest
  /// [feedCost]: Cost of feed consumed
  /// Returns net profit
  static double calculateProfit(double harvestRevenue, double feedCost) {
    return harvestRevenue - feedCost;
  }

  /// Calculates profit margin percentage.
  ///
  /// Formula: margin(%) = (profit / revenue) × 100
  ///
  /// [profit]: Net profit
  /// [revenue]: Total revenue
  /// Returns profit margin percentage
  static double calculateProfitMargin(double profit, double revenue) {
    if (revenue <= 0) return 0.0;
    return (profit / revenue) * 100.0;
  }

  /// Calculates return on investment (ROI).
  ///
  /// Formula: ROI(%) = (profit / total_cost) × 100
  ///
  /// [profit]: Net profit
  /// [totalCost]: Total costs incurred
  /// Returns ROI percentage
  static double calculateROI(double profit, double totalCost) {
    if (totalCost <= 0) return 0.0;
    return (profit / totalCost) * 100.0;
  }

  /// Calculates break-even biomass amount.
  ///
  /// Formula: break_even_biomass = total_feed_cost / price_per_kg
  ///
  /// [totalFeedCost]: Total feed cost incurred
  /// [pricePerKg]: Selling price per kg
  /// Returns biomass needed to break even in kg
  static double calculateBreakEvenBiomass(double totalFeedCost, double pricePerKg) {
    if (pricePerKg <= 0) return double.infinity;
    return totalFeedCost / pricePerKg;
  }

  /// Calculates daily revenue potential.
  ///
  /// Formula: daily_potential = biomass × price_per_kg
  ///
  /// [biomass]: Current biomass in kg
  /// [pricePerKg]: Selling price per kg
  /// Returns daily revenue potential
  static double calculateDailyRevenuePotential(double biomass, double pricePerKg) {
    return biomass * pricePerKg;
  }

  /// Calculates total revenue from multiple harvests.
  ///
  /// Formula: total_revenue = Σ(harvest_revenues)
  ///
  /// [harvestRevenues]: List of revenue amounts from each harvest
  /// Returns total revenue
  static double calculateTotalRevenue(List<double> harvestRevenues) {
    return harvestRevenues.fold(0.0, (sum, revenue) => sum + revenue);
  }

  /// Calculates average revenue per day.
  ///
  /// Formula: avg_daily_revenue = total_revenue / simulation_days
  ///
  /// [totalRevenue]: Total revenue earned
  /// [simulationDays]: Number of days in simulation
  /// Returns average daily revenue
  static double calculateAverageDailyRevenue(double totalRevenue, int simulationDays) {
    if (simulationDays <= 0) return 0.0;
    return totalRevenue / simulationDays;
  }

  /// Calculates revenue growth rate between periods.
  ///
  /// Formula: growth_rate(%) = ((current_revenue - previous_revenue) / previous_revenue) × 100
  ///
  /// [currentRevenue]: Revenue in current period
  /// [previousRevenue]: Revenue in previous period
  /// Returns growth rate percentage
  static double calculateRevenueGrowthRate(double currentRevenue, double previousRevenue) {
    if (previousRevenue <= 0) return 0.0;
    return ((currentRevenue - previousRevenue) / previousRevenue) * 100.0;
  }
}

