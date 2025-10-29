// lib/widgets/weather_status_widget_updated.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/providers/weather_forecasting/weather_forecast_providers.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';
import 'package:my_app/util/weatherAnimation.dart';
import 'package:my_app/widgets/weather_forecast_sheet.dart';

class WeatherStatusWidgetUpdated extends ConsumerWidget {
  const WeatherStatusWidgetUpdated({super.key});

  String getCurrentDate() {
    DateTime now = DateTime.now();
    String formatted = DateFormat('d MMM, yyyy').format(now);
    return formatted;
  }

  String _capitalizeEachWord(String input) {
    return input
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final brightness = ref.watch(themeModeProvider);
    final todayWeather = ref.watch(todayWeatherSummaryProvider);

    // Default values if no weather data
    String weatherStatus = 'sunny';
    double temperature = 32.0;
    String date = getCurrentDate();

    // Use actual weather data if available
    if (todayWeather != null) {
      weatherStatus = todayWeather.weatherStatus;
      temperature = todayWeather.avgTemperature;
    }

    return GestureDetector(
      onTap: () {
        // Show forecast bottom sheet
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => WeatherForecastSheet(),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 1),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Material(
          elevation: 0,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Container(
              width: screenWidth * 0.9,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.whiteWidgetBg(brightness),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Text(
                              "${_capitalizeEachWord(weatherStatus)}, ${temperature.toStringAsFixed(0)}°C",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(width: 8),
                            // Tap indicator
                            Icon(
                              Icons.keyboard_arrow_up,
                              size: 20,
                              color: AppColors.greyText(brightness),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          date,
                          style: TextStyle(
                            color: AppColors.greyText(brightness),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),

                  // Weather animation
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    switchInCurve: Curves.easeInBack,
                    switchOutCurve: Curves.linear,
                    child: Padding(
                      key: ValueKey(weatherStatus),
                      padding: const EdgeInsets.only(right: 20),
                      child: WeatherAnimation(weatherCondition: weatherStatus),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
