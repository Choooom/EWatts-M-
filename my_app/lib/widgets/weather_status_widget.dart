import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/models/weather_status.dart';
import 'package:intl/intl.dart';
import 'package:my_app/util/weatherAnimation.dart';

class WeatherStatusWidget extends StatefulWidget {
  const WeatherStatusWidget({super.key});

  @override
  State<WeatherStatusWidget> createState() => _WeatherStatusWidgetState();
}

class _WeatherStatusWidgetState extends State<WeatherStatusWidget> {
  late Future<LottieComposition> _composition;

  String getCurrentDate() {
    DateTime now = DateTime.now();
    String formatted = DateFormat('d MMM, yyyy').format(now);

    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    WeatherStatus weather = WeatherStatus(
      status: "partly sunny",
      degrees: 32,
      degreeUnit: "Celsius",
      date: getCurrentDate(),
    );

    String capitalizeEachWord(String input) {
      return input
          .split(' ')
          .map((word) {
            if (word.isEmpty) return word;
            return word[0].toUpperCase() + word.substring(1).toLowerCase();
          })
          .join(' ');
    }

    return Material(
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
            color: AppColors.whiteWidgetBg,
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
                    padding: EdgeInsetsGeometry.only(left: 20),
                    child: Text(
                      "${capitalizeEachWord(weather.status)}, ${weather.degrees}°${weather.degreeUnit == 'Celsius' ? 'C' : 'F'}",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.only(left: 20),
                    child: Text(
                      "${weather.date}",
                      style: TextStyle(color: AppColors.greyText),
                    ),
                  ),
                ],
              ),
              const Spacer(),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.easeInBack,
                switchOutCurve: Curves.linear,
                child: Padding(
                  key: ValueKey(weather.status),
                  padding: const EdgeInsets.only(right: 20),
                  child: WeatherAnimation(weatherCondition: weather.status),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
