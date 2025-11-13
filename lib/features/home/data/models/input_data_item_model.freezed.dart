// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'input_data_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

InputDataItemModel _$InputDataItemModelFromJson(Map<String, dynamic> json) {
  return _InputDataItemModel.fromJson(json);
}

/// @nodoc
mixin _$InputDataItemModel {
  String get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String get iconPath => throw _privateConstructorUsedError;
  String get backgroundColor => throw _privateConstructorUsedError;
  String get iconColor => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;

  /// Serializes this InputDataItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InputDataItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InputDataItemModelCopyWith<InputDataItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InputDataItemModelCopyWith<$Res> {
  factory $InputDataItemModelCopyWith(
    InputDataItemModel value,
    $Res Function(InputDataItemModel) then,
  ) = _$InputDataItemModelCopyWithImpl<$Res, InputDataItemModel>;
  @useResult
  $Res call({
    String id,
    String label,
    String iconPath,
    String backgroundColor,
    String iconColor,
    int order,
  });
}

/// @nodoc
class _$InputDataItemModelCopyWithImpl<$Res, $Val extends InputDataItemModel>
    implements $InputDataItemModelCopyWith<$Res> {
  _$InputDataItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InputDataItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? iconPath = null,
    Object? backgroundColor = null,
    Object? iconColor = null,
    Object? order = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            iconPath: null == iconPath
                ? _value.iconPath
                : iconPath // ignore: cast_nullable_to_non_nullable
                      as String,
            backgroundColor: null == backgroundColor
                ? _value.backgroundColor
                : backgroundColor // ignore: cast_nullable_to_non_nullable
                      as String,
            iconColor: null == iconColor
                ? _value.iconColor
                : iconColor // ignore: cast_nullable_to_non_nullable
                      as String,
            order: null == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InputDataItemModelImplCopyWith<$Res>
    implements $InputDataItemModelCopyWith<$Res> {
  factory _$$InputDataItemModelImplCopyWith(
    _$InputDataItemModelImpl value,
    $Res Function(_$InputDataItemModelImpl) then,
  ) = __$$InputDataItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String label,
    String iconPath,
    String backgroundColor,
    String iconColor,
    int order,
  });
}

/// @nodoc
class __$$InputDataItemModelImplCopyWithImpl<$Res>
    extends _$InputDataItemModelCopyWithImpl<$Res, _$InputDataItemModelImpl>
    implements _$$InputDataItemModelImplCopyWith<$Res> {
  __$$InputDataItemModelImplCopyWithImpl(
    _$InputDataItemModelImpl _value,
    $Res Function(_$InputDataItemModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InputDataItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? iconPath = null,
    Object? backgroundColor = null,
    Object? iconColor = null,
    Object? order = null,
  }) {
    return _then(
      _$InputDataItemModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        iconPath: null == iconPath
            ? _value.iconPath
            : iconPath // ignore: cast_nullable_to_non_nullable
                  as String,
        backgroundColor: null == backgroundColor
            ? _value.backgroundColor
            : backgroundColor // ignore: cast_nullable_to_non_nullable
                  as String,
        iconColor: null == iconColor
            ? _value.iconColor
            : iconColor // ignore: cast_nullable_to_non_nullable
                  as String,
        order: null == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InputDataItemModelImpl implements _InputDataItemModel {
  const _$InputDataItemModelImpl({
    required this.id,
    required this.label,
    required this.iconPath,
    required this.backgroundColor,
    required this.iconColor,
    required this.order,
  });

  factory _$InputDataItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InputDataItemModelImplFromJson(json);

  @override
  final String id;
  @override
  final String label;
  @override
  final String iconPath;
  @override
  final String backgroundColor;
  @override
  final String iconColor;
  @override
  final int order;

  @override
  String toString() {
    return 'InputDataItemModel(id: $id, label: $label, iconPath: $iconPath, backgroundColor: $backgroundColor, iconColor: $iconColor, order: $order)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InputDataItemModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.iconPath, iconPath) ||
                other.iconPath == iconPath) &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.iconColor, iconColor) ||
                other.iconColor == iconColor) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    label,
    iconPath,
    backgroundColor,
    iconColor,
    order,
  );

  /// Create a copy of InputDataItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InputDataItemModelImplCopyWith<_$InputDataItemModelImpl> get copyWith =>
      __$$InputDataItemModelImplCopyWithImpl<_$InputDataItemModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$InputDataItemModelImplToJson(this);
  }
}

abstract class _InputDataItemModel implements InputDataItemModel {
  const factory _InputDataItemModel({
    required final String id,
    required final String label,
    required final String iconPath,
    required final String backgroundColor,
    required final String iconColor,
    required final int order,
  }) = _$InputDataItemModelImpl;

  factory _InputDataItemModel.fromJson(Map<String, dynamic> json) =
      _$InputDataItemModelImpl.fromJson;

  @override
  String get id;
  @override
  String get label;
  @override
  String get iconPath;
  @override
  String get backgroundColor;
  @override
  String get iconColor;
  @override
  int get order;

  /// Create a copy of InputDataItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InputDataItemModelImplCopyWith<_$InputDataItemModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
