class PerformanceMetric {
  final DateTime timestamp;
  final double totalKwh;
  final double efficiency;

  PerformanceMetric({
    required this.timestamp,
    required this.totalKwh,
    required this.efficiency,
  });
}
