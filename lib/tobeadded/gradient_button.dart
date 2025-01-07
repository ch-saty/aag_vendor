import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback? onTap;
  final String text;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 140, // Minimum width
            minHeight: 50, // Minimum height
          ),
          // color: const Color.fromARGB(255, 255, 146, 29),

          // rgba(255, 146, 29, 1),
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.deepPurple, width: 2),
            color: const Color.fromARGB(255, 255, 146, 29),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ElevatedButton(
            onPressed: widget.onTap ?? () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: _getBackgroundColor(),
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              widget.text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (_isPressed) {
      return Colors.deepPurple.shade700; // Darker shade when pressed
    } else if (_isHovered) {
      return Colors.deepPurple; // Original deep purple when hovered
    } else {
      return Colors.transparent; // Transparent when neither hovered nor pressed
    }
  }
}
