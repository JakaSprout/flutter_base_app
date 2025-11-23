import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:app_mobile_afms/design_system/components/navigation/stp_bottom_nav_bar.dart';
import 'package:app_mobile_afms/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:app_mobile_afms/features/auth/presentation/screens/login_screen.dart';
import 'package:app_mobile_afms/features/graph/presentation/screens/graph_screen.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/simulation_results_models.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/screens/create_simulation_screen.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/screens/simulation_list_screen.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/screens/simulation_results_screen.dart';
import 'package:app_mobile_afms/features/home/presentation/screens/home_screen.dart';
import 'package:app_mobile_afms/features/input_data/presentation/screens/input_data_screen.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/screens/lab_request_form_screen.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/screens/lab_request_list_screen.dart';
import 'package:app_mobile_afms/features/pond/presentation/screens/pond_screen.dart';
import 'package:app_mobile_afms/features/profile/presentation/screens/profile_screen.dart';
import 'package:app_mobile_afms/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Main router configuration for the application.
class AppRouter {
  /// Root navigator key for route observation
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  /// Shell navigator key for route observation
  static final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>();

  /// Current GoRouter instance (set when router is created)
  static GoRouter? _currentRouter;

  /// Get root navigator key (public access for logout navigation)
  static GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;

  /// Get current GoRouter instance
  static GoRouter? get currentRouter => _currentRouter;

  /// Create GoRouter instance with authentication redirect guard.
  ///
  /// This router automatically redirects unauthenticated users to login
  /// and authenticated users away from login screen.
  ///
  /// Best Practice Implementation:
  /// - Uses `/loading` route that is not visible to user (splash still shown)
  /// - Redirects based on auth state directly in redirect callback
  /// - Native splash is removed in App widget when auth state resolves
  static GoRouter createRouter(WidgetRef ref, AsyncValue<bool> authStateAsync) {
    // Start at loading route - not visible to user because splash is preserved
    // Once auth state resolves, redirect will navigate to home or login
    final router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: Routes.splash, // /loading route
      redirect: (context, state) {
        // Read auth state directly from provider to get latest value
        // This ensures redirect works correctly after logout/invalidate
        final currentAuthState = ref.read(authStateProvider);

        // Log redirect check for debugging
        final currentPath = state.uri.path;
        currentAuthState.whenOrNull(
          data: (isAuthenticated) {
            AppLogger.info(
              'Router redirect check: path=$currentPath, '
              'isAuthenticated=$isAuthenticated',
            );
          },
        );

        // Handle redirect based on auth state
        return currentAuthState.when(
          loading: () {
            // Still loading, stay on loading route (splash still visible)
            return null;
          },
          error: (_, __) {
            // Error occurred, go to login
            return Routes.login;
          },
          data: (isAuthenticated) {
            // Auth state resolved, redirect based on authentication
            final currentPath = state.uri.path;

            // If authenticated and trying to access login, redirect to home
            if (isAuthenticated && currentPath == Routes.login) {
              return Routes.home;
            }

            // If not authenticated and trying to access protected route,
            // redirect to login
            // Protected routes are all routes except login, splash,
            // and public routes
            if (!isAuthenticated &&
                currentPath != Routes.login &&
                currentPath != Routes.splash &&
                !_isPublicRoute(currentPath)) {
              return Routes.login;
            }

            // If on loading route and authenticated, go to home
            if (currentPath == Routes.splash && isAuthenticated) {
              return Routes.home;
            }

            // If on loading route and not authenticated, go to login
            if (currentPath == Routes.splash && !isAuthenticated) {
              return Routes.login;
            }

            // No redirect needed
            return null;
          },
        );
      },
      refreshListenable: _AuthNotifier(ref),
      routes: [
        // Shell route with bottom navigation bar
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          observers: [TalkerRouteObserver(AppLogger.instance)],
          builder: (context, state, child) {
            return Scaffold(
              body: child,
              bottomNavigationBar: STPBottomNavBar(
                currentLocation: state.uri.path,
              ),
              floatingActionButton: STPBottomNavBar.buildFAB(context),
              floatingActionButtonLocation:
                  const FixedCenterDockedFabLocation(),
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
        // Loading route (outside shell route, no bottom nav)
        // This route is not visible to user because native splash is preserved
        // Once auth state resolves, redirect will navigate away
        GoRoute(
          path: Routes.splash,
          name: Routes.splashName,
          builder: (context, state) {
            // Empty widget - not visible because splash is still shown
            return const SizedBox.shrink();
          },
        ),
        // Login route (outside shell route, no bottom nav)
        GoRoute(
          path: Routes.login,
          name: Routes.loginName,
          builder: (context, state) => const LoginScreen(),
        ),
        // Lab Request routes (outside shell route, no bottom nav)
        GoRoute(
          path: Routes.labRequestList,
          name: Routes.labRequestListName,
          builder: (context, state) => const LabRequestListScreen(),
        ),
        GoRoute(
          path: Routes.labRequestForm,
          name: Routes.labRequestFormName,
          builder: (context, state) => const LabRequestFormScreen(),
        ),
        // Harvest Calculator routes (outside shell route, no bottom nav)
        GoRoute(
          path: Routes.harvestCalculatorHome,
          name: Routes.harvestCalculatorHomeName,
          builder: (context, state) => const SimulationListScreen(),
        ),
        GoRoute(
          path: Routes.harvestCalculatorCreate,
          name: Routes.harvestCalculatorCreateName,
          builder: (context, state) => const CreateSimulationScreen(
            simulationType: HarvestCalculatorConstants.simulationTypeCycle,
          ),
        ),
        GoRoute(
          path: Routes.harvestCalculatorCreateAgent,
          name: Routes.harvestCalculatorCreateAgentName,
          builder: (context, state) => const CreateSimulationScreen(
            simulationType: HarvestCalculatorConstants.simulationTypeAgent,
          ),
        ),
        GoRoute(
          path: Routes.harvestCalculatorResults,
          name: Routes.harvestCalculatorResultsName,
          builder: (context, state) {
            final args = state.extra;
            return SimulationResultsScreen(
              args: args is SimulationResultsScreenArgs ? args : null,
            );
          },
        ),
        GoRoute(
          path: Routes.harvestCalculatorSaved,
          name: Routes.harvestCalculatorSavedName,
          builder: (context, state) => const SimulationListScreen(),
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

    // Store router instance for logout navigation
    _currentRouter = router;
    return router;
  }

  /// Check if a route is public (doesn't require authentication).
  static bool _isPublicRoute(String path) {
    return path == Routes.login ||
        path == Routes.splash ||
        path == Routes.labRequestList ||
        path == Routes.labRequestForm;
  }
}

/// Notifier for auth state changes to trigger router refresh.
class _AuthNotifier extends ChangeNotifier {
  _AuthNotifier(this._ref) {
    // Listen to auth state changes
    _ref.listen(authStateProvider, (previous, next) {
      // Trigger router refresh when auth state changes
      // This ensures redirect logic is re-evaluated
      notifyListeners();

      // Log auth state change for debugging
      next.whenOrNull(
        data: (isAuthenticated) {
          final prevValue = previous?.value ?? 'null';
          AppLogger.info('Auth state changed: $prevValue -> $isAuthenticated');
        },
        error: (error, _) {
          AppLogger.warning('Auth state error: $error');
        },
      );
    });
  }

  final WidgetRef _ref;
}
