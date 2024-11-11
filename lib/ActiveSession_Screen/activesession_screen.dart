// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:AAG/ActiveSession_Screen/animated_score_graph.dart';
import 'package:AAG/PublishGameScreen/gamescreen2.dart';
import 'package:AAG/LeagueScreen/leaguescreen_one.dart';
import 'package:AAG/TournamentScreen/tournamentscreen_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';

class ActiveSessionsScreen extends StatefulWidget {
  const ActiveSessionsScreen({super.key});

  @override
  State<ActiveSessionsScreen> createState() => _ActiveSessionsScreenState();
}

class _ActiveSessionsScreenState extends State<ActiveSessionsScreen> {
  int revealedCount = 1;

  @override
  void initState() {
    super.initState();
    // Add a small delay before showing the first popup
    // Future.delayed(Duration(milliseconds: 500), () {
    //   showPopupsSequentially();
    // });
  }

  // void showPopupsSequentially() {
  //   // Show Leagues popup first
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) => LeaguesPopup(),
  //   ).then((_) {
  //     // After Leagues popup is closed, show Ludo popup
  //     Future.delayed(Duration(milliseconds: 300), () {
  //       showDialog(
  //         context: context,
  //         barrierDismissible: false,
  //         builder: (context) => LudoThemePopup(),
  //       ).then((_) {
  //         // After Ludo popup is closed, show Tournament popup
  //         Future.delayed(Duration(milliseconds: 300), () {
  //           showDialog(
  //             context: context,
  //             barrierDismissible: false,
  //             builder: (context) => TournamentPopup(),
  //           );
  //         });
  //       });
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'ACTIVE SESSIONS',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/idkbg.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(
          children: [
            _buildSection(context, 'GAMES', 'lib/images/ic3.png', 2),
            _buildLeagueSection(context, 'LEAGUES', 'lib/images/ic3.png'),
            _buildTournamentSection(
                context, 'TOURNAMENT', 'lib/images/ic3.png'),
          ],
        ),
      ),
    );
  }
}

Widget _buildLeagueSection(
    BuildContext context, String title, String iconPath) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Image.asset(iconPath, width: 24, height: 24),
            const SizedBox(width: 8),
            Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 2,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => const LeaguesPopup(),
                  );
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromRGBO(233, 116, 17, 0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Animate(
                      effects: [
                        ShimmerEffect(
                          duration: 5.seconds,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ],
                      onPlay: (controller) => controller.repeat(),
                      child: GlassmorphicContainer(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: 125,
                        borderRadius: 15,
                        blur: 5,
                        alignment: Alignment.bottomCenter,
                        border: 1.5,
                        linearGradient: LinearGradient(
                          colors: [
                            const Color.fromARGB(255, 64, 243, 133)
                                .withOpacity(0.4),
                            const Color.fromARGB(255, 237, 63, 0)
                                .withOpacity(0.5),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderGradient: LinearGradient(
                          colors: [
                            const Color.fromRGBO(233, 116, 17, 1)
                                .withOpacity(0.5),
                            const Color.fromRGBO(233, 116, 17, 1)
                                .withOpacity(0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 113, 47, 160),
                                Color.fromARGB(255, 54, 47, 145),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color.fromRGBO(233, 116, 17, 1),
                              width: 1.5,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            // Keep your existing Row and its children here
                            child: Row(
                              // Your existing row content remains exactly the same
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Left Team Card
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'lib/images/card.png',
                                      fit: BoxFit.cover,
                                      height: 90,
                                      width: 40,
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'TEAM DHONI',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),

                                // Center Info Column
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    // Prize Pool Row
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // Image.asset('lib/images/prize.png',
                                        //     height: 24, width: 24),
                                        // const SizedBox(width: 8),
                                        const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Prize Pool',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '₹3373',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    // Active Players Row
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // Image.asset('lib/images/team.png',
                                        //     height: 24, width: 24),
                                        // const SizedBox(width: 8),
                                        const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Active Players',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '1500+',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                // Center Game Logo and Entry Fee
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color.fromRGBO(
                                                233, 116, 17, 0.3),
                                            blurRadius: 10,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: Image.asset(
                                          'lib/images/center.png',
                                          height: 60,
                                          width: 60),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 6),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color.fromRGBO(131, 65, 10, 1),
                                            Color.fromRGBO(233, 116, 17, 1),
                                            Color.fromRGBO(136, 68, 10, 1),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        '₹4',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),

                                // Timer Column
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Time Left',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                    const SizedBox(height: 4),
                                    CountdownTimer(), // Create this as a separate StatefulWidget
                                  ],
                                ),

                                // Right Team Card
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 90,
                                      width: 39,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Image.asset(
                                          'lib/images/oppcard.png',
                                          fit: BoxFit.cover),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'TEAM KOHLI',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
              ));
        },
      ),
    ],
  );
}

