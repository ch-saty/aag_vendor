import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage>
    with SingleTickerProviderStateMixin {
  int _currentCategoryIndex = 1;
  int _currentPlanIndex = 0;
  final List<String> _categories = ["POPULAR", "REVENUE", "POINTS"];
  final List<String> _plans = ["Standard", "Pro", "Elite"];
  late AnimationController _animationController;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> fetchData(String category, String plan) {
    List<Map<String, dynamic>> data = [];
    for (int i = 1; i <= 60; i++) {
      data.add({
        'rank': i,
        'name': i == 29 ? 'You' : 'User ${i + 100}',
        'value': _getValueForCategory(category, i, plan),
      });
    }
    return data;
  }

  String _getValueForCategory(String category, int rank, String plan) {
    int multiplier = _plans.indexOf(plan) + 1;
    switch (category) {
      case 'POPULAR':
        return '${(600 - rank * 10) * multiplier}k+';
      case 'REVENUE':
        return '₹${(100000 - rank * 1000) * multiplier}';
      case 'POINTS':
        return '${(1000 - rank * 15) * multiplier}';
      default:
        return '';
    }
  }

  List<Map<String, dynamic>> getCurrentData() {
    return fetchData(
        _categories[_currentCategoryIndex], _plans[_currentPlanIndex]);
  }

  Future<void> _onSwipe(DragEndDetails details) async {
    if (_isAnimating) return;

    int newIndex;
    if (details.primaryVelocity! > 0) {
      // Swiped right
      newIndex =
          (_currentCategoryIndex - 1 + _categories.length) % _categories.length;
    } else {
      // Swiped left
      newIndex = (_currentCategoryIndex + 1) % _categories.length;
    }

    // Haptic feedback
    await HapticFeedback.mediumImpact();

    setState(() {
      _isAnimating = true;
      _currentCategoryIndex = newIndex;
    });

    await _animationController.forward(from: 0.0);
    setState(() {
      _isAnimating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Image.asset(
          'lib/images/aag_white.png',
          height: screenSize.height * 0.04,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/images/idkbg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Title Row with Icon
                Padding(
                  padding: EdgeInsets.all(screenSize.height * 0.02),
                  child: Row(
                    children: [
                      Image.asset(
                        'lib/images/ic4.png',
                        width: screenSize.width * 0.06,
                        height: screenSize.width * 0.06,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'LEADERBOARD',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Dynamic Spacing
                SizedBox(height: screenSize.height * 0.03),

                // Categories Row with GestureDetector for swipe
                GestureDetector(
                  onHorizontalDragEnd: _onSwipe,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 0; i < _categories.length; i++)
                          _leaderboardTab(
                              _categories[i], _currentCategoryIndex == i),
                      ],
                    ),
                  ),
                ),

                // Dynamic Spacing
                SizedBox(height: screenSize.height * 0.03),

                // Plans Row
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0; i < _plans.length; i++)
                        _planTab(_plans[i], _currentPlanIndex == i),
                    ],
                  ),
                ),

                // Dynamic Spacing
                SizedBox(height: screenSize.height * 0.02),

                // Leaderboard Content
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          const Color.fromARGB(120, 0, 0, 0).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: animation.drive(Tween<Offset>(
                              begin: const Offset(0.0, 0.3),
                              end: Offset.zero,
                            ).chain(CurveTween(curve: Curves.easeOut))),
                            child: child,
                          ),
                        );
                      },
                      child: _buildLeaderboardContent(getCurrentData()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardContent(List<Map<String, dynamic>> data) {
    return ListView.builder(
      key: ValueKey<String>(
          "${_categories[_currentCategoryIndex]}_${_plans[_currentPlanIndex]}"),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return _buildLeaderboardItem(
          item['rank'],
          item['name'],
          item['value'],
          item['rank'] <= 3,
        );
      },
    );
  }

  Widget _leaderboardTab(String text, bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: isActive ? Colors.orange : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 500),
        style: TextStyle(
          color: isActive ? Colors.white : Colors.white.withOpacity(0.7),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        child: Text(text),
      ),
    );
  }

  Widget _planTab(String text, bool isActive) {
    return GestureDetector(
      onTap: () async {
        if (_currentPlanIndex != _plans.indexOf(text) && !_isAnimating) {
          await HapticFeedback.selectionClick();
          setState(() {
            _currentPlanIndex = _plans.indexOf(text);
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? Colors.orange : Colors.transparent,
              width: 5,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.orange : Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildLeaderboardItem(
      int rank, String name, String value, bool isTopThree) {
    List<List<Color>> gradients = [
      [
        const Color.fromARGB(255, 245, 187, 41),
        const Color.fromARGB(255, 109, 101, 27)
      ], // Gold
      [Colors.grey[900]!, Colors.grey[600]!], // Silver
      [Colors.brown[800]!, Colors.brown[300]!], // Bronze
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isTopThree
              ? gradients[rank - 1]
              : name == 'You'
                  ? [
                      const Color.fromARGB(255, 237, 55, 173),
                      const Color.fromARGB(255, 245, 153, 33)
                    ]
                  : [
                      const Color.fromRGBO(101, 47, 157, 1),
                      const Color.fromRGBO(57, 47, 146, 1)
                    ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          children: [
            if (isTopThree) _buildMedal(rank),
            if (!isTopThree) ...[
              const SizedBox(width: 2),
              Image.asset(
                'lib/images/rank.png',
                height: 40,
                width: 40,
              ),
            ],
            const SizedBox(width: 10),
            Text(
              "#$rank",
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                'lib/images/ch.png',
                height: 50,
                width: 50,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _getCategoryLabel(),
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Text(
                  value,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedal(int rank) {
    final medalImages = [
      'lib/images/gold.png',
      'lib/images/silver.png',
      'lib/images/bronze.png'
    ];
    return SizedBox(
      width: 40,
      height: 40,
      child: Center(
        child: Image.asset(
          medalImages[rank - 1],
          width: 40,
          height: 40,
        ),
      ),
    );
  }

  String _getCategoryLabel() {
    switch (_categories[_currentCategoryIndex]) {
      case 'POPULAR':
        return 'FOLLOWERS';
      case 'REVENUE':
        return 'REVENUE';
      case 'POINTS':
        return 'POINTS';
      default:
        return '';
    }
  }
}
