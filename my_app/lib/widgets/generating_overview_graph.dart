import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/models/panel_generation_overview.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';

class PanelGenerationGraph extends StatelessWidget {
  final List<PanelGenerationOverview> data;

  const PanelGenerationGraph({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;

    final DateTime timePh = DateTime.now().toUtc().add(
      const Duration(hours: 8),
    );
    final int now = timePh.hour;
    final List<int> hours = List.generate(7, (i) => (now - 5 + i) % 24);

    final random = Random();

    final List<PanelGenerationOverview> data = hours.map((hour) {
      final overview = PanelGenerationOverview(
        hour: hour,
        energyGeneration: double.parse(
          (random.nextDouble() * 5).toStringAsFixed(2),
        ),
      );
      overview.hour = hour;
      overview.energyGeneration = double.parse(
        (random.nextDouble() * 5).toStringAsFixed(2),
      ); // 0.00 - 5.00
      return overview;
    }).toList();

    // Map hour -> model
    final Map<int, PanelGenerationOverview> hourToModel = {
      for (var e in data) e.hour: e,
    };

    // Get only the first 6 actual data points
    final energyValues = [
      for (var hour in hours.take(6)) hourToModel[hour]?.energyGeneration ?? 0,
    ];

    final double maxEnergy = energyValues.isNotEmpty
        ? energyValues.reduce(max)
        : 1;

    final double futureBarHeight = maxEnergy * 0.5;

    return Consumer(
      builder: (context, ref, child) {
        final brightness = ref.watch(themeModeProvider);

        return BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,

                  getTitlesWidget: (value, _) {
                    final index = value.toInt();
                    if (index < 0 || index >= 7) return const SizedBox();
                    final h = hours[index];
                    final label =
                        '${h % 12 == 0 ? 12 : h % 12} ${h < 12 ? 'AM' : 'PM'}';
                    return Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        index == 5 ? 'Now' : label,
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.greyText(brightness),
                        ),
                      ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                fitInsideVertically: true,
                fitInsideHorizontally: true,
                direction: TooltipDirection.top,
                tooltipMargin: 0,
                tooltipPadding: const EdgeInsets.all(5),
                tooltipBorderRadius: BorderRadius.circular(8),
                tooltipBorder: const BorderSide(color: Colors.white),
                tooltipHorizontalAlignment: FLHorizontalAlignment.center,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  final hour = hours[group.x.toInt()];
                  final model = hourToModel[hour];
                  final index = group.x.toInt();

                  if (model == null || index == 6) return null;

                  return BarTooltipItem(
                    '${model.getHour()}\nEnergy: ${model.energyGeneration.toStringAsFixed(2)} kWh',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),

            barGroups: List.generate(7, (index) {
              final hour = hours[index];
              final model = hourToModel[hour];
              final isFuture = index == 6;

              double energy = isFuture
                  ? futureBarHeight
                  : model?.energyGeneration ?? 0;
              final normalized = maxEnergy > 0 ? energy / maxEnergy * 100 : 0;

              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: normalized.toDouble(),
                    width: width * 0.07,
                    color: isFuture
                        ? AppColors.whiteBodyBg(brightness)
                        : AppColors.greenEnergy,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ],
              );
            }),
            extraLinesData: ExtraLinesData(
              extraLinesOnTop: false,
              horizontalLines: [
                HorizontalLine(
                  y: maxEnergy > 0
                      ? (hourToModel[hours[5]]?.energyGeneration ?? 0) /
                            maxEnergy *
                            90
                      : 0,
                  color: AppColors.yellowDottedLine,
                  strokeWidth: 2.5,
                  dashArray: [5, 5],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
