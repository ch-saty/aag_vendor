import 'dart:math';

import 'package:AAG/HomeScreen/homescreen_game.dart';
import 'package:flutter/material.dart';

class DailyTaskScreen extends StatelessWidget {
  const DailyTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context)
            .size
            .height, // Set container height to screen height
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/idkbg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildAppBar(context),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildDailyBonus(context),
                    SizedBox(height: 12),
                    _buildSpinAndEarn(context),
                    SizedBox(height: 20),
                    _buildTasksList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GameHomepage()),
                );
              },
            ),
            Text(
              'DAILY TASK',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Container(
              constraints: const BoxConstraints(
                minWidth: 50, // Minimum width
                minHeight: 30,
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(113, 47, 160, 1),
                    Color.fromRGBO(54, 47, 145, 1),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Image.asset('lib/images/coin.png', height: 30),
                  SizedBox(width: 4),
                  Text(
                    '150',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyBonus(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => const DailyBonusPopup(),
        );
      },
      //
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color.fromRGBO(233, 116, 17, 1), // Border color
            width: 1, // Border width
          ),
          image: DecorationImage(
            image: AssetImage('lib/images/task1.png'),
            fit: BoxFit.fitWidth,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpinAndEarn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => const WheelOfRewardsPopup(),
        );
      },
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color.fromRGBO(233, 116, 17, 1), // Border color
            width: 1, // Border width
          ),
          image: DecorationImage(
            image: AssetImage('lib/images/task2.png'),
            fit: BoxFit.fitWidth,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTasksList() {
    final tasks = [
      {'title': 'Refer and Earn', 'coins': '100', 'status': 'Completed'},
      {'title': 'Challenge a Friend', 'coins': '100', 'status': 'Completed'},
      {
        'title': 'Leader board Ranking Rewards',
        'coins': '100',
        'status': 'Start'
      },
      {'title': 'Publish Game Task', 'coins': '100', 'status': 'Task'},
      {'title': 'Seasonal Award', 'coins': '100', 'status': 'Task'},
      {'title': 'Challenge a Friend', 'coins': '100', 'status': 'Completed'},
      {
        'title': 'Leader board Ranking Rewards',
        'coins': '100',
        'status': 'Start'
      },
      {'title': 'First Purchase Award', 'coins': '100', 'status': 'Task'},
      {'title': 'Seasonal Award', 'coins': '100', 'status': 'Task'},
      {'title': 'Challenge a Friend', 'coins': '100', 'status': 'Completed'},
      {
        'title': 'Leader board Ranking Rewards',
        'coins': '100',
        'status': 'Start'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TASK',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        ...tasks.map((task) => _buildTaskItem(task)),
      ],
    );
  }

  Widget _buildTaskItem(Map<String, String> task) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
        children: [
          // Left side text
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to the left
              children: [
                Text(
                  task['title']!,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '${task['coins']} coins',
                  style: TextStyle(color: Colors.orange),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          // Right side text
          Text(
            task['status']!,
            style: TextStyle(
              color:
                  task['status'] == 'Completed' ? Colors.green : Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}

class DailyBonusPopup extends StatelessWidget {
  const DailyBonusPopup({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: screenSize.width * 0.9, // 90% of screen width
        constraints: BoxConstraints(
          maxWidth: 400, // to prevent stretching on large screens
          maxHeight: screenSize.height * 0.8, // Maximum height
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(53, 3, 90, 1),
              Color.fromRGBO(81, 9, 133, 1),
              Color.fromRGBO(53, 3, 90, 1),
            ],
            stops: [0.1572, 0.5, 0.8753],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color.fromRGBO(233, 116, 17, 1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: SingleChildScrollView(
          // content scrollable if
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: isSmallScreen ? 10.0 : 15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(context),
                SizedBox(height: isSmallScreen ? 5 : 10),
                _buildProgressSlider(isSmallScreen, context),
                _buildTopBoxes(isSmallScreen),
                SizedBox(height: isSmallScreen ? 5 : 10),
                _buildDailyRewards(screenSize),
                SizedBox(height: isSmallScreen ? 5 : 10),
                _buildBronzeBonus(),
                SizedBox(height: isSmallScreen ? 5 : 10),
                _buildClaimButton(screenSize),
                SizedBox(height: isSmallScreen ? 5 : 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Positioned(
          top: 10,
          left: MediaQuery.of(context).size.width * .235,
          child: Text(
            'DAILY BONUS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // const SizedBox(
        //   width: 149,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressSlider(bool isSmallScreen, BuildContext context) {
    final double progressWidth = MediaQuery.of(context).size.width - 40;
    final double progress = (3 / 28) * progressWidth; // Changed to day 3 of 28

    return Column(
      children: [
        Container(
          width: 600,
          height: 30,
          child: Stack(
            children: [
              // Progress Bar Background
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              // Progress Bar Fill
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0),
                width: progress,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xFF83410A),
                      Color(0xFFE97411),
                      Color(0xFF88440A),
                    ],
                    stops: [0.071, 0.491, 0.951],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              // Marker Points
              Positioned.fill(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 1; i <= 5; i++) // Increased to 5 points
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: 3 >= (i == 5 ? 28 : i * 7)
                              ? Color(0xFFE97411)
                              : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xFFE97411),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${i == 5 ? 28 : i * 7}', // Last point shows 28
                            style: TextStyle(
                              color: 3 >= (i == 5 ? 28 : i * 7)
                                  ? Colors.white
                                  : Color(0xFFE97411),
                              fontSize: isSmallScreen ? 8 : 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildTopBoxes(bool isSmallScreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 1; i <= 4; i++)
          Column(
            children: [
              Image.asset(
                'lib/images/box$i.png',
                height: isSmallScreen ? 32 : 40,
                width: isSmallScreen ? 32 : 40,
              ),
              SizedBox(height: 4),
              Text(
                '${i * 7}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSmallScreen ? 12 : 14,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildDailyRewards(Size screenSize) {
    return LayoutBuilder(builder: (context, constraints) {
      return GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.1,
        children: List.generate(6, (index) {
          bool isActive = index == 0;
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isActive
                    ? [
                        Color.fromRGBO(233, 116, 17, 1),
                        Color.fromRGBO(233, 116, 17, 1),
                      ]
                    : [
                        Color.fromRGBO(113, 47, 160, 1),
                        Color.fromRGBO(54, 47, 145, 1),
                      ],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Day ${index + 1}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenSize.width < 360 ? 12 : 14,
                  ),
                ),
                SizedBox(height: 4),
                Image.asset(
                  'lib/images/coin.png',
                  height: screenSize.width < 360 ? 20 : 24,
                ),
                Text(
                  '${400 + (index * 200)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: screenSize.width < 360 ? 12 : 14,
                  ),
                ),
              ],
            ),
          );
        }),
      );
    });
  }

  Widget _buildBronzeBonus() {
    return LayoutBuilder(builder: (context, constraints) {
      final isSmallScreen = constraints.maxWidth < 360;
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: isSmallScreen ? 8 : 12,
          horizontal: isSmallScreen ? 12 : 16,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(113, 47, 160, 1),
              Color.fromRGBO(54, 47, 145, 1),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Day 7 ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 12 : 14,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      width: 75, // Makes container take full available width
                      height: 75,
                      child: Image.asset(
                        'lib/images/box1.png',
                        // height: double.infinity,
                        // width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Bronze',
                          style: TextStyle(
                            color: Color.fromRGBO(233, 116, 17, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 18 : 24,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      ' Big Bonus',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isSmallScreen ? 16 : 22,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildClaimButton(Size screenSize) {
    final buttonHeight = screenSize.height < 600 ? 40.0 : 48.0;

    return Container(
      width: 140,
      height: 30,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(233, 116, 17, 1),
            Color.fromRGBO(233, 116, 17, 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonHeight / 2),
          ),
        ),
        child: Text(
          'Claim',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenSize.width < 360 ? 14 : 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class WheelOfRewardsPopup extends StatefulWidget {
  const WheelOfRewardsPopup({super.key});

  @override
  State<WheelOfRewardsPopup> createState() => _WheelOfRewardsPopupState();
}

class _WheelOfRewardsPopupState extends State<WheelOfRewardsPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _spinAnimation;
  bool isButtonHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );

    // Create a curved animation that starts fast and slows down
    _spinAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linearToEaseOut,
    );
  }

  void _spinWheel() {
    final random = Random();
    final baseRotations = random.nextInt(10); // 5-10 full rotations
    final randomAngle = 360 / random.nextDouble(); // Random final position
    final totalRotation = baseRotations + (randomAngle); // Convert to turns

    final spinTween = Tween<double>(
      begin: 0,
      end: totalRotation,
    );

    _spinAnimation = spinTween.animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color.fromRGBO(233, 116, 17, 1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 45,
                ),
                Text(
                  'WHEEL OF REWARDS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                // Base layer (spin_wheel-01)
                Positioned(
                  top: 35,
                  child: Image.asset(
                    'lib/images/spin_wheel-01.png',
                    width: 30,
                    height: 30,
                  ),
                ),
                // Middle rotating layer (spin_wheel-02)
                RotationTransition(
                  turns: _spinAnimation,
                  child: Image.asset(
                    'lib/images/spin_wheel-02.png',
                    width: 300,
                    height: 300,
                  ),
                ),
                // Top layer (spin_wheel-03)
                SizedBox(height: 20),
                Positioned(
                  top: 350,
                  child: Image.asset(
                    'lib/images/spin_wheel-03.png',
                    width: 200,
                    height: 50,
                  ),
                ),
                // Center pointer
                //   Container(
                //     width: 40,
                //     height: 40,
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color: Color.fromRGBO(233, 116, 17, 1),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.black.withOpacity(0.25),
                //           blurRadius: 8,
                //           offset: Offset(0, 4),
                //         ),
                //       ],
                //     ),
                //   ),
              ],
            ),
            SizedBox(height: 20),
            _buildClaimButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildClaimButton() {
    return MouseRegion(
      onEnter: (_) => setState(() => isButtonHovered = true),
      onExit: (_) => setState(() => isButtonHovered = false),
      child: Container(
        width: 125,
        height: 48,
        decoration: BoxDecoration(
          gradient: isButtonHovered
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(131, 65, 10, 1),
                    Color.fromRGBO(233, 116, 17, 1),
                    Color.fromRGBO(136, 68, 10, 1),
                  ],
                  stops: [0.071, 0.491, 0.951],
                )
              : null,
          color: isButtonHovered ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Color.fromRGBO(202, 99, 11, 1),
            width: 1,
          ),
        ),
        child: TextButton(
          onPressed: _spinWheel,
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: Text(
            'Spin',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
