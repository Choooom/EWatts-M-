import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/screens/analytics.dart';
import 'package:my_app/screens/dashboard.dart';
import 'package:my_app/screens/panels.dart';
import 'package:my_app/screens/settings.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, chilld) {
        final brightness = ref.watch(themeModeProvider);

        final List<Widget> _screens = [
          DashBoard(),
          PanelsScreen(),
          AnalyticsScreen(),
          SettingsScreen(),
        ];

        return Scaffold(
          extendBody: true,
          body: _screens[_selectedIndex],
          bottomNavigationBar: bottomNavBar(context, brightness),
        );
      },
    );
  }

  Padding bottomNavBar(BuildContext context, Brightness brightness) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteWidgetBg(brightness),
          borderRadius: BorderRadius.all(Radius.circular(50)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: GNav(
            gap: 8,
            color: AppColors.bottomIconColor(brightness),
            activeColor: AppColors.bottomIconActiveColor(brightness),
            tabBackgroundColor: AppColors.bottomNavActiveIconColor(brightness),
            backgroundColor: Colors.white,
            selectedIndex: _selectedIndex,
            onTabChange: (index) => {
              setState(() {
                _selectedIndex = index;
              }),
            },
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
