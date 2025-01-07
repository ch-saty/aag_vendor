// ignore_for_file: unused_field

import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class PromotionalsSlider extends StatefulWidget {
  final List<Map<String, String>> promotions = [
    {'image': 'lib/images/banner.png'},
    {'image': 'lib/images/banner2.png'},
  ];

  PromotionalsSlider({super.key});

  @override
  _PromotionalsSliderState createState() => _PromotionalsSliderState();
}

class _PromotionalsSliderState extends State<PromotionalsSlider>
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
    final screenHeight = MediaQuery.of(context).size.height * 0.55;
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight * 0.55, // 55% of the screen height
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
                fit: BoxFit.fill, // Ensure image fills the space
                height: screenHeight * 0.55, // Height based on screen height
                width: screenWidth, // Full width of the screen
              );
            },
          ),

          // Positioned dot indicator at the bottom of the image
          Positioned(
            bottom: 56,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.promotions.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: _currentPage == index ? 8 : 5, // Size of dots
                    height: _currentPage == index ? 8 : 5, // Size of dots
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          _currentPage == index ? Colors.orange : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}






// 

// 



///////////////////////////////////////////////////////////////////////////////////



// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:math' as math;

// class PromotionalsSlider extends StatefulWidget {
//   final List<Map<String, String>> promotions = [
//     {
//       'image': 'lib/images/banner.png',
//     },
//     {
//       'image': 'lib/images/banner2.png',
//     },
//   ];

//   PromotionalsSlider({super.key});

//   @override
//   _PromotionalsSliderState createState() => _PromotionalsSliderState();
// }

// class _PromotionalsSliderState extends State<PromotionalsSlider> with SingleTickerProviderStateMixin {
//   late PageController _pageController;
//   late Timer _timer;
//   int _currentPage = 0;
//   late AnimationController _animationController;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: 0);
//     _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
//       if (_currentPage < widget.promotions.length - 1) {
//         _currentPage++;
//       } else {
//         _currentPage = 0;
//       }
//       _pageController.animateToPage(
//         _currentPage,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeIn,
//       );
//     });
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat();
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     _pageController.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(0),
//           child: SizedBox(
//             height: MediaQuery.of(context).size.height / 2,
//             width: MediaQuery.of(context).size.width,
//             child: Stack(
//               children: [
//                 PageView.builder(
//                   controller: _pageController,
//                   scrollDirection: Axis.horizontal,
//                   itemCount: widget.promotions.length,
//                   onPageChanged: (int page) {
//                     setState(() {
//                       _currentPage = page;
//                     });
//                   },
//                   itemBuilder: (context, index) {
//                     final promotion = widget.promotions[index];
//                     return Stack(
//                       children: [
//                         Center(
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(20),
//                             child: Image.asset(
//                               promotion['image'] ?? '',
//                               fit: BoxFit.cover,
//                               height: MediaQuery.of(context).size.height / 2.2,
//                               width: MediaQuery.of(context).size.width,
//                             ),
//                           ),
//                         ),
//                         Positioned.fill(
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(20),
//                             child: CustomPaint(
//                               painter: BorderPainter(),
//                               child: Container(),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           left: 0,
//                           right: 0,
//                           child: AnimatedBuilder(
//                             animation: _animationController,
//                             builder: (context, child) {
//                               return CustomPaint(
//                                 size: Size(MediaQuery.of(context).size.width, 50),
//                                 painter: WavePainter(animationValue: _animationController.value),
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(
//               widget.promotions.length,
//               (index) => Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 300),
//                   width: 10,
//                   height: 10,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: _currentPage == index ? Colors.orange : Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class BorderPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final rect = Rect.fromLTRB(0, 0, size.width, size.height);
//     final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(20));

//     final paint = Paint()
//       ..color = Colors.black
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 4;

//     canvas.drawRRect(rrect, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }

// class WavePainter extends CustomPainter {
//   final double animationValue;

//   WavePainter({required this.animationValue});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.orange.withOpacity(0.5)
//       ..style = PaintingStyle.fill;

//     final path = Path();

//     path.moveTo(0, size.height);

//     for (double i = 0; i < size.width; i++) {
//       path.lineTo(
//         i,
//         size.height - 20 * math.sin((i / size.width * 2 * math.pi) + animationValue * 2 * math.pi) - 20
//       );
//     }

//     path.lineTo(size.width, size.height);
//     path.close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// import 'package:flutter/material.dart';
// import 'dart:async';

// class PromotionalsSlider extends StatefulWidget {
//   final List<Map<String, String>> promotions = [
//     {
//       'image': 'lib/images/vector1.png',
//     },
//     {
//       'image': 'lib/images/vector2.png',
//     },
//   ];

//   PromotionalsSlider({super.key});

//   @override
//   _PromotionalsSliderState createState() => _PromotionalsSliderState();
// }

// class _PromotionalsSliderState extends State<PromotionalsSlider> {
//   late PageController _pageController;
//   late Timer _timer;
//   int _currentPage = 0;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: 0);
//     _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
//       if (_currentPage < widget.promotions.length - 1) {
//         _currentPage++;
//       } else {
//         _currentPage = 0;
//       }
//       _pageController.animateToPage(
//         _currentPage,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeIn,
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(0),
//           child: SizedBox(
//             height: MediaQuery.of(context).size.height / 2,
//             width: MediaQuery.of(context).size.width,
//             child: PageView.builder(
//               controller: _pageController,
//               scrollDirection: Axis.horizontal,
//               itemCount: widget.promotions.length,
//               onPageChanged: (int page) {
//                 setState(() {
//                   _currentPage = page;
//                 });
//               },
//               itemBuilder: (context, index) {
//                 final promotion = widget.promotions[index];
//                 return Center(
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: Image.asset(
//                       promotion['image'] ?? '',
//                       fit: BoxFit.cover,
//                       height: MediaQuery.of(context).size.height / 2.2,
//                       width: MediaQuery.of(context).size.width,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(
//               widget.promotions.length,
//               (index) => Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 300),
//                   width: 10,
//                   height: 10,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: _currentPage == index ? Colors.orange : Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
