// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lab_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LabRequestModel _$LabRequestModelFromJson(Map<String, dynamic> json) {
  return _LabRequestModel.fromJson(json);
}

/// @nodoc
mixin _$LabRequestModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'nama_pengirim')
  String get namaPengirim => throw _privateConstructorUsedError;
  @JsonKey(name: 'no_telp')
  String get noTelp => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'tambak_asal')
  String get tambakAsal => throw _privateConstructorUsedError;
  String get customer => throw _privateConstructorUsedError;
  @JsonKey(name: 'tanggal_pengiriman')
  DateTime get tanggalPengiriman => throw _privateConstructorUsedError;
  String get anamnesa =>
      throw _privateConstructorUsedError; // "diagnostik" or "screening"
  @JsonKey(name: 'keterangan_sampel')
  String get keteranganSampel => throw _privateConstructorUsedError;
  @JsonKey(name: 'jenis_testing')
  String get jenisTesting => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
  LabRequestStatus? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'tanggal_request')
  DateTime? get tanggalRequest => throw _privateConstructorUsedError;
  @JsonKey(name: 'jumlah_sampel')
  int? get jumlahSampel => throw _privateConstructorUsedError;

  /// Serializes this LabRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LabRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LabRequestModelCopyWith<LabRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LabRequestModelCopyWith<$Res> {
  factory $LabRequestModelCopyWith(
    LabRequestModel value,
    $Res Function(LabRequestModel) then,
  ) = _$LabRequestModelCopyWithImpl<$Res, LabRequestModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'nama_pengirim') String namaPengirim,
    @JsonKey(name: 'no_telp') String noTelp,
    String email,
    @JsonKey(name: 'tambak_asal') String tambakAsal,
    String customer,
    @JsonKey(name: 'tanggal_pengiriman') DateTime tanggalPengiriman,
    String anamnesa,
    @JsonKey(name: 'keterangan_sampel') String keteranganSampel,
    @JsonKey(name: 'jenis_testing') String jenisTesting,
    @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
    LabRequestStatus? status,
    @JsonKey(name: 'tanggal_request') DateTime? tanggalRequest,
    @JsonKey(name: 'jumlah_sampel') int? jumlahSampel,
  });
}

/// @nodoc
class _$LabRequestModelCopyWithImpl<$Res, $Val extends LabRequestModel>
    implements $LabRequestModelCopyWith<$Res> {
  _$LabRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LabRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? namaPengirim = null,
    Object? noTelp = null,
    Object? email = null,
    Object? tambakAsal = null,
    Object? customer = null,
    Object? tanggalPengiriman = null,
    Object? anamnesa = null,
    Object? keteranganSampel = null,
    Object? jenisTesting = null,
    Object? status = freezed,
    Object? tanggalRequest = freezed,
    Object? jumlahSampel = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            namaPengirim: null == namaPengirim
                ? _value.namaPengirim
                : namaPengirim // ignore: cast_nullable_to_non_nullable
                      as String,
            noTelp: null == noTelp
                ? _value.noTelp
                : noTelp // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            tambakAsal: null == tambakAsal
                ? _value.tambakAsal
                : tambakAsal // ignore: cast_nullable_to_non_nullable
                      as String,
            customer: null == customer
                ? _value.customer
                : customer // ignore: cast_nullable_to_non_nullable
                      as String,
            tanggalPengiriman: null == tanggalPengiriman
                ? _value.tanggalPengiriman
                : tanggalPengiriman // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            anamnesa: null == anamnesa
                ? _value.anamnesa
                : anamnesa // ignore: cast_nullable_to_non_nullable
                      as String,
            keteranganSampel: null == keteranganSampel
                ? _value.keteranganSampel
                : keteranganSampel // ignore: cast_nullable_to_non_nullable
                      as String,
            jenisTesting: null == jenisTesting
                ? _value.jenisTesting
                : jenisTesting // ignore: cast_nullable_to_non_nullable
                      as String,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as LabRequestStatus?,
            tanggalRequest: freezed == tanggalRequest
                ? _value.tanggalRequest
                : tanggalRequest // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            jumlahSampel: freezed == jumlahSampel
                ? _value.jumlahSampel
                : jumlahSampel // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LabRequestModelImplCopyWith<$Res>
    implements $LabRequestModelCopyWith<$Res> {
  factory _$$LabRequestModelImplCopyWith(
    _$LabRequestModelImpl value,
    $Res Function(_$LabRequestModelImpl) then,
  ) = __$$LabRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'nama_pengirim') String namaPengirim,
    @JsonKey(name: 'no_telp') String noTelp,
    String email,
    @JsonKey(name: 'tambak_asal') String tambakAsal,
    String customer,
    @JsonKey(name: 'tanggal_pengiriman') DateTime tanggalPengiriman,
    String anamnesa,
    @JsonKey(name: 'keterangan_sampel') String keteranganSampel,
    @JsonKey(name: 'jenis_testing') String jenisTesting,
    @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
    LabRequestStatus? status,
    @JsonKey(name: 'tanggal_request') DateTime? tanggalRequest,
    @JsonKey(name: 'jumlah_sampel') int? jumlahSampel,
  });
}

