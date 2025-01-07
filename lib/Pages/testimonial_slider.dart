import 'dart:async';

import 'package:flutter/material.dart';

class TestimonialsSlider extends StatefulWidget {
  final List<Map<String, String>> testimonials = [
    {
      'text': 'Great game!',
      'author': 'User 1',
    },
    {
      'text': 'Love the gameplay',
      'author': "User 2",
    },
    {
      'text': 'Very addictive',
      'author': 'User 3',
    },
    {
      'text': 'Amazing graphics',
      'author': 'User 4',
    },
    {
      'text': 'Best game ever',
      'author': 'User 5',
    },
  ];

  TestimonialsSlider({super.key});

  @override
  _TestimonialsSliderState createState() => _TestimonialsSliderState();
}

class _TestimonialsSliderState extends State<TestimonialsSlider> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_currentPage < widget.testimonials.length - 1) {
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
      height: 150, // Adjust height as needed
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.testimonials.length,
        itemBuilder: (context, index) {
          final testimonial = widget.testimonials[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 300, // Adjust width as needed
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white24,
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
                  const Icon(Icons.person, size: 40, color: Colors.white),
                  const SizedBox(height: 10),
                  Text(
                    testimonial['text'] ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    testimonial['author'] ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
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
