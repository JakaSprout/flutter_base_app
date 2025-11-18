// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lab_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LabRequestModelImpl _$$LabRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$LabRequestModelImpl(
  id: json['id'] as String,
  namaPengirim: json['nama_pengirim'] as String,
  noTelp: json['no_telp'] as String,
  email: json['email'] as String,
  tambakAsal: json['tambak_asal'] as String,
  customer: json['customer'] as String,
  tanggalPengiriman: DateTime.parse(json['tanggal_pengiriman'] as String),
  anamnesa: json['anamnesa'] as String,
  keteranganSampel: json['keterangan_sampel'] as String,
  jenisTesting: json['jenis_testing'] as String,
  status: json['status'] as String?,
  tanggalRequest: json['tanggal_request'] == null
      ? null
      : DateTime.parse(json['tanggal_request'] as String),
  jumlahSampel: (json['jumlah_sampel'] as num?)?.toInt(),
);

Map<String, dynamic> _$$LabRequestModelImplToJson(
  _$LabRequestModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'nama_pengirim': instance.namaPengirim,
  'no_telp': instance.noTelp,
  'email': instance.email,
  'tambak_asal': instance.tambakAsal,
  'customer': instance.customer,
  'tanggal_pengiriman': instance.tanggalPengiriman.toIso8601String(),
  'anamnesa': instance.anamnesa,
  'keterangan_sampel': instance.keteranganSampel,
  'jenis_testing': instance.jenisTesting,
  'status': instance.status,
  'tanggal_request': instance.tanggalRequest?.toIso8601String(),
  'jumlah_sampel': instance.jumlahSampel,
};
