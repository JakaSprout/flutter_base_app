part of '../app_database.dart';

/// Capacity reference table for commodity-specific harvest capacity parameters.
/// 100% matches backend PostgreSQL schema.
/// Note: This file includes both fms_10_capacity_references table and its views
/// (fms_10_capacity_references_en and fms_10_capacity_references_id)
@DataClassName('Fms10CapacityReference')
class Fms10CapacityReferences extends Table {
  IntColumn get capacityRefId => integer().autoIncrement()();
  TextColumn get capacityRefUuid => text().unique()();
  TextColumn get commodityCode => text().unique()();
  TextColumn get commodityNameId => text()();
  TextColumn get commodityNameEn => text()();
  TextColumn get possibleTechnologyId => text()();
  TextColumn get possibleTechnologyEn => text()();
  TextColumn get categoryId => text()();
  TextColumn get categoryEn => text()();
  TextColumn get intensityLevelId => text()();
  TextColumn get intensityLevelEn => text()();
  RealColumn get maxCapacity => real()();
  TextColumn get maxCapacityUnit =>
      text().withDefault(const Constant('kg_per_sqm'))();
  TextColumn get maxCapacityNotes => text().nullable()();
  TextColumn get scientificReferences => text().nullable()();
  TextColumn get referenceUrls => text().nullable()(); // Array stored as text
  BoolColumn get isActive =>
      boolean().nullable().withDefault(const Constant(true))();
  DateTimeColumn get createdDate =>
      dateTime().nullable().withDefault(currentDateAndTime)();
  IntColumn get createdBy => integer().nullable()();
  DateTimeColumn get lastUpdatedDate =>
      dateTime().nullable().withDefault(currentDateAndTime)();
  IntColumn get lastUpdatedBy => integer().nullable()();
  RealColumn get maxCapacityKgPerSqm => real().nullable()();
}
