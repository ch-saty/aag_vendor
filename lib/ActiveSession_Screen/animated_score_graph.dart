import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedTeamScore extends StatefulWidget {
  final String team;
  final int score;
  final String imagePath;
  final Color color;
  final bool isLeft;

  const AnimatedTeamScore({
    super.key,
    required this.team,
    required this.score,
    required this.imagePath,
    required this.color,
    required this.isLeft,
  });

  @override
  State<AnimatedTeamScore> createState() => _AnimatedTeamScoreState();
}

class _AnimatedTeamScoreState extends State<AnimatedTeamScore>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _pulseController;
  late AnimationController _particleController;
  late Animation<double> _heightAnimation;
  bool _isHovered = false;
  final List<Particle> _particles = [];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _generateParticles();

    Future.delayed(const Duration(milliseconds: 200), () {
      _mainController.forward();
      _pulseController.repeat();
      _particleController.repeat();
    });
  }

  void _initializeAnimations() {
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _particleController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _heightAnimation = Tween<double>(
      begin: 0,
      end: widget.score / 14,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: Curves.elasticOut,
    ));
  }

  void _generateParticles() {
    final random = math.Random();
    for (int i = 0; i < 40; i++) {
      _particles.add(
        Particle(
          id: i,
          initialX: random.nextDouble() * 60 - 30,
          initialY: -random.nextDouble() * 50 - 20,
          speed: random.nextDouble() * 2 + 1,
          angle: random.nextDouble() * math.pi * 2,
        ),
      );
    }
  }

  @override
  void didUpdateWidget(AnimatedTeamScore oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.score != widget.score) {
      _heightAnimation = Tween<double>(
        begin: oldWidget.score / 10,
        end: widget.score / 12,
      ).animate(CurvedAnimation(
        parent: _mainController,
        curve: Curves.elasticOut,
      ));
      _mainController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    _pulseController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // // Score display
          // AnimatedBuilder(
          //   animation: _pulseController,
          //   builder: (context, child) {
          //     return Container(
          //       padding: const EdgeInsets.symmetric(
          //         horizontal: 12,
          //         vertical: 6,
          //       ),
          //       decoration: BoxDecoration(
          //         color: widget.color.withOpacity(0.1),
          //         borderRadius: BorderRadius.circular(12),
          //         boxShadow: _isHovered
          //             ? [
          //                 BoxShadow(
          //                   color: widget.color.withOpacity(0.3),
          //                   blurRadius: _glowAnimation.value * 10,
          //                   spreadRadius: _glowAnimation.value * 2,
          //                 )
          //               ]
          //             : [],
          //       ),
          //       child: Text(
          //         '${widget.score}',
          //         style: TextStyle(
          //           color: widget.color,
          //           fontSize: 24,
          //           fontWeight: FontWeight.bold,
          //           shadows: [
          //             Shadow(
          //               color: widget.color.withOpacity(0.5),
          //               blurRadius: 8,
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // ),
          // const SizedBox(height: 8),

          // Animated bar
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (widget.isLeft) ...[
                // Card and team name on left
                Container(
                  width: 85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        widget.imagePath,
                        width: 50,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.team,
                            style: TextStyle(
                              color: widget.color,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${widget.score}',
                        style: TextStyle(
                          color: widget.color,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: widget.color.withOpacity(0.5),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // AnimatedBuilder (stays in the middle)
              AnimatedBuilder(
                animation: _heightAnimation,
                builder: (context, child) {
                  return Container(
                    height: _heightAnimation.value,
                    width: _isHovered ? 40 : 35,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          widget.color.withOpacity(0.8),
                          widget.color,
                          widget.color.withOpacity(0.6),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: widget.color.withOpacity(0.3),
                          blurRadius: _isHovered ? 15 : 8,
                          spreadRadius: _isHovered ? 3 : 1,
                        ),
                      ],
                    ),
                    child: CustomPaint(
                      painter: ParticlePainter(
                        particles: _particles,
                        animation: _particleController,
                        color: widget.color,
                      ),
                    ),
                  );
                },
              ),

              if (!widget.isLeft) ...[
                // Card and team name on right
                Container(
                  width: 85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        widget.imagePath,
                        width: 50,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      Text(
                        widget.team,
                        style: TextStyle(
                          color: widget.color,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        '${widget.score}',
                        style: TextStyle(
                          color: widget.color,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: widget.color.withOpacity(0.5),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ), // const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class Particle {
  final int id;
  final double initialX;
  final double initialY;
  final double speed;
  final double angle;

  Particle({
    required this.id,
    required this.initialX,
    required this.initialY,
    required this.speed,
    required this.angle,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Animation<double> animation;
  final Color color;

  ParticlePainter({
    required this.particles,
    required this.animation,
    required this.color,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    for (var particle in particles) {
      final progress = (animation.value + particle.id / particles.length) % 1.0;
      final x = particle.initialX +
          math.cos(particle.angle) * particle.speed * progress * size.width;
      final y = particle.initialY +
          math.sin(particle.angle) * particle.speed * progress * size.height;

      final particleSize = (1 - progress) * 4;
      canvas.drawCircle(
        Offset(x + size.width / 2, y + size.height),
        particleSize,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}
