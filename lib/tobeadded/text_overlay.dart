import 'package:flutter/material.dart';

class HeaderWithBorder extends StatelessWidget {
  final String text;
  final Color borderColor;

  const HeaderWithBorder({
    super.key,
    required this.text,
    this.borderColor =
        const Color.fromARGB(255, 102, 44, 144), // Purple color from image
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top border that spans full width
        Container(
          width: double.infinity,
          height: 2, // Border thickness
          color: borderColor,
        ),
        Center(
          child: CenteredTextOverlay(text: text),
        ),
      ],
    );
  }
}

class CenteredTextOverlay extends StatelessWidget {
  final String text;

  const CenteredTextOverlay({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 52,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/images/background.png'),
          fit: BoxFit.contain,
        ),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
