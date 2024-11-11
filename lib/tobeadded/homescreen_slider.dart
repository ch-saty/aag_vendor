// ignore_for_file: unused_field

import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class PromotionalsSlider2 extends StatefulWidget {
  final List<Map<String, String>> promotions = [
    {'image': 'lib/images/hsb1.png'},
    {'image': 'lib/images/hsb2.png'},
    {'image': 'lib/images/hsb1.png'},
  ];

  PromotionalsSlider2({super.key});

  @override
  _PromotionalsSlider2State createState() => _PromotionalsSlider2State();
}

class _PromotionalsSlider2State extends State<PromotionalsSlider2>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;
  late AnimationController _animationController;
  ui.Image? _currentImage;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < widget.promotions.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeIn,
      );
    });
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _loadImages();
  }

  Future<void> _loadImages() async {
    for (var promotion in widget.promotions) {
      final image = await _loadImage(promotion['image']!);
      promotion['loaded_image'] = image as String;
    }
    setState(() {});
  }

  Future<ui.Image> _loadImage(String assetName) async {
    final data = await DefaultAssetBundle.of(context).load(assetName);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Responsive sizing calculations
    final screenHeight = MediaQuery.of(context).size.height * 0.30;
    final screenWidth = MediaQuery.of(context).size.width * 0.90;

    return SizedBox(
      height: screenHeight, // 55% of the screen height
      width: screenWidth, // Full width of the screen
      child: Stack(
        children: [
          // Image slider
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.promotions.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
                _currentImage =
                    widget.promotions[page]['loaded_image'] as ui.Image?;
              });
            },
            itemBuilder: (context, index) {
              final promotion = widget.promotions[index];
              return Image.asset(
                promotion['image'] ?? '',
                fit: BoxFit.contain, // Ensure image fills the space
                height: screenHeight * 0.55, // Height based on screen height
                width: screenWidth, // Full width of the screen
              );
            },
          ),
          // const SizedBox(height: 15),
          // Positioned dot indicator at the bottom of the image
          //   Positioned(
          //     bottom:
          //         0, // Adjust this to set how far from the bottom you want the dots
          //     left: 0,
          //     right: 0,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: List.generate(
          //         widget.promotions.length,
          //         (index) => Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 3),
          //           child: AnimatedContainer(
          //             duration: const Duration(milliseconds: 300),
          //             width: _currentPage == index ? 8 : 5, // Size of dots
          //             height: _currentPage == index ? 8 : 5, // Size of dots
          //             decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               color:
          //                   _currentPage == index ? Colors.orange : Colors.white,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
