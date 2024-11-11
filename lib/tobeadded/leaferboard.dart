import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LeaderboardWidget extends StatefulWidget {
  const LeaderboardWidget({super.key});

  @override
  _LeaderboardWidgetState createState() => _LeaderboardWidgetState();
}

class _LeaderboardWidgetState extends State<LeaderboardWidget>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 1; // Start with REVENUE (index 1)
  final List<String> _categories = ["POPULAR", "REVENUE", "POINTS"];
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

  // Simulated data fetching functions
  List<Map<String, dynamic>> fetchPopularData() {
    return [
      {'rank': 1, 'name': 'Shivam', 'value': '500k+'},
      {'rank': 2, 'name': 'Rahul', 'value': '400k+'},
      {'rank': 3, 'name': 'Amit', 'value': '300k+'},
      {'rank': 29, 'name': 'You', 'value': '100k+'},
    ];
  }

  List<Map<String, dynamic>> fetchRevenueData() {
    return [
      {'rank': 1, 'name': 'Shivam', 'value': '₹100,000'},
      {'rank': 2, 'name': 'Priya', 'value': '₹80,000'},
      {'rank': 3, 'name': 'Neha', 'value': '₹70,000'},
      {'rank': 15, 'name': 'You', 'value': '₹50,000'},
    ];
  }

  List<Map<String, dynamic>> fetchPointsData() {
    return [
      {'rank': 1, 'name': 'Shivam', 'value': '1000'},
      {'rank': 2, 'name': 'Vikram', 'value': '950'},
      {'rank': 3, 'name': 'Sneha', 'value': '900'},
      {'rank': 45, 'name': 'You', 'value': '100'},
    ];
  }

  List<Map<String, dynamic>> getCurrentData() {
    switch (_categories[_currentIndex]) {
      case 'POPULAR':
        return fetchPopularData();
      case 'REVENUE':
        return fetchRevenueData();
      case 'POINTS':
        return fetchPointsData();
      default:
        return [];
    }
  }

  Future<void> _onSwipe(DragEndDetails details) async {
    if (_isAnimating) return;

    int newIndex;
    if (details.primaryVelocity! > 0) {
      // Swiped right
      newIndex = (_currentIndex - 1 + _categories.length) % _categories.length;
    } else {
      // Swiped left
      newIndex = (_currentIndex + 1) % _categories.length;
    }

    // Haptic feedback
    await HapticFeedback.mediumImpact();

    setState(() {
      _isAnimating = true;
      _currentIndex = newIndex;
    });

    await _animationController.forward(from: 0.0);
    setState(() {
      _isAnimating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentData = getCurrentData();

    return GestureDetector(
      onHorizontalDragEnd: _onSwipe,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.96,
        decoration: BoxDecoration(
          color: const Color.fromARGB(120, 0, 0, 0).withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < _categories.length; i++)
                    _leaderboardTab(_categories[i], _currentIndex == i),
                ],
              ),
            ),
            const SizedBox(height: 10),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
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
              child: _buildLeaderboardContent(currentData),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardContent(List<Map<String, dynamic>> data) {
    return Column(
      key: ValueKey<int>(_currentIndex),
      children: data
          .map((item) => _buildLeaderboardItem(
                item['rank'],
                item['name'],
                item['value'],
                item['rank'] <= 3,
              ))
          .toList(),
    );
  }

  Widget _leaderboardTab(String text, bool isActive) {
    return GestureDetector(
      onTap: () async {
        if (_currentIndex != _categories.indexOf(text) && !_isAnimating) {
          await HapticFeedback.selectionClick();
          await _onSwipe(DragEndDetails(
            primaryVelocity:
                _categories.indexOf(text) > _currentIndex ? -1000 : 1000,
          ));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? Colors.orange : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.orange : Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildLeaderboardItem(
      int rank, String name, String value, bool isTopThree) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isTopThree
              ? [
                  const Color.fromRGBO(101, 47, 157, 1),
                  const Color.fromRGBO(57, 47, 146, 1)
                ]
              : [
                  const Color.fromARGB(255, 237, 55, 173),
                  const Color.fromARGB(255, 245, 153, 33)
                ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          children: [
            if (isTopThree) _buildMedal(rank),
            // Display the medal image if the name is "You"
            if (name == 'You') ...[
              const SizedBox(width: 2),
              Image.asset(
                'lib/images/rank.png',
                height: 40,
                width: 40,
              ),
            ],
            if (name != 'You') const SizedBox(width: 10),
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
    return Container(
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
    switch (_categories[_currentIndex]) {
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
