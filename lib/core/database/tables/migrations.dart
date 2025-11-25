part of '../app_database.dart';

/// Migrations tracking table.
/// 100% matches backend PostgreSQL schema.
/// Based on schema.sql - migrations
@DataClassName('Migration')
class Migrations extends Table {
  @override
  String get tableName => 'migrations';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get timestamp => integer()();
  TextColumn get name => text()();
}
