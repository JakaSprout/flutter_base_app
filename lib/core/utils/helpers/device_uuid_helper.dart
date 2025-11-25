import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

/// Helper class for persistent device UUID management.
///
/// Generates and stores a unique device UUID that persists across app restarts.
/// This UUID is used for multi-device sync and conflict resolution.
class DeviceUuidHelper {
  const DeviceUuidHelper._();

  static const String _keyDeviceUuid = 'device_uuid';
  static const Uuid _uuid = Uuid();

  /// Get or generate device UUID (persistent across app restarts).
  ///
  /// The UUID is stored in SharedPreferences and will be reused
  /// on subsequent calls. This ensures consistent device identification
  /// for sync operations.
  ///
  /// Returns the device UUID string.
  static Future<String> getOrGenerateUuid() async {
    final prefs = await SharedPreferences.getInstance();
    final storedUuid = prefs.getString(_keyDeviceUuid);

    if (storedUuid != null) {
      return storedUuid;
    }

    // Generate new UUID and store it
    final newUuid = _uuid.v4();
    await prefs.setString(_keyDeviceUuid, newUuid);
    return newUuid;
  }

  /// Clear device UUID (for testing/logout).
  ///
  /// Use this to reset the device UUID. Typically called during:
  /// - Testing (to simulate new device)
  /// - Logout (optional, if device should be de-registered)
  static Future<void> clearUuid() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyDeviceUuid);
  }

  /// Check if device UUID exists.
  ///
  /// Returns `true` if a device UUID has been generated and stored.
  static Future<bool> hasUuid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_keyDeviceUuid);
  }
}
