import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Helper class for retrieving device information.
///
/// Collects device metadata for sync logging and device registration.
class DeviceInfoHelper {
  const DeviceInfoHelper._();

  /// Get comprehensive device information.
  ///
  /// Returns a map containing:
  /// - `deviceName`: User-friendly device name
  /// - `deviceType`: Mobile, Tablet, or Desktop
  /// - `osType`: Android, iOS, Windows, MacOS, or Linux
  /// - `osVersion`: Operating system version
  /// - `appVersion`: Application version from pubspec.yaml
  /// - `deviceModel`: Device model name
  /// - `deviceManufacturer`: Device manufacturer
  static Future<Map<String, String>> getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      return {
        'deviceName': androidInfo.model,
        'deviceType': 'Mobile',
        'osType': 'Android',
        'osVersion': androidInfo.version.release,
        'appVersion': packageInfo.version,
        'deviceModel': androidInfo.model,
        'deviceManufacturer': androidInfo.manufacturer,
      };
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      return {
        'deviceName': iosInfo.name,
        'deviceType': iosInfo.model.contains('iPad') ? 'Tablet' : 'Mobile',
        'osType': 'iOS',
        'osVersion': iosInfo.systemVersion,
        'appVersion': packageInfo.version,
        'deviceModel': iosInfo.model,
        'deviceManufacturer': 'Apple',
      };
    }

    // Fallback for other platforms
    return {
      'deviceName': 'Unknown Device',
      'deviceType': 'Mobile',
      'osType': Platform.operatingSystem,
      'osVersion': '',
      'appVersion': packageInfo.version,
      'deviceModel': '',
      'deviceManufacturer': '',
    };
  }

  /// Get a short device description for display.
  ///
  /// Example: "iPhone 15 Pro (iOS 17.0)"
  static Future<String> getDeviceDescription() async {
    final info = await getDeviceInfo();
    return '${info['deviceModel']} (${info['osType']} ${info['osVersion']})';
  }

  /// Get device type only.
  ///
  /// Returns: Mobile, Tablet, or Desktop
  static Future<String> getDeviceType() async {
    final info = await getDeviceInfo();
    return info['deviceType'] ?? 'Mobile';
  }
}
