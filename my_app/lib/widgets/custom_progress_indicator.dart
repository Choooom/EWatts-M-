import 'package:flutter/material.dart';

class CustomCircularProgress extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final double size;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;

  const CustomCircularProgress({
    super.key,
    required this.progress,
    this.size = 60,
    this.strokeWidth = 6,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 0.8),
      duration: const Duration(seconds: 2),
      builder: (context, value, _) {
        return SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: _CircularPainter(
              progress,
              strokeWidth,
              backgroundColor,
              progressColor,
            ),
          ),
        );
      },
    );
  }
}

class _CircularPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;

  _CircularPainter(
    this.progress,
    this.strokeWidth,
    this.backgroundColor,
    this.progressColor,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final Paint base = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Paint progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = size.center(Offset.zero);
    final radius = (size.width / 2) - (strokeWidth / 2);

    // Draw background circle
    canvas.drawCircle(center, radius, base);

    // Draw progress arc
    final sweepAngle = 2 * 3.1416 * progress.clamp(0.0, 1.0);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.1416 / 2, // Start angle at top
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
