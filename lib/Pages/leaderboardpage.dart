import 'package:flutter/material.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage>
    with SingleTickerProviderStateMixin {
  int _currentCategoryIndex = 1;
  final List<String> _categories = ["POPULAR", "REVENUE", "POINTS"];

  // Animation controller for swipe effect
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Create a scale animation for wobble effect
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Method to change category with animation
  void _changeCategory(int direction) {
    setState(() {
      // Update category index with wrap-around logic
      _currentCategoryIndex =
          (_currentCategoryIndex + direction + _categories.length) %
              _categories.length;
    });

    // Trigger animation
    _animationController.forward(from: 0.0);
  }

  List<Map<String, dynamic>> fetchData(String category) {
    List<Map<String, dynamic>> data = [];
    for (int i = 4; i <= 60; i++) {
      data.add({
        'rank': i.toString(),
        'name': i == 29 ? 'You' : 'User ${i + 100}',
        'image': 'lib/images/k.jpeg', // Replace with appropriate image logic
        'point': _getPointForCategory(category, i),
      });
    }
    return data;
  }

  int _getPointForCategory(String category, int rank) {
    switch (category) {
      case 'POPULAR':
        return (600 - rank * 10);
      case 'REVENUE':
        return (100000 - rank * 1000);
      case 'POINTS':
        return (1000 - rank * 15);
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
        // Add swipe gesture detection
        onHorizontalDragEnd: (details) {
          // Detect swipe direction
          if (details.primaryVelocity! > 0) {
            // Swipe right - previous category
            _changeCategory(-1);
          } else if (details.primaryVelocity! < 0) {
            // Swipe left - next category
            _changeCategory(1);
          }
        },
        child: Container(
          width: screenWidth,
          height: screenHeight,
          color: Colors.black87, // Match AppBar background
          child: Stack(
            children: [
              // Background Image
              Positioned(
                top: -35,
                left: 0,
                right: 0,
                child: Image.asset(
                  "lib/images/po.png",
                  width: screenWidth,
                  fit: BoxFit.contain,
                ),
              ),

              // Category Selector (Responsive Positioning)
              Positioned(
                top: screenHeight * 0.05, // Adjusted for AppBar
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: screenWidth * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _categories.map((category) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _currentCategoryIndex =
                                    _categories.indexOf(category);
                              });
                            },
                            child: Text(
                              category,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _currentCategoryIndex ==
                                        _categories.indexOf(category)
                                    ? Colors.white
                                    : Colors.black38,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),

              // Top 3 Ranks (Responsive Positioning)
              Positioned(
                top: screenHeight * 0.15, // Adjusted relative positioning
                left: 0,
                right: 0,
                child: AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        width: screenWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Second Place (Left)
                            _buildTopRank(
                              radius: 20.0,
                              height: 2,
                              image: "lib/images/k.jpeg",
                              name: "Hodges",
                              point: "12323",
                            ),

                            // First Place (Middle, Larger)
                            _buildTopRank(
                              radius: 25.0,
                              height: 2,
                              image: "lib/images/g.jpeg",
                              name: "Johnny Rios",
                              point: "23131",
                            ),
                            // Third Place (Right)
                            _buildTopRank(
                              radius: 20.0,
                              height: 2,
                              image: "lib/images/j.jpeg",
                              name: "loram",
                              point: "6343",
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Leaderboard List
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: screenHeight * 0.55, // Adjusted to leave more space
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount:
                          fetchData(_categories[_currentCategoryIndex]).length,
                      itemBuilder: (context, index) {
                        final items = fetchData(
                            _categories[_currentCategoryIndex])[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 20, right: 20, left: 20, bottom: 15),
                          child: Row(
                            children: [
                              Text(
                                items['rank'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 15),
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage(items['image']),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                items['name'],
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                height: 25,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 5),
                                    const RotatedBox(
                                      quarterTurns: 1,
                                      child: Icon(
                                        Icons.back_hand,
                                        color: Color.fromARGB(255, 255, 187, 0),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      items['point'].toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildTopRank({
    required double radius,
    required double height,
    required String image,
    required String name,
    required String point,
  }) {
    return Column(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: AssetImage(image),
        ),
        SizedBox(
          height: height,
        ),
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(
          height: height,
        ),
        Container(
          height: 25,
          width: 70,
          decoration: BoxDecoration(
              color: Colors.black54, borderRadius: BorderRadius.circular(50)),
          child: Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              const Icon(
                Icons.back_hand,
                color: Color.fromARGB(255, 255, 187, 0),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                point,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
