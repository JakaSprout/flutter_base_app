import 'package:app_mobile_afms/core/config/app_config.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Log level configuration per flavor.
class LogLevels {
  // Private constructor to prevent instantiation
  LogLevels._();

  /// Get log level based on flavor.
  static LogLevel getLogLevel(AppFlavor flavor) {
    switch (flavor) {
      case AppFlavor.dev:
        return LogLevel.verbose; // Show all logs in dev
      case AppFlavor.staging:
        return LogLevel.warning; // Show warnings and above in staging
      case AppFlavor.prod:
        return LogLevel.error; // Show only errors in prod
    }
  }
}
