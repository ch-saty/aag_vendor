import 'package:AAG/PublishGameScreen/gamescreen2.dart';
import 'package:AAG/LeagueScreen/leaguescreen_one.dart';
import 'package:AAG/TournamentScreen/tournamentscreen_one.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class AppGamesScreen extends StatefulWidget {
  const AppGamesScreen({super.key});

  @override
  State<AppGamesScreen> createState() => _AppGamesScreenState();
}

class _AppGamesScreenState extends State<AppGamesScreen>
    with SingleTickerProviderStateMixin {
  int revealedCount = 1;
  late TabController _tabController;
  bool isPublishSelected = true;
  bool isGamesSelected = true;
  bool isLeagueSelected = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void incrementCounter() {
    setState(() {
      if (revealedCount < 5) {
        revealedCount++;
      }
    });
  }

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
          'GAMES',
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
        child: Column(
          children: [
            const SizedBox(height: kToolbarHeight + 20),
            _buildDailyLimit(context),
            // Publish/History Toggle
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTabButton('PUBLISH', isPublishSelected, () {
                    setState(() {
                      isPublishSelected = true;
                    });
                  }),
                  const SizedBox(width: kToolbarHeight - 20),
                  _buildTabButton('HISTORY', !isPublishSelected, () {
                    setState(() {
                      isPublishSelected = false;
                    });
                  }),
                ],
              ),
            ),
            if (!isPublishSelected) ...[
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.withOpacity(0.5)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildToggleButton('Games', isGamesSelected, () {
                        setState(() {
                          isGamesSelected = true;
                        });
                      }),
                    ),
                    Expanded(
                      child: _buildToggleButton('Event', !isGamesSelected, () {
                        setState(() {
                          isGamesSelected = false;
                        });
                      }),
                    ),
                  ],
                ),
              ),
              // League/Tournament Toggle (only visible when Event is selected)
              if (!isGamesSelected)
                Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange.withOpacity(0.5)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child:
                            _buildToggleButton('Leagues', isLeagueSelected, () {
                          setState(() => isLeagueSelected = true);
                        }),
                      ),
                      Expanded(
                        child: _buildToggleButton(
                            'Tournament', !isLeagueSelected, () {
                          setState(() => isLeagueSelected = false);
                        }),
                      ),
                    ],
                  ),
                ),
            ],
            Expanded(
              child: isPublishSelected
                  ? ListView(
                      padding: const EdgeInsets.only(top: 10),
                      children: [
                        _buildSection(context, 'PUBLISH', 'lib/images/ic3.png',
                            'Games', 5),
                        _buildSection(context, 'EVENTS', 'lib/images/ic3.png',
                            'Leagues', 2),
                        _buildSection(context, '', '', 'Tournament', 2),
                      ],
                    )
                  : _buildHistoryContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.orange : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
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
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.orange.withOpacity(0.5),
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
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
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.orange.shade900,
                      Colors.orange.shade800,
                      Colors.orange.shade600,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
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
                              fontSize: 18,
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
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Row(
                      children: [
                        Text(
                          'View All',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 12,
                        ),
                      ],
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

  Widget _buildSection(BuildContext context, String title, String iconPath,
      String subtitle, int gameCount) {
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
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            subtitle,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          padding: const EdgeInsets.all(8),
          children: List.generate(
            gameCount,
            (index) => GestureDetector(
              onTap: () {
                switch (subtitle) {
                  case 'Games':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GamesScreen(),
                      ),
                    );
                    break;
                  case 'Leagues':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LeagueScreen(),
                      ),
                    );
                    break;
                  case 'Tournament':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Tournamentscreen(),
                      ),
                    );
                    break;
                }
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
      ],
    );
  }

  Widget _buildHistoryContent() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'September 2024',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ),
        ...List.generate(
          8,
          (index) => _buildHistoryItem(),
        ),
      ],
    );
  }

  Widget _buildHistoryItem() {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.orange.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'lib/images/g1.png',
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        title: const Text(
          'Monday, Sep 11, 2023',
          style: TextStyle(color: Colors.white),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '8:30 AM',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                // Add navigation logic here
              },
              child: Row(
                children: const [
                  Text(
                    'View',
                    style: TextStyle(color: Colors.orange),
                  ),
                  Icon(
                    Icons.remove_red_eye,
                    color: Colors.orange,
                    size: 16,
                  ),
                ],
              ),
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.orange.withOpacity(0.5),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.3),
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ],
        ),
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
                          fit: BoxFit.fill,
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
                            Colors.orange.shade800,
                            Colors.orange.shade400,
                            Colors.orange.shade800,
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '?',
                          style: TextStyle(
                            color: Colors.white,
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
