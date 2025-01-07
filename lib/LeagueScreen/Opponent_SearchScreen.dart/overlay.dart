import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OpponentStatusContainer2 extends StatelessWidget {
  final String text;
  final Color borderColor;

  const OpponentStatusContainer2({
    super.key,
    required this.text,
    this.borderColor = const Color.fromRGBO(255, 146, 29, 1),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top border that spans full width
        Container(
          width: double.infinity,
          height: 1.5, // Border thickness
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
      // height: 42,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/images/background.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.russoOne(
            textStyle: const TextStyle(
                fontSize: 12, color: Colors.white, fontWeight: FontWeight.w200),
          ),
        ),
      ),
    );
  }
}