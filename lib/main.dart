import 'package:flutter/material.dart';
import 'package:app_mobile_afms/app.dart';
import 'package:app_mobile_afms/core/config/app_config.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Common initialization function that sets up the app with the given
/// configuration.
void mainCommon(AppConfig config) {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Preserve native splash screen during initialization
  // This keeps the native splash visible while Flutter initializes
  // and auth state is being checked
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);

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
