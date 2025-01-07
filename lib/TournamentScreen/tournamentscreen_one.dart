// ignore_for_file: unused_import, unused_field

import 'dart:math';

import 'package:AAG/TournamentScreen/tournament_configured.dart';
import 'package:flutter/material.dart';
import 'package:AAG/PublishGameScreen/publishgamescreen.dart';
import 'package:AAG/PublishGameScreen/scheduledgamescreen.dart';
import 'package:AAG/tobeadded/gradient_button.dart';
import 'package:intl/intl.dart';

import '../PublishGameScreen/gamescreen2.dart';

class PublishTournamentscreen extends StatefulWidget {
  const PublishTournamentscreen({super.key});

  @override
  PublishTournamentscreenState createState() => PublishTournamentscreenState();
}

class PublishTournamentscreenState extends State<PublishTournamentscreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int selectedThemeIndex = 0;
  int selectedFeeIndex = 0;
  int selectedParticipantIndex = -1;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? scheduledInfo;
  int selectedFee = 2;
  final List<int> fees = [2, 3, 4, 5, 6, 8, 10, 50, 100];
  final List<int> participantCounts = [8, 16, 32, 64, 128, 256, 512, 1024];
  late AnimationController _gradientAnimationController;
  late Animation<double> _gradientAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation1;
  late Animation<Color?> _colorAnimation2;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _gradientAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _gradientAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * 3.14159, // Full rotation in radians
    ).animate(CurvedAnimation(
      parent: _gradientAnimationController,
      curve: Curves.easeInOutCubic,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _gradientAnimationController,
      curve: Curves.elasticOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _gradientAnimationController,
      curve: Curves.easeInOutSine,
    ));

    _colorAnimation1 = ColorTween(
      begin: Colors.purple[900],
      end: Colors.deepPurple[700],
    ).animate(CurvedAnimation(
      parent: _gradientAnimationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeInOutCubic),
    ));

    _colorAnimation2 = ColorTween(
      begin: Colors.deepPurple[700],
      end: Colors.purple[900],
    ).animate(CurvedAnimation(
      parent: _gradientAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeInOutCubic),
    ));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _gradientAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "PUBLISH GAMES",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 102, 44, 144),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Custom AppBar section
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.orange,
              indicatorWeight: 3,
              labelColor: Colors.orange,
              unselectedLabelColor: Colors.black,
              onTap: (_) {
                _tabController.index = _tabController.previousIndex;
              },
              tabs: const [
                Tab(text: 'THEMES'),
                Tab(text: 'ENTRY FEES'),
                Tab(text: 'PARTICIPANTS'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                // physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildThemesView(),
                  _buildEntryFeesView(),
                  _buildParticipantsView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemesView() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double gridAspectRatio = constraints.maxWidth > 600 ? 0.7 : 0.5;

        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.04,
                    vertical: constraints.maxWidth * 0.08),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constraints.maxWidth > 600 ? 4 : 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: gridAspectRatio,
                  ),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedThemeIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: selectedThemeIndex == index
                                ? Color.fromRGBO(255, 146, 29, 1)
                                : Color.fromARGB(255, 102, 44, 144),
                            /**
                                 * Color.fromRGBO(255, 146, 29, 1),


       Color.fromARGB(255, 102, 44, 144),
                                 */
                            width: selectedThemeIndex == index ? 4 : 1,
                          ),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.asset(
                                'lib/images/jungle.jpeg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),

                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.purple,
                                      Colors.deepPurple,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(8),
                                  ),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  index < 2 ? 'DEFAULT' : 'NATURE',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            // Lock overlay for locked themes
                            if (index >= 2)
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.black.withOpacity(0.7),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.lock,
                                        color: Colors.white, size: 20),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    _buildHeader(constraints),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                onTap: () {
                  _tabController.animateTo(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                text: 'Next',
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader(BoxConstraints constraints) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 2,
          margin: const EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 102, 44, 144),
                Colors.orange.withOpacity(0.7),
                Color.fromARGB(255, 102, 44, 144),
              ],
            ),
          ),
        ),
        CustomPaint(
          painter: HexagonPainter(
              color: Color.fromARGB(255, 102, 44, 144),
              gridAspectRatio: constraints.maxWidth > 600 ? 0.7 : 0.5,
              constraintMaxWidth: constraints.maxWidth),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              child: Text(
                'Level B',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEntryFeesView() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.04,
                    vertical: constraints.maxWidth * 0.08),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constraints.maxWidth > 600 ? 4 : 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: fees.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFeeIndex = index;
                          selectedFee = fees[index];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: selectedFeeIndex == index
                                ? Colors.orange
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'lib/images/ludo.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.orange, Colors.deepOrange],
                                  ),
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(4),
                                  ),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.currency_rupee,
                                        color: Colors.white, size: 14),
                                    Text(
                                      fees[index].toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                onTap: () {
                  _tabController.animateTo(
                    2,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                text: 'Next',
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildParticipantsView() {
    final participantCounts = [8, 16, 32, 64, 128, 256, 512, 1024];

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.04,
                    vertical: constraints.maxWidth * 0.08),
                itemCount: participantCounts.length,
                itemBuilder: (context, index) {
                  final totalPool = selectedFee;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedParticipantIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: selectedParticipantIndex == index
                              ? Colors.orange
                              : Colors.black,
                          width: selectedParticipantIndex == index ? 2 : 1,
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.purple.withOpacity(0.3),
                            Colors.deepPurple.withOpacity(0.3),
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Leading image
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'lib/images/g1.png',
                                height: 84,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          // Player count section
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'lib/images/playerg.png',
                                width: 50,
                                height: 50,
                              ),
                              Text(
                                '${participantCounts[index]}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          // Pool fee section
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Container(
                                width: 70,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Colors.orange, Colors.deepOrange],
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.currency_rupee,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                      Text(
                                        '$totalPool',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: CustomButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const TournamentConfiguredScreen(),
                      ),
                    );
                  },
                  text: 'Next',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// class CustomButton extends StatelessWidget {
//   final VoidCallback onTap;
//   final String text;

//   const CustomButton({
//     super.key,
//     required this.onTap,
//     required this.text,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 12),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Colors.purple, Colors.deepPurple],
//           ),
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.purple.withOpacity(0.3),
//               spreadRadius: 1,
//               blurRadius: 4,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Center(
//           child: Text(
//             text,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class ComplexGradientPainter extends CustomPainter {
  final Animation<double> animation;
  final Animation<double> rotationAnimation;
  final Animation<double> scaleAnimation;
  final Animation<Color?> colorAnimation1;
  final Animation<Color?> colorAnimation2;

  ComplexGradientPainter({
    required this.animation,
    required this.rotationAnimation,
    required this.scaleAnimation,
    required this.colorAnimation1,
    required this.colorAnimation2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final center = Offset(size.width / 2, size.height / 2);

    // Create multiple gradient layers
    for (int i = 0; i < 3; i++) {
      final double phase = animation.value + (i * 3.14159 / 3);
      final double scale = scaleAnimation.value + (i * 0.02);

      final Gradient gradient = RadialGradient(
        center: Alignment(
          cos(phase) * 0.5,
          sin(phase) * 0.5,
        ),
        colors: [
          colorAnimation1.value ?? Colors.purple[900]!,
          colorAnimation2.value ?? Colors.deepPurple[700]!,
          Colors.purple[500]!.withOpacity(0.5),
          Colors.deepPurple[900]!.withOpacity(0.8),
        ],
        stops: const [0.0, 0.3, 0.6, 1.0],
        radius: 1.5 * scale,
      );

      final Paint paint = Paint()
        ..shader = gradient.createShader(rect)
        ..blendMode = BlendMode.overlay;

      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(rotationAnimation.value * 0.2 * i);
      canvas.scale(scale);
      canvas.translate(-center.dx, -center.dy);
      canvas.drawRect(rect, paint);
      canvas.restore();
    }

    // Add metallic shine effect
    final Paint shinePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment(cos(animation.value), sin(animation.value)),
        end: Alignment(
            cos(animation.value + 3.14159), sin(animation.value + 3.14159)),
        colors: [
          Colors.white.withOpacity(0.0),
          Colors.white.withOpacity(0.2),
          Colors.white.withOpacity(0.0),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(rect)
      ..blendMode = BlendMode.overlay;

    canvas.drawRect(rect, shinePaint);
  }

  @override
  bool shouldRepaint(ComplexGradientPainter oldDelegate) => true;
}
