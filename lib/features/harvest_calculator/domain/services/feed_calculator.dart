/// Service for calculating feed consumption and related costs in harvest simulation.
///
/// This service handles feed-related calculations:
/// - Daily feed consumption based on biomass and feeding rate
/// - Cumulative feed consumption over time
/// - Feed cost calculations
/// - Feed efficiency metrics
class FeedCalculator {
  const FeedCalculator._();

  /// Calculates daily feed consumption.
  ///
  /// Formula: daily_feed(kg) = biomass(kg) × feeding_rate(%) / 100
  ///
  /// [biomass]: Current biomass in kg
  /// [feedingRatePercentage]: Feeding rate percentage (0-100)
  /// Returns daily feed consumption in kg
  static double calculateDailyFeedConsumption(double biomass, double feedingRatePercentage) {
    return biomass * (feedingRatePercentage / 100.0);
  }

  /// Calculates cumulative feed consumption up to current DOC.
  ///
  /// Formula: cumulative_feed(DOC) = cumulative_feed(DOC-1) + daily_feed(DOC)
  ///
  /// [previousCumulative]: Cumulative feed up to previous DOC
  /// [dailyFeed]: Daily feed consumption for current DOC
  /// Returns cumulative feed consumption in kg
  static double calculateCumulativeFeedConsumption(double previousCumulative, double dailyFeed) {
    return previousCumulative + dailyFeed;
  }

  /// Calculates feed cost for a given feed amount.
  ///
  /// Formula: feed_cost = feed_amount(kg) × price_per_kg
  ///
  /// [feedAmount]: Amount of feed in kg
  /// [pricePerKg]: Price per kg in currency units
  /// Returns feed cost
  static double calculateFeedCost(double feedAmount, double pricePerKg) {
    return feedAmount * pricePerKg;
  }

  /// Calculates cumulative feed cost.
  ///
  /// Formula: cumulative_cost = cumulative_feed(kg) × price_per_kg
  ///
  /// [cumulativeFeed]: Total feed consumed in kg
  /// [pricePerKg]: Price per kg in currency units
  /// Returns cumulative feed cost
  static double calculateCumulativeFeedCost(double cumulativeFeed, double pricePerKg) {
    return cumulativeFeed * pricePerKg;
  }

  /// Calculates feed efficiency (revenue per kg of feed).
  ///
  /// Formula: efficiency = total_revenue / total_feed_consumed
  ///
  /// [totalRevenue]: Total revenue generated
  /// [totalFeedConsumed]: Total feed consumed in kg
  /// Returns feed efficiency (currency units per kg feed)
  static double calculateFeedEfficiency(double totalRevenue, double totalFeedConsumed) {
    if (totalFeedConsumed <= 0) return 0.0;
    return totalRevenue / totalFeedConsumed;
  }

  /// Calculates Feed Conversion Ratio for the entire simulation.
  ///
  /// Formula: FCR = total_feed_consumed / total_biomass_harvested
  ///
  /// [totalFeedConsumed]: Total feed consumed in kg
  /// [totalBiomassHarvested]: Total biomass harvested in kg
  /// Returns overall FCR
  static double calculateOverallFCR(double totalFeedConsumed, double totalBiomassHarvested) {
    if (totalBiomassHarvested <= 0) return double.infinity;
    return totalFeedConsumed / totalBiomassHarvested;
  }

  /// Calculates average daily feed consumption.
  ///
  /// Formula: average_daily = total_feed_consumed / simulation_days
  ///
  /// [totalFeedConsumed]: Total feed consumed in kg
  /// [simulationDays]: Number of days in simulation
  /// Returns average daily feed consumption in kg/day
  static double calculateAverageDailyFeedConsumption(double totalFeedConsumed, int simulationDays) {
    if (simulationDays <= 0) return 0.0;
    return totalFeedConsumed / simulationDays;
  }

  /// Calculates feed cost as percentage of revenue.
  ///
  /// Formula: cost_percentage = (feed_cost / total_revenue) × 100
  ///
  /// [feedCost]: Total feed cost
  /// [totalRevenue]: Total revenue
  /// Returns feed cost as percentage of revenue
  static double calculateFeedCostPercentage(double feedCost, double totalRevenue) {
    if (totalRevenue <= 0) return 0.0;
    return (feedCost / totalRevenue) * 100.0;
  }
}

