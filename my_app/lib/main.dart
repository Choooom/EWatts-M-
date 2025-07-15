import 'package:flutter/material.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/screens/dashboard.dart';
import 'package:my_app/screens/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.whiteBodyBg,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.whiteBodyBg,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      home: DashBoard(),
    );
  }
}
