// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'dart:math';

class EnchantingProgressBar extends StatefulWidget {
  final double progress;

  const EnchantingProgressBar({super.key, required this.progress});

  @override
  _EnchantingProgressBarState createState() => _EnchantingProgressBarState();
}

class _EnchantingProgressBarState extends State<EnchantingProgressBar>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _shimmerController;
  late AnimationController _pulseController;
  late AnimationController _textAnimationController;

  @override
  void initState() {
    super.initState();
    _waveController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
    _shimmerController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();
    _pulseController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);
    _textAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    _shimmerController.dispose();
    _pulseController.dispose();
    _textAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _waveController,
          _shimmerController,
          _pulseController,
          _textAnimationController
        ]),
        builder: (context, child) {
          return Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.green
                      .withOpacity(0.5 + 0.5 * _pulseController.value),
                  blurRadius: 10,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  // Background
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(color: Colors.white),
                  ),

                  // Gradient fill
                  FractionallySizedBox(
                    widthFactor: widget.progress,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: const [
                            Color.fromARGB(255, 45, 175, 45),
                            Color.fromARGB(255, 35, 114, 35),
                            Color.fromARGB(255, 17, 58, 17),
                          ],
                          stops: [
                            0,
                            _shimmerController.value,
                            1,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // White line over green filling
                  // CustomPaint(
                  //   painter: WhiteLinePainter(
                  //     animation: _waveController.value,
                  //     progress: widget.progress,
                  //   ),
                  //   size: Size(MediaQuery.of(context).size.width * 0.8, 40),
                  // ),

                  // Animated text for 100%
                  if (widget.progress >= 1.0)
                    ClipRect(
                      child: AnimatedBuilder(
                        animation: _textAnimationController,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(
                                0, 80 * (.4 - _textAnimationController.value)),
                            child: Center(
                              child: Text(
                                "!! CONGRATULATIONS !!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.5),
                                      offset: const Offset(1, 2),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  // Percentage text (visible only when progress < 100%)
                  if (widget.progress < 1.0)
                    Positioned(
                      top: 8,
                      right: 10,
                      child: Text(
                        "${(widget.progress * 100).toInt().clamp(0, 100)}%",
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(1, 1),
                              blurRadius: 2,
                            ),
                          ],
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

// class WhiteLinePainter extends CustomPainter {
//   final double animation;
//   final double progress;

//   WhiteLinePainter({required this.animation, required this.progress});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.white.withOpacity(0.5)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;

//     final waveHeight = size.height * 0.2;
//     const waveCount = 3;
//     final waveWidth = size.width / waveCount;

//     final path = Path();
//     path.moveTo(0, size.height);

//     for (var i = 0.0; i <= size.width * progress; i++) {
//       final x = i;
//       final sinValue = sin((x / waveWidth + animation * 2) * pi);
//       final y = size.height - (sinValue * waveHeight + waveHeight);
//       path.lineTo(x, y);
//     }

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
