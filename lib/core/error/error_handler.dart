import 'package:flutter/foundation.dart';
import 'package:app_mobile_afms/core/error/error_mapper.dart';
import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';

/// Global error handler for the application.
class ErrorHandler {
  // Private constructor to prevent instantiation
  ErrorHandler._();

  /// Handle error and log it.
  static void handleError(
    Failure failure, {
    String? context,
    StackTrace? stackTrace,
  }) {
    // Log error
    AppLogger.error(
      '${context != null ? '[$context] ' : ''}${failure.message}',
      failure,
      stackTrace,
    );

    // In debug mode, print to console
    if (kDebugMode) {
      debugPrint('Error: ${failure.message}');
      if (stackTrace != null) {
        debugPrint('StackTrace: $stackTrace');
      }
    }

    // TODO(team): Add crash reporting integration here
    // if (failure is CriticalFailure) {
    //   crashReporter.recordError(failure, stackTrace);
    // }
  }

  /// Handle exception and convert to failure.
  static Failure handleException(
    dynamic exception, {
    String? context,
    StackTrace? stackTrace,
  }) {
    final failure = ErrorMapper.mapException(exception);

    // Log error
    AppLogger.error(
      '${context != null ? '[$context] ' : ''}Exception: '
      '$exception',
      exception,
      stackTrace,
    );

    return failure;
  }
}
