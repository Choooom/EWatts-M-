class Panels {
  String panelName;
  double efficiencyLevel;
  bool status;
  double energyLevel;

  Panels({
    required this.panelName,
    required this.efficiencyLevel,
    required this.energyLevel,
    this.status = false,
  });
}
