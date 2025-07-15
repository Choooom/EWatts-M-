import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';

Widget energyCircle(
  String label,
  String value,
  Color borderColor,
  double size,
) {
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
          color: borderColor.withOpacity(0.2),
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
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    ),
  );
}

Widget dottedLine({
  Axis direction = Axis.vertical,
  double length = 50,
  Color color = Colors.green,
}) {
  return Dash(
    direction: direction,
    length: length,
    dashLength: 10,
    dashColor: color,
    dashThickness: 2,
    dashGap: 5,
  );
}