Widget _buildTournamentSection(
    BuildContext context, String title, String iconPath) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Image.asset(iconPath, width: 24, height: 24),
            const SizedBox(width: 8),
            Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 2,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const TournamentPopup(),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromRGBO(233, 116, 17, 0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Animate(
                  effects: [
                    ShimmerEffect(
                      duration: 5.seconds,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ],
                  onPlay: (controller) => controller.repeat(),
                  child: GlassmorphicContainer(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: 125,
                    borderRadius: 15,
                    blur: 5,
                    alignment: Alignment.bottomCenter,
                    border: 1.5,
                    linearGradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 64, 243, 133)
                            .withOpacity(0.4),
                        const Color.fromARGB(255, 237, 63, 0).withOpacity(0.5),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderGradient: LinearGradient(
                      colors: [
                        const Color.fromRGBO(233, 116, 17, 1).withOpacity(0.5),
                        const Color.fromRGBO(233, 116, 17, 1).withOpacity(0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 113, 47, 160),
                            Color.fromARGB(255, 54, 47, 145),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: const Color.fromRGBO(233, 116, 17, 1),
                          width: 1.5,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Left Team Card
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'lib/images/card.png',
                                  fit: BoxFit.cover,
                                  height: 90,
                                  width: 40,
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'TEAM A',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),

                            // Prize Pool Column
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Prize Pool',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '₹5000',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromRGBO(131, 65, 10, 1),
                                        Color.fromRGBO(233, 116, 17, 1),
                                        Color.fromRGBO(136, 68, 10, 1),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    '₹50',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // VS Logo
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromRGBO(
                                            233, 116, 17, 0.3),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    'lib/images/vs.png',
                                    height: 60,
                                    width: 60,
                                  ),
                                ),
                              ],
                            ),

                            // Timer Column
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Starting in',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                const SizedBox(height: 4),
                                CountdownTimer(), // You'll need to implement this widget
                              ],
                            ),

                            // Right Team Card
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 90,
                                  width: 39,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Image.asset(
                                    'lib/images/oppcard.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'TEAM B',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ],
  );
}

