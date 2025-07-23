import 'package:flutter/material.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/widgets/energy_circle.dart';

class EnergyDiagram extends StatefulWidget {
  final double width;
  const EnergyDiagram({super.key, required this.width});

  @override
  State<EnergyDiagram> createState() => _EnergyDiagramState();
}

class _EnergyDiagramState extends State<EnergyDiagram> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.4, // Width:Height
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          final circleSize = width * 0.18;

          return Stack(
            children: [
              //vertical green line underneath Produce
              Positioned(
                top: height * 0.345,
                left: width * 0.807,
                child: dottedLine(
                  length: width * 0.16,
                  dashThickness: width * 0.0041,
                  color: AppColors.greenDottedLines,
                  direction: Axis.vertical,
                ),
              ),

              //horizontal line for export
              Positioned(
                top: height * 0.494,
                left: width * 0.132,
                child: dottedLine(
                  length: width * 0.5,
                  dashThickness: width * 0.0041,
                  color: AppColors.redDottedLines,
                  direction: Axis.horizontal,
                ),
              ),

              // House Image
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/house.png',
                  width: width * 0.73,
                  fit: BoxFit.contain,
                ),
              ),

              // Export Circle
              Positioned(
                left: width * 0.04,
                top: height * 0.08,
                child: energyCircle(
                  "Export",
                  "1.5 kw",
                  AppColors.redOfflineStatus,
                  circleSize,
                ),
              ),

              // Home Circle
              Positioned(
                left: width * 0.37,
                top: width * 0.08,
                child: energyCircle(
                  "Home",
                  "64 kw",
                  AppColors.redOfflineStatus,
                  circleSize,
                ),
              ),

              // Produce Circle
              Positioned(
                left: width * 0.72,
                top: height * 0.08,
                child: energyCircle(
                  "Produce",
                  "3.65 w",
                  AppColors.greenCircle,
                  circleSize,
                ),
              ),

              //Stored circle
              Positioned(
                left: width * 0.17,
                top: height * 0.65,
                child: energyCircle(
                  "Stored",
                  "129 kw",
                  AppColors.greenCircle,
                  circleSize,
                ),
              ),

              //vertical line for home
              Positioned(
                top: height * 0.375,
                left: width * 0.458,
                child: dottedLine(
                  length: width * 0.13,
                  dashThickness: width * 0.0041,
                  color: AppColors.redDottedLines,
                  direction: Axis.vertical,
                ),
              ),

              //horizontal line for home
              Positioned(
                top: height * 0.564,
                left: width * 0.462,
                child: dottedLine(
                  length: width * 0.06,
                  dashThickness: width * 0.0041,
                  color: AppColors.redDottedLines,
                  direction: Axis.horizontal,
                ),
              ),

              //horizontal line for Stored
              Positioned(
                top: height * 0.4,
                left: width * 0.27,
                child: dottedLine(
                  length: width * 0.32,
                  dashThickness: width * 0.0041,
                  color: AppColors.greenDottedLines,
                  direction: Axis.horizontal,
                ),
              ),

              //vertical line for Stored
              Positioned(
                top: height * 0.41,
                left: width * 0.26,
                child: dottedLine(
                  length: width * 0.16,
                  dashThickness: width * 0.0041,
                  color: AppColors.greenDottedLines,
                  direction: Axis.vertical,
                ),
              ),

              //vertical line for export
              Positioned(
                top: height * 0.345,
                left: width * 0.127,
                child: dottedLine(
                  length: width * 0.1,
                  dashThickness: width * 0.0041,
                  color: AppColors.redDottedLines,
                  direction: Axis.vertical,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
