import 'package:app_mobile_afms/core/reference_data/domain/reference_data_type.dart';

class _CacheBucket {
  _CacheBucket(this.data, this.timestamp);

  final List<dynamic> data;
  final DateTime timestamp;
}

/// Simple in-memory cache scoped by user and reference data type.
class ReferenceDataCache {
  ReferenceDataCache({this.defaultTtl = const Duration(minutes: 5)});

  final Duration defaultTtl;
  final Map<String, _CacheBucket> _store = {};

  String _key(String userId, ReferenceDataType type) => '$userId-${type.key}';

  /// Returns cached data if still valid; otherwise null.
  List<T>? get<T>({required String userId, required ReferenceDataType type}) {
    final entry = _store[_key(userId, type)];
    if (entry == null) return null;
    final age = DateTime.now().difference(entry.timestamp);
    if (age > defaultTtl) {
      _store.remove(_key(userId, type));
      return null;
    }
    return entry.data.cast<T>();
  }

  /// Saves data in cache.
  void set<T>({
    required String userId,
    required ReferenceDataType type,
    required List<T> data,
  }) {
    _store[_key(userId, type)] = _CacheBucket(
      List<T>.from(data),
      DateTime.now(),
    );
  }

  /// Clears cache for given user & type.
  void invalidate({required String userId, required ReferenceDataType type}) {
    _store.remove(_key(userId, type));
  }

  /// Clears cache for a user (all types).
  void clearForUser(String userId) {
    _store.removeWhere((key, _) => key.startsWith('$userId-'));
  }

  /// Clears entire cache.
  void clearAll() => _store.clear();
}
