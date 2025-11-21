import 'package:app_mobile_afms/core/config/app_config.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Application logger using Talker.
class AppLogger {
  // Private constructor to prevent instantiation
  AppLogger._();

  static Talker? _instance;

  /// Get logger instance.
  static Talker get instance {
    _instance ??= _createLogger();
    return _instance!;
  }

  /// Create logger instance based on configuration.
  static Talker _createLogger() {
    // Default to dev config if not initialized
    const config = AppConfig.dev;
    return _createLoggerWithConfig(config);
  }

  /// Create logger with specific configuration.
  static Talker _createLoggerWithConfig(AppConfig config) {
    // Note: Talker handles log filtering automatically based on the method
    // called (debug, info, warning, error, critical). The LogLevels class is
    // available for reference but Talker's filtering is controlled by the
    // logging methods.
    return TalkerFlutter.init(
      settings: TalkerSettings(
        enabled: config.enableLogging,
        maxHistoryItems: 100,
      ),
    );
  }

  /// Initialize logger with configuration.
  static void initialize(AppConfig config) {
    _instance = _createLoggerWithConfig(config);
  }

  /// Log debug message.
  static void debug(
    String message, [
    dynamic exception,
    StackTrace? stackTrace,
  ]) {
    instance.debug(message, exception, stackTrace);
  }

  /// Log info message.
  static void info(
    String message, [
    dynamic exception,
    StackTrace? stackTrace,
  ]) {
    instance.info(message, exception, stackTrace);
  }

  /// Log warning message.
  static void warning(
    String message, [
    dynamic exception,
    StackTrace? stackTrace,
  ]) {
    instance.warning(message, exception, stackTrace);
  }

  /// Log error message.
  static void error(
    String message, [
    dynamic exception,
    StackTrace? stackTrace,
  ]) {
    instance.error(message, exception, stackTrace);
  }

  /// Log critical error.
  static void critical(
    String message, [
    dynamic exception,
    StackTrace? stackTrace,
  ]) {
    instance.critical(message, exception, stackTrace);
  }
}
