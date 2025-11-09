// lib/screens/analytics_screen_updated.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/models/consumption_overview.dart';
import 'package:my_app/providers/analytics/analytics_providers.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';
import 'package:my_app/widgets/consumption_overview_graph.dart';
import 'package:my_app/widgets/custom_app_bar.dart';
import 'package:my_app/widgets/performanceMetrics.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = ref.watch(themeModeProvider);
    final selectedTimeFrame = ref.watch(selectedTimeFrameProvider);
    final analyticsAsync = ref.watch(analyticsDataProvider);
    final consumptionData = ref.watch(consumptionOverviewProvider);
    final totalEnergy = ref.watch(totalEnergyConsumedProvider);
    final costSaved = ref.watch(costSavedProvider);
    final carbonSaved = ref.watch(carbonSavedProvider);

    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SecondaryAppBar(
              screeenName: "Analytics",
              brightness: brightness,
            ),
          ),

          // Time Frame Selector
          SliverToBoxAdapter(
            child: _timeFrame(
              brightness: brightness,
              selectedTimeFrame: selectedTimeFrame,
              onTimeFrameChanged: (index) {
                ref.read(selectedTimeFrameProvider.notifier).state = index;
              },
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 10)),

          // Loading/Error/Data State Handling
          analyticsAsync.when(
            data: (_) => SliverToBoxAdapter(child: SizedBox.shrink()),
            loading: () => SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            error: (error, stack) => SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Icon(Icons.error_outline, size: 48, color: Colors.red),
                      SizedBox(height: 10),
                      Text(
                        'Failed to load analytics',
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(height: 5),
                      Text(
                        error.toString(),
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          ref.invalidate(analyticsDataProvider);
                        },
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Consumption Overview
          SliverToBoxAdapter(
            child: _consumptionOverview(
              width: width,
              data: consumptionData,
              brightness: brightness,
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 10)),

          // Carbon Emission
          SliverToBoxAdapter(
            child: _carbonEmission(
              width: width,
              brightness: brightness,
              carbonSaved: carbonSaved,
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 10)),

          // Performance Metrics
          SliverToBoxAdapter(
            child: _performanceMetrics(
              width: width,
              brightness: brightness,
              ref: ref,
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 10)),

          // Cost and Earnings
          SliverToBoxAdapter(
            child: _costAndEarnings(
              width: width,
              brightness: brightness,
              costSaved: costSaved,
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _timeFrame({
    required Brightness brightness,
    required int selectedTimeFrame,
    required Function(int) onTimeFrameChanged,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.greyBg,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _timeFrameButton(
                  label: "Daily",
                  index: 0,
                  selected: selectedTimeFrame == 0,
                  brightness: brightness,
                  onTap: () => onTimeFrameChanged(0),
                ),
                _timeFrameButton(
                  label: "Weekly",
                  index: 1,
                  selected: selectedTimeFrame == 1,
                  brightness: brightness,
                  onTap: () => onTimeFrameChanged(1),
                ),
                _timeFrameButton(
                  label: "Monthly",
                  index: 2,
                  selected: selectedTimeFrame == 2,
                  brightness: brightness,
                  onTap: () => onTimeFrameChanged(2),
                ),
                _timeFrameButton(
                  label: "Yearly",
                  index: 3,
                  selected: selectedTimeFrame == 3,
                  brightness: brightness,
                  onTap: () => onTimeFrameChanged(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _timeFrameButton({
    required String label,
    required int index,
    required bool selected,
    required Brightness brightness,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: selected
              ? AppColors.whiteWidgetBg(brightness)
              : Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: selected ? Colors.black : AppColors.greyText(brightness),
            ),
          ),
        ),
      ),
    );
  }

  Widget _consumptionOverview({
    required double width,
    required List<ConsumptionOverview> data,
    required Brightness brightness,
  }) {
    return Center(
      child: Container(
        width: width * 0.9,
        decoration: BoxDecoration(
          color: AppColors.whiteWidgetBg(brightness),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 1,
            ),
          ],
        ),
        child: AspectRatio(
          aspectRatio: 1 / 0.85,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Consumption overview",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15,
                    bottom: 15,
                  ),
                  child: data.isEmpty
                      ? Center(child: Text('No data available'))
                      : ConsumptionOverviewGraph(data: data),
                ),
              ),
              _buildLegend(brightness),
            ],
          ),
        ),
      ),
    );
  }

  Widget _carbonEmission({
    required double width,
    required Brightness brightness,
    required double carbonSaved,
  }) {
    return Center(
      child: Container(
        width: width * 0.9,
        decoration: BoxDecoration(
          color: AppColors.whiteWidgetBg(brightness),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.greenCircleBg,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    "assets/images/analytics/recycle-sign.png",
                    width: width * 0.08,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${carbonSaved.toStringAsFixed(0)} kg CO2 emissions saved",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "Carbon footprint offset",
                    style: TextStyle(color: AppColors.greyText(brightness)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _performanceMetrics({
    required double width,
    required Brightness brightness,
    required WidgetRef ref,
  }) {
    return Center(
      child: Container(
        width: width * 0.9,
        decoration: BoxDecoration(
          color: AppColors.whiteWidgetBg(brightness),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 1,
            ),
          ],
        ),
        child: AspectRatio(
          aspectRatio: 1 / 0.8,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Text(
                      "Performance Metrics",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: PerformanceMetrics(),
                ),
              ),
              SizedBox(height: 15),
              _buildLegend(brightness),
            ],
          ),
        ),
      ),
    );
  }

  Widget _costAndEarnings({
    required double width,
    required Brightness brightness,
    required double costSaved,
  }) {
    return Center(
      child: SizedBox(
        width: width * 0.9,
        child: AspectRatio(
          aspectRatio: 1 / 0.4,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteWidgetBg(brightness),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: BoxBorder.all(
                                color: AppColors.whiteBodyBg(brightness),
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Image.asset(
                                'assets/icons/percentage.png',
                                color: Colors.orange,
                                width: width * 0.06,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                costSaved.toStringAsFixed(2),
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                "Cost Saved",
                                style: TextStyle(
                                  color: AppColors.greyText(brightness),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteWidgetBg(brightness),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: BoxBorder.all(
                                color: AppColors.whiteBodyBg(brightness),
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Image.asset(
                                'assets/icons/coins.png',
                                color: Colors.orange,
                                width: width * 0.06,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                "${(costSaved * 0.2).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                "Earned from grid",
                                style: TextStyle(
                                  color: AppColors.greyText(brightness),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegend(Brightness brightness) {
    return Padding(
      padding: EdgeInsetsGeometry.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _legendItem("Direct Solar", AppColors.greenLabel, brightness),
          _legendItem("Battery", AppColors.yellowLabel, brightness),
          _legendItem("Grid", AppColors.greyBgColor, brightness),
        ],
      ),
    );
  }

  Widget _legendItem(String label, Color color, Brightness brightness) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          child: Padding(padding: EdgeInsetsGeometry.all(8)),
        ),
        SizedBox(width: 10),
        Text(label, style: TextStyle(color: AppColors.greyText(brightness))),
      ],
    );
  }
}
