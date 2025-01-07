import 'package:flutter/material.dart';

class AnimatedPulseImage extends StatefulWidget {
  final String imagePath;
  final double height;
  final double width;
  final Duration animationDuration;
  final double minScale;
  final double maxScale;

  const AnimatedPulseImage({
    super.key,
    required this.imagePath,
    this.height = 306,
    this.width = 311,
    this.animationDuration = const Duration(milliseconds: 700),
    this.minScale = 1.1,
    this.maxScale = 1.3,
  });

  @override
  _AnimatedPulseImageState createState() => _AnimatedPulseImageState();
}

class _AnimatedPulseImageState extends State<AnimatedPulseImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    // Initialize Animation Controller
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat(reverse: true); // Makes the scale animation pulse

    _scaleAnimation =
        Tween<double>(begin: widget.minScale, end: widget.maxScale).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Delay to trigger fade-in effect
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _visible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(seconds: 1),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Image.asset(
          widget.imagePath,
          height: widget.height,
          width: widget.width,
        ),
      ),
    );
  }
}
