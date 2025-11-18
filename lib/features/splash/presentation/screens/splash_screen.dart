import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:flutter_base_app/router/routes.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Splash screen that checks authentication state and redirects accordingly.
///
/// Best Practice Implementation:
/// 1. Preserve native splash screen during initialization
/// 2. Check authentication state asynchronously
/// 3. Remove native splash only after auth check completes
/// 4. Navigate to appropriate screen based on auth state
///
/// This ensures:
/// - Smooth transition from native splash to app
/// - No flash of white screen
/// - Proper auth state handling before navigation
class SplashScreen extends HookConsumerWidget {
  /// Creates a new instance of [SplashScreen].
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch auth state
    final authStateAsync = ref.watch(authStateProvider);

    // Check auth and redirect when state is available
    useEffect(() {
      // Preserve native splash during auth check
      FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);

      Future<void> checkAuthAndRedirect() async {
        try {
          // Wait for auth state to resolve
          // If still loading, wait for it to complete
          final isAuthenticated = authStateAsync.hasValue
              ? authStateAsync.value ?? false
              : await ref.read(authStateProvider.future);

          if (!context.mounted) return;

          // Remove native splash before navigation
          // This ensures smooth transition
          FlutterNativeSplash.remove();

          // Small delay to ensure splash removal is complete
          await Future<void>.delayed(const Duration(milliseconds: 100));

          if (!context.mounted) return;

          // Navigate based on auth state
          if (isAuthenticated) {
            context.goNamed(Routes.homeName);
          } else {
            context.goNamed(Routes.loginName);
          }
        } catch (e) {
          // On error, remove splash and go to login
          if (context.mounted) {
            FlutterNativeSplash.remove();
            await Future<void>.delayed(const Duration(milliseconds: 100));
            if (context.mounted) {
              context.goNamed(Routes.loginName);
            }
          }
        }
      }

      // Wait for first frame, then check auth and redirect
      WidgetsBinding.instance.addPostFrameCallback((_) {
        checkAuthAndRedirect();
      });

      // Cleanup: ensure splash is removed if widget is disposed
      return FlutterNativeSplash.remove;
    }, [authStateAsync]);

    // This widget is only shown briefly while checking auth
    // The native splash screen (flutter_native_splash) is preserved
    // during this time. We show a white background to match the native splash
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.shrink(), // Empty body, just show white background
    );
  }
}
