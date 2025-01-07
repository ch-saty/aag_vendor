import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LeaderboardWidget extends StatefulWidget {
  final bool isComponent;

  const LeaderboardWidget({
    super.key,
    this.isComponent = true,
  });

  @override
  State<LeaderboardWidget> createState() => _LeaderboardWidgetState();
}

class _LeaderboardWidgetState extends State<LeaderboardWidget>
    with SingleTickerProviderStateMixin {
  int _selectedTabIndex = 0;
  final List<String> _tabs = ["POPULAR", "REVENUE", "POINTS"];
  late AnimationController _animationController;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Keep your existing data fetching functions

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
    switch (_tabs[_selectedTabIndex]) {
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

  Future<void> _switchToTab(int newIndex) async {
    if (_isAnimating || newIndex == _selectedTabIndex) return;

    await HapticFeedback.mediumImpact();

    setState(() {
      _isAnimating = true;
      _selectedTabIndex = newIndex;
    });

    await _animationController.forward(from: 0.0);
    setState(() {
      _isAnimating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTabBar(),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _buildLeaderboardContent(
              key: ValueKey(_selectedTabIndex),
              entries: getCurrentData(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        child: Row(
          children: _tabs.asMap().entries.map((entry) {
            final index = entry.key;
            final tab = entry.value;
            return GestureDetector(
              onTap: () => _switchToTab(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: _selectedTabIndex == index
                          ? Colors.purple
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  tab,
                  style: TextStyle(
                    color: _selectedTabIndex == index
                        ? Colors.purple
                        : Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildLeaderboardContent({
    required Key key,
    required List<Map<String, dynamic>> entries,
  }) {
    return ListView.builder(
      key: key,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        return _buildLeaderboardItem(
          rank: entry['rank'],
          name: entry['name'],
          value: entry['value'],
          isTopThree: entry['rank'] <= 3,
        );
      },
    );
  }

  Widget _buildLeaderboardItem({
    required int rank,
    required String name,
    required String value,
    required bool isTopThree,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isTopThree
              ? [
                  const Color.fromRGBO(101, 47, 157, 1),
                  const Color.fromRGBO(57, 47, 146, 1),
                ]
              : [Colors.purple.shade100, Colors.purple.shade200],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _buildRankAndAvatar(rank, name, isTopThree),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankAndAvatar(int rank, String name, bool isTopThree) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage('lib/images/ch.png'),
        ),
        if (isTopThree)
          Positioned(
            top: -8,
            left: -8,
            child: Image.asset(
              'lib/images/${rank == 1 ? 'gold' : rank == 2 ? 'silver' : 'bronze'}.png',
              width: 24,
              height: 24,
            ),
          ),
        if (!isTopThree)
          Positioned(
            top: -8,
            left: -8,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.purple[400],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$rank',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
