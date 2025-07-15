class WeatherStatus {
  String status;
  double degrees;
  String degreeUnit;
  String date;

  WeatherStatus({
    required this.status,
    required this.degrees,
    required this.degreeUnit,
    required this.date,
  });

  String getWeatherStatus() {
    return status;
  }
}
