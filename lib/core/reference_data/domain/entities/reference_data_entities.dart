import 'package:app_mobile_afms/core/database/app_database.dart';
import 'package:drift/drift.dart';

/// Lab test type domain entity.
class LabTestTypeEntity {
  const LabTestTypeEntity({
    required this.id,
    required this.name,
    this.description,
    this.displayOrder = 0,
    this.isActive = true,
  });

  factory LabTestTypeEntity.fromLocal(LabTestTypeEntry entry) {
    return LabTestTypeEntity(
      id: entry.labTestTypeId,
      name: entry.name,
      description: entry.description,
      displayOrder: entry.displayOrder,
      isActive: entry.isActive,
    );
  }

  final String id;
  final String name;
  final String? description;
  final int displayOrder;
  final bool isActive;

  LabTestTypeEntriesCompanion toCompanion({
    required String userId,
    DateTime? timestamp,
  }) {
    final now = timestamp ?? DateTime.now();
    return LabTestTypeEntriesCompanion.insert(
      userId: userId,
      labTestTypeId: id,
      name: name,
      description: Value(description),
      displayOrder: Value(displayOrder),
      isActive: Value(isActive),
      createdAt: Value(now),
      updatedAt: Value(now),
    );
  }
}

/// Employee domain entity (lightweight summary for dropdowns).
class EmployeeSummary {
  const EmployeeSummary({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.position,
    this.department,
    this.isActive = true,
  });

  factory EmployeeSummary.fromLocal(EmployeeEntry entry) {
    return EmployeeSummary(
      id: entry.employeeId,
      name: entry.name,
      email: entry.email,
      phone: entry.phone,
      position: entry.position,
      department: entry.department,
      isActive: entry.isActive,
    );
  }

  final int id;
  final String name;
  final String? email;
  final String? phone;
  final String? position;
  final String? department;
  final bool isActive;

  EmployeeEntriesCompanion toCompanion({
    required String userId,
    DateTime? timestamp,
  }) {
    final now = timestamp ?? DateTime.now();
    return EmployeeEntriesCompanion.insert(
      userId: userId,
      employeeId: id,
      name: name,
      email: Value(email),
      phone: Value(phone),
      position: Value(position),
      department: Value(department),
      isActive: Value(isActive),
      createdAt: Value(now),
      updatedAt: Value(now),
    );
  }
}

/// Customer domain entity (lightweight summary for selection).
class CustomerSummary {
  const CustomerSummary({
    required this.id,
    required this.name,
    this.code,
    this.email,
    this.phone,
    this.address,
    this.isActive = true,
  });

  factory CustomerSummary.fromLocal(CustomerEntry entry) {
    return CustomerSummary(
      id: entry.customerId,
      name: entry.name,
      code: entry.code,
      email: entry.email,
      phone: entry.phone,
      address: entry.address,
      isActive: entry.isActive,
    );
  }

  final int id;
  final String name;
  final String? code;
  final String? email;
  final String? phone;
  final String? address;
  final bool isActive;

  CustomerEntriesCompanion toCompanion({
    required String userId,
    DateTime? timestamp,
  }) {
    final now = timestamp ?? DateTime.now();
    return CustomerEntriesCompanion.insert(
      userId: userId,
      customerId: id,
      name: name,
      code: Value(code),
      email: Value(email),
      phone: Value(phone),
      address: Value(address),
      isActive: Value(isActive),
      createdAt: Value(now),
      updatedAt: Value(now),
    );
  }
}

/// Farm domain entity.
class FarmSummary {
  const FarmSummary({
    required this.id,
    required this.name,
    this.code,
    this.address,
    this.latitude,
    this.longitude,
    this.isActive = true,
  });

  factory FarmSummary.fromLocal(FarmEntry entry) {
    return FarmSummary(
      id: entry.farmId,
      name: entry.name,
      code: entry.code,
      address: entry.address,
      latitude: entry.latitude,
      longitude: entry.longitude,
      isActive: entry.isActive,
    );
  }

  final int id;
  final String name;
  final String? code;
  final String? address;
  final double? latitude;
  final double? longitude;
  final bool isActive;

  FarmEntriesCompanion toCompanion({
    required String userId,
    DateTime? timestamp,
  }) {
    final now = timestamp ?? DateTime.now();
    return FarmEntriesCompanion.insert(
      userId: userId,
      farmId: id,
      name: name,
      code: Value(code),
      address: Value(address),
      latitude: Value(latitude),
      longitude: Value(longitude),
      isActive: Value(isActive),
      createdAt: Value(now),
      updatedAt: Value(now),
    );
  }
}

/// Pond domain entity.
class PondSummary {
  const PondSummary({
    required this.id,
    required this.name,
    this.farmId,
    this.code,
    this.areaSqm,
    this.status = 'Available',
    this.isActive = true,
  });

  factory PondSummary.fromLocal(PondEntry entry) {
    return PondSummary(
      id: entry.pondId,
      name: entry.name,
      farmId: entry.farmId,
      code: entry.code,
      areaSqm: entry.areaSqm,
      status: entry.status,
      isActive: entry.isActive,
    );
  }

  final int id;
  final String name;
  final int? farmId;
  final String? code;
  final double? areaSqm;
  final String status;
  final bool isActive;

  PondEntriesCompanion toCompanion({
    required String userId,
    DateTime? timestamp,
  }) {
    final now = timestamp ?? DateTime.now();
    return PondEntriesCompanion.insert(
      userId: userId,
      pondId: id,
      farmId: Value(farmId),
      name: name,
      code: Value(code),
      areaSqm: Value(areaSqm),
      status: Value(status),
      isActive: Value(isActive),
      createdAt: Value(now),
      updatedAt: Value(now),
    );
  }
}

