// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'country_code_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CountryCodeModel _$CountryCodeModelFromJson(Map<String, dynamic> json) {
  return _CountryCodeModel.fromJson(json);
}

/// @nodoc
mixin _$CountryCodeModel {
  String get code => throw _privateConstructorUsedError;
  String get dialCode => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get flag => throw _privateConstructorUsedError;

  /// Serializes this CountryCodeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CountryCodeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CountryCodeModelCopyWith<CountryCodeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CountryCodeModelCopyWith<$Res> {
  factory $CountryCodeModelCopyWith(
    CountryCodeModel value,
    $Res Function(CountryCodeModel) then,
  ) = _$CountryCodeModelCopyWithImpl<$Res, CountryCodeModel>;
  @useResult
  $Res call({String code, String dialCode, String name, String? flag});
}

/// @nodoc
class _$CountryCodeModelCopyWithImpl<$Res, $Val extends CountryCodeModel>
    implements $CountryCodeModelCopyWith<$Res> {
  _$CountryCodeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CountryCodeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? dialCode = null,
    Object? name = null,
    Object? flag = freezed,
  }) {
    return _then(
      _value.copyWith(
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            dialCode: null == dialCode
                ? _value.dialCode
                : dialCode // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            flag: freezed == flag
                ? _value.flag
                : flag // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CountryCodeModelImplCopyWith<$Res>
    implements $CountryCodeModelCopyWith<$Res> {
  factory _$$CountryCodeModelImplCopyWith(
    _$CountryCodeModelImpl value,
    $Res Function(_$CountryCodeModelImpl) then,
  ) = __$$CountryCodeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String dialCode, String name, String? flag});
}

/// @nodoc
class __$$CountryCodeModelImplCopyWithImpl<$Res>
    extends _$CountryCodeModelCopyWithImpl<$Res, _$CountryCodeModelImpl>
    implements _$$CountryCodeModelImplCopyWith<$Res> {
  __$$CountryCodeModelImplCopyWithImpl(
    _$CountryCodeModelImpl _value,
    $Res Function(_$CountryCodeModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CountryCodeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? dialCode = null,
    Object? name = null,
    Object? flag = freezed,
  }) {
    return _then(
      _$CountryCodeModelImpl(
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        dialCode: null == dialCode
            ? _value.dialCode
            : dialCode // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        flag: freezed == flag
            ? _value.flag
            : flag // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CountryCodeModelImpl implements _CountryCodeModel {
  const _$CountryCodeModelImpl({
    required this.code,
    required this.dialCode,
    required this.name,
    this.flag,
  });

  factory _$CountryCodeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CountryCodeModelImplFromJson(json);

  @override
  final String code;
  @override
  final String dialCode;
  @override
  final String name;
  @override
  final String? flag;

  @override
  String toString() {
    return 'CountryCodeModel(code: $code, dialCode: $dialCode, name: $name, flag: $flag)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CountryCodeModelImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.dialCode, dialCode) ||
                other.dialCode == dialCode) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.flag, flag) || other.flag == flag));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, dialCode, name, flag);

  /// Create a copy of CountryCodeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CountryCodeModelImplCopyWith<_$CountryCodeModelImpl> get copyWith =>
      __$$CountryCodeModelImplCopyWithImpl<_$CountryCodeModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CountryCodeModelImplToJson(this);
  }
}

abstract class _CountryCodeModel implements CountryCodeModel {
  const factory _CountryCodeModel({
    required final String code,
    required final String dialCode,
    required final String name,
    final String? flag,
  }) = _$CountryCodeModelImpl;

  factory _CountryCodeModel.fromJson(Map<String, dynamic> json) =
      _$CountryCodeModelImpl.fromJson;

  @override
  String get code;
  @override
  String get dialCode;
  @override
  String get name;
  @override
  String? get flag;

  /// Create a copy of CountryCodeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CountryCodeModelImplCopyWith<_$CountryCodeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
