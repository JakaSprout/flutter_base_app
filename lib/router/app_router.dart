import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/logging/logger.dart';
import 'package:flutter_base_app/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Main router configuration for the application.
class AppRouter {
  /// GoRouter instance for navigation.
  static final GoRouter router = GoRouter(
    initialLocation: Routes.home,
    routes: [
      GoRoute(
        path: Routes.home,
        name: Routes.homeName,
        builder: (context, state) {
          // TODO(team): Replace with actual home screen
          return const Scaffold(
            body: Center(child: Text('Home Screen - TODO: Implement')),
          );
        },
      ),
      // TODO(team): Add more routes as features are implemented
    ],
    // Add TalkerRouteObserver for logging route changes
    observers: [TalkerRouteObserver(AppLogger.instance)],
    // Log navigation errors
    onException: (context, state, exception) {
      AppLogger.error(
        'Navigation error: ${state.uri}',
        exception,
        StackTrace.current,
      );
    },
  );
}
