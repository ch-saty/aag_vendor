import 'package:flutter/material.dart';

class SelectableGradientContainer extends StatefulWidget {
  const SelectableGradientContainer({super.key});

  @override
  _SelectableGradientContainerState createState() =>
      _SelectableGradientContainerState();
}

class _SelectableGradientContainerState
    extends State<SelectableGradientContainer> {
  bool isBasicSelected = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 69,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border:
            Border.all(color: const Color.fromRGBO(233, 116, 17, 1), width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isBasicSelected = true),
              child: isBasicSelected
                  ? MovingGradientBorder(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 65,
                      gradientColors: const [
                        Color.fromRGBO(131, 65, 10, 1),
                        Color.fromRGBO(233, 116, 17, 1),
                        Color.fromRGBO(136, 68, 10, 1),
                      ],
                      child: _buildOption('BASIC', isBasicSelected, true),
                    )
                  : _buildOption('BASIC', isBasicSelected, true),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isBasicSelected = false),
              child: !isBasicSelected
                  ? MovingGradientBorder(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 65,
                      gradientColors: const [
                        Color.fromRGBO(131, 65, 10, 1),
                        Color.fromRGBO(233, 116, 17, 1),
                        Color.fromRGBO(136, 68, 10, 1),
                      ],
                      child: _buildOption(
                          'Game Limit 4/5', !isBasicSelected, false),
                    )
                  : _buildOption('Game Limit 4/5', !isBasicSelected, false),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(String text, bool isSelected, bool isLeft) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          left: isLeft ? const Radius.circular(16) : Radius.zero,
          right: !isLeft ? const Radius.circular(16) : Radius.zero,
        ),
        color: isSelected ? Colors.transparent : Colors.black,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            color: isSelected
                ? Colors.white
                : const Color.fromRGBO(233, 116, 17, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MovingGradientBorder extends StatefulWidget {
  final Widget child;
  final double width;
  final double height;
  final List<Color> gradientColors;

  const MovingGradientBorder({
    super.key,
    required this.child,
    required this.width,
    required this.height,
    required this.gradientColors,
  });

  @override
  _MovingGradientBorderState createState() => _MovingGradientBorderState();
}

class _MovingGradientBorderState extends State<MovingGradientBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
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
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.gradientColors,
              stops: [
                _controller.value - 0.3,
                _controller.value,
                _controller.value + 0.3,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: widget.child,
          ),
        );
      },
    );
  }
}
