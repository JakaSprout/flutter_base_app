import 'package:app_mobile_afms/features/lab_request/domain/entities/anamnesa_type.dart';
import 'package:app_mobile_afms/features/lab_request/domain/entities/lab_request.dart';
import 'package:app_mobile_afms/features/lab_request/domain/entities/testing_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lab_request_model.freezed.dart';
part 'lab_request_model.g.dart';

/// Lab request model (data layer).
@freezed
class LabRequestModel with _$LabRequestModel {
  /// Creates a new instance of [LabRequestModel].
  const factory LabRequestModel({
    required String id,
    @JsonKey(name: 'nama_pengirim')
    required String namaPengirim,
    @JsonKey(name: 'no_telp')
    required String noTelp,
    required String email,
    @JsonKey(name: 'tambak_asal')
    required String tambakAsal,
    required String customer,
    @JsonKey(name: 'tanggal_pengiriman')
    required DateTime tanggalPengiriman,
    required String anamnesa, // "diagnostik" or "screening"
    @JsonKey(name: 'keterangan_sampel')
    required String keteranganSampel,
    @JsonKey(name: 'jenis_testing')
    required String jenisTesting,
    String? status,
    @JsonKey(name: 'tanggal_request')
    DateTime? tanggalRequest,
    @JsonKey(name: 'jumlah_sampel')
    int? jumlahSampel,
  }) = _LabRequestModel;

  /// Creates [LabRequestModel] from JSON.
  factory LabRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LabRequestModelFromJson(json);
}

/// Extension to convert [LabRequestModel] to [LabRequest].
extension LabRequestModelExtension on LabRequestModel {
  /// Converts [LabRequestModel] to [LabRequest].
  LabRequest toEntity() {
    return LabRequest(
      id: id,
      namaPengirim: namaPengirim,
      noTelp: noTelp,
      email: email,
      tambakAsal: tambakAsal,
      customer: customer,
      tanggalPengiriman: tanggalPengiriman,
      anamnesa: _parseAnamnesa(anamnesa),
      keteranganSampel: keteranganSampel,
      jenisTesting: _parseTestingType(jenisTesting),
      status: status,
      tanggalRequest: tanggalRequest,
      jumlahSampel: jumlahSampel,
    );
  }

  /// Parse anamnesa string to enum
  AnamnesaType _parseAnamnesa(String value) {
    switch (value.toLowerCase()) {
      case 'diagnostik':
        return AnamnesaType.diagnostik;
      case 'screening':
        return AnamnesaType.screening;
      default:
        return AnamnesaType.diagnostik;
    }
  }

  /// Parse testing type string to enum
  TestingType _parseTestingType(String value) {
    switch (value.toLowerCase()) {
      case 'pcr konvensional':
        return TestingType.pcrKonvensional;
      case 'pcr realtime':
        return TestingType.pcrRealtime;
      case 'pcr pockit':
      case 'pcr pckit':
        return TestingType.pcrPockit;
      case 'water quality':
        return TestingType.waterQuality;
      default:
        return TestingType.pcrKonvensional;
    }
  }
}

/// Extension to convert [LabRequest] to [LabRequestModel].
extension LabRequestEntityExtension on LabRequest {
  /// Converts [LabRequest] to [LabRequestModel].
  LabRequestModel toModel() {
    return LabRequestModel(
      id: id,
      namaPengirim: namaPengirim,
      noTelp: noTelp,
      email: email,
      tambakAsal: tambakAsal,
      customer: customer,
      tanggalPengiriman: tanggalPengiriman,
      anamnesa: _anamnesaToString(anamnesa),
      keteranganSampel: keteranganSampel,
      jenisTesting: _testingTypeToString(jenisTesting),
      status: status,
      tanggalRequest: tanggalRequest,
      jumlahSampel: jumlahSampel,
    );
  }

  /// Convert anamnesa enum to string
  String _anamnesaToString(AnamnesaType value) {
    switch (value) {
      case AnamnesaType.diagnostik:
        return 'diagnostik';
      case AnamnesaType.screening:
        return 'screening';
    }
  }

  /// Convert testing type enum to string
  String _testingTypeToString(TestingType value) {
    switch (value) {
      case TestingType.pcrKonvensional:
        return 'PCR Konvensional';
      case TestingType.pcrRealtime:
        return 'PCR Realtime';
      case TestingType.pcrPockit:
        return 'PCR Pockit';
      case TestingType.waterQuality:
        return 'Water Quality';
    }
  }
}

