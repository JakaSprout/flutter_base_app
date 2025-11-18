import 'package:flutter_base_app/features/lab_request/domain/entities/anamnesa_type.dart';
import 'package:flutter_base_app/features/lab_request/domain/entities/testing_type.dart';

/// Lab request entity (domain layer).
///
/// Represents a laboratory analysis request.
class LabRequest {
  /// Creates a new instance of [LabRequest].
  const LabRequest({
    required this.id,
    required this.namaPengirim,
    required this.noTelp,
    required this.email,
    required this.tambakAsal,
    required this.customer,
    required this.tanggalPengiriman,
    required this.anamnesa,
    required this.keteranganSampel,
    required this.jenisTesting,
    this.status,
    this.tanggalRequest,
    this.jumlahSampel,
  });

  /// Unique identifier for the request
  final String id;

  /// Sender name
  final String namaPengirim;

  /// Phone number
  final String noTelp;

  /// Email address
  final String email;

  /// Origin pond
  final String tambakAsal;

  /// Customer name
  final String customer;

  /// Delivery/pickup date
  final DateTime tanggalPengiriman;

  /// Anamnesa type (Diagnostik or Screening)
  final AnamnesaType anamnesa;

  /// Sample description/notes
  final String keteranganSampel;

  /// Testing type
  final TestingType jenisTesting;

  /// Request status (optional, for submitted requests)
  final String? status;

  /// Request date (optional, for submitted requests)
  final DateTime? tanggalRequest;

  /// Number of samples (optional, for submitted requests)
  final int? jumlahSampel;
}
