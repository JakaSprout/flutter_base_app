import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_base_app/features/auth/domain/entities/country_code.dart';

part 'country_code_model.freezed.dart';
part 'country_code_model.g.dart';

/// Country code data model (data layer).
@freezed
class CountryCodeModel with _$CountryCodeModel {
  /// Creates a new instance of [CountryCodeModel].
  const factory CountryCodeModel({
    required String code,
    required String dialCode,
    required String name,
    String? flag,
  }) = _CountryCodeModel;

  /// Creates [CountryCodeModel] from JSON.
  factory CountryCodeModel.fromJson(Map<String, dynamic> json) =>
      _$CountryCodeModelFromJson(json);
}

/// Extension to convert [CountryCodeModel] to [CountryCode].
extension CountryCodeModelExtension on CountryCodeModel {
  /// Converts [CountryCodeModel] to [CountryCode].
  CountryCode toEntity() {
    return CountryCode(
      code: code,
      dialCode: dialCode,
      name: name,
      flag: flag,
    );
  }
}

/// Extension to convert [CountryCode] to [CountryCodeModel].
extension CountryCodeEntityExtension on CountryCode {
  /// Converts [CountryCode] to [CountryCodeModel].
  CountryCodeModel toModel() {
    return CountryCodeModel(
      code: code,
      dialCode: dialCode,
      name: name,
      flag: flag,
    );
  }
}


