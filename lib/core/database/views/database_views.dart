part of '../app_database.dart';

/// This file contains SQL for creating all 4 database views.
/// Views are created via custom SQL in migrations because:
/// 1. Some use complex recursive CTEs not supported by Drift's View syntax
/// 2. Bilingual views (_en, _id) are simpler as raw SQL
///
/// The views match backend PostgreSQL schema 100%.

class DatabaseViews {
  /// SQL for fms_10_capacity_references_en view
  static const String capacityReferencesEn = '''
    CREATE VIEW IF NOT EXISTS fms_10_capacity_references_en AS
    SELECT
      capacity_ref_id,
      commodity_code,
      commodity_name_en AS commodity_name,
      possible_technology_en AS possible_technology,
      category_en AS category,
      intensity_level_en AS intensity_level,
      max_capacity,
      max_capacity_unit,
      max_capacity_kg_per_sqm,
      max_capacity_notes,
      scientific_references,
      reference_urls,
      is_active,
      created_date,
      created_by,
      last_updated_date,
      last_updated_by
    FROM fms_10_capacity_references
  ''';

  /// SQL for fms_10_capacity_references_id view
  static const String capacityReferencesId = '''
    CREATE VIEW IF NOT EXISTS fms_10_capacity_references_id AS
    SELECT
      capacity_ref_id,
      commodity_code,
      commodity_name_id AS commodity_name,
      possible_technology_id AS possible_technology,
      category_id AS category,
      intensity_level_id AS intensity_level,
      max_capacity,
      max_capacity_unit,
      max_capacity_kg_per_sqm,
      max_capacity_notes,
      scientific_references,
      reference_urls,
      is_active,
      created_date,
      created_by,
      last_updated_date,
      last_updated_by
    FROM fms_10_capacity_references
  ''';

  /// SQL for v_agent_simulation_daily view
  static const String agentSimulationDaily = '''
    CREATE VIEW IF NOT EXISTS v_agent_simulation_daily AS
    SELECT
      simulation_id,
      simulation_code,
      simulation_name,
      current_doc,
      current_biomass,
      stocking_count,
      target_sr_percent,
      target_doc,
      feed_payment,
      harvest_price,
      estimated_harvest,
      estimated_fcr,
      feed_price,
      harvest_guarantee,
      ltv_ratio,
      progress,
      current_abw,
      harvest_abw,
      feed_need,
      feed_cost,
      max_loan,
      display_currency,
      display_weight_unit,
      display_area_unit,
      simulation_status,
      is_synced,
      created_date
    FROM fms_10_agent_simulation
    WHERE simulation_status <> 'Archived' AND deleted_date IS NULL
  ''';

