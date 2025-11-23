import 'package:app_mobile_afms/core/database/app_database.dart';
import 'package:app_mobile_afms/core/reference_data/domain/entities/reference_data_entities.dart';
import 'package:app_mobile_afms/core/reference_data/domain/reference_data_type.dart';
import 'package:drift/drift.dart';

/// Local data source that encapsulates all Drift read/write logic for
/// reference data tables.
class ReferenceDataLocalDatasource {
  const ReferenceDataLocalDatasource(this._database);

  final AppDatabase _database;

  // ---------------------------------------------------------------------------
  // Metadata helpers
  // ---------------------------------------------------------------------------

  Future<ReferenceDataMetadataEntry?> getMetadata(
    String userId,
    ReferenceDataType type,
  ) {
    return (_database.select(_database.referenceDataMetadataEntries)..where(
          (tbl) => tbl.userId.equals(userId) & tbl.dataType.equals(type.key),
        ))
        .getSingleOrNull();
  }

  Future<void> upsertMetadata(
    ReferenceDataMetadataEntriesCompanion companion,
  ) async {
    await _database
        .into(_database.referenceDataMetadataEntries)
        .insertOnConflictUpdate(
          companion.copyWith(updatedAt: Value(DateTime.now())),
        );
  }

  // ---------------------------------------------------------------------------
  // Lab Test Types
  // ---------------------------------------------------------------------------

  Future<void> replaceLabTestTypes(
    String userId,
    List<LabTestTypeEntity> items,
  ) async {
    await _database.transaction(() async {
      await (_database.delete(
        _database.labTestTypeEntries,
      )..where((tbl) => tbl.userId.equals(userId))).go();
      if (items.isEmpty) return;
      final now = DateTime.now();
      await _database.batch((batch) {
        batch.insertAll(
          _database.labTestTypeEntries,
          items
              .map((item) => item.toCompanion(userId: userId, timestamp: now))
              .toList(),
          mode: InsertMode.insertOrReplace,
        );
      });
    });
  }

  Future<List<LabTestTypeEntity>> getLabTestTypes(String userId) async {
    final rows =
        await (_database.select(_database.labTestTypeEntries)
              ..where((tbl) => tbl.userId.equals(userId))
              ..orderBy([(tbl) => OrderingTerm(expression: tbl.displayOrder)]))
            .get();
    return rows.map(LabTestTypeEntity.fromLocal).toList();
  }

  // ---------------------------------------------------------------------------
  // Employees
  // ---------------------------------------------------------------------------

  Future<void> replaceEmployees(
    String userId,
    List<EmployeeSummary> items,
  ) async {
    await _database.transaction(() async {
      await (_database.delete(
        _database.employeeEntries,
      )..where((tbl) => tbl.userId.equals(userId))).go();
      if (items.isEmpty) return;
      final now = DateTime.now();
      await _database.batch((batch) {
        batch.insertAll(
          _database.employeeEntries,
          items
              .map((item) => item.toCompanion(userId: userId, timestamp: now))
              .toList(),
          mode: InsertMode.insertOrReplace,
        );
      });
    });
  }

  Future<List<EmployeeSummary>> getEmployees(String userId) async {
    final rows =
        await (_database.select(_database.employeeEntries)
              ..where((tbl) => tbl.userId.equals(userId))
              ..orderBy([(tbl) => OrderingTerm(expression: tbl.name)]))
            .get();
    return rows.map(EmployeeSummary.fromLocal).toList();
  }

  // ---------------------------------------------------------------------------
  // Customers
  // ---------------------------------------------------------------------------

  Future<void> replaceCustomers(
    String userId,
    List<CustomerSummary> items,
  ) async {
    await _database.transaction(() async {
      await (_database.delete(
        _database.customerEntries,
      )..where((tbl) => tbl.userId.equals(userId))).go();
      if (items.isEmpty) return;
      final now = DateTime.now();
      await _database.batch((batch) {
        batch.insertAll(
          _database.customerEntries,
          items
              .map((item) => item.toCompanion(userId: userId, timestamp: now))
              .toList(),
          mode: InsertMode.insertOrReplace,
        );
      });
    });
  }

  Future<List<CustomerSummary>> getCustomers(String userId) async {
    final rows =
        await (_database.select(_database.customerEntries)
              ..where((tbl) => tbl.userId.equals(userId))
              ..orderBy([(tbl) => OrderingTerm(expression: tbl.name)]))
            .get();
    return rows.map(CustomerSummary.fromLocal).toList();
  }

  // ---------------------------------------------------------------------------
  // Farms
  // ---------------------------------------------------------------------------

  Future<void> replaceFarms(String userId, List<FarmSummary> items) async {
    await _database.transaction(() async {
      await (_database.delete(
        _database.farmEntries,
      )..where((tbl) => tbl.userId.equals(userId))).go();
      if (items.isEmpty) return;
      final now = DateTime.now();
      await _database.batch((batch) {
        batch.insertAll(
          _database.farmEntries,
          items
              .map((item) => item.toCompanion(userId: userId, timestamp: now))
              .toList(),
          mode: InsertMode.insertOrReplace,
        );
      });
    });
  }

  Future<List<FarmSummary>> getFarms(String userId) async {
    final rows =
        await (_database.select(_database.farmEntries)
              ..where((tbl) => tbl.userId.equals(userId))
              ..orderBy([(tbl) => OrderingTerm(expression: tbl.name)]))
            .get();
    return rows.map(FarmSummary.fromLocal).toList();
  }

  // ---------------------------------------------------------------------------
  // Ponds
  // ---------------------------------------------------------------------------

  Future<void> replacePonds(String userId, List<PondSummary> items) async {
    await _database.transaction(() async {
      await (_database.delete(
        _database.pondEntries,
      )..where((tbl) => tbl.userId.equals(userId))).go();
      if (items.isEmpty) return;
      final now = DateTime.now();
      await _database.batch((batch) {
        batch.insertAll(
          _database.pondEntries,
          items
              .map((item) => item.toCompanion(userId: userId, timestamp: now))
              .toList(),
          mode: InsertMode.insertOrReplace,
        );
      });
    });
  }

  Future<List<PondSummary>> getPonds(String userId) async {
    final rows =
        await (_database.select(_database.pondEntries)
              ..where((tbl) => tbl.userId.equals(userId))
              ..orderBy([(tbl) => OrderingTerm(expression: tbl.name)]))
            .get();
    return rows.map(PondSummary.fromLocal).toList();
  }

  // ---------------------------------------------------------------------------
  // Cleanup helpers
  // ---------------------------------------------------------------------------

  Future<void> deleteAllForUser(String userId) async {
    await _database.transaction(() async {
      await (_database.delete(
        _database.referenceDataMetadataEntries,
      )..where((tbl) => tbl.userId.equals(userId))).go();
      await (_database.delete(
        _database.labTestTypeEntries,
      )..where((tbl) => tbl.userId.equals(userId))).go();
      await (_database.delete(
        _database.employeeEntries,
      )..where((tbl) => tbl.userId.equals(userId))).go();
      await (_database.delete(
        _database.customerEntries,
      )..where((tbl) => tbl.userId.equals(userId))).go();
      await (_database.delete(
        _database.farmEntries,
      )..where((tbl) => tbl.userId.equals(userId))).go();
      await (_database.delete(
        _database.pondEntries,
      )..where((tbl) => tbl.userId.equals(userId))).go();
    });
  }
}
