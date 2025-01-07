import 'dart:math';

import 'package:flutter/material.dart';

class PlanCard extends StatefulWidget {
  final Map<String, dynamic> plan;
  final bool isSelected;
  final double price;
  final bool isMonthly;

  const PlanCard({
    super.key,
    required this.plan,
    required this.isSelected,
    required this.price,
    required this.isMonthly,
  });

  @override
  State<PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends State<PlanCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _borderAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _borderAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * pi,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Color> getGradientColors() {
    switch (widget.plan['name'].toString().toUpperCase()) {
      case 'STANDARD':
        return [
          Color.fromARGB(255, 113, 47, 160),
          Color.fromARGB(255, 54, 47, 145),
        ];
      case 'PRO':
        return [
          Color.fromARGB(255, 239, 38, 209),
          Color.fromARGB(255, 255, 111, 79),
        ];
      case 'ELITE':
        return [
          Color.fromARGB(155, 239, 105, 82),
          Color.fromARGB(155, 255, 249, 71),
        ];
      default:
        return [
          Color.fromARGB(255, 113, 47, 160),
          Color.fromARGB(255, 54, 47, 145),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedBuilder(
          animation: _borderAnimation,
          builder: (context, child) {
            return CustomPaint(
              painter: GlowingBorderPainter(
                animation: _borderAnimation.value,
                gradientColors: getGradientColors(),
                isSelected: widget.isSelected,
              ),
              child: Container(
                margin: const EdgeInsets.all(2), // Space for the border
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: getGradientColors()
                        .map((color) => color.withOpacity(0.15))
                        .toList(),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Plan Header
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: _buildPlanHeader(widget.plan, widget.price),
                    ),
                    // Features List
                    _buildFeaturesList(widget.plan),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlanHeader(Map<String, dynamic> plan, double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  plan['name'] as String,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                if (plan['isPopular'] == true) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'POPULAR',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${plan["followers"]} Followers Required',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '₹${price.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              widget.isMonthly
                  ? '/month'
                  : '/year', // Updated to use widget.isMonthly
              style: const TextStyle(
                  color: Colors.white70, fontSize: 14, letterSpacing: 0),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeaturesList(Map<String, dynamic> plan) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Features',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(
            (plan['features'] as List).length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: plan['gradientColors'][0] as Color,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      (plan['features'] as List)[index] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GlowingBorderPainter extends CustomPainter {
  final double animation;
  final List<Color> gradientColors;
  final bool isSelected;

  GlowingBorderPainter({
    required this.animation,
    required this.gradientColors,
    required this.isSelected,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (!isSelected) return;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final roundedRect = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(16),
    );

    // Create a gradient that rotates
    final gradient = SweepGradient(
      transform: GradientRotation(animation),
      colors: [
        Colors.white.withOpacity(0.1),
        Colors.white.withOpacity(0.8),
        Colors.white.withOpacity(0.1),
      ],
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw the glowing border
    canvas.drawRRect(roundedRect, paint);

    // Draw a second border with the plan's gradient colors
    final borderGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: gradientColors,
    );

    final borderPaint = Paint()
      ..shader = borderGradient.createShader(rect)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(roundedRect, borderPaint);
  }

  @override
  bool shouldRepaint(GlowingBorderPainter oldDelegate) {
    return animation != oldDelegate.animation ||
        isSelected != oldDelegate.isSelected;
  }
}
