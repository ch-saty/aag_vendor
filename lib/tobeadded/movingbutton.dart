import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class PremiumShimmerButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final List<Color> gradientColors;
  final double width;
  final double height;

  const PremiumShimmerButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.gradientColors,
    this.width = 200,
    this.height = 50,
  });

  @override
  _PremiumShimmerButtonState createState() => _PremiumShimmerButtonState();
}

class _PremiumShimmerButtonState extends State<PremiumShimmerButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown() {
    _controller.forward(from: 0).then((_) {
      // Call the onPressed callback after the animation finishes
      widget.onPressed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _onTapDown(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: SizedBox(
              width: widget.width,
              height: widget.height,
              child: Stack(
                children: [
                  CustomPaint(
                    painter: ShimmerPainter(
                      colors: widget.gradientColors,
                      progress: _controller.value,
                    ),
                    size: Size(widget.width, widget.height),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: widget.onPressed,
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: widget.width,
                        height: widget.height,
                        alignment: Alignment.center,
                        child: widget.child,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ShimmerPainter extends CustomPainter {
  final List<Color> colors;
  final double progress;

  ShimmerPainter({required this.colors, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rRect = RRect.fromRectAndRadius(rect, const Radius.circular(10));

    final paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(size.width * -0.5 + size.width * progress * 2, 0),
        Offset(size.width * 0.5 + size.width * progress * 2, size.height),
        colors,
        [0.0, 0.5, 1.0],
        TileMode.clamp,
      );

    canvas.drawRRect(rRect, paint);

    // Add a subtle shine effect
    final shinePaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(size.width * progress, 0),
        Offset(size.width * progress + 20, size.height),
        [
          Colors.white.withOpacity(0.0),
          Colors.white.withOpacity(0.2),
          Colors.white.withOpacity(0.0)
        ],
        [0.0, 0.5, 1.0],
        TileMode.clamp,
      );

    canvas.drawRRect(rRect, shinePaint);
  }

  @override
  bool shouldRepaint(ShimmerPainter oldDelegate) => true;
}
