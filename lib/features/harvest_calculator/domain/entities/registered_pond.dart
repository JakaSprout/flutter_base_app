import 'package:freezed_annotation/freezed_annotation.dart';

part 'registered_pond.freezed.dart';
part 'registered_pond.g.dart';

/// Domain entity representing registered pond information.
@freezed
class RegisteredPond with _$RegisteredPond {
  const factory RegisteredPond({
    required String id,
    required String name,
    required double area,
    required String location,
    required DateTime registeredAt,
  }) = _RegisteredPond;

  factory RegisteredPond.fromJson(Map<String, dynamic> json) =>
      _$RegisteredPondFromJson(json);
}

