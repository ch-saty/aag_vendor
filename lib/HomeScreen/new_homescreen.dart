// ignore_for_file: avoid_print

import 'package:AAG/ActiveSession_Screen/activesession_screen.dart';
import 'package:AAG/Pages/new_leaderboard.dart';
import 'package:AAG/PublishGameScreen/publishscreen.dart';
import 'package:AAG/Refer%20and%20Earn/referandearnscreen.dart';
import 'package:AAG/Wallet_Screen/wallet_screen.dart';
import 'package:AAG/tobeadded/custom_appbar.dart';
import 'package:AAG/tobeadded/custom_appdrawer.dart';
import 'package:AAG/tobeadded/plancard.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class NewHomescreen extends StatelessWidget {
  const NewHomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 102, 44, 144).withOpacity(0.1),
              Color.fromARGB(255, 102, 44, 144).withOpacity(0.05),
              Colors.white.withOpacity(0.9),
            ],
            stops: [0.0, 0.3, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 4,
                ),
                const SizedBox(
                  height: 220,
                  child: EnhancedScrollView(),
                ),
                const SizedBox(height: 20),
                const FeaturedGameBanner(),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                        // crossAxisAlignment: CrossAxisAlignment
                        //     .baseline, // Optional: ensure vertical center
                        // textBaseline: TextBaseline.alphabetic,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(
                            'lib/images/available_games.png',
                            width: 26,
                            height: 26,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Available Games',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const AvailableGames(),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                        // crossAxisAlignment: CrossAxisAlignment
                        //     .baseline, // Optional: ensure vertical center
                        // textBaseline: TextBaseline.alphabetic,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(
                            'lib/images/ActiveGames.png',
                            width: 26,
                            height: 26,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Active Sessions',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const ActiveGames(),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const FeaturedGameBanner(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Image.asset(
                                'lib/images/Leaderboard.png',
                                width: 26,
                                height: 26,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                'Leaderboard',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const NewLeaderboardPage(),
                                ),
                              );
                            },
                            child: Text(
                              'View All',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const LeaderboardSection(),
                // const SizedBox(height: 5),
                _buildPlayerListItems(6, 'Satyam', 34, 'lib/images/ch.png')
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }

  Color rgba(int r, int g, int b, double a) {
    return Color.fromRGBO(r, g, b, a);
  }

  Widget _buildPlayerListItems(
    int rank,
    String name,
    int value,
    String imagePath, {
    bool isCurrentUser = true,
  }) {
    return Material(
      elevation: 3,
      child: Container(
        margin: EdgeInsets.only(bottom: 10, left: 16, right: 16),
        decoration: BoxDecoration(
          color:
              isCurrentUser ? Color.fromARGB(255, 102, 44, 144) : Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0)),
        ),
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            // Rank display
            Text(
              '$rank',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(width: 8),

            // Profile Image
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(imagePath),
              backgroundColor: Color.fromARGB(255, 102, 44, 144),
            ),
            SizedBox(width: 12),

            // Player Name
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Spacer(),
            Text(
              '$value',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EnhancedScrollView extends StatefulWidget {
  const EnhancedScrollView({super.key});

  @override
  _EnhancedScrollViewState createState() => _EnhancedScrollViewState();
}

class _EnhancedScrollViewState extends State<EnhancedScrollView> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 1.0,
      initialPage: 0,
    );
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return PageView.builder(
          controller: _pageController,
          itemCount: 4,
          itemBuilder: (context, index) {
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: index == _currentPage ? 1.0 : 0.0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: _buildCard(index),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCard(int index) {
    final List<Map<String, String>> cardData = [
      {'name': 'Satyam', 'packageType': 'standard'},
      {'name': 'Anupam', 'packageType': 'pro'},
      {'name': 'Priya', 'packageType': 'elite'},
      {'name': 'Maharani', 'packageType': 'enterprise'},
    ];

    return CustomCard(
      address: '0x742d35Cc6634C0532925a3b844Bc454e4438f44e',
      name: cardData[index]['name']!,
      packageType: cardData[index]['packageType']!,
    );
  }
}

class FeaturedGameBanner extends StatelessWidget {
  const FeaturedGameBanner({super.key});

  final List<String> gameImages = const [
    'lib/images/ludo_image.jpg',
    'lib/images/chess_game.jpg',
    'lib/images/chausar.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 150,
          aspectRatio: 16 / 9,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
        ),
        items: gameImages.map((image) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }).toList(),
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
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => PublishGamesScreen()),
            );
          },
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
      ),
    );
  }
}

class ActiveGames extends StatelessWidget {
  final Color? backgroundColor;

  const ActiveGames({super.key, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor, // Apply the background color here
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ActiveSessionsScreen()),
            );
          },
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
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  // final String title;
  final String imagePath;
  final double height;

  const GameCard({
    super.key,
    // required this.title,
    required this.imagePath,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          height: height,
          fit: BoxFit.cover,
        ),
        // Text(title),
      ],
    );
  }
}

enum LeaderboardType { popular, revenue, points }

class LeaderboardEntry {
  final String name;
  final String avatarUrl;
  final int score;
  final int rank;

  LeaderboardEntry({
    required this.name,
    required this.avatarUrl,
    required this.score,
    required this.rank,
  });
}

class LeaderboardSection extends StatefulWidget {
  const LeaderboardSection({super.key});

  @override
  _LeaderboardSectionState createState() => _LeaderboardSectionState();
}

class _LeaderboardSectionState extends State<LeaderboardSection> {
  LeaderboardType _selectedType = LeaderboardType.popular;

