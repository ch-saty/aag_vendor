import 'dart:async';

import 'package:flutter/material.dart';

class PrizesSlider extends StatefulWidget {
  final List<Map<String, String>> prizes = [
    {
      'text': 'First Prize',
      'author': 'Amount 1',
    },
    {
      'text': 'Refer and earn',
      'author': "Upto thousands",
    },
    {
      'text': 'Second Prize',
      'author': 'Amount 2',
    },
    {
      'text': 'Third Prize',
      'author': 'Amount 2',
    },
    {
      'text': 'And Many',
      'author': 'More with Millions',
    },
  ];

  PrizesSlider({super.key});

  @override
  _PrizesSliderState createState() => _PrizesSliderState();
}

class _PrizesSliderState extends State<PrizesSlider> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_currentPage < widget.prizes.length - 1) {
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
      height: 140, // Adjust height as needed
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.prizes.length,
        itemBuilder: (context, index) {
          final prizes = widget.prizes[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 100, // Adjust width as needed
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
                  const Icon(Icons.monetization_on,
                      size: 40, color: Colors.green),
                  const SizedBox(height: 10),
                  Text(
                    prizes['text'] ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    prizes['author'] ?? '',
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
