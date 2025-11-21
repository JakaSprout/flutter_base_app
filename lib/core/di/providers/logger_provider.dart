import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'logger_provider.g.dart';

/// Provider for Talker logger instance.
///
/// This provider provides access to the AppLogger singleton instance.
/// The logger is initialized during app startup with the appropriate
/// configuration based on the flavor.
@Riverpod(keepAlive: true)
Talker logger(LoggerRef ref) {
  return AppLogger.instance;
}
