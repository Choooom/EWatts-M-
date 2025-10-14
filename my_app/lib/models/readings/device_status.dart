class DeviceStatus {
  final int deviceId;
  final String deviceName;
  final bool online;
  final DateTime? lastSeenAt;

  DeviceStatus({
    required this.deviceId,
    required this.deviceName,
    required this.online,
    this.lastSeenAt,
  });

  factory DeviceStatus.fromJson(Map<String, dynamic> json) {
    return DeviceStatus(
      deviceId: json['id'],
      deviceName: json['deviceName'],
      online: json['online'],
      lastSeenAt: json['lastSeenAt'] != null
          ? DateTime.parse(json['lastSeenAt'])
          : null,
    );
  }
}
