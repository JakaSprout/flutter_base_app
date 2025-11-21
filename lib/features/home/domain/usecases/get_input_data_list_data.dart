import 'package:dartz/dartz.dart';
import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/home/domain/entities/input_data_list_data.dart';
import 'package:app_mobile_afms/features/home/domain/repositories/home_repository.dart';

/// Use case for getting input data list.
class GetInputDataListData {
  /// Creates a new instance of [GetInputDataListData].
  const GetInputDataListData(this.repository);

  /// Home repository
  final HomeRepository repository;

  /// Execute the use case.
  ///
  /// Returns [Either] containing [Failure] on error or [InputDataListData] on success.
  Future<Either<Failure, InputDataListData>> call() async {
    return repository.getInputDataListData();
  }
}