  final Map<LeaderboardType, List<Color>> _categoryColors = {
    LeaderboardType.popular: [
      Colors.purple,
      Colors.purpleAccent,
      Colors.purple[200]!,
    ],
    LeaderboardType.revenue: [
      Colors.green,
      Colors.greenAccent,
      Colors.green[200]!,
    ],
    LeaderboardType.points: [
      Colors.blue,
      Colors.blueAccent,
      Colors.blue[200]!,
    ],
  };

  // Sample data for each category
  final Map<LeaderboardType, List<LeaderboardEntry>> _leaderboardData = {
    LeaderboardType.popular: [
      LeaderboardEntry(
        name: "John",
        avatarUrl: "lib/images/k.jpeg",
        score: 1200,
        rank: 1,
      ),
      LeaderboardEntry(
        name: "Jane",
        avatarUrl: "lib/images/i.jpeg",
        score: 1100,
        rank: 2,
      ),
      LeaderboardEntry(
        name: "Mike",
        avatarUrl: "lib/images/h.jpeg",
        score: 1000,
        rank: 3,
      ),
    ],
    LeaderboardType.revenue: [
      LeaderboardEntry(
        name: "Sarah",
        avatarUrl: "lib/images/g.jpeg",
        score: 5000,
        rank: 1,
      ),
      LeaderboardEntry(
        name: "David",
        avatarUrl: "lib/images/f.jpeg",
        score: 4500,
        rank: 2,
      ),
      LeaderboardEntry(
        name: "Riya",
        avatarUrl: "lib/images/e.jpeg",
        score: 4000,
        rank: 3,
      ),
    ],
    LeaderboardType.points: [
      LeaderboardEntry(
        name: "Tom",
        avatarUrl: "lib/images/d.png",
        score: 2500,
        rank: 1,
      ),
      LeaderboardEntry(
        name: "Emma",
        avatarUrl: "lib/images/b.png",
        score: 2300,
        rank: 2,
      ),
      LeaderboardEntry(
        name: "Chris",
        avatarUrl: "lib/images/a.png",
        score: 2100,
        rank: 3,
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.2),
        //     spreadRadius: 1,
        //     blurRadius: 4,
        //     offset: const Offset(0, 2),
        //   ),
        // ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildTab('POPULAR', LeaderboardType.popular),
              _buildTab('REVENUE', LeaderboardType.revenue),
              _buildTab('POINTS', LeaderboardType.points),
            ],
          ),
          // const SizedBox(height: 20),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Podium Image with error handling
              Image.asset(
                'lib/images/po2.png',
                width: double.infinity,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  print('Error loading podium image: $error');
                  return Container(
                    width: double.infinity,
                    height: 150,
                    color: Colors.grey[200],
                    child: Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey[400],
                      ),
                    ),
                  );
                },
              ),

              // Animated Players Positioning
              _buildPodiumPlayers(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumPlayers() {
    final entries = _leaderboardData[_selectedType]!;
    final colors = _categoryColors[_selectedType]!;

    return SizedBox(
      height: 330,
      child: Stack(
        children: [
          // Second Place
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.bounceInOut,
            left: MediaQuery.of(context).size.width * 0.10,
            bottom: MediaQuery.of(context).size.height * 0.16,
            child: _buildPlayerWidget(
              entry: entries[1],
              color: colors[1],
              size: 50,
            ),
          ),

          // First Place (Center)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.bounceInOut,
            left: MediaQuery.of(context).size.width * 0.35,
            bottom: MediaQuery.of(context).size.height * 0.20,
            child: _buildPlayerWidget(
              entry: entries[0],
              color: colors[0],
              size: 60,
            ),
          ),

          // Third Place
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.bounceInOut,
            right: MediaQuery.of(context).size.width * 0.10,
            bottom: MediaQuery.of(context).size.height * 0.13,
            child: _buildPlayerWidget(
              entry: entries[2],
              color: colors[2],
              size: 40,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerWidget({
    required LeaderboardEntry entry,
    required Color color,
    required double size,
  }) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      child: Column(
        key: ValueKey('${entry.name}_$_selectedType'),
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 3),
              image: DecorationImage(
                image: AssetImage(entry.avatarUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            entry.name,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${entry.score}',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildPlayerPosition({
  //   required LeaderboardEntry entry,
  //   required Color color,
  //   double? left,
  //   double? right,
  //   required double bottom,
  //   required double size,
  // }) {
  //   return Positioned(
  //     left: left,
  //     right: right,
  //     bottom: bottom,
  //     child: AnimatedOpacity(
  //       key: ValueKey('${entry.name}_$_selectedType'),
  //       opacity: 1,
  //       duration: const Duration(milliseconds: 300),
  //       child: Column(
  //         children: [
  //           Container(
  //             width: size,
  //             height: size,
  //             decoration: BoxDecoration(
  //               shape: BoxShape.circle,
  //               border: Border.all(color: color, width: 3),
  //               image: DecorationImage(
  //                 image: AssetImage(entry.avatarUrl),
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 8),
  //           Text(
  //             entry.name,
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           Text(
  //             '${entry.score}',
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget _buildTab(String text, LeaderboardType type) {
    final isSelected = _selectedType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedType = type;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? Colors.purple : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.purple : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      currentIndex: 0,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewHomescreen()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReferAndEarnPage()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NewLeaderboardPage()),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WalletScreen()),
            );
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money_outlined),
          label: 'Refer',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.emoji_events),
          label: 'LeaderBoard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet_outlined),
          label: 'Wallet',
        ),
      ],
    );
  }
}
