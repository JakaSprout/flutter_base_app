/// Interface for secure storage operations.
///
/// This abstraction allows for different implementations of secure storage,
/// making it easier to test and potentially swap implementations in the future.
abstract class SecureStorageInterface {
  /// Read a value from secure storage.
  ///
  /// Returns the value associated with [key], or `null` if not found.
  Future<String?> read({required String key});

  /// Write a value to secure storage.
  ///
  /// Stores [value] associated with [key].
  Future<void> write({required String key, required String value});

  /// Delete a value from secure storage.
  ///
  /// Removes the value associated with [key].
  Future<void> delete({required String key});

  /// Delete all values from secure storage.
  ///
  /// Removes all stored values.
  Future<void> deleteAll();

  /// Check if a key exists in secure storage.
  ///
  /// Returns `true` if [key] exists, `false` otherwise.
  Future<bool> containsKey({required String key});
}
