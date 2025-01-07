// ignore_for_file: constant_identifier_names

import 'package:AAG/HomeScreen/new_homescreen.dart';
import 'package:AAG/LeagueScreen/leaguescreen_one.dart';
import 'package:AAG/PublishGameScreen/gamescreen2.dart';
import 'package:AAG/TournamentScreen/tournamentscreen_one.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

// import '../HomeScreen/new_homescreen.dart';

enum HistoryType { Games, Leagues, Tournament }

class PublishGamesScreen extends StatefulWidget {
  const PublishGamesScreen({super.key});

  @override
  _PublishGamesScreenState createState() => _PublishGamesScreenState();
}

class _PublishGamesScreenState extends State<PublishGamesScreen> {
  int revealedCount = 1;

  void incrementCounter() {
    setState(() {
      if (revealedCount < 5) {
        revealedCount++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    // final horizontalPadding = screenSize.width * 0.02; // 2% of screen width
    // final verticalSpacing = screenSize.height * 0.02; // 2% of screen height
    // final enhancedSpacing = screenSize.height * 0.03; // 3% for enhanced spacing

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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              _buildDailyLimit(context),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'lib/images/games_section.png',
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Games',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PublishLudoScreen()),
                          );
                        },
                        child: const AvailableGames()),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'lib/images/leagues-01.png',
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Leagues',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PublishLeagueScreen()),
                          );
                        },
                        child: const AvailableGames()),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'lib/images/Tournament.png',
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Tournament',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PublishTournamentscreen()),
                          );
                        },
                        child: const AvailableGames()),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDailyLimit(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height * 0.18,
      width: screenSize.width * 0.9,
      margin: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.purple.withOpacity(0.5),
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.white30,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.purple.shade900,
                      Colors.purple.shade800,
                      Colors.purple.shade600,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'DAILY LIMIT',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            width: 2,
                            height: 20,
                            color: Colors.white,
                          ),
                          Text(
                            '$revealedCount/5',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    5,
                    (index) => FlipCard(
                      index: index,
                      isRevealed: index < revealedCount,
                      onFlip: incrementCounter,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AvailableGames extends StatelessWidget {
  final Color? backgroundColor;

  const AvailableGames({super.key, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor, // Apply the background color here
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: const [
            GameCard(
              // title: 'Ludo Classic',
              imagePath: 'lib/images/ludo.png',
              height: 100,
            ),
            SizedBox(width: 10),
            GameCard(
              // title: 'Snakes & Ladders',
              imagePath: 'lib/images/snakes.png',
              height: 100,
            ),
            SizedBox(width: 10),
            GameCard(
              // title: 'Ludo Classic',
              imagePath: 'lib/images/ludo.png',
              height: 100,
            ),
            SizedBox(width: 10),
            GameCard(
              // title: 'Snakes & Ladders',
              imagePath: 'lib/images/snakes.png',
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}

class FlipCard extends StatefulWidget {
  final int index;
  final bool isRevealed;
  final VoidCallback onFlip;

  const FlipCard({
    super.key,
    required this.index,
    required this.isRevealed,
    required this.onFlip,
  });

  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isRevealed = false;
  late Timer _gradientTimer;
  double _gradientPosition = -1.0;

  @override
  void initState() {
    super.initState();
    _isRevealed = widget.isRevealed;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    if (_isRevealed) {
      _controller.value = 1.0;
    }
    _gradientTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        _gradientPosition += 0.02;
        if (_gradientPosition >= 2.0) _gradientPosition = -1.0;
      });
    });
  }

  @override
  void didUpdateWidget(FlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRevealed != oldWidget.isRevealed) {
      setState(() {
        _isRevealed = widget.isRevealed;
        if (_isRevealed) {
          _controller.value = 1.0;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!_isRevealed) {
          setState(() {
            _isRevealed = true;
          });
          _controller.forward();
          widget.onFlip(); // Call the callback when card is flipped
        }
      },
      child: Container(
        width: 60,
        height: 80,
        // decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(10),
        // border: Border.all(
        //   color: Colors.purple.withOpacity(0.5),
        //   width: 2,
        // ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.purple.withOpacity(0.3),
        //     blurRadius: 2,
        //     spreadRadius: 1,
        //   ),
        // ],
        // ),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final angle = _animation.value * pi;
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle),
              alignment: Alignment.center,
              child: angle >= pi / 2
                  ? Transform(
                      transform: Matrix4.identity()..rotateY(pi),
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          height: 80,
                          width: 60,
                          'lib/images/g1.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin:
                              Alignment(_gradientPosition, _gradientPosition),
                          end: Alignment(
                              _gradientPosition + 1, _gradientPosition + 1),
                          colors: [
                            Colors.purple.shade800,
                            Colors.purple.shade400,
                            Colors.purple.shade800,
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '?',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _gradientTimer.cancel();
    super.dispose();
  }
}
