import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/screens/analytics.dart';
import 'package:my_app/screens/dashboard.dart';
import 'package:my_app/screens/panels.dart';
import 'package:my_app/screens/settings.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';

class bottomNavBar extends StatefulWidget {
  const bottomNavBar({super.key});

  @override
  State<bottomNavBar> createState() => _bottomNavBarState();
}

class _bottomNavBarState extends State<bottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    DashBoardUpdated(),
    PanelsScreen(),
    AnalyticsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
      child: Consumer(
        builder: (context, ref, child) {
          final brightness = ref.watch(themeModeProvider);
          return Container(
            decoration: BoxDecoration(
              color: AppColors.whiteWidgetBg(brightness),
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 10),
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
                tabBackgroundColor: AppColors.bottomNavActiveIconColor(
                  brightness,
                ),
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
                    text: "Ewan",
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashBoardUpdated(),
                        ),
                      ),
                    },
                  ),
                  GButton(
                    padding: EdgeInsets.all(12),
                    icon: Icons.solar_power_rounded,
                    text: "Panels",
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PanelsScreen()),
                      ),
                    },
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
          );
        },
      ),
    );
  }
}
