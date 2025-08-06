import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/models/consumption_overview.dart';

//Make sure na pag inintigrate na yung back end,
//i solve mo muna yung values for energy sources
//to make sure na sum nung tatlo is 100%
//modified yung graph to have uniform gaps kapag
//yung 3 value ay nag ssum to 100.
class ConsumptionOverviewGraph extends StatelessWidget {
  final List<ConsumptionOverview> data;

  const ConsumptionOverviewGraph({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double barWidth = screenWidth * 0.11;
    double minBarCount = 7;
    double totalWidth =
        (data.length > minBarCount ? data.length : minBarCount) *
        (barWidth + 3); // include group space

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: totalWidth,
        height: double.infinity,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(show: false),
            gridData: FlGridData(show: false),
            groupsSpace: 3,
            barTouchData: BarTouchData(
              enabled: true,
              handleBuiltInTouches: true,
              touchTooltipData: BarTouchTooltipData(
                fitInsideVertically: true,
                fitInsideHorizontally: true,
                direction: TooltipDirection.top,
                tooltipMargin: 0,
                tooltipPadding: const EdgeInsets.all(5),
                tooltipBorderRadius: BorderRadius.circular(8),
                tooltipBorder: BorderSide(color: Colors.white),
                tooltipHorizontalAlignment: FLHorizontalAlignment.center,

                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  final item = data[group.x.toInt()];
                  final total = item.total;

                  final solar = (item.directSolar / total * 100)
                      .toStringAsFixed(1);
                  final battery = (item.battery / total * 100).toStringAsFixed(
                    1,
                  );
                  final grid = (item.grid / total * 100).toStringAsFixed(1);

                  return BarTooltipItem(
                    'Direct Solar: $solar%\n'
                    'Battery: $battery%\n'
                    'Grid: $grid%',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
            barGroups: List.generate(data.length, (i) {
              final item = data[i];
              final total = item.total;
              final double gap = 2.0;
              double adjustedTotal = total + gap * 2;

              double current = 0;

              final stackItems = <BarChartRodStackItem>[
                BarChartRodStackItem(
                  current,
                  current += (item.directSolar / adjustedTotal * 100),
                  AppColors.greenBottomRight,
                ),
                BarChartRodStackItem(
                  current += (gap / adjustedTotal * 100),
                  current += (item.battery / adjustedTotal * 100),
                  AppColors.yellowBottomLeft,
                ),
                BarChartRodStackItem(
                  current += (gap / adjustedTotal * 100),
                  current += (item.grid / adjustedTotal * 100),
                  AppColors.greyBgColor,
                ),
              ];

              return BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: 100,
                    rodStackItems: stackItems,
                    width: barWidth,
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