  /// SQL for v_simulation_harvest_daily view with recursive CTE
  static const String simulationHarvestDaily = '''
    CREATE VIEW IF NOT EXISTS v_simulation_harvest_daily AS
    WITH RECURSIVE simulation_params AS (
         SELECT s.simulation_id,
            s.pond_area,
            s.pwa,
            s.stocking_density,
            s.initial_abw,
            s.target_abw,
            s.target_survival_rate_percent,
            s.target_fcr,
            s.target_doc,
            s.initial_stocking_count,
            s.daily_loss_rate_percent,
            s.feed_price,
            s.commodity_price,
            s.feeding_rate_percent,
            s.base_mortality_rate_percent,
            s.water_exchange_rate_percent,
            s.capacity_per_area,
            s.cycle_type,
            s.harvest_mode,
            s.harvest_frequency_days,
            COALESCE(s.partial_harvest_percentage, 20.00) AS partial_harvest_percentage,
            COALESCE(s.current_doc, 0) AS current_doc,
            COALESCE(s.current_population, s.initial_stocking_count) AS current_population,
            COALESCE(s.current_abw, s.initial_abw) AS current_abw,
            COALESCE(s.cumulative_feed_used, 0) AS cumulative_feed_used,
                CASE
                    WHEN s.target_doc > 0 THEN (s.target_abw - s.initial_abw) / s.target_doc
                    ELSE 0
                END AS estimated_adg
           FROM fms_10_harvest_simulations s
          WHERE s.simulation_status <> 'Archived' AND s.deleted_date IS NULL
        ), daily_recursive AS (
         SELECT sp.simulation_id,
            1 AS doc,
            date('now') AS projected_date,
            sp.initial_abw AS estimated_abw,
            sp.estimated_adg,
            sp.initial_stocking_count AS estimated_population,
            0 AS daily_mortality_count,
            0 AS cumulative_mortality_count,
            100.00 AS survival_rate_percent,
            ROUND(sp.initial_stocking_count * sp.initial_abw / 1000.0, 2) AS estimated_biomass,
            ROUND(sp.initial_stocking_count * sp.initial_abw / 1000.0 / CASE WHEN sp.pwa = 0 THEN 1 ELSE sp.pwa END, 2) AS biomass_density,
                CASE
                    WHEN (sp.initial_stocking_count * sp.initial_abw / 1000.0 / CASE WHEN sp.pwa = 0 THEN 1 ELSE sp.pwa END) > sp.capacity_per_area THEN 1
                    ELSE 0
                END AS is_over_capacity,
            ROUND(sp.initial_stocking_count * sp.initial_abw / 1000.0 / CASE WHEN sp.pwa = 0 THEN 1 ELSE sp.pwa END * 100.0 / CASE WHEN sp.capacity_per_area = 0 THEN 1 ELSE sp.capacity_per_area END, 1) AS capacity_utilization_percent,
            sp.feeding_rate_percent AS feeding_rate_percent,
            ROUND(sp.initial_stocking_count * sp.initial_abw / 1000.0 * (sp.feeding_rate_percent / 100.0), 2) AS estimated_feed,
            0 AS cumulative_feed,
            'None' AS harvest_event,
            0 AS harvest_weight,
            0 AS harvest_count,
            sp.initial_stocking_count AS remaining_population,
            sp.pond_area,
            sp.pwa,
            sp.initial_abw,
            sp.target_abw,
            sp.target_doc,
            sp.initial_stocking_count,
            sp.daily_loss_rate_percent,
            sp.feed_price,
            sp.commodity_price,
            sp.target_fcr,
            sp.capacity_per_area,
            sp.cycle_type,
            sp.harvest_mode,
            sp.harvest_frequency_days,
            sp.partial_harvest_percentage,
            sp.cumulative_feed_used,
            sp.water_exchange_rate_percent
           FROM simulation_params sp
        UNION ALL
         SELECT dr.simulation_id,
            dr.doc + 1 AS doc,
            date(dr.projected_date, '+1 day') AS projected_date,
            ROUND(dr.estimated_abw + dr.estimated_adg, 3) AS estimated_abw,
            dr.estimated_adg,
            MAX(CAST(dr.remaining_population * (1 - dr.daily_loss_rate_percent / 100.0) AS INTEGER), 0) AS estimated_population,
            dr.remaining_population - MAX(CAST(dr.remaining_population * (1 - dr.daily_loss_rate_percent / 100.0) AS INTEGER), 0) AS daily_mortality_count,
            dr.cumulative_mortality_count + (dr.remaining_population - MAX(CAST(dr.remaining_population * (1 - dr.daily_loss_rate_percent / 100.0) AS INTEGER), 0)) AS cumulative_mortality_count,
            ROUND(MAX(CAST(dr.remaining_population * (1 - dr.daily_loss_rate_percent / 100.0) AS INTEGER), 0) * 100.0 / CASE WHEN dr.initial_stocking_count = 0 THEN 1 ELSE dr.initial_stocking_count END, 2) AS survival_rate_percent,
            ROUND(MAX(CAST(dr.remaining_population * (1 - dr.daily_loss_rate_percent / 100.0) AS INTEGER), 0) * (dr.estimated_abw + dr.estimated_adg) / 1000.0, 2) AS estimated_biomass,
            ROUND(MAX(CAST(dr.remaining_population * (1 - dr.daily_loss_rate_percent / 100.0) AS INTEGER), 0) * (dr.estimated_abw + dr.estimated_adg) / 1000.0 / CASE WHEN dr.pwa = 0 THEN 1 ELSE dr.pwa END, 2) AS biomass_density,
                CASE
                    WHEN (MAX(CAST(dr.remaining_population * (1 - dr.daily_loss_rate_percent / 100.0) AS INTEGER), 0) * (dr.estimated_abw + dr.estimated_adg) / 1000.0 / CASE WHEN dr.pwa = 0 THEN 1 ELSE dr.pwa END) > dr.capacity_per_area THEN 1
                    ELSE 0
                END AS is_over_capacity,
            ROUND(MAX(CAST(dr.remaining_population * (1 - dr.daily_loss_rate_percent / 100.0) AS INTEGER), 0) * (dr.estimated_abw + dr.estimated_adg) / 1000.0 / CASE WHEN dr.pwa = 0 THEN 1 ELSE dr.pwa END * 100.0 / CASE WHEN dr.capacity_per_area = 0 THEN 1 ELSE dr.capacity_per_area END, 1) AS capacity_utilization_percent,
            dr.feeding_rate_percent,
            ROUND(MAX(CAST(dr.remaining_population * (1 - dr.daily_loss_rate_percent / 100.0) AS INTEGER), 0) * (dr.estimated_abw + dr.estimated_adg) / 1000.0 * (dr.feeding_rate_percent / 100.0), 2) AS estimated_feed,
            dr.cumulative_feed + ROUND(MAX(CAST(dr.remaining_population * (1 - dr.daily_loss_rate_percent / 100.0) AS INTEGER), 0) * (dr.estimated_abw + dr.estimated_adg) / 1000.0 * (dr.feeding_rate_percent / 100.0), 2) AS cumulative_feed,
                CASE
                    WHEN (dr.doc + 1) = dr.target_doc THEN 'Final'
                    WHEN (MAX(CAST(dr.remaining_population * (1 - dr.daily_loss_rate_percent / 100.0) AS INTEGER), 0) * (dr.estimated_abw + dr.estimated_adg) / 1000.0 / CASE WHEN dr.pwa = 0 THEN 1 ELSE dr.pwa END) > dr.capacity_per_area THEN 'Partial'
                    WHEN dr.harvest_mode = 'Auto' AND dr.harvest_frequency_days > 0 AND ((dr.doc + 1) % dr.harvest_frequency_days) = 0 AND (dr.doc + 1) < dr.target_doc THEN 'Partial'
                    ELSE 'None'
                END AS harvest_event,
                CASE
                    WHEN (dr.doc + 1) = dr.target_doc THEN ROUND(MAX(CAST(dr.remaining_population * (1 - dr.daily_loss_rate_percent / 100.0) AS INTEGER), 0) * (dr.estimated_abw + dr.estimated_adg) / 1000.0, 2)
                    WHEN (MAX(CAST(dr.remaining_population * (1 - dr.daily_loss_rate_percent / 100.0) AS INTEGER), 0) * (dr.estimated_abw + dr.estimated_adg) / 1000.0 / CASE WHEN dr.pwa = 0 THEN 1 ELSE dr.pwa END) > dr.capacity_per_area OR (dr.harvest_mode = 'Auto' AND dr.harvest_frequency_days > 0 AND ((dr.doc + 1) % dr.harvest_frequency_days) = 0 AND (dr.doc + 1) < dr.target_doc) THEN ROUND(MAX(CAST(dr.remaining_population * (1 - dr.daily_loss_rate_percent / 100.0) AS INTEGER), 0) * (dr.estimated_abw + dr.estimated_adg) / 1000.0 * (dr.partial_harvest_percentage / 100.0), 2)
                    ELSE 0
                END AS harvest_weight,
                CASE
                    WHEN (dr.doc + 1) = dr.target_doc THEN MAX(CAST(dr.remaining_population * (1 - dr.daily_loss_rate_percent / 100.0) AS INTEGER), 0)
                    WHEN (MAX(CAST(dr.remaining_population * (1 - dr.daily_loss_rate_percent / 100.0) AS INTEGER), 0) * (dr.estimated_abw + dr.estimated_adg) / 1000.0 / CASE WHEN dr.pwa = 0 THEN 1 ELSE dr.pwa END) > dr.capacity_per_area OR (dr.harvest_mode = 'Auto' AND dr.harvest_frequency_days > 0 AND ((dr.doc + 1) % dr.harvest_frequency_days) = 0 AND (dr.doc + 1) < dr.target_doc) THEN CAST(MAX(CAST(dr.remaining_population * (1 - dr.daily_loss_rate_percent / 100.0) AS INTEGER), 0) * (dr.partial_harvest_percentage / 100.0) AS INTEGER)
                    ELSE 0
                END AS harvest_count,
                CASE
                    WHEN (dr.doc + 1) = dr.target_doc THEN 0
                    WHEN (MAX(CAST(dr.remaining_population * (1 - dr.daily_loss_rate_percent / 100.0) AS INTEGER), 0) * (dr.estimated_abw + dr.estimated_adg) / 1000.0 / CASE WHEN dr.pwa = 0 THEN 1 ELSE dr.pwa END) > dr.capacity_per_area OR (dr.harvest_mode = 'Auto' AND dr.harvest_frequency_days > 0 AND ((dr.doc + 1) % dr.harvest_frequency_days) = 0 AND (dr.doc + 1) < dr.target_doc) THEN MAX(CAST(dr.remaining_population * (1 - dr.daily_loss_rate_percent / 100.0) AS INTEGER), 0) - CAST(MAX(CAST(dr.remaining_population * (1 - dr.daily_loss_rate_percent / 100.0) AS INTEGER), 0) * (dr.partial_harvest_percentage / 100.0) AS INTEGER)
                    ELSE MAX(CAST(dr.remaining_population * (1 - dr.daily_loss_rate_percent / 100.0) AS INTEGER), 0)
                END AS remaining_population,
            dr.pond_area,
            dr.pwa,
            dr.initial_abw,
            dr.target_abw,
            dr.target_doc,
            dr.initial_stocking_count,
            dr.daily_loss_rate_percent,
            dr.feed_price,
            dr.commodity_price,
            dr.target_fcr,
            dr.capacity_per_area,
            dr.cycle_type,
            dr.harvest_mode,
            dr.harvest_frequency_days,
            dr.partial_harvest_percentage,
            dr.cumulative_feed_used,
            dr.water_exchange_rate_percent
           FROM daily_recursive dr
          WHERE dr.doc < dr.target_doc
        )
    SELECT
      simulation_id,
      doc,
      projected_date,
      estimated_abw,
      estimated_adg,
      estimated_population,
      daily_mortality_count,
      cumulative_mortality_count,
      survival_rate_percent,
      estimated_biomass,
      biomass_density,
      is_over_capacity,
      capacity_utilization_percent,
      feeding_rate_percent,
      estimated_feed,
      cumulative_feed,
      ROUND(estimated_feed * feed_price, 2) AS daily_feed_cost,
      ROUND(cumulative_feed * feed_price, 2) AS cumulative_feed_cost,
      ROUND(cumulative_feed / CASE WHEN estimated_biomass = 0 THEN 1 ELSE estimated_biomass END, 2) AS fcr_to_date,
      ROUND(estimated_feed * 1000 * 0.04, 2) AS estimated_tan_production,
      ROUND(estimated_feed * 1000 * 0.4, 2) AS estimated_do_demand,
          CASE
              WHEN biomass_density < 2 THEN 5.0
              WHEN biomass_density < 5 THEN 10.0
              WHEN biomass_density < 10 THEN 15.0
              WHEN biomass_density < 15 THEN 20.0
              ELSE 25.0
          END AS recommended_water_exchange_percent,
      harvest_event,
      harvest_weight,
      harvest_count,
      ROUND(harvest_weight * commodity_price, 2) AS harvest_value,
      remaining_population,
      ROUND(SUM(harvest_weight * commodity_price) OVER (PARTITION BY simulation_id ORDER BY doc ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2) AS cumulative_revenue,
      ROUND(SUM(harvest_weight * commodity_price) OVER (PARTITION BY simulation_id ORDER BY doc ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) - cumulative_feed * feed_price, 2) AS cumulative_profit,
      ROUND((SUM(harvest_weight * commodity_price) OVER (PARTITION BY simulation_id ORDER BY doc ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) - cumulative_feed * feed_price) * 100.0 / CASE WHEN cumulative_feed * feed_price = 0 THEN 1 ELSE cumulative_feed * feed_price END, 2) AS roi_to_date
    FROM daily_recursive
    ORDER BY simulation_id, doc
  ''';
}
