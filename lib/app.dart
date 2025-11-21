import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/app_config.dart';
import 'package:flutter_base_app/core/events/auth_event_bus.dart';
import 'package:flutter_base_app/core/utils/status_bar_config.dart';
import 'package:flutter_base_app/design_system/theme/app_theme.dart';
import 'package:flutter_base_app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:flutter_base_app/features/auth/presentation/providers/logout_provider.dart';
import 'package:flutter_base_app/features/auth/presentation/providers/session_timeout_provider.dart';
import 'package:flutter_base_app/features/auth/presentation/providers/token_refresh_provider.dart';
import 'package:flutter_base_app/router/app_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Root widget of the application.
class App extends HookConsumerWidget {
  /// Creates a new instance of [App].
  const App({required this.config, super.key});

  /// Application configuration
  final AppConfig config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch auth state
    final authStateAsync = ref.watch(authStateProvider);

    // Listen to auth state changes to remove splash screen
    // Remove splash when auth state resolves (data or error)
    ref.listen(authStateProvider, (previous, next) {
      next.whenOrNull(
        data: (_) => FlutterNativeSplash.remove(),
        error: (_, __) => FlutterNativeSplash.remove(),
      );
    });

    // Create router with auth guard (memoized to avoid recreating on rebuilds)
    final routerRef = useRef<GoRouter?>(null);
    routerRef.value ??= AppRouter.createRouter(ref, authStateAsync);
    final router = routerRef.value!;

    return ScreenUtilInit(
      // Design size from Figma (adjust according to design system)
      // Default: iPhone 14 Pro (390 x 844)
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: config.appName,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.lightTheme, // Always use light theme
          themeMode: ThemeMode.light, // Always use light mode
          routerConfig: router,
          builder: (context, widget) {
            // Wrap widget with auth event listener and status bar updater
            final wrappedWidget = _AuthEventListener(
              child: _StatusBarUpdater(
                child: widget ?? const SizedBox.shrink(),
              ),
            );

            // Show flavor banner in debug mode
            if (kDebugMode) {
              return Banner(
                location: BannerLocation.topStart,
                message: config.flavor.name.toUpperCase(),
                color: Colors.green.withAlpha(150),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  letterSpacing: 1,
                ),
                textDirection: TextDirection.ltr,
                child: wrappedWidget,
              );
            }
            return wrappedWidget;
          },
        );
      },
    );
  }
}

/// Widget that updates status bar when theme changes.
///
/// This widget listens to theme changes and automatically updates
/// the status bar configuration based on the current theme brightness.
class _StatusBarUpdater extends StatefulWidget {
  /// Creates a new instance of [_StatusBarUpdater].
  const _StatusBarUpdater({required this.child});

  /// Child widget to wrap.
  final Widget child;

  @override
  State<_StatusBarUpdater> createState() => _StatusBarUpdaterState();
}

class _StatusBarUpdaterState extends State<_StatusBarUpdater> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update status bar whenever theme changes
    _updateStatusBar();
  }

  void _updateStatusBar() {
    // Always use light status bar regardless of theme mode
    StatusBarConfig.setLightStatusBar();
  }

  @override
  Widget build(BuildContext context) {
    // Update status bar on build as well (for initial setup)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateStatusBar();
    });

    return widget.child;
  }
}

/// Widget that listens to auth events and handles auto-logout.
class _AuthEventListener extends HookConsumerWidget {
  /// Creates a new instance of [_AuthEventListener].
  const _AuthEventListener({required this.child});

  /// Child widget to wrap.
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch auth state to initialize monitors
    final authStateAsync = ref.watch(authStateProvider);

    // Initialize auth monitoring when authenticated
    useEffect(() {
      authStateAsync.whenData((isAuthenticated) {
        if (isAuthenticated) {
          // User logged in, start monitors
          ref
            ..read(tokenRefreshMonitorProvider)
            ..read(sessionTimeoutMonitorProvider);
        }
      });
      return null;
    }, [authStateAsync]);

    // Listen to auth state changes to start/stop monitors
    ref.listen(authStateProvider, (previous, next) {
      next.whenData((isAuthenticated) {
        if (isAuthenticated) {
          // User logged in, start monitors
          ref
            ..read(tokenRefreshMonitorProvider)
            ..read(sessionTimeoutMonitorProvider);
        }
        // If logged out, monitors will stop automatically via onDispose
      });
    });

    // Listen to auth events for auto-logout
    useEffect(() {
      StreamSubscription<AuthEvent>? eventSubscription;

      eventSubscription = AuthEventBus.instance.events.listen((event) {
        if (event.type == AuthEventType.loggedOut ||
            event.type == AuthEventType.sessionExpired) {
          // Use context from the widget, but check mounted in handler
          _handleAutoLogout(context, ref, event);
        }
      });

      return () {
        eventSubscription?.cancel();
      };
    }, []);

    return child;
  }

  Future<void> _handleAutoLogout(
    BuildContext context,
    WidgetRef ref,
    AuthEvent event,
  ) async {
    if (!context.mounted) return;

    try {
      // Logout provider will clear tokens and invalidate auth state
      // Router redirect logic will automatically navigate to login
      await ref.read(logoutProvider.future);
    } catch (e) {
      // Logout should always succeed, but log error just in case
      debugPrint('Auto-logout error: $e');
    }
  }
}
