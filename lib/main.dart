import 'package:flutter/material.dart';
import 'package:flutter_base_app/app.dart';
import 'package:flutter_base_app/core/config/app_config.dart';
import 'package:flutter_base_app/core/logging/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Common initialization function that sets up the app with the given
/// configuration.
void mainCommon(AppConfig config) {
  // TODO(team): Initialize logging based on config.enableLogging
  // TODO(team): Initialize crash reporting based on config.enableCrashReporting
  // TODO(team): Initialize other services (database, network, etc.)

  // Initialize logger with config
  AppLogger.initialize(config);

  runApp(ProviderScope(child: App(config: config)));
}

/// Default main entry point (uses dev flavor).
///
/// This is the default entry point when running the app without specifying
/// a flavor. For flavor-specific builds, use `main_dev.dart`,
/// `main_staging.dart`, or `main_prod.dart`.
void main() {
  mainCommon(AppConfig.dev);
}