/// @nodoc
class __$$LabRequestModelImplCopyWithImpl<$Res>
    extends _$LabRequestModelCopyWithImpl<$Res, _$LabRequestModelImpl>
    implements _$$LabRequestModelImplCopyWith<$Res> {
  __$$LabRequestModelImplCopyWithImpl(
    _$LabRequestModelImpl _value,
    $Res Function(_$LabRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LabRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? namaPengirim = null,
    Object? noTelp = null,
    Object? email = null,
    Object? tambakAsal = null,
    Object? customer = null,
    Object? tanggalPengiriman = null,
    Object? anamnesa = null,
    Object? keteranganSampel = null,
    Object? jenisTesting = null,
    Object? status = freezed,
    Object? tanggalRequest = freezed,
    Object? jumlahSampel = freezed,
  }) {
    return _then(
      _$LabRequestModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        namaPengirim: null == namaPengirim
            ? _value.namaPengirim
            : namaPengirim // ignore: cast_nullable_to_non_nullable
                  as String,
        noTelp: null == noTelp
            ? _value.noTelp
            : noTelp // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        tambakAsal: null == tambakAsal
            ? _value.tambakAsal
            : tambakAsal // ignore: cast_nullable_to_non_nullable
                  as String,
        customer: null == customer
            ? _value.customer
            : customer // ignore: cast_nullable_to_non_nullable
                  as String,
        tanggalPengiriman: null == tanggalPengiriman
            ? _value.tanggalPengiriman
            : tanggalPengiriman // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        anamnesa: null == anamnesa
            ? _value.anamnesa
            : anamnesa // ignore: cast_nullable_to_non_nullable
                  as String,
        keteranganSampel: null == keteranganSampel
            ? _value.keteranganSampel
            : keteranganSampel // ignore: cast_nullable_to_non_nullable
                  as String,
        jenisTesting: null == jenisTesting
            ? _value.jenisTesting
            : jenisTesting // ignore: cast_nullable_to_non_nullable
                  as String,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as LabRequestStatus?,
        tanggalRequest: freezed == tanggalRequest
            ? _value.tanggalRequest
            : tanggalRequest // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        jumlahSampel: freezed == jumlahSampel
            ? _value.jumlahSampel
            : jumlahSampel // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LabRequestModelImpl implements _LabRequestModel {
  const _$LabRequestModelImpl({
    required this.id,
    @JsonKey(name: 'nama_pengirim') required this.namaPengirim,
    @JsonKey(name: 'no_telp') required this.noTelp,
    required this.email,
    @JsonKey(name: 'tambak_asal') required this.tambakAsal,
    required this.customer,
    @JsonKey(name: 'tanggal_pengiriman') required this.tanggalPengiriman,
    required this.anamnesa,
    @JsonKey(name: 'keterangan_sampel') required this.keteranganSampel,
    @JsonKey(name: 'jenis_testing') required this.jenisTesting,
    @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson) this.status,
    @JsonKey(name: 'tanggal_request') this.tanggalRequest,
    @JsonKey(name: 'jumlah_sampel') this.jumlahSampel,
  });

  factory _$LabRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LabRequestModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'nama_pengirim')
  final String namaPengirim;
  @override
  @JsonKey(name: 'no_telp')
  final String noTelp;
  @override
  final String email;
  @override
  @JsonKey(name: 'tambak_asal')
  final String tambakAsal;
  @override
  final String customer;
  @override
  @JsonKey(name: 'tanggal_pengiriman')
  final DateTime tanggalPengiriman;
  @override
  final String anamnesa;
  // "diagnostik" or "screening"
  @override
  @JsonKey(name: 'keterangan_sampel')
  final String keteranganSampel;
  @override
  @JsonKey(name: 'jenis_testing')
  final String jenisTesting;
  @override
  @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
  final LabRequestStatus? status;
  @override
  @JsonKey(name: 'tanggal_request')
  final DateTime? tanggalRequest;
  @override
  @JsonKey(name: 'jumlah_sampel')
  final int? jumlahSampel;

  @override
  String toString() {
    return 'LabRequestModel(id: $id, namaPengirim: $namaPengirim, noTelp: $noTelp, email: $email, tambakAsal: $tambakAsal, customer: $customer, tanggalPengiriman: $tanggalPengiriman, anamnesa: $anamnesa, keteranganSampel: $keteranganSampel, jenisTesting: $jenisTesting, status: $status, tanggalRequest: $tanggalRequest, jumlahSampel: $jumlahSampel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LabRequestModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.namaPengirim, namaPengirim) ||
                other.namaPengirim == namaPengirim) &&
            (identical(other.noTelp, noTelp) || other.noTelp == noTelp) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.tambakAsal, tambakAsal) ||
                other.tambakAsal == tambakAsal) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            (identical(other.tanggalPengiriman, tanggalPengiriman) ||
                other.tanggalPengiriman == tanggalPengiriman) &&
            (identical(other.anamnesa, anamnesa) ||
                other.anamnesa == anamnesa) &&
            (identical(other.keteranganSampel, keteranganSampel) ||
                other.keteranganSampel == keteranganSampel) &&
            (identical(other.jenisTesting, jenisTesting) ||
                other.jenisTesting == jenisTesting) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.tanggalRequest, tanggalRequest) ||
                other.tanggalRequest == tanggalRequest) &&
            (identical(other.jumlahSampel, jumlahSampel) ||
                other.jumlahSampel == jumlahSampel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    namaPengirim,
    noTelp,
    email,
    tambakAsal,
    customer,
    tanggalPengiriman,
    anamnesa,
    keteranganSampel,
    jenisTesting,
    status,
    tanggalRequest,
    jumlahSampel,
  );

  /// Create a copy of LabRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LabRequestModelImplCopyWith<_$LabRequestModelImpl> get copyWith =>
      __$$LabRequestModelImplCopyWithImpl<_$LabRequestModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LabRequestModelImplToJson(this);
  }
}

