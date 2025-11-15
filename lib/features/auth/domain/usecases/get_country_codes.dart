import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/auth/domain/entities/country_code.dart';
import 'package:flutter_base_app/features/auth/domain/repositories/auth_repository.dart';

/// Use case for getting country codes.
class GetCountryCodes {
  /// Creates a new instance of [GetCountryCodes].
  const GetCountryCodes(this._repository);

  final AuthRepository _repository;

  /// Executes the use case.
  ///
  /// Returns [Either] containing [Failure] on error or [List<CountryCode>] on success.
  Future<Either<Failure, List<CountryCode>>> call() async {
    return await _repository.getCountryCodes();
  }
}


