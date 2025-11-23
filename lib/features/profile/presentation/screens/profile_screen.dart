import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/core/config/navigation_constants.dart';
import 'package:app_mobile_afms/features/auth/presentation/providers/logout_provider.dart';
import 'package:app_mobile_afms/features/profile/presentation/constants/profile_design_constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Profile (Profil) screen.
///
/// This is a placeholder screen that will be implemented based on Figma design.
class ProfileScreen extends ConsumerWidget {
  /// Creates a new instance of [ProfileScreen].
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              NavigationConstants.screenProfileTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              NavigationConstants.placeholderProfile,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),
            // Logout button (temporary)
            _LogoutButton(ref: ref),
          ],
        ),
      ),
    );
  }
}

/// Logout button widget.
///
/// This is a temporary button for logout functionality.
/// Will be replaced with proper design later.
class _LogoutButton extends ConsumerStatefulWidget {
  /// Creates a new instance of [_LogoutButton].
  const _LogoutButton({required this.ref});

  final WidgetRef ref;

  @override
  ConsumerState<_LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends ConsumerState<_LogoutButton> {
  bool _isLoading = false;

  Future<void> _handleLogout() async {
    if (_isLoading) return;

    if (!mounted) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Logout provider will clear tokens and invalidate auth state
      // Router redirect logic will automatically navigate to login
      await ref.read(logoutProvider.future);
      // Navigation is handled automatically by router redirect
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logout failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _isLoading ? null : _handleLogout,
      icon: _isLoading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: ProfileDesignConstants.white,
              ),
            )
          : const Icon(Icons.logout, size: 20),
      label: Text(
        _isLoading ? 'Logging out...' : 'Logout',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: ProfileDesignConstants.white,
          fontFamily: AppConstants.fontFamily,
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        backgroundColor: Colors.red,
        foregroundColor: ProfileDesignConstants.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
    );
  }
}
