import 'package:AAG/ActiveSession_Screen/activesession_screen.dart';
import 'package:AAG/Pages/new_leaderboard.dart';
import 'package:AAG/tobeadded/custom_appbar.dart';
import 'package:AAG/tobeadded/custom_appdrawer.dart';
import 'package:AAG/tobeadded/homescreen_slider.dart';
import 'package:AAG/tobeadded/leaferboard.dart';
import 'package:flutter/material.dart';

class GameHomepage extends StatefulWidget {
  const GameHomepage({super.key});

  @override
  State<GameHomepage> createState() => _GameHomepageState();
}

class _GameHomepageState extends State<GameHomepage>
    with SingleTickerProviderStateMixin {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1.0;
  bool isDrawerOpen = false;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void openDrawer() {
    setState(() {
      xOffset = 290;
      yOffset = 80;
      scaleFactor = 0.85;
      isDrawerOpen = true;
    });
  }

  void closeDrawer() {
    setState(() {
      xOffset = 0;
      yOffset = 0;
      scaleFactor = 1.0;
      isDrawerOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final horizontalPadding =
        screenSize.width * 0.02; // Consistent horizontal padding
    final verticalSpacing =
        screenSize.height * 0.01; // Consistent vertical spacing

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aapka Apna Game',
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const CustomAppBar(),
        drawer: const CustomDrawer(),
        body: Stack(
          children: [
            Container(
              color: Colors.white, // Set the background color to white
              width: double.infinity,
              height: double.infinity,
            ),
            SafeArea(
              child: AnimatedContainer(
                transform: Matrix4.translationValues(xOffset, yOffset, 0)
                  ..scale(scaleFactor),
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  borderRadius: isDrawerOpen
                      ? BorderRadius.circular(40)
                      : BorderRadius.circular(0),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: verticalSpacing + 8),
                        //

                        //
                        //
                        PromotionalsSlider2(),
                        //
                        _buildSectionHeader(context,
                            icon: 'lib/images/ic3.png',
                            title: "AVAILABLE GAMES",
                            onViewAll: () => {}
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         const ActiveSessionsScreen(),
                            //   ),
                            // ),
                            ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: _buildGameImages(screenSize),
                          ),
                        ),
                        //
                        SizedBox(height: verticalSpacing),
                        //
                        _buildSectionHeader(
                          context,
                          icon: 'lib/images/ic3.png',
                          title: "ACTIVE GAMES",
                          onViewAll: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ActiveSessionsScreen(),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: _buildGameImages(screenSize),
                          ),
                        ),
                        //
                        SizedBox(height: verticalSpacing + 5),

                        //LEADERBOARD
                        _buildSectionHeader(
                          context,
                          icon: 'lib/images/ic4.png',
                          title: "LEADERBOARD",
                          onViewAll: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NewLeaderboardPage(),
                            ),
                          ),
                        ),
                        const LeaderboardWidget(),
                        SizedBox(height: verticalSpacing * 2),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String icon,
    required String title,
    required VoidCallback onViewAll,
  }) {
    var screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side with icon and title
          Expanded(
            child: Row(
              children: [
                Image.asset(
                  icon,
                  // width: screenSize.width * 0.06,
                  height: screenSize.width * 0.06,
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Right side with View All text
          Container(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: onViewAll,
              behavior: HitTestBehavior.opaque, // Improves tap target
              child: Padding(
                padding: const EdgeInsets.all(8.0), // Increases tap target area
                child: const Text(
                  "View All",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildGameImages(Size screenSize) {
    final gameImages = [
      'lib/images/ludo.png',
      'lib/images/snakes.png',
      // 'lib/images/ludo.png',
      // 'lib/images/snakes.png',
      // 'lib/images/ludo.png',
      // 'lib/images/snakes.png',
    ];

    return gameImages.map((image) {
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Image.asset(
          image,
          height: screenSize.width * 0.30,
        ),
      );
    }).toList();
  }
}
