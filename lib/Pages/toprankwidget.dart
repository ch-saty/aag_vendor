import 'package:flutter/material.dart';

class TopRanksWidget extends StatefulWidget {
  const TopRanksWidget({super.key});

  @override
  _TopRanksWidgetState createState() => _TopRanksWidgetState();
}

class _TopRanksWidgetState extends State<TopRanksWidget> {
  final List<String> _categories = ['Daily', 'Weekly', 'Monthly'];
  int _currentCategoryIndex = 0;

  Widget _buildTopRank({
    required double radius,
    required double height,
    required String image,
    required String name,
    required String point,
  }) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Background glow effect
            Container(
              width: radius * 2.5,
              height: radius * 2.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blue.withOpacity(0.5),
                  width: 4,
                ),
              ),
              transform: Matrix4.identity()..scale(1 + height * 0.1),
            ),
            // Profile image
            Container(
              width: radius * 2,
              height: radius * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          '$point pts',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // Background Image
        Positioned(
          top: -35,
          left: 0,
          right: 0,
          child: Image.asset(
            "lib/images/lb2.png",
            width: screenWidth,
            fit: BoxFit.contain,
          ),
        ),

        // Category Selector
        Positioned(
          top: screenHeight * 0.05,
          left: 0,
          right: 0,
          child: Center(
            child: SizedBox(
              width: screenWidth * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentCategoryIndex = _categories.indexOf(category);
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

        // Top 3 Ranks
        Positioned(
          top: screenHeight * 0.15,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Second Place
              _buildTopRank(
                radius: 20.0,
                height: 2,
                image: "lib/images/k.jpeg",
                name: "Hodges",
                point: "12323",
              ),

              // First Place
              _buildTopRank(
                radius: 25.0,
                height: 2,
                image: "lib/images/g.jpeg",
                name: "Johnny Rios",
                point: "23131",
              ),

              // Third Place
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
      ],
    );
  }
}
