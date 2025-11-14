import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/logging/logger.dart';
import 'package:flutter_base_app/design_system/components/navigation/stp_bottom_nav_bar.dart';
import 'package:flutter_base_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_base_app/features/input_data/presentation/screens/input_data_screen.dart';
import 'package:flutter_base_app/features/graph/presentation/screens/graph_screen.dart';
import 'package:flutter_base_app/features/pond/presentation/screens/pond_screen.dart';
import 'package:flutter_base_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter_base_app/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Main router configuration for the application.
class AppRouter {
  /// GoRouter instance for navigation.
  static final GoRouter router = GoRouter(
    initialLocation: Routes.home,
    routes: [
      // Shell route with bottom navigation bar
      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            body: child,
            bottomNavigationBar: STPBottomNavBar(
              currentLocation: state.uri.path,
            ),
            floatingActionButton: STPBottomNavBar.buildFAB(context),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        },
        routes: [
          GoRoute(
            path: Routes.home,
            name: Routes.homeName,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: Routes.graph,
            name: Routes.graphName,
            builder: (context, state) => const GraphScreen(),
          ),
          GoRoute(
            path: Routes.inputData,
            name: Routes.inputDataName,
            builder: (context, state) => const InputDataScreen(),
          ),
          GoRoute(
            path: Routes.pond,
            name: Routes.pondName,
            builder: (context, state) => const PondScreen(),
          ),
          GoRoute(
            path: Routes.profile,
            name: Routes.profileName,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      // Splash route (outside shell route, no bottom nav)
      GoRoute(
        path: Routes.splash,
        name: Routes.splashName,
        builder: (context, state) {
          return const Scaffold(body: Center(child: Text('Splash Screen')));
        },
      ),
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
