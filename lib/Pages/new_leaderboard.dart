import 'package:flutter/material.dart';

class Player {
  final String name;
  final int points;
  final int popularity;
  final double revenue;
  final String imagePath;

  Player({
    required this.name,
    required this.points,
    required this.popularity,
    required this.revenue,
    required this.imagePath,
  });
}

class NewLeaderboardPage extends StatefulWidget {
  const NewLeaderboardPage({super.key});

  @override
  State<NewLeaderboardPage> createState() => _NewLeaderboardPageState();
}

class _NewLeaderboardPageState extends State<NewLeaderboardPage> {
  int _selectedTabIndex = 0;
  final PageController _pageController = PageController();

  final List<Player> _players = [
    Player(
        name: 'Bryan Wolf',
        points: 43,
        popularity: 1200,
        revenue: 5600.50,
        imagePath: 'lib/images/a.png'),
    Player(
        name: 'Sarah Chen',
        points: 40,
        popularity: 1100,
        revenue: 5200.75,
        imagePath: 'lib/images/b.png'),
    Player(
        name: 'Alex Turner',
        points: 38,
        popularity: 980,
        revenue: 4900.25,
        imagePath: 'lib/images/d.png'),
    Player(
        name: 'Marsha Fisher',
        points: 38,
        popularity: 1400,
        revenue: 4700.00,
        imagePath: 'lib/images/e.jpeg'),
    Player(
        name: 'Junia Corer',
        points: 35,
        popularity: 1500,
        revenue: 4500.50,
        imagePath: 'lib/images/g.jpeg'),
    Player(
        name: 'You',
        points: 34,
        popularity: 2000,
        revenue: 4300.75,
        imagePath: 'lib/images/f.jpeg'),
    Player(
        name: 'Tara Schmit',
        points: 33,
        popularity: 820,
        revenue: 6100.00,
        imagePath: 'lib/images/h.jpeg'),
    Player(
        name: 'Mike Walt',
        points: 32,
        popularity: 800,
        revenue: 7500.50,
        imagePath: 'lib/images/i.jpeg'),
    Player(
        name: 'Emily Wong',
        points: 31,
        popularity: 780,
        revenue: 9000.25,
        imagePath: 'lib/images/j.jpeg'),
    Player(
        name: 'Carl Driguez',
        points: 30,
        popularity: 750,
        revenue: 10500.75,
        imagePath: 'lib/images/k.jpeg'),
    Player(
        name: 'Lisa Kim',
        points: 29,
        popularity: 720,
        revenue: 13300.00,
        imagePath: 'lib/images/a.png'),
    Player(
        name: 'David Thompson',
        points: 40,
        popularity: 700,
        revenue: 3100.50,
        imagePath: 'lib/images/b.png'),
    Player(
        name: 'Rachel Green',
        points: 37,
        popularity: 680,
        revenue: 2900.25,
        imagePath: 'lib/images/f.jpeg'),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final newIndex = _pageController.page?.round() ?? 0;
      if (newIndex != _selectedTabIndex) {
        setState(() {
          _selectedTabIndex = newIndex;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Player> _getSortedPlayers() {
    switch (_selectedTabIndex) {
      case 0: // POINTS
        return List.from(_players)
          ..sort((a, b) => b.points.compareTo(a.points));
      case 1: // POPULAR
        return List.from(_players)
          ..sort((a, b) => b.popularity.compareTo(a.popularity));
      case 2: // REVENUE
        return List.from(_players)
          ..sort((a, b) => b.revenue.compareTo(a.revenue));
      default:
        return List.from(_players)
          ..sort((a, b) => b.points.compareTo(a.points));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "LEADERBOARD",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 102, 44, 144),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < 0 && _selectedTabIndex < 2) {
            // Swipe left
            _pageController.animateToPage(
              _selectedTabIndex + 1,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          } else if (details.primaryVelocity! > 0 && _selectedTabIndex > 0) {
            // Swipe right
            _pageController.animateToPage(
              _selectedTabIndex - 1,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color.fromARGB(255, 102, 44, 144),
                    Colors.purple[700]!
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Navigation Tabs
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            )),
                        child: Row(
                          children: [
                            _buildNavButton('POINTS', 0),
                            _buildNavButton('POPULAR', 1),
                            _buildNavButton('REVENUE', 2),
                          ],
                        ),
                      ),
                    ),

                    // Ranking Highlight
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.orange[400]!, Colors.orange[500]!],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
                              '#6',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'You are doing better than 60% of other players!',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Top Three and Podium Section with PageView
                    SizedBox(
                      height: 275,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: 3,
                        onPageChanged: (index) {
                          setState(() {
                            _selectedTabIndex = index;
                          });
                        },
                        itemBuilder: (context, pageIndex) {
                          final sortedPlayers = _getSortedPlayers();
                          final topThree = sortedPlayers.take(3).toList();

                          return AnimatedSwitcher(
                            duration: Duration(milliseconds: 400),
                            child: Stack(
                              key: ValueKey<String>(
                                  'podium_${pageIndex}_${topThree.map((p) => p.name).join("_")}'),
                              alignment: Alignment.center,
                              children: [
                                // Background Podium Image
                                Positioned(
                                  top: 125,
                                  left: 32,
                                  right: 32,
                                  child: Image.asset(
                                    'lib/images/po2.png',
                                    height: 175,
                                    fit: BoxFit.contain,
                                  ),
                                ),

                                // Top Three Players
                                Positioned(
                                  top: 0,
                                  left: 5,
                                  right: 5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Second Place (Left)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, bottom: 8),
                                        child: _buildTopPlayer(
                                          2,
                                          topThree[1].name,
                                          _getTopValue(topThree[1]),
                                          topThree[1].imagePath,
                                        ),
                                      ),
                                      // First Place (Center)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 40, bottom: 120),
                                        child: _buildTopPlayer(
                                          1,
                                          topThree[0].name,
                                          _getTopValue(topThree[0]),
                                          topThree[0].imagePath,
                                        ),
                                      ),
                                      // Third Place (Right)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, top: 70),
                                        child: _buildTopPlayer(
                                          3,
                                          topThree[2].name,
                                          _getTopValue(topThree[2]),
                                          topThree[2].imagePath,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    // Remaining Players List
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: ListView.builder(
                          itemCount: _getSortedPlayers().skip(3).length,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          itemBuilder: (context, index) {
                            final player =
                                _getSortedPlayers().skip(3).toList()[index];
                            return _buildPlayerListItem(
                              index + 4,
                              player.name,
                              _getTopValue(player),
                              player.imagePath,
                              isCurrentUser: player.name == 'You',
                            );
                          },
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
    );
  }

  Widget _buildNavButton(String title, int index) {
    bool isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: isSelected
              ? BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                )
              : null,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopPlayer(int rank, String name, int value, String imagePath) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: rank == 1 ? 40 : 24,
              backgroundImage: AssetImage(imagePath),
              backgroundColor: Colors.white,
            ),
          ],
        ),
        // SizedBox(height: 5),
        Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '$value ${_getTabTitle()}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  String _getTabTitle() {
    switch (_selectedTabIndex) {
      case 0:
        return 'pts';
      case 1:
        return 'pop';
      case 2:
        return 'rev';
      default:
        return 'pts';
    }
  }

  int _getTopValue(Player player) {
    switch (_selectedTabIndex) {
      case 0:
        return player.points;
      case 1:
        return player.popularity;
      case 2:
        return player.revenue.round();
      default:
        return player.points;
    }
  }

  Widget _buildPlayerListItem(
    int rank,
    String name,
    int value,
    String imagePath, {
    bool isCurrentUser = false,
  }) {
    return Column(
      children: [
        Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 0),
            decoration: BoxDecoration(
              color: isCurrentUser
                  ? const Color.fromARGB(255, 102, 44, 144)
                  : Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Text(
                  rank.toString(),
                  style: TextStyle(
                    color: isCurrentUser ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(imagePath),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      color: isCurrentUser ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Text(
                  '$value ${_getTabTitle()}',
                  style: TextStyle(
                    color: isCurrentUser ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