abstract class _LabRequestModel implements LabRequestModel {
  const factory _LabRequestModel({
    required final String id,
    @JsonKey(name: 'nama_pengirim') required final String namaPengirim,
    @JsonKey(name: 'no_telp') required final String noTelp,
    required final String email,
    @JsonKey(name: 'tambak_asal') required final String tambakAsal,
    required final String customer,
    @JsonKey(name: 'tanggal_pengiriman')
    required final DateTime tanggalPengiriman,
    required final String anamnesa,
    @JsonKey(name: 'keterangan_sampel') required final String keteranganSampel,
    @JsonKey(name: 'jenis_testing') required final String jenisTesting,
    @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
    final LabRequestStatus? status,
    @JsonKey(name: 'tanggal_request') final DateTime? tanggalRequest,
    @JsonKey(name: 'jumlah_sampel') final int? jumlahSampel,
  }) = _$LabRequestModelImpl;

  factory _LabRequestModel.fromJson(Map<String, dynamic> json) =
      _$LabRequestModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'nama_pengirim')
  String get namaPengirim;
  @override
  @JsonKey(name: 'no_telp')
  String get noTelp;
  @override
  String get email;
  @override
  @JsonKey(name: 'tambak_asal')
  String get tambakAsal;
  @override
  String get customer;
  @override
  @JsonKey(name: 'tanggal_pengiriman')
  DateTime get tanggalPengiriman;
  @override
  String get anamnesa; // "diagnostik" or "screening"
  @override
  @JsonKey(name: 'keterangan_sampel')
  String get keteranganSampel;
  @override
  @JsonKey(name: 'jenis_testing')
  String get jenisTesting;
  @override
  @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
  LabRequestStatus? get status;
  @override
  @JsonKey(name: 'tanggal_request')
  DateTime? get tanggalRequest;
  @override
  @JsonKey(name: 'jumlah_sampel')
  int? get jumlahSampel;

  /// Create a copy of LabRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LabRequestModelImplCopyWith<_$LabRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
