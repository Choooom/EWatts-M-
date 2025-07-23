import 'package:flutter/material.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/util/energyBar.dart';

class BatteryChargeMeter extends StatelessWidget {
  final double batteryLevel;
  final double batteryCapacity;
  final double maxWidth;
  final double maxHeight;

  const BatteryChargeMeter({
    super.key,
    required this.batteryLevel,
    required this.batteryCapacity,
    required this.maxWidth,
    required this.maxHeight,
  });

  List<double> computeBarLevels() {
    double capPerBar = batteryCapacity / 10;

    return List.generate(10, (index) {
      double lowerBound = index * capPerBar;
      double upperBound = (index + 1) * capPerBar;

      if (batteryLevel >= upperBound) {
        return 1.0;
      } else if (batteryLevel <= lowerBound) {
        return 0.0;
      } else {
        return (batteryLevel - lowerBound) / capPerBar;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final barHeight = maxHeight * 0.7;
    final barWidth = maxWidth * 0.093;
    final barFillLevels = computeBarLevels();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(10, (index) {
        return EnergyBar(
          fillPercentage: barFillLevels[index],
          barWidth: barWidth,
          barHeight: barHeight,
          barColor: AppColors.batteryLevels[index],
        );
      }),
    );
  }
}
