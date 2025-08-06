import 'package:flutter/material.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/widgets/energyDiagram.dart';
import 'package:my_app/widgets/energy_circle.dart';

class EnergySummary extends StatelessWidget {
  const EnergySummary({super.key});

  @override
  Widget build(BuildContext context) {
    final containerWidth = MediaQuery.sizeOf(context).width * 0.9;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 1),
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Material(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Container(
          width: containerWidth,
          decoration: BoxDecoration(
            color: AppColors.whiteWidgetBg,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: EnergyDiagram(width: containerWidth),
          ),
        ),
      ),
    );
  }
}
