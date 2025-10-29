// lib/widgets/weather_forecast_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/models/weather_forecasting/weather_forecast_models.dart';
import 'package:my_app/providers/weather_forecasting/weather_forecast_providers.dart';
import 'package:my_app/services/weather_forecasting/weather_service.dart';

import 'package:my_app/state_management/theme_mode_listener.dart';
import 'package:my_app/util/weatherAnimation.dart';

class WeatherForecastSheet extends ConsumerStatefulWidget {
  const WeatherForecastSheet({super.key});

  @override
  ConsumerState<WeatherForecastSheet> createState() =>
      _WeatherForecastSheetState();
}

class _WeatherForecastSheetState extends ConsumerState<WeatherForecastSheet> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    final brightness = ref.watch(themeModeProvider);
    final dailySummaries = ref.watch(dailyWeatherSummariesProvider);
    final forecastAsync = ref.watch(weatherForecastProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: AppColors.whiteWidgetBg(brightness),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            margin: EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.greyText(brightness).withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '7-Day Weather Forecast',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Weather & Solar Predictions',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.greyText(brightness),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, size: 28),
                ),
              ],
            ),
          ),

          Divider(height: 1),

          // Content
          Expanded(
            child: forecastAsync.when(
              data: (weatherResponse) {
                if (weatherResponse == null || dailySummaries.isEmpty) {
                  return _buildEmptyState(brightness);
                }

                return ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    // Info card
                    Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.blue.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.blue,
                            size: 20,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Tap any day to see hourly forecast details',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.blue[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Daily forecast cards
                    ...dailySummaries.asMap().entries.map((entry) {
                      final index = entry.key;
                      final summary = entry.value;
                      return _buildDayCard(summary, brightness, index);
                    }),

                    SizedBox(height: 20),

                    // Footer info
                    Center(
                      child: Text(
                        'Model: ${weatherResponse.modelUsed}',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.greyText(brightness),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Center(
                      child: Text(
                        'Updated: ${_formatGeneratedTime(weatherResponse.generatedAt)}',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.greyText(brightness),
                        ),
                      ),
                    ),
                  ],
                );
              },
              loading: () => _buildLoadingState(brightness),
              error: (error, stack) => _buildErrorState(error, brightness),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(Brightness brightness) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_off,
            size: 64,
            color: AppColors.greyText(brightness),
          ),
          SizedBox(height: 16),
          Text(
            'No weather data available',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.greyText(brightness),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Please check your connection',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.greyText(brightness).withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(Brightness brightness) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            'Loading weather forecast...',
            style: TextStyle(color: AppColors.greyText(brightness)),
          ),
          SizedBox(height: 8),
          Text(
            'This may take a few moments',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.greyText(brightness).withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(Object error, Brightness brightness) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text(
              'Failed to load weather data',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.greyText(brightness),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ref.invalidate(weatherForecastProvider);
              },
              icon: Icon(Icons.refresh),
              label: Text('Retry'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayCard(
    DailyWeatherSummary summary,
    Brightness brightness,
    int index,
  ) {
    final isSelected =
        selectedDate != null &&
        selectedDate!.year == summary.date.year &&
        selectedDate!.month == summary.date.month &&
        selectedDate!.day == summary.date.day;

    final now = DateTime.now();
    final isToday =
        now.day == summary.date.day &&
        now.month == summary.date.month &&
        now.year == summary.date.year;

    final isTomorrow =
        summary.date
            .difference(DateTime(now.year, now.month, now.day))
            .inDays ==
        1;

    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isSelected
            ? BorderSide(color: Colors.blue, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedDate = isSelected ? null : summary.date;
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Day header
              Row(
                children: [
                  // Date
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              isToday
                                  ? 'Today'
                                  : isTomorrow
                                  ? 'Tomorrow'
                                  : DateFormat('EEEE').format(summary.date),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (index == 0 && isToday)
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Current',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Text(
                          DateFormat('MMM d, yyyy').format(summary.date),
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.greyText(brightness),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Weather animation
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: WeatherAnimation(
                      weatherCondition: summary.weatherStatus,
                    ),
                  ),

                  SizedBox(width: 16),

                  // Temperature
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${summary.maxTemperature.toStringAsFixed(0)}°',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${summary.minTemperature.toStringAsFixed(0)}°',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.greyText(brightness),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Weather details
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDetailItem(
                    Icons.water_drop,
                    '${summary.precipitationProbability.toStringAsFixed(0)}%',
                    'Rain',
                    brightness,
                  ),
                  _buildDetailItem(
                    Icons.solar_power,
                    WeatherService.formatEfficiency(summary.avgSolarEfficiency),
                    'Efficiency',
                    brightness,
                  ),
                  _buildDetailItem(
                    Icons.bolt,
                    WeatherService.formatPowerOutput(
                      summary.totalEstimatedOutput,
                    ),
                    'Output',
                    brightness,
                  ),
                ],
              ),

              // Confidence indicator
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.verified,
                    size: 14,
                    color: _getConfidenceColor(summary.confidenceScore),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Confidence: ${(summary.confidenceScore * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.greyText(brightness),
                    ),
                  ),
                ],
              ),

              // Expanded hourly details
              if (isSelected) ...[
                SizedBox(height: 16),
                Divider(),
                SizedBox(height: 12),
                _buildHourlyDetails(summary.date, brightness),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(
    IconData icon,
    String value,
    String label,
    Brightness brightness,
  ) {
    return Column(
      children: [
        Icon(icon, size: 22, color: AppColors.greyText(brightness)),
        SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: AppColors.greyText(brightness)),
        ),
      ],
    );
  }

  Widget _buildHourlyDetails(DateTime date, Brightness brightness) {
    final hourlyPredictions = ref.watch(hourlyPredictionsForDateProvider(date));

    if (hourlyPredictions.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'No hourly data available for this day',
          style: TextStyle(color: AppColors.greyText(brightness), fontSize: 13),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.access_time,
              size: 16,
              color: AppColors.greyText(brightness),
            ),
            SizedBox(width: 8),
            Text(
              'Hourly Forecast',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hourlyPredictions.length,
            itemBuilder: (context, index) {
              final prediction = hourlyPredictions[index];
              final time = DateTime.parse(prediction.forecastDate);

              return Container(
                width: 90,
                margin: EdgeInsets.only(right: 12),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: brightness == Brightness.dark
                      ? Colors.grey[800]
                      : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: brightness == Brightness.dark
                        ? Colors.grey[700]!
                        : Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      DateFormat('HH:mm').format(time),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: WeatherAnimation(
                        weatherCondition: _getHourlyWeatherStatus(prediction),
                      ),
                    ),
                    Text(
                      '${prediction.weatherCondition.temperature.toStringAsFixed(0)}°',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getEfficiencyColor(
                          prediction.solarConditions.estimatedEfficiencyFactor,
                        ).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        WeatherService.formatEfficiency(
                          prediction.solarConditions.estimatedEfficiencyFactor,
                        ),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: _getEfficiencyColor(
                            prediction
                                .solarConditions
                                .estimatedEfficiencyFactor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _getHourlyWeatherStatus(WeatherPrediction prediction) {
    final precip = prediction.weatherCondition.precipitationProbability;
    final cloud = prediction.weatherCondition.cloudDescription.toLowerCase();

    if (precip > 60 || cloud.contains('storm')) {
      return 'storm';
    } else if (precip > 30 || cloud.contains('rain')) {
      return 'rainy';
    } else if (cloud.contains('overcast') || cloud.contains('cloudy')) {
      return 'cloudy';
    } else if (cloud.contains('partly')) {
      return 'partly_cloudy';
    } else {
      return 'sunny';
    }
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 0.8) return Colors.green;
    if (confidence >= 0.6) return Colors.orange;
    return Colors.red;
  }

  Color _getEfficiencyColor(double efficiency) {
    if (efficiency >= 0.7) return Colors.green;
    if (efficiency >= 0.4) return Colors.orange;
    return Colors.red;
  }

  String _formatGeneratedTime(String isoTime) {
    try {
      final dateTime = DateTime.parse(isoTime);
      return DateFormat('MMM d, yyyy HH:mm').format(dateTime);
    } catch (e) {
      return isoTime;
    }
  }
}
