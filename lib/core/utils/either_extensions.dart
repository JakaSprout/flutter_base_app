import 'package:dartz/dartz.dart';
import 'package:app_mobile_afms/core/error/failures.dart';

/// Extension methods for [Either] to simplify error handling.
extension EitherExtensions<L extends Failure, R> on Either<L, R> {
  /// Converts [Either] to [Future] by throwing the failure if left,
  /// or returning the value if right.
  ///
  /// This is useful when you need to convert Either to Future
  /// for use with Riverpod providers or async functions.
  Future<R> toFuture() {
    return fold<Future<R>>((failure) => throw failure, Future.value);
  }

  /// Converts [Either] to [Future] synchronously by throwing the failure if left,
  /// or returning the value if right.
  ///
  /// This is useful when you need to convert Either to a value directly.
  R toValue() {
    return fold<R>((failure) => throw failure, (data) => data);
  }
}
