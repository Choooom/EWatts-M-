class PanelGenerationOverview {
  int hour;
  double energyGeneration;

  PanelGenerationOverview({required this.hour, required this.energyGeneration});

  String getHour() {
    return '${hour % 12 == 0 ? 12 : hour % 12} ${hour < 12 ? 'AM' : 'PM'}';
  }
}
