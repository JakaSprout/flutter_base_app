/// Application configuration based on flavor.
enum AppFlavor {
  /// Development environment
  dev,

  /// Staging environment
  staging,

  /// Production environment
  prod,
}

/// Application configuration class.
class AppConfig {
  /// Creates a new instance of [AppConfig].
  const AppConfig({
    required this.flavor,
    required this.appName,
    required this.apiBaseUrl,
    required this.enableLogging,
    required this.enableCrashReporting,
    this.useMockApi = false,
    this.mockApiDelayMs = 0,
  });

  /// Current flavor
  final AppFlavor flavor;

  /// Application name
  final String appName;

  /// API base URL
  final String apiBaseUrl;

  /// Enable logging
  final bool enableLogging;

  /// Enable crash reporting
  final bool enableCrashReporting;

  /// Whether to use mock API instead of real API
  final bool useMockApi;

  /// Mock API delay in milliseconds (for testing/simulation)
  final int mockApiDelayMs;

  /// Development configuration
  static const AppConfig dev = AppConfig(
    flavor: AppFlavor.dev,
    appName: 'Flutter Base App Dev',
    apiBaseUrl: 'https://1809277e3b79.ngrok-free.app/',
    enableLogging: true,
    enableCrashReporting: false,
  );

  /// Staging configuration
  static const AppConfig staging = AppConfig(
    flavor: AppFlavor.staging,
    appName: 'Flutter Base App Staging',
    apiBaseUrl: 'https://api-staging.example.com',
    enableLogging: true,
    enableCrashReporting: true,
  );

  /// Production configuration
  static const AppConfig prod = AppConfig(
    flavor: AppFlavor.prod,
    appName: 'Flutter Base App',
    apiBaseUrl: 'https://api.example.com',
    enableLogging: false,
    enableCrashReporting: true,
  );

  /// Get configuration based on flavor
  static AppConfig fromFlavor(AppFlavor flavor) {
    switch (flavor) {
      case AppFlavor.dev:
        return dev;
      case AppFlavor.staging:
        return staging;
      case AppFlavor.prod:
        return prod;
    }
  }
}
