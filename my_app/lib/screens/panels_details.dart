import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/models/battery_charge_meter.dart';
import 'package:my_app/models/panel_generation_overview.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';
import 'package:my_app/widgets/chargeMeter.dart';
import 'package:my_app/widgets/generating_overview_graph.dart';
import 'package:my_app/widgets/tap_scale_effect.dart';

class PanelsDetails extends StatelessWidget {
  String panelName;
  String panelStatus;
  PanelsDetails({
    super.key,
    required this.panelName,
    required this.panelStatus,
  });

  final List<PanelGenerationOverview> data = [
    PanelGenerationOverview(hour: 7, energyGeneration: 100.0),
    PanelGenerationOverview(hour: 8, energyGeneration: 1.5),
    PanelGenerationOverview(hour: 9, energyGeneration: 2.0),
    PanelGenerationOverview(hour: 10, energyGeneration: 1.2),
    PanelGenerationOverview(hour: 11, energyGeneration: 2.5),
    PanelGenerationOverview(hour: 12, energyGeneration: 3.0),
  ];

  final BatteryChargeMeterDetails batteryStatus = BatteryChargeMeterDetails(
    batteryLevel: 82,
    batteryCapacity: 100,
    efficiencyLevel: 100.0,
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Consumer(
      builder: (context, ref, child) {
        final brightness = ref.watch(themeModeProvider);

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: 10)),
              SliverToBoxAdapter(
                child: appBar(
                  width: width,
                  context: context,
                  brightness: brightness,
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 30)),
              SliverToBoxAdapter(
                child: header(
                  width: width,
                  panelName: panelName,
                  panelStatus: panelStatus,
                  brightness: brightness,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Performance",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: generatingSection(
                  data: data,
                  width: width,
                  brightness: brightness,
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 10)),
              SliverToBoxAdapter(
                child: generatingAveragely(
                  width: width,
                  batteryStatus: batteryStatus,
                  brightness: brightness,
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 10)),
              SliverToBoxAdapter(
                child: summary(width: width, brightness: brightness),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 10)),
            ],
          ),
        );
      },
    );
  }
}

class summary extends StatelessWidget {
  const summary({super.key, required this.width, required this.brightness});

  final double width;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
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
                        SizedBox(
                          height: width * 0.14,
                          child: Image.asset(
                            "assets/images/panels_screen/ewan.png",
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                "5.63 kwh",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                "Total Produced",
                                style: TextStyle(
                                  color: AppColors.greyText(brightness),
                                  fontSize: 14,
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
                        SizedBox(
                          height: width * 0.15,
                          child: Image.asset(
                            "assets/images/panels_screen/efficieency.png",
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                "80%",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                "Avg. efficiency",
                                style: TextStyle(
                                  color: AppColors.greyText(brightness),
                                  fontSize: 14,
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
}

class appBar extends StatelessWidget {
  const appBar({
    super.key,
    required this.width,
    required this.context,
    required this.brightness,
  });

  final double width;
  final BuildContext context;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TapScaleEffect(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.whiteWidgetBg(brightness),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ),
          ),

          Text(
            "Panel Details",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          SizedBox(width: width * 0.32),

          Container(
            decoration: BoxDecoration(
              color: AppColors.greenPowerButtonArea,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.greenPowerButtonBorder,
                width: 2,
              ),
            ),
            child: Padding(
              padding: EdgeInsetsGeometry.all(15),
              child: Icon(Icons.power_settings_new),
            ),
          ),
        ],
      ),
    );
  }
}

class generatingSection extends StatelessWidget {
  const generatingSection({
    super.key,
    required this.data,
    required this.width,
    required this.brightness,
  });

  final List<PanelGenerationOverview> data;
  final double width;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
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
          aspectRatio: 1 / 0.6,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  vertical: 15,
                  horizontal: 15,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Generating", style: TextStyle(fontSize: 20)),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          border: BoxBorder.all(
                            color: AppColors.whiteBodyBg(brightness),
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsGeometry.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Set power limit",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.keyboard_arrow_down_outlined),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15,
                    bottom: 15,
                  ),
                  //yung data nandun sa loob ng PanelGenerationGraph, modify mo dun
                  child: PanelGenerationGraph(data: data),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class header extends StatelessWidget {
  String panelName;
  String panelStatus;
  header({
    super.key,
    required this.width,
    required this.panelName,
    required this.panelStatus,
    required this.brightness,
  });

  final double width;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: panelStatus == "Active"
                              ? AppColors.greenActiveCircle
                              : AppColors.redOfflineStatus,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        panelStatus,
                        style: TextStyle(
                          color: panelStatus == "Active"
                              ? AppColors.greenText
                              : AppColors.redOfflineStatus,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 5),
                  Text(
                    panelName,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'In good condition',
                    style: TextStyle(
                      color: AppColors.greyText(brightness),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                "assets/images/panels_screen/panel_3d.png",
                width: width * 0.25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class generatingAveragely extends StatelessWidget {
  const generatingAveragely({
    super.key,
    required this.width,
    required this.batteryStatus,
    required this.brightness,
  });

  final double width;
  final BatteryChargeMeterDetails batteryStatus;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    return Center(
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
        width: width * 0.9,
        child: AspectRatio(
          aspectRatio: 1 / 0.45,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "⚡ 1.1 kwh",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Generating Averagely",
                          style: TextStyle(
                            color: AppColors.greyText(brightness),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        border: BoxBorder.all(
                          color: AppColors.whiteBodyBg(brightness),
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsGeometry.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Set power limit",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(Icons.keyboard_arrow_down_outlined),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15,
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) => BatteryChargeMeter(
                            batteryLevel: batteryStatus.batteryLevel,
                            batteryCapacity: batteryStatus.batteryCapacity,
                            maxWidth: constraints.maxWidth,
                            maxHeight: constraints.maxHeight,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${batteryStatus.batteryLevel.toString()}%",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Efficiency",
                                  style: TextStyle(
                                    color: AppColors.greyText(brightness),
                                    fontSize: 12,
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}
