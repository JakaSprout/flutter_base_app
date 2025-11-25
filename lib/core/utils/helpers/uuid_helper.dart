import 'package:uuid/uuid.dart';

/// Helper class for UUID generation and validation.
///
/// Provides utilities for generating UUIDs for simulations, devices, etc.
class UuidHelper {
  const UuidHelper._();

  static const Uuid _uuid = Uuid();

  /// Generate a new UUID v4.
  ///
  /// Returns a random UUID string in the format:
  /// `xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx`
  static String generate() {
    return _uuid.v4();
  }

  /// Validate UUID format.
  ///
  /// Returns `true` if the [uuid] string matches the UUID v4 format.
  static bool isValid(String uuid) {
    final regex = RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
      caseSensitive: false,
    );
    return regex.hasMatch(uuid);
  }

  /// Generate simulation code with timestamp.
  ///
  /// Format: `SIM-YYYYMMDD-XXX`
  ///
  /// Example: `SIM-20251124-A3F`
  static String generateSimulationCode() {
    final now = DateTime.now();
    final year = now.year;
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');
    final dateStr = '$year$month$day';
    final randomStr = _uuid.v4().substring(0, 3).toUpperCase();
    return 'SIM-$dateStr-$randomStr';
  }

  /// Generate device code with timestamp.
  ///
  /// Format: `DEV-YYYYMMDD-XXX`
  ///
  /// Example: `DEV-20251124-B4C`
  static String generateDeviceCode() {
    final now = DateTime.now();
    final year = now.year;
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');
    final dateStr = '$year$month$day';
    final randomStr = _uuid.v4().substring(0, 3).toUpperCase();
    return 'DEV-$dateStr-$randomStr';
  }
}
