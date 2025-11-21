// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registered_pond.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RegisteredPond _$RegisteredPondFromJson(Map<String, dynamic> json) {
  return _RegisteredPond.fromJson(json);
}

/// @nodoc
mixin _$RegisteredPond {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get area => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  DateTime get registeredAt => throw _privateConstructorUsedError;

  /// Serializes this RegisteredPond to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegisteredPond
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisteredPondCopyWith<RegisteredPond> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisteredPondCopyWith<$Res> {
  factory $RegisteredPondCopyWith(
    RegisteredPond value,
    $Res Function(RegisteredPond) then,
  ) = _$RegisteredPondCopyWithImpl<$Res, RegisteredPond>;
  @useResult
  $Res call({
    String id,
    String name,
    double area,
    String location,
    DateTime registeredAt,
  });
}

/// @nodoc
class _$RegisteredPondCopyWithImpl<$Res, $Val extends RegisteredPond>
    implements $RegisteredPondCopyWith<$Res> {
  _$RegisteredPondCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisteredPond
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? area = null,
    Object? location = null,
    Object? registeredAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            area: null == area
                ? _value.area
                : area // ignore: cast_nullable_to_non_nullable
                      as double,
            location: null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String,
            registeredAt: null == registeredAt
                ? _value.registeredAt
                : registeredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RegisteredPondImplCopyWith<$Res>
    implements $RegisteredPondCopyWith<$Res> {
  factory _$$RegisteredPondImplCopyWith(
    _$RegisteredPondImpl value,
    $Res Function(_$RegisteredPondImpl) then,
  ) = __$$RegisteredPondImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    double area,
    String location,
    DateTime registeredAt,
  });
}

/// @nodoc
class __$$RegisteredPondImplCopyWithImpl<$Res>
    extends _$RegisteredPondCopyWithImpl<$Res, _$RegisteredPondImpl>
    implements _$$RegisteredPondImplCopyWith<$Res> {
  __$$RegisteredPondImplCopyWithImpl(
    _$RegisteredPondImpl _value,
    $Res Function(_$RegisteredPondImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RegisteredPond
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? area = null,
    Object? location = null,
    Object? registeredAt = null,
  }) {
    return _then(
      _$RegisteredPondImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        area: null == area
            ? _value.area
            : area // ignore: cast_nullable_to_non_nullable
                  as double,
        location: null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String,
        registeredAt: null == registeredAt
            ? _value.registeredAt
            : registeredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisteredPondImpl implements _RegisteredPond {
  const _$RegisteredPondImpl({
    required this.id,
    required this.name,
    required this.area,
    required this.location,
    required this.registeredAt,
  });

  factory _$RegisteredPondImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisteredPondImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final double area;
  @override
  final String location;
  @override
  final DateTime registeredAt;

  @override
  String toString() {
    return 'RegisteredPond(id: $id, name: $name, area: $area, location: $location, registeredAt: $registeredAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisteredPondImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.registeredAt, registeredAt) ||
                other.registeredAt == registeredAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, area, location, registeredAt);

  /// Create a copy of RegisteredPond
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisteredPondImplCopyWith<_$RegisteredPondImpl> get copyWith =>
      __$$RegisteredPondImplCopyWithImpl<_$RegisteredPondImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisteredPondImplToJson(this);
  }
}

abstract class _RegisteredPond implements RegisteredPond {
  const factory _RegisteredPond({
    required final String id,
    required final String name,
    required final double area,
    required final String location,
    required final DateTime registeredAt,
  }) = _$RegisteredPondImpl;

  factory _RegisteredPond.fromJson(Map<String, dynamic> json) =
      _$RegisteredPondImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  double get area;
  @override
  String get location;
  @override
  DateTime get registeredAt;

  /// Create a copy of RegisteredPond
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisteredPondImplCopyWith<_$RegisteredPondImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
