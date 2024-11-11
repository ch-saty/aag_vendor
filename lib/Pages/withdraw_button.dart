import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:lottie/lottie.dart';

class AnimatedClaimButton extends StatefulWidget {
  final double progress;
  final VoidCallback onPressed;

  const AnimatedClaimButton({
    super.key,
    required this.progress,
    required this.onPressed,
  });

  @override
  _AnimatedClaimButtonState createState() => _AnimatedClaimButtonState();
}

class _AnimatedClaimButtonState extends State<AnimatedClaimButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant AnimatedClaimButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.progress == 1.0) {
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showAnimationPopup() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 500),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return PopScope(
          canPop: false,
          child: Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(seconds: 5),
              builder: (context, value, child) {
                return Transform.rotate(
                  angle: value * 2 * 3.14159,
                  child: Transform.scale(
                    scale: 1 + value,
                    child: Opacity(
                      opacity: 1 - value,
                      child: child,
                    ),
                  ),
                );
              },
              onEnd: () {
                Navigator.of(context).pop();
              },
              child: Lottie.asset(
                'assets/ani.json',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed();
        _showAnimationPopup();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              height: widget.progress == 1.0 ? 31.5 : 30,
              width: widget.progress == 1.0 ? 105 : 100,
              child: Stack(
                children: [
                  CustomPaint(
                    painter: ShimmerPainter(
                      colors: widget.progress == 1.0
                          ? [Colors.green, Colors.white]
                          : [Colors.orange, Colors.orangeAccent],
                      progress: _controller.value,
                    ),
                    size: const Size(100, 30),
                  ),
                  Center(
                    child: Text(
                      "Claim",
                      style: TextStyle(
                        color: widget.progress == 1.0
                            ? Colors.white
                            : Colors.orange,
                        fontSize: 20,
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
        [0.0, 1.0], // Ensure this list has the same length as colors
        TileMode.clamp,
      );

    canvas.drawRRect(rRect, paint);

    final shinePaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(size.width * progress, 0),
        Offset(size.width * progress + 20, size.height),
        [
          Colors.white.withOpacity(0.0),
          Colors.white.withOpacity(0.2),
          Colors.white.withOpacity(0.0),
        ],
        [0.0, 0.5, 1.0],
        TileMode.clamp,
      );

    canvas.drawRRect(rRect, shinePaint);
  }

  @override
  bool shouldRepaint(ShimmerPainter oldDelegate) => true;
}
