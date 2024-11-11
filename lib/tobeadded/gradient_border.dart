import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedGradientBorderPainter extends CustomPainter {
  final Animation<double> animation;

  AnimatedGradientBorderPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(20));

    final paint = Paint()
      ..shader = SweepGradient(
        colors: const [Colors.red, Colors.yellow, Colors.red],
        stops: const [0.0, 0.5, 1.0],
        startAngle: 0,
        endAngle: math.pi * 2,
        transform: GradientRotation(animation.value * math.pi * 2),
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class AnimatedGradientBorderDialog extends StatefulWidget {
  final Widget child;

  const AnimatedGradientBorderDialog({super.key, required this.child});

  @override
  _AnimatedGradientBorderDialogState createState() =>
      _AnimatedGradientBorderDialogState();
}

class _AnimatedGradientBorderDialogState
    extends State<AnimatedGradientBorderDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: AnimatedGradientBorderPainter(_controller),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
