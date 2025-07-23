import 'package:flutter/material.dart';
import 'package:my_app/constants/colors.dart';

class EnergyBar extends StatefulWidget {
  final double fillPercentage;
  final double barWidth;
  final double barHeight;
  final Color barColor;

  const EnergyBar({
    super.key,
    required this.fillPercentage,
    required this.barHeight,
    required this.barWidth,
    required this.barColor,
  });

  @override
  State<EnergyBar> createState() => _EnergyBarState();
}

class _EnergyBarState extends State<EnergyBar> {
  late double oldFill;

  @override
  void initState() {
    super.initState();
    oldFill = widget.fillPercentage;
  }

  @override
  void didUpdateWidget(covariant EnergyBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldFill = oldWidget.fillPercentage;
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: oldFill, end: widget.fillPercentage),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Container(
          width: widget.barWidth,
          height: widget.barHeight,
          decoration: BoxDecoration(
            color: AppColors.whiteBatteryColor,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: value.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: widget.barColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
