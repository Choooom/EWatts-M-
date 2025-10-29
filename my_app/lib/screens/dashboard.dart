// lib/screens/dashboard_updated.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/models/devices.dart';
import 'package:my_app/models/user_detail.dart';
import 'package:my_app/screens/deviceDetails.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';
import 'package:my_app/widgets/batteryStatus.dart';
import 'package:my_app/widgets/customAppBar.dart';
import 'package:my_app/widgets/devices.dart';
import 'package:my_app/widgets/energy_summary.dart';
import 'package:my_app/widgets/weather_status_widget_updated.dart';

class DashBoardUpdated extends StatefulWidget {
  const DashBoardUpdated({super.key});

  @override
  State<DashBoardUpdated> createState() => _DashBoardUpdatedState();
}

class _DashBoardUpdatedState extends State<DashBoardUpdated> {
  UserDetail userDetail = UserDetail(
    username: 'Romille',
    phoneNumber: '09296726163',
    email: 'romilleilaida420@gmail.com',
    password: 'Amen103',
  );

  @override
  Widget build(BuildContext context) {
    String username = userDetail.username;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: CustomAppBar(username: username)),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                // Updated widget with tap functionality
                Center(child: WeatherStatusWidgetUpdated()),
                SizedBox(height: 5),
                Center(child: EnergySummary()),
                SizedBox(height: 10),
                Center(child: BatteryStatus()),
                SizedBox(height: 20),
                Consumptions(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Consumptions extends StatefulWidget {
  // Convert to StatefulWidget to manage _showAllDevices state
  const Consumptions({super.key});

  @override
  State<Consumptions> createState() => _ConsumptionsState();
}

class _ConsumptionsState extends State<Consumptions> {
  // 1. State variable from the original panelList logic
  bool _showAllDevices = false;
  final int _initialCount = 4; // Max items to show initially

  @override
  Widget build(BuildContext context) {
    // Mock data for demonstration (replace with your actual data source)
    final List<Devices> devices = [
      Devices(deviceName: 'Device', deviceCount: 1),
    ];

    // 2. Logic to determine item count, adapted from panelList
    final int itemCount = _showAllDevices
        ? devices.length
        : (devices.length > _initialCount ? _initialCount : devices.length);

    // 3. Visibility for the buttons
    final bool isShowAllVisible =
        devices.length > _initialCount && !_showAllDevices;
    final bool isShowLessVisible =
        devices.length > _initialCount && _showAllDevices;

    return Consumer(
      builder: (context, ref, child) {
        final brightness = ref.watch(themeModeProvider);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              // 1. Title Row (Consumptions / Total or See all)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Consumptions',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  // Display Total count when Show/Less logic is active, otherwise 'See all'
                  Text(
                    isShowAllVisible || isShowLessVisible
                        ? 'Total ${devices.length}'
                        : 'See all',
                    style: TextStyle(
                      color: AppColors.greyText(brightness),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),

              // 2. Device Grid (Limited by itemCount)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1 / 0.9,
                ),
                itemCount: itemCount, // Controlled by the state logic
                itemBuilder: (context, index) {
                  final device = devices[index];

                  // Item Tile with Navigation (adapted from panelList)
                  return InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            DeviceDetails(
                              // Use DeviceDetails as requested
                              panelName: device.deviceName,
                              panelStatus: device.deviceCount > 0
                                  ? "Active"
                                  : "Offline", // Example status logic
                            ),
                        transitionDuration: Duration(milliseconds: 500),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1, 0);
                              const end = Offset.zero;
                              const curve = Curves.ease;

                              var tween = Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: curve));

                              // Apply the same slide/fade transition
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                ),
                              );
                            },
                      ),
                    ),
                    // Assuming DeviceCard is the item tile for devices
                    child: DeviceCard(device: device),
                  );
                },
              ),

              // 3. Show All Button (if more than _initialCount items and not all are shown)
              if (isShowAllVisible)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _showAllDevices = true; // Show all items
                    });
                  },
                  child: Text(
                    'Show All',
                    style: TextStyle(color: AppColors.greyText(brightness)),
                  ),
                ),

              // 4. Show Less Button (if all items are shown and there are more than _initialCount)
              if (isShowLessVisible)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _showAllDevices = false; // Collapse to initial count
                    });
                  },
                  child: Text(
                    'Show Less',
                    style: TextStyle(color: AppColors.greyText(brightness)),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
