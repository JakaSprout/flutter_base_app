import 'package:flutter_base_app/core/config/app_config.dart';

/// Flavor-specific configurations.
class FlavorConfig {
  // Private constructor to prevent instantiation
  FlavorConfig._();

  /// Get API base URL based on flavor
  static String getApiBaseUrl(AppFlavor flavor) {
    switch (flavor) {
      case AppFlavor.dev:
        // Fake API for development (JSONPlaceholder)
        return 'https://jsonplaceholder.typicode.com';
      case AppFlavor.staging:
        return 'https://api-staging.example.com';
      case AppFlavor.prod:
        return 'https://api.example.com';
    }
  }

  /// Get API timeout based on flavor
  static int getApiTimeout(AppFlavor flavor) {
    switch (flavor) {
      case AppFlavor.dev:
        return 60; // Longer timeout for dev
      case AppFlavor.staging:
        return 30;
      case AppFlavor.prod:
        return 20; // Shorter timeout for prod
    }
  }

  /// Check if mock API should be used
  static bool useMockApi(AppFlavor flavor) {
    return flavor == AppFlavor.dev;
  }

  /// Get mock API delay in milliseconds (for testing)
  static int getMockApiDelay(AppFlavor flavor) {
    switch (flavor) {
      case AppFlavor.dev:
        return 500; // Simulate network delay
      case AppFlavor.staging:
        return 200;
      case AppFlavor.prod:
        return 0; // No delay in prod
    }
  }
}
