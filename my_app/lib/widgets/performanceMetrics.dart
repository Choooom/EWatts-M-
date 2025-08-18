import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';

class PerformanceMetrics extends StatelessWidget {
  const PerformanceMetrics({super.key});

  final List<double> yLabels = const [
    400,
  ]; // Add more if needed (e.g. [0, 100, 200, 300, 400])

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final brightness = ref.watch(themeModeProvider);

        return Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (var i = 0; i < yLabels.length; i++)
                  Text(
                    yLabels[i].toStringAsFixed(0),
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.greyText(brightness),
                    ),
                  ),
                SizedBox(height: 20),
                RotatedBox(
                  quarterTurns: -1,
                  child: Text(
                    'Energy (kWh)',
                    style: TextStyle(
                      color: AppColors.greyText(brightness),
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),

            // Chart
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          const days = [
                            'Su',
                            'Mo',
                            'Tu',
                            'We',
                            'Th',
                            'Fr',
                            'Sa',
                          ];
                          return Text(days[value.toInt()]);
                        },
                      ),
                    ),
                    // Disable y-axis value titles inside the chart
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 400,
                  lineBarsData: [
                    _lineBarData([
                      300,
                      250,
                      200,
                      350,
                      400,
                      300,
                      250,
                    ], AppColors.greenUpperLeft),
                    _lineBarData([
                      200,
                      180,
                      160,
                      220,
                      240,
                      210,
                      190,
                    ], AppColors.yellowBottomLeft),
                    _lineBarData([
                      350,
                      340,
                      330,
                      360,
                      370,
                      390,
                      370,
                    ], AppColors.greyBgColor),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 8),

            // Right label column
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < yLabels.length; i++)
                  Text(
                    yLabels[i].toStringAsFixed(0),
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.greyText(brightness),
                    ),
                  ),
                SizedBox(height: 20),
                RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    'Efficiency (%)',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.greyText(brightness),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  LineChartBarData _lineBarData(List<double> spots, Color color) {
    return LineChartBarData(
      spots: List.generate(
        spots.length,
        (index) => FlSpot(index.toDouble(), spots[index]),
      ),
      isCurved: true,
      color: color,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    );
  }
}
