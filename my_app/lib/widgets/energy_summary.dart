import 'package:flutter/material.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/widgets/energy_circle.dart';

class EnergySummary extends StatefulWidget {
  const EnergySummary({super.key});

  @override
  State<EnergySummary> createState() => _EnergySummaryState();
}

class _EnergySummaryState extends State<EnergySummary> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      child: Container(
        height:
            300, // Consider making this dynamic, e.g., height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: AppColors.whiteWidgetBg,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final height = constraints.maxHeight;
              final circleSize = width * 0.21; // Keep circle size relative

              return Stack(
                children: [
                  // House Image
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      'assets/images/house.png',
                      width: width * 0.8,
                      // Maintain aspect ratio
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Export Circle
                  Align(
                    alignment: Alignment(
                      -0.85,
                      -0.85,
                    ), // Adjust based on testing
                    child: energyCircle(
                      "Export",
                      "1.5 kw",
                      AppColors.redOfflineStatus,
                      circleSize,
                    ),
                  ),

                  // Home Circle
                  Align(
                    alignment: Alignment(-0.1, -0.7), // Adjust based on testing
                    child: energyCircle(
                      "Home",
                      "64 kw",
                      AppColors.redOfflineStatus,
                      circleSize,
                    ),
                  ),

                  // Produce Circle
                  Align(
                    alignment: Alignment(0.7, -0.85), // Adjust based on testing
                    child: energyCircle(
                      "Produce",
                      "3.65 kw",
                      AppColors.greenCircle,
                      circleSize,
                    ),
                  ),

                  // Stored Circle
                  Align(
                    alignment: Alignment(-0.5, 0.9), // Adjust based on testing
                    child: energyCircle(
                      "Stored",
                      "129 kw",
                      AppColors.greenCircle,
                      circleSize,
                    ),
                  ),

                  // Dotted Lines (adjusted for responsiveness)
                  Positioned(
                    top: height * 0.33,
                    left: width * 0.15,
                    child: dottedLine(
                      length: height * 0.13,
                      color: AppColors.redDottedLines,
                    ),
                  ),
                  Positioned(
                    top: height * 0.41,
                    left: width * 0.29,
                    child: dottedLine(
                      length: height * 0.26,
                      color: AppColors.greenDottedLines,
                      direction: Axis.vertical,
                    ),
                  ),
                  Positioned(
                    top: height * 0.4,
                    left: width * 0.3,
                    child: dottedLine(
                      length: width * 0.29,
                      color: AppColors.greenDottedLines,
                      direction: Axis.horizontal,
                    ),
                  ),
                  Positioned(
                    top: height * 0.385,
                    left: width * 0.45,
                    child: dottedLine(
                      length: height * 0.13,
                      color: AppColors.redDottedLines,
                    ),
                  ),
                  Positioned(
                    top: height * 0.52,
                    left: width * 0.46,
                    child: dottedLine(
                      length: width * 0.08,
                      color: AppColors.redDottedLines,
                      direction: Axis.horizontal,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// [energyCircle and dottedLine widgets remain unchanged]
