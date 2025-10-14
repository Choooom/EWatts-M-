class SSRStatus {
  final int deviceId;
  final String deviceName;
  final bool ssrEnabled;
  final DateTime timestamp;

  SSRStatus({
    required this.deviceId,
    required this.deviceName,
    required this.ssrEnabled,
    required this.timestamp,
  });

  factory SSRStatus.fromJson(Map<String, dynamic> json) {
    return SSRStatus(
      deviceId: json['id'],
      deviceName: json['deviceName'],
      ssrEnabled: json['ssrEnabled'],
      timestamp: DateTime.parse(json['updatedAt']),
    );
  }
}
