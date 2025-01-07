import 'dart:async';

import 'package:flutter/material.dart';

class PromotionalsSlider extends StatefulWidget {
  final List<Map<String, String>> promotions = [
    {
      'image': 'lib/images/promo1.jpg',
    },
    {
      'image': 'lib/images/promo2.jpg',
    },
    {
      'image': 'lib/images/promo3.jpg',
    },
    {
      'image': 'lib/images/promo2.jpg',
    }
  ];

  PromotionalsSlider({super.key});

  @override
  _PromotionalsSliderState createState() => _PromotionalsSliderState();
}

class _PromotionalsSliderState extends State<PromotionalsSlider> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < widget.promotions.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Adjust height as needed
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.promotions.length,
        itemBuilder: (context, index) {
          final promotion = widget.promotions[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity, // Adjust width as needed
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    promotion['image'] ?? '',
                    height: 160, // Adjust height as needed
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
