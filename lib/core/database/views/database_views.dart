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
      capacity_ref_uuid,
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
      capacity_ref_uuid,
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

  /// SQL for v_simulation_daily view
  static const String simulationDaily = r'''
    CREATE VIEW IF NOT EXISTS v_simulation_daily AS
    SELECT
        hs.simulation_id,
        CAST(json_extract(dp.value, '$.doc') AS INTEGER) AS doc,
        CAST(json_extract(dp.value, '$.abw') AS REAL) AS estimated_abw_gram,
        COALESCE(
            CAST(json_extract(dp.value, '$.population') AS INTEGER),
            CAST(json_extract(dp.value, '$.pop') AS INTEGER)
        ) AS estimated_population,
        CAST(json_extract(dp.value, '$.biomass') AS REAL) AS estimated_biomass_kg,
        COALESCE(
            CAST(json_extract(dp.value, '$.feed_kg') AS REAL),
            CAST(json_extract(dp.value, '$.feed') AS REAL)
        ) AS estimated_feed_kg,
        CAST(json_extract(dp.value, '$.cumulative_feed') AS REAL) AS cumulative_feed_kg,
        COALESCE(
            CAST(json_extract(dp.value, '$.feed_cost') AS REAL),
            CAST(json_extract(dp.value, '$.cost') AS REAL)
        ) AS estimated_feed_cost_daily,
        CAST(json_extract(dp.value, '$.cumulative_cost') AS REAL) AS cumulative_feed_cost,
        json_extract(dp.value, '$.harvest_event') AS harvest_event
    FROM fms_10_harvest_simulation hs,
        json_each(hs.daily_projections) dp
    WHERE hs.deleted_date IS NULL
        AND hs.daily_projections IS NOT NULL;
  ''';

  /// SQL for v_simulation_harvest_daily view
  static const String simulationHarvestDaily = '''
    CREATE VIEW IF NOT EXISTS v_simulation_harvest_daily AS
    SELECT
        simulation_id,
        simulation_uuid,
        simulation_code,
        simulation_name,
        employee_id,
        pond_id,
        device_uuid,
        cycle_type,
        harvest_mode,
        harvest_frequency_days,
        initial_stocking_count,
        initial_abw,
        initial_abw_unit,
        target_abw,
        target_abw_unit,
        target_doc,
        current_doc,
        current_population,
        current_abw,
        current_abw_unit,
        stocking_density,
        stocking_density_unit,
        target_survival_rate_percent,
        target_fcr,
        pond_area,
        pond_area_unit,
        pwa,
        pwa_unit,
        pond_depth,
        pond_depth_unit,
        capacity_per_area,
        capacity_per_area_unit,
        capacity_total,
        capacity_total_unit,
        estimated_adg,
        estimated_adg_unit,
        daily_loss_rate_percent,
        feeding_rate_percent,
        base_mortality_rate_percent,
        water_exchange_rate_percent,
        simulation_status,
        approval_status,
        is_materialized,
        is_synced,
        daily_projections,
        harvest_events,
        summary_data,
        monthly_summary,
        created_date,
        last_updated_date,
        synced_date,
        materialized_date,
        date(created_date) AS simulation_date,
        CASE
            WHEN simulation_status IN ('Active', 'Approved') THEN 1
            ELSE 0
        END AS is_active,
        CASE
            WHEN current_doc IS NOT NULL AND target_doc IS NOT NULL
            THEN ROUND(CAST(current_doc AS REAL) / NULLIF(target_doc, 0) * 100, 2)
            ELSE NULL
        END AS progress_percent
    FROM fms_10_harvest_simulation
    WHERE deleted_date IS NULL;
  ''';

  /// SQL for v_agent_simulation_daily view
  static const String agentSimulationDaily = '''
    CREATE VIEW IF NOT EXISTS v_agent_simulation_daily AS
    SELECT
        simulation_id,
        simulation_uuid,
        simulation_code,
        simulation_name,
        employee_id,
        pond_id,
        device_uuid,
        agent_type,
        loan_amount,
        loan_currency,
        interest_rate_percent,
        loan_term_months,
        guarantee_percentage,
        guarantee_amount,
        guarantee_currency,
        collateral_value,
        collateral_currency,
        estimated_production_kg,
        estimated_revenue,
        estimated_revenue_currency,
        estimated_profit,
        estimated_profit_currency,
        debt_service_coverage_ratio,
        loan_to_value_ratio,
        risk_score,
        risk_level,
        approval_recommendation,
        simulation_data,
        calculation_details,
        risk_assessment,
        monthly_payment_schedule,
        is_approved,
        is_synced,
        simulation_status,
        approved_by,
        approved_date,
        created_date,
        last_updated_date,
        date(created_date) AS simulation_date,
        CASE
            WHEN simulation_status = 'Approved' THEN 1
            ELSE 0
        END AS is_active
    FROM fms_10_agent_simulation
    WHERE deleted_date IS NULL;
  ''';
}
