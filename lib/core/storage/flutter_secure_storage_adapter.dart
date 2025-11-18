import 'package:flutter_base_app/core/storage/secure_storage_interface.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Adapter for [FlutterSecureStorage] to implement [SecureStorageInterface].
///
/// This adapter allows [FlutterSecureStorage] to be used through the
/// [SecureStorageInterface] abstraction, enabling easier testing and
/// potential future implementation swaps.
class FlutterSecureStorageAdapter implements SecureStorageInterface {
  /// Creates a new instance of [FlutterSecureStorageAdapter].
  FlutterSecureStorageAdapter(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  @override
  Future<String?> read({required String key}) async {
    return _secureStorage.read(key: key);
  }

  @override
  Future<void> write({required String key, required String value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  @override
  Future<void> delete({required String key}) async {
    await _secureStorage.delete(key: key);
  }

  @override
  Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }

  @override
  Future<bool> containsKey({required String key}) async {
    final value = await _secureStorage.read(key: key);
    return value != null && value.isNotEmpty;
  }
}
