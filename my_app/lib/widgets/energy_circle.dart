import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';

Widget energyCircle(
  String label,
  String value,
  Color borderColor,
  double size,
) {
  final valueFontSize = size * 0.2;
  final labelFontSize = size * 0.15;

  return Consumer(
    builder: (context, ref, child) {
      final brightness = ref.watch(themeModeProvider);

      return Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: 1),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: borderColor.withValues(alpha: 0.2),
              blurRadius: 6,
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: valueFontSize,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: labelFontSize,
                color: AppColors.greyText(brightness),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget dottedLine({
  Axis direction = Axis.vertical,
  double length = 50,
  double dashThickness = 2,
  Color color = Colors.green,
}) {
  return Dash(
    direction: direction,
    length: length,
    dashLength: 10,
    dashColor: color,
    dashThickness: dashThickness,
    dashGap: 5,
  );
}
