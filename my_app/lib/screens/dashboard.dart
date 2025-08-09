import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/models/devices.dart';
import 'package:my_app/models/user_detail.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';
import 'package:my_app/widgets/batteryStatus.dart';
import 'package:my_app/widgets/customAppBar.dart';
import 'package:my_app/widgets/devices.dart';
import 'package:my_app/widgets/energy_summary.dart';
import 'package:my_app/widgets/weather_status_widget.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
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
                Center(child: WeatherStatusWidget()),
                SizedBox(height: 5),
                Center(child: EnergySummary()),
                SizedBox(height: 10),
                Center(child: BatteryStatus()),
                SizedBox(height: 20),
                consumptions(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class consumptions extends StatelessWidget {
  const consumptions({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Devices> devices = [
      Devices(deviceName: 'Car', deviceCount: 3),
      Devices(deviceName: 'Refrigerator', deviceCount: 2),
      Devices(deviceName: 'Television', deviceCount: 4),
      Devices(deviceName: 'PC', deviceCount: 2),
      Devices(deviceName: 'Lights', deviceCount: 8),
    ];

    return Consumer(
      builder: (context, ref, child) {
        final brightness = ref.watch(themeModeProvider);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Consumptions',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                      color: AppColors.greyText(brightness),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1 / 0.9,
                ),
                itemCount: devices.length,
                itemBuilder: (context, index) =>
                    DeviceCard(device: devices[index]),
              ),
            ],
          ),
        );
      },
    );
  }
}
