import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PowerBarChart extends StatelessWidget {
  final Map<int, double> powerData; // e.g. {6: 120, 7: 150, 8: 100, ...}
  final int currentHour;

  const PowerBarChart({
    super.key,
    required this.powerData,
    required this.currentHour,
  });

  @override
  Widget build(BuildContext context) {
    final maxPower = powerData.values.fold<double>(
      0,
      (prev, el) => el > prev ? el : prev,
    );

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxPower + (maxPower * 0.1), // slight padding
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 40),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) => Text('${value.toInt()}AM'),
            ),
          ),
        ),
        gridData: FlGridData(show: false),
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(
              y: powerData[currentHour] ?? 0,
              color: Colors.amber,
              dashArray: [5, 5],
              strokeWidth: 2,
            ),
          ],
        ),
        barGroups: powerData.entries.map((entry) {
          final isCurrent = entry.key == currentHour;
          final isFuture = entry.key > currentHour;

          return BarChartGroupData(
            x: entry.key,
            barRods: [
              BarChartRodData(
                toY: isFuture ? 0 : entry.value,
                color: isCurrent
                    ? Colors.lightGreen
                    : (isFuture ? Colors.grey[300] : Colors.green),
                width: 18,
                borderRadius: BorderRadius.circular(6),
                rodStackItems: [],
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