Widget _buildSection(
    BuildContext context, String title, String iconPath, int gameCount) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (title.isNotEmpty)
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Image.asset(iconPath, width: 24, height: 24),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        padding: const EdgeInsets.all(12),
        children: List.generate(
          gameCount,
          (index) => GestureDetector(
            onTap: () {
              // Updated navigation logic based on subtitle
              switch (title) {
                case 'Games':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GamesScreen()),
                  );
                  break;
                case 'Leagues':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LeagueScreen()),
                  );
                  break;
                case 'Tournament':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Tournamentscreen()),
                  );
                  break;
              }
            },
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const LudoThemePopup(),
                );
              },
              child: Container(
                height: 131,
                width: 140,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'lib/images/g1.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

// Create a separate CountdownTimer widget

class TournamentPopup extends StatelessWidget {
  const TournamentPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFF35035A),
              Color(0xFF510985),
              Color(0xFF35035A),
            ],
            stops: [0.1572, 0.5, 0.8753],
          ),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.orange,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'TOURNAMENT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.085),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [],
            // ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'lib/images/xl.png',
                  // height: 200,
                  width: 275,
                  height: 75,
                ),
                // const SizedBox(width: 8),
                // const Text(
                //   'Round 1 Starting',
                //   style: TextStyle(
                //     color: Colors.blue,
                //     fontSize: 14,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),

            const SizedBox(height: 5),
            // Container(
            //   padding: const EdgeInsets.all(20),
            //   decoration: BoxDecoration(
            //     color: Colors.purple[900],
            //     borderRadius: BorderRadius.circular(15),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children:
            //         List.generate(4, (index) => _buildRoundCircle(index + 1)),
            //   ),
            // ),
            // const SizedBox(height: 10),
            const Text(
              '4 Rounds',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.69,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.2),
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.emoji_events, color: Colors.yellow),
                      const SizedBox(width: 5),
                      const Text(
                        '₹3373',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.people, color: Colors.white),
                      const SizedBox(width: 5),
                      const Text(
                        '16/32',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF83410A),
                    Color(0xFFE97411),
                    Color(0xFF88440A),
                  ],
                  stops: [0.071, 0.491, 0.951],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                child: const Text(
                  'Entry Fee ₹3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Column(
              children: [
                Text(
                  'Starting in',
                  style: TextStyle(color: Colors.white),
                ),
                CountdownTimer2(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildRoundCircle(int number) {
  //   return Container(
  //     width: 45,
  //     height: 45,
  //     decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: number == 1 ? Colors.orange : Colors.transparent,
  //       border: Border.all(
  //         color: Colors.blue,
  //         width: 2,
  //       ),
  //     ),
  //     child: Center(
  //       child: Text(
  //         number.toString(),
  //         style: TextStyle(
  //           color: Colors.white,
  //           fontSize: 20,
  //           fontWeight: number == 1 ? FontWeight.bold : FontWeight.normal,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

class LudoThemePopup extends StatelessWidget {
  const LudoThemePopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFF35035A),
              Color(0xFF510985),
              Color(0xFF35035A),
            ],
            stops: [0.1572, 0.5, 0.8753],
          ),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.orange,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'LUDO',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('lib/images/g1.png'),
                      fit: BoxFit.contain,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.people, color: Colors.orange),
                    const SizedBox(height: 5),
                    const Text(
                      'Active Players:',
                      style: TextStyle(color: Colors.white),
                    ),
                    const Text(
                      '1546',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF83410A),
                            Color(0xFFE97411),
                            Color(0xFF88440A),
                          ],
                          stops: [0.071, 0.491, 0.951],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        child: Text(
                          'Entry Fee ₹3',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // const SizedBox(height: 15),
            const SizedBox(height: 15),
            const Column(
              children: [
                Text(
                  'Time Left',
                  style: TextStyle(color: Colors.white),
                ),
                CountdownTimer2(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LeaguesPopup extends StatelessWidget {
  const LeaguesPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFF35035A),
              Color(0xFF510985),
              Color(0xFF35035A),
            ],
            stops: [0.1572, 0.5, 0.8753],
          ),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.orange,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'LEAGUES',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.13),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AnimatedTeamScore(
                    team: 'My TEAM',
                    score: 3000,
                    color: Colors.orange,
                    isLeft: true),
                Column(
                  children: [
                    Image.asset('lib/images/verses.png', height: 100),
                  ],
                ),
                AnimatedTeamScore(
                    team: 'KOHLI TEAM',
                    score: 1000,
                    color: Colors.blue,
                    isLeft: false),
              ],
            ),
            const Divider(color: Colors.white38, thickness: 1),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF712FA0),
                    Color(0xFF362F91),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'IN LEAD',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Icon(Icons.emoji_events, color: Colors.yellow),
                    const Text('₹3373', style: TextStyle(color: Colors.white)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.people, color: Colors.white),
                    const Text('1247', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Column(
              children: [
                Text('Time Left', style: TextStyle(color: Colors.white)),
                CountdownTimer(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildTeamScore(String team, int score, Color color, bool isLeft) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.end,
  //     children: [
  //       Row(
  //         crossAxisAlignment: CrossAxisAlignment.end,
  //         children: [
  //           if (isLeft) Image.asset('lib/images/ch.png', height: 30),
  //           Container(
  //             height: score / 20, // Increased height
  //             width: 30, // Increased width
  //             color: color,
  //           ),
  //           if (!isLeft) Image.asset('lib/images/ch.png', height: 30),
  //         ],
  //       ),
  //       const SizedBox(height: 8),
  //       Text(team, style: const TextStyle(color: Colors.white)),
  //       Text(
  //         score.toString(),
  //         style: const TextStyle(
  //           color: Colors.white,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ],
  //   );
  // }
}

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  int _timeLeft = 150; // 2:30 in seconds

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get timerText {
    int minutes = _timeLeft ~/ 60;
    int seconds = _timeLeft % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      timerText,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class CountdownTimer2 extends StatefulWidget {
  const CountdownTimer2({super.key});

  @override
  State<CountdownTimer2> createState() => _CountdownTimer2State();
}

class _CountdownTimer2State extends State<CountdownTimer2> {
  late Timer _timer;
  int _timeLeft = 3550; // 2:30 in seconds

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get timerText {
    int minutes = _timeLeft ~/ 60;
    int seconds = _timeLeft % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      timerText,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
