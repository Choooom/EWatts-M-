import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/models/user_detail.dart';
import 'package:my_app/widgets/batteryStatus.dart';
import 'package:my_app/widgets/customAppBar.dart';
import 'package:my_app/widgets/energy_summary.dart';
import 'package:my_app/widgets/weather_status_widget.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

UserDetail userDetail = UserDetail(
  username: 'Romille',
  phoneNumber: '09296726163',
  email: 'romilleilaida420@gmail.com',
  password: 'Amen103',
);
String username = userDetail.username;

class _DashBoardState extends State<DashBoard> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(username: username),
      extendBody: true,
      body: SingleChildScrollView(
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
            Container(),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavBar(),
    );
  }
}

class bottomNavBar extends StatelessWidget {
  const bottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteWidgetBg,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: GNav(
            gap: 8,
            color: AppColors.bottomIconColor,
            activeColor: AppColors.bottomIconActiveColor,
            tabBackgroundColor: AppColors.bottomNavActiveIconColor,
            backgroundColor: Colors.white,
            tabs: [
              GButton(
                padding: EdgeInsets.all(12),
                icon: Icons.dashboard_rounded,
                text: "Dashboard",
              ),
              GButton(
                padding: EdgeInsets.all(12),
                icon: Icons.solar_power_rounded,
                text: "Panels",
              ),
              GButton(
                padding: EdgeInsets.all(12),
                icon: Icons.analytics_rounded,
                text: "Analytics",
              ),
              GButton(
                padding: EdgeInsets.all(12),
                icon: Icons.settings,
                text: "Settings",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
