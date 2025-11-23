import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';

/// View model representing a pond option for UI display.
/// This is a presentation-layer model that adapts domain data for UI purposes.
class PondOption {
  /// Creates a new instance of [PondOption].
  const PondOption({
    required this.name,
    required this.id,
    this.areaSqm,
    this.code,
    this.status,
    this.farmId,
  });

  /// Pond display name.
  final String name;

  /// Pond identifier.
  final String id;

  /// Pond area in square meters (if available).
  final double? areaSqm;

  /// Pond code/reference from backend (if available).
  final String? code;

  /// Status label (Available, Maintenance, etc.).
  final String? status;

  /// Related farm identifier.
  final String? farmId;

  /// Returns a formatted subtitle for UI (code + area + status).
  String get subtitle {
    final parts = <String>[];
    if (code != null && code!.isNotEmpty) parts.add('Kode: $code');
    if (areaSqm != null) {
      parts.add('Luas: ${areaSqm!.toCleanString()} m²');
    }
    if (status != null && status!.isNotEmpty) parts.add(status!);
    return parts.join(' • ');
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PondOption) return false;
    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
