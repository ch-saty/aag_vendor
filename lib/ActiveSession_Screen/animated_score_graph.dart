import 'package:flutter/material.dart';

class AnimatedTeamScore extends StatefulWidget {
  final String team;
  final int score;
  final Color color;
  final bool isLeft;

  const AnimatedTeamScore({
    super.key,
    required this.team,
    required this.score,
    required this.color,
    required this.isLeft,
  });

  @override
  State<AnimatedTeamScore> createState() => _AnimatedTeamScoreState();
}

class _AnimatedTeamScoreState extends State<AnimatedTeamScore>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnimation;
  late Animation<double> _opacityAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _heightAnimation = Tween<double>(
      begin: 0,
      end: widget.score / 20,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0),
    ));

    Future.delayed(const Duration(milliseconds: 200), () {
      _controller.forward();
    });
  }

  @override
  void didUpdateWidget(AnimatedTeamScore oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.score != widget.score) {
      _heightAnimation = Tween<double>(
        begin: oldWidget.score / 20,
        end: widget.score / 20,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.isLeft)
                FadeTransition(
                  opacity: _opacityAnimation,
                  child: Image.asset('lib/images/ch.png', height: 30),
                ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Background container showing target height
                  Container(
                    height: widget.score / 20,
                    width: 30,
                    decoration: BoxDecoration(
                      color: widget.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  // Animated growing bar
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 200),
                        tween: ColorTween(
                          begin: widget.color,
                          end: _isHovered
                              ? widget.color.withOpacity(0.7)
                              : widget.color,
                        ),
                        builder: (context, Color? color, _) {
                          return Container(
                            height: _heightAnimation.value,
                            width: _isHovered ? 35 : 30,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: _isHovered
                                  ? [
                                      BoxShadow(
                                        color: widget.color.withOpacity(0.3),
                                        blurRadius: 8,
                                        spreadRadius: 2,
                                      )
                                    ]
                                  : null,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              if (!widget.isLeft)
                FadeTransition(
                  opacity: _opacityAnimation,
                  child: Image.asset('lib/images/ch.png', height: 30),
                ),
            ],
          ),
          const SizedBox(height: 8),
          FadeTransition(
            opacity: _opacityAnimation,
            child: Column(
              children: [
                Text(
                  widget.team,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 200),
                      tween: Tween<double>(
                        begin: 18,
                        end: _isHovered ? 20 : 18,
                      ),
                      builder: (context, double fontSize, _) {
                        return Text(
                          (widget.score * _controller.value).toInt().toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
