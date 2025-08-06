import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/models/consumption_overview.dart';
import 'package:my_app/widgets/consumption_overview_graph.dart';
import 'package:my_app/widgets/custom_app_bar.dart';
import 'package:my_app/widgets/performanceMetrics.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  List<int> timeframe = [0, 1, 2, 3];
  int selectedTimeFrame = 0;

  final Random _random = Random();

  List<ConsumptionOverview> generateRandomConsumptionData(int count) {
    return List.generate(count, (_) {
      // Step 1: Generate two random numbers between 0 and 100
      double first = _random.nextDouble() * 100;
      double second = _random.nextDouble() * 100;

      // Step 2: Sort them to ensure valid partitioning
      List<double> parts = [first, second]..sort();

      double directSolar = parts[0];
      double battery = parts[1] - parts[0];
      double grid = 100 - parts[1];

      return ConsumptionOverview(
        directSolar: double.parse(directSolar.toStringAsFixed(1)),
        battery: double.parse(battery.toStringAsFixed(1)),
        grid: double.parse(grid.toStringAsFixed(1)),
      );
    });
  }

  /*
  final List<ConsumptionOverview> datas = [
    ConsumptionOverview(directSolar: 20, battery: 70, grid: 10),
    ConsumptionOverview(directSolar: 40, battery: 30, grid: 30),
    ConsumptionOverview(directSolar: 10, battery: 40, grid: 50),
    ConsumptionOverview(directSolar: 60, battery: 20, grid: 20),
    ConsumptionOverview(directSolar: 30, battery: 50, grid: 20),
    ConsumptionOverview(directSolar: 30, battery: 50, grid: 20),
    ConsumptionOverview(directSolar: 20, battery: 70, grid: 10),
    ConsumptionOverview(directSolar: 40, battery: 30, grid: 30),
    ConsumptionOverview(directSolar: 10, battery: 40, grid: 50),
    ConsumptionOverview(directSolar: 60, battery: 20, grid: 20),
  ];
  */
  @override
  Widget build(BuildContext context) {
    final List<ConsumptionOverview> data = generateRandomConsumptionData(10);
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SecondaryAppBar(screeenName: "Analytics")),
          SliverToBoxAdapter(child: timeFrame()),
          SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverToBoxAdapter(
            child: consumptionOverview(width: width, data: data),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverToBoxAdapter(child: carbonEmission(width: width)),
          SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverToBoxAdapter(child: performanceMetrics(width: width)),
          SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverToBoxAdapter(
            child: Center(
              child: SizedBox(
                width: width * 0.9,
                child: AspectRatio(
                  aspectRatio: 1 / 0.4,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.whiteWidgetBg,
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
                                        color: AppColors.whiteBodyBg,
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
                                      padding: const EdgeInsets.only(
                                        left: 15.0,
                                      ),
                                      child: Text(
                                        "\$50.45",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 15.0,
                                      ),
                                      child: Text(
                                        "Cost Saved",
                                        style: TextStyle(
                                          color: AppColors.greyText,
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
                            color: AppColors.whiteWidgetBg,
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
                                        color: AppColors.whiteBodyBg,
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
                                      padding: const EdgeInsets.only(
                                        left: 15.0,
                                      ),
                                      child: Text(
                                        "\$10.32",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 15.0,
                                      ),
                                      child: Text(
                                        "Earned from grid",
                                        style: TextStyle(
                                          color: AppColors.greyText,
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
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Center timeFrame() {
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
                GestureDetector(
                  onTap: () => setState(() {
                    selectedTimeFrame = timeframe[0];
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedTimeFrame == 0
                          ? AppColors.whiteWidgetBg
                          : Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 17.0,
                        vertical: 8,
                      ),
                      child: Text(
                        "Daily",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: selectedTimeFrame == 0
                              ? Colors.black
                              : AppColors.greyText,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    selectedTimeFrame = timeframe[1];
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedTimeFrame == 1
                          ? AppColors.whiteWidgetBg
                          : Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 17.0,
                        vertical: 8,
                      ),
                      child: Text(
                        "Weekly",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: selectedTimeFrame == 1
                              ? Colors.black
                              : AppColors.greyText,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    selectedTimeFrame = timeframe[2];
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedTimeFrame == 2
                          ? AppColors.whiteWidgetBg
                          : Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 17.0,
                        vertical: 8,
                      ),
                      child: Text(
                        "Monthly",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: selectedTimeFrame == 2
                              ? Colors.black
                              : AppColors.greyText,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    selectedTimeFrame = timeframe[3];
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedTimeFrame == 3
                          ? AppColors.whiteWidgetBg
                          : Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 17.0,
                        vertical: 8,
                      ),
                      child: Text(
                        "Yearly",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: selectedTimeFrame == 3
                              ? Colors.black
                              : AppColors.greyText,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class performanceMetrics extends StatelessWidget {
  const performanceMetrics({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width * 0.9,
        decoration: BoxDecoration(
          color: AppColors.whiteWidgetBg,
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
              Padding(
                padding: EdgeInsetsGeometry.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.greenLabel,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                          ),
                          child: Padding(padding: EdgeInsetsGeometry.all(8)),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Direct Solar",
                          style: TextStyle(color: AppColors.greyText),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.yellowLabel,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                          ),
                          child: Padding(padding: EdgeInsetsGeometry.all(8)),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Battery",
                          style: TextStyle(color: AppColors.greyText),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.greyBgColor,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                          ),
                          child: Padding(padding: EdgeInsetsGeometry.all(8)),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Grid",
                          style: TextStyle(color: AppColors.greyText),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class carbonEmission extends StatelessWidget {
  const carbonEmission({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width * 0.9,
        decoration: BoxDecoration(
          color: AppColors.whiteWidgetBg,
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
                    "750 kg CO2 emmisions saved",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "Carbon footprint offset",
                    style: TextStyle(color: AppColors.greyText),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class consumptionOverview extends StatelessWidget {
  const consumptionOverview({
    super.key,
    required this.width,
    required this.data,
  });

  final double width;
  final List<ConsumptionOverview> data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width * 0.9,
        decoration: BoxDecoration(
          color: AppColors.whiteWidgetBg,
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
                  child: ConsumptionOverviewGraph(data: data),
                ),
              ),

              Padding(
                padding: EdgeInsetsGeometry.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.greenLabel,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                          ),
                          child: Padding(padding: EdgeInsetsGeometry.all(8)),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Direct Solar",
                          style: TextStyle(color: AppColors.greyText),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.yellowLabel,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                          ),
                          child: Padding(padding: EdgeInsetsGeometry.all(8)),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Battery",
                          style: TextStyle(color: AppColors.greyText),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.greyBgColor,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                          ),
                          child: Padding(padding: EdgeInsetsGeometry.all(8)),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Grid",
                          style: TextStyle(color: AppColors.greyText),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
