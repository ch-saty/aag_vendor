// ripple_painter.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';

class RipplePainter extends CustomPainter {
  final List<Animation<double>> animations;

  RipplePainter(this.animations);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromRGBO(206, 138, 255, 1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius =
        math.sqrt(size.width * size.width + size.height * size.height) / 2;

    for (var anim in animations) {
      final radius = maxRadius * anim.value;
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
