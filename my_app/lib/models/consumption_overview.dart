class ConsumptionOverview {
  final double directSolar;
  final double battery;
  final double grid;

  ConsumptionOverview({
    required this.directSolar,
    required this.battery,
    required this.grid,
  });

  double get total => directSolar + battery + grid;
}
