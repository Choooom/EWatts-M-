import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/models/weather_status.dart';
import 'package:intl/intl.dart';

class WeatherStatusWidget extends StatefulWidget {
  const WeatherStatusWidget({super.key});

  @override
  State<WeatherStatusWidget> createState() => _WeatherStatusWidgetState();
}

class _WeatherStatusWidgetState extends State<WeatherStatusWidget> {
  String getCurrentDate() {
    DateTime now = DateTime.now();
    String formatted = DateFormat('d MMM, yyyy').format(now);

    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    WeatherStatus weather = WeatherStatus(
      status: "Sunny",
      degrees: 32,
      degreeUnit: "Celsius",
      date: getCurrentDate(),
    );

    return Material(
      elevation: 0,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.only(
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
                      "${weather.status}, ${weather.degrees}°${weather.degreeUnit == 'Celsius' ? 'C' : 'F'}",
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

              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Lottie.asset(
                  'assets/animations/weather_sunny.json',
                  width: 80,
                  height: 80,
                  repeat: true,
                  animate: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
