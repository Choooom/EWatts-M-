import 'package:flutter/material.dart';

class AppColors {
  static Color whiteBodyBg(Brightness b) => b == Brightness.dark
      ? Color.fromARGB(255, 53, 53, 53)
      : Color(0xFFF6F6F6);
  static Color whiteWidgetBg(Brightness b) => b == Brightness.dark
      ? Color.fromARGB(255, 29, 29, 29)
      : Color(0xFFFFFFFF);
  static const Color greenEnergy = Color(0xFF6cf074);
  static const Color greenActiveStatus = Color(0xFF32d683);
  static const Color redOfflineStatus = Color(0xFFc64d44);
  static const Color redDottedLines = Color(0xFFd86d6f);
  static const Color black = Colors.black;
  static Color greyText(Brightness b) => b == Brightness.dark
      ? Color.fromARGB(255, 161, 162, 175)
      : Color(0xFF71727b);
  static const Color greyBg = Color(0xFFebecf0);
  static const Color greenCircle = Color(0xFF2b9670);
  static const Color greenDottedLines = Color(0xFF5abf8f);
  static const Color subTextColor = Color(0xFF848688);
  static const List<Color> batteryLevels = [
    Color(0xFF5ae75f),
    Color(0xFF61ea65),
    Color(0xFF6aee6f),
    Color(0xFF6eef74),
    Color(0xFF77f37c),
    Color(0xFF7df684),
    Color(0xFF82f88a),
    Color(0xFF8afb90),
    Color(0xFF90fd96),
    Color(0xFF97ffa0),
  ];

  static const Color yellowDottedLine = Color(0xFFf8e2b3);

  static const Color whiteBatteryColor = Color(0xFFf3f5f9);
  static Color bottomNavIconColor(Brightness b) => b == Brightness.dark
      ? Color.fromARGB(255, 29, 29, 29)
      : Color(0xFFf1f5f9);
  static Color bottomNavActiveIconColor(Brightness b) => b == Brightness.dark
      ? Color.fromARGB(255, 164, 166, 172)
      : Color(0xFF111727);
  static Color bottomIconActiveColor(Brightness b) => b == Brightness.dark
      ? Color.fromARGB(255, 75, 77, 78)
      : Color(0xFFfafdff);
  static Color bottomIconColor(Brightness b) => b == Brightness.dark
      ? Color.fromARGB(255, 212, 220, 228)
      : Color(0xFF677582);

  static const Color greenPowerButtonArea = Color(0xFFeefef2);
  static const Color greenPowerButtonBorder = Color(0xFF9edbbe);
  static const Color greenActiveCircle = Color(0xFF31d683);
  static const Color greenText = Color(0xFF46bc85);

  static const Color greenUpperLeft = Color(0xFF93fd95);
  static const Color greenBottomRight = Color(0xFF52eb5c);
  static const Color greenLabel = Color(0xFF61de5d);
  static const Color greenCircleBg = Color(0xFFe5f9f0);

  static const Color yellowUpperLeft = Color(0xFFe8ed86);
  static const Color yellowBottomLeft = Color(0xFFdce63c);
  static const Color yellowLabel = Color(0xFFe2ea64);

  static const Color greyBgColor = Color(0xFFdde2df);

  static const Color blackLeft = Color(0xFF1A1A1F);
  static const Color blackRight = Color(0xFF3E414C);

  static const Color goldLeft = Color(0xFFdbba7e);
  static const Color goldRight = Color(0xFFf6f7d3);

  static const Color discord = Color(0xFF566af6);
  static const Color facebook = Color(0xFF086dff);
}
