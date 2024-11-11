import 'package:flutter/material.dart';
import 'package:AAG/Pages/splashscreen.dart';

void main() {
  runApp(const AAG());
}

class AAG extends StatelessWidget {
  const AAG({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aapka Apna Game',
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Splashscreen(), // Replace with your main content widget
          ],
        ),
      ),
    );
  }
}
