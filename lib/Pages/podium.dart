import 'package:flutter/material.dart';

class PodiumPage extends StatelessWidget {
  const PodiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPodiumElement(
            color: Colors.white,
            size: Size(200, 50),
            elevation: 8,
          ),
          SizedBox(height: 20),
          _buildPodiumElement(
            color: Colors.white,
            size: Size(250, 70),
            elevation: 12,
          ),
          SizedBox(height: 20),
          _buildPodiumElement(
            color: Colors.white,
            size: Size(300, 90),
            elevation: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumElement({
    required Color color,
    required Size size,
    required double elevation,
  }) {
    return Transform(
      transform: Matrix4.identity()
        ..translate(0.0, 0.0, elevation / 2)
        ..rotateX(0.1),
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: elevation,
              offset: Offset(0, elevation / 2),
            ),
          ],
        ),
      ),
    );
  }
}
