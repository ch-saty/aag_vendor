import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedLottieButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final String lottieAsset;

  const AnimatedLottieButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.lottieAsset,
  });

  @override
  _AnimatedLottieButtonState createState() => _AnimatedLottieButtonState();
}

class _AnimatedLottieButtonState extends State<AnimatedLottieButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isExpanded = false;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = true;
    });
    _animationController.forward().then((_) {
      widget.onPressed();
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isExpanded = false;
          });
          _animationController.reverse();
        }
      });
    });
  }

  void _onHover(bool hovering) {
    setState(() {
      _isHovering = hovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: _handleTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: _isExpanded ? 200 : 150,
          height: 60,
          decoration: BoxDecoration(
            gradient: _isHovering
                ? const LinearGradient(
                    colors: [Colors.purple, Colors.deepPurple],
                  )
                : null,
            color: _isHovering ? Colors.purple : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.purple,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: _isExpanded
                ? Lottie.asset(
                    widget.lottieAsset,
                    controller: _animationController,
                    width: 50,
                    height: 50,
                  )
                : Text(
                    widget.text,
                    style: TextStyle(
                      color: _isHovering ? Colors.white : Colors.purple,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
