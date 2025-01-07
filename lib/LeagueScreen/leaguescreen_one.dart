// ignore_for_file: unused_import, unused_field

import 'dart:math';

import 'package:AAG/LeagueScreen/opponentmatchmaking.dart';
import 'package:AAG/PublishGameScreen/gamescreen2.dart';
import 'package:flutter/material.dart';
import 'package:AAG/PublishGameScreen/publishgamescreen.dart';
import 'package:AAG/PublishGameScreen/scheduledgamescreen.dart';
import 'package:AAG/tobeadded/gradient_button.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PublishLeagueScreen extends StatefulWidget {
  const PublishLeagueScreen({super.key});

  @override
  PublishLeagueScreenState createState() => PublishLeagueScreenState();
}

class PublishLeagueScreenState extends State<PublishLeagueScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int selectedThemeIndex = -1;
  int selectedFeeIndex = -1;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? scheduledInfo;
  late AnimationController _gradientAnimationController;
  late Animation<double> _gradientAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation1;
  late Animation<Color?> _colorAnimation2;
  @override
  void initState() {
    super.initState();
    // Initialize tab controller with same length as Ludo screen
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        setState(() {}); // Rebuild on tab change
      });

    _gradientAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    // Setup animations with same configurations
    _setupAnimations();
  }

  void _setupAnimations() {
    _gradientAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * 3.14159,
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
          "LEAGUES",
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
              tabs: const [
                Tab(text: 'THEMES'),
                Tab(text: 'PRIZE POOL'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildThemesView(),
                  _buildEntryFeesView(),
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

  Widget _buildEntryFeesView() {
    final fees = [2, 3, 4, 5, 6, 8, 10, 50, 100];

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
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFeeIndex = index;
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
                                'lib/images/g1.png',
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
                    ).animate().fadeIn(delay: (100 * index).ms).scale();
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.3,
                  vertical: MediaQuery.of(context).size.width * 0.05),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OpponentSearchScreen(
                                    poolPrize:
                                        (selectedFeeIndex + 2).toString(),
                                  )),
                        );
                      },
                      text: 'Next',
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
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
                'Locked',
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
}
