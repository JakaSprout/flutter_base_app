/// Connectivity status models.
enum ConnectivityStatus {
  /// Device is connected to internet
  connected,

  /// Device is disconnected from internet
  disconnected,

  /// Connectivity status is unknown
  unknown,
}

/// App connectivity result model.
class AppConnectivityResult {
  /// Creates a new instance of [AppConnectivityResult].
  const AppConnectivityResult({required this.status, this.type, this.message});

  /// Connectivity status
  final ConnectivityStatus status;

  /// Connection type (wifi, mobile, etc.)
  final String? type;

  /// Optional message
  final String? message;

  /// Check if connected.
  bool get isConnected => status == ConnectivityStatus.connected;

  /// Check if disconnected.
  bool get isDisconnected => status == ConnectivityStatus.disconnected;

  @override
  String toString() => 'AppConnectivityResult(status: $status, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppConnectivityResult &&
        other.status == status &&
        other.type == type &&
        other.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ type.hashCode ^ message.hashCode;
}
