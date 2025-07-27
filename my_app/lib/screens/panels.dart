import 'package:flutter/material.dart';
import 'package:my_app/widgets/bottomNavBar.dart';

class PanelsScreen extends StatelessWidget {
  const PanelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(), bottomNavigationBar: bottomNavBar());
  }
}
