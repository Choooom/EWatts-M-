class RealtimeReading {
  final int deviceId;
  final String deviceName;
  final String deviceType;
  final int userId;
  final double voltage;
  final double current;
  final double power;
  final double energy;
  final bool ssrEnabled;
  final DateTime timestamp;

  RealtimeReading({
    required this.deviceId,
    required this.deviceName,
    required this.deviceType,
    required this.userId,
    required this.voltage,
    required this.current,
    required this.power,
    required this.energy,
    required this.ssrEnabled,
    required this.timestamp,
  });

  factory RealtimeReading.fromJson(Map<String, dynamic> json) {
    return RealtimeReading(
      deviceId: json['deviceId'],
      deviceName: json['deviceName'],
      deviceType: json['deviceType'],
      userId: json['userId'],
      voltage: json['voltage'].toDouble(),
      current: json['current'].toDouble(),
      power: json['power'].toDouble(),
      energy: json['energy'].toDouble(),
      ssrEnabled: json['ssrEnabled'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
