import 'package:flutter/material.dart';
import 'dart:async';

import 'package:AAG/Pages/loginsignup.dart';

class GameHomeScreen extends StatefulWidget {
  const GameHomeScreen({super.key});

  @override
  State<GameHomeScreen> createState() => _GameHomeScreenState();
}

class _GameHomeScreenState extends State<GameHomeScreen> {
  void _navigateToPage(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black,
            title: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/idkbg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aapka Apna Game',
      home: Scaffold(
        extendBodyBehindAppBar:
            true, // This ensures the body is behind the app bar
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu_sharp, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          title: Padding(
            padding: const EdgeInsets.only(),
            child: Center(
              child: Image.asset(
                'lib/images/aag.png',
                height: 35,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // open drawer
              },
              icon: Image.asset(
                'lib/images/ch.png',
                height: 30,
                width: 30,
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.black,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Image.asset(
                    'lib/images/aag.png',
                    height: 15,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
                  child: Text(
                    'DASHBOARD',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.white),
                  title:
                      const Text('Home', style: TextStyle(color: Colors.white)),
                  onTap: () => _navigateToPage(context, 'Home'),
                ),
                ListTile(
                  leading:
                      const Icon(Icons.account_circle, color: Colors.white),
                  title: const Text('Account',
                      style: TextStyle(color: Colors.white)),
                  onTap: () => _navigateToPage(context, 'Account'),
                ),
                ExpansionTile(
                  leading: const Icon(Icons.inventory, color: Colors.white),
                  title: const Text('Package',
                      style: TextStyle(color: Colors.white)),
                  trailing:
                      const Icon(Icons.arrow_drop_down, color: Colors.white),
                  children: [
                    ListTile(
                      title: const Text('Standard',
                          style: TextStyle(color: Colors.orange)),
                      onTap: () => _navigateToPage(context, 'Standard Package'),
                    ),
                    ListTile(
                      title: const Text('Premium ',
                          style: TextStyle(color: Colors.orange)),
                      onTap: () => _navigateToPage(context, 'Premium Package'),
                    ),
                    ListTile(
                      title: const Text('Regular ',
                          style: TextStyle(color: Colors.orange)),
                      onTap: () => _navigateToPage(context, 'Regular Package'),
                    ),
                    ListTile(
                      title: const Text('Custom ',
                          style: TextStyle(color: Colors.orange)),
                      onTap: () => _navigateToPage(context, 'Custom Package'),
                    ),
                  ],
                ),
                ListTile(
                  leading: const Icon(Icons.games, color: Colors.white),
                  title: const Text('Games',
                      style: TextStyle(color: Colors.white)),
                  onTap: () => _navigateToPage(context, 'Games'),
                ),
                ListTile(
                  leading: const Icon(Icons.gamepad, color: Colors.white),
                  title: const Text('Commission Gaming',
                      style: TextStyle(color: Colors.white)),
                  onTap: () => _navigateToPage(context, 'Commission Gaming'),
                ),
                ListTile(
                  leading: const Icon(Icons.payment, color: Colors.white),
                  title: const Text('Payment Request',
                      style: TextStyle(color: Colors.white)),
                  onTap: () => _navigateToPage(context, 'Payment Request'),
                ),
                ListTile(
                  leading: const Icon(Icons.description, color: Colors.white),
                  title:
                      const Text('T&C', style: TextStyle(color: Colors.white)),
                  onTap: () => _navigateToPage(context, 'T&C'),
                ),
                ListTile(
                  leading: const Icon(Icons.policy, color: Colors.white),
                  title: const Text('Vendor Policy',
                      style: TextStyle(color: Colors.white)),
                  onTap: () => _navigateToPage(context, 'Vendor Policy'),
                ),
                ListTile(
                  leading: const Icon(Icons.attach_money, color: Colors.white),
                  title: const Text('Games Commission',
                      style: TextStyle(color: Colors.white)),
                  onTap: () => _navigateToPage(context, 'Games Commission'),
                ),
                ListTile(
                  leading: const Icon(Icons.analytics, color: Colors.white),
                  title: const Text('Analytics / Statics',
                      style: TextStyle(color: Colors.white)),
                  onTap: () => _navigateToPage(context, 'Analytics / Statics'),
                ),
                Divider(color: Colors.grey.shade800),
                ListTile(
                  leading: const Icon(Icons.help_outline, color: Colors.white),
                  title: const Text('Help / Support',
                      style: TextStyle(color: Colors.white)),
                  onTap: () => _navigateToPage(context, 'Help / Support'),
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text('Logout Account',
                      style: TextStyle(color: Colors.red)),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const LoginScreen()));
                    // Handle Logout tap
                  },
                ),
              ],
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/images/idkbg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PromotionBanner(),

                  PrizesSlider(),

                  // Testimonials

                  const CategorySection(
                    title: 'Trending',
                    items: [
                      'lib/images/carrom.webp',
                      'lib/images/snl.webp',
                    ],
                    color: Colors.white30,
                    titleStyle: TextStyle(color: Colors.white),
                  ),

                  PromotionalsSlider(),

                  // Slider

                  const CategorySection(
                    title: 'Popular Game',
                    items: [
                      'lib/images/carrom.webp',
                      'lib/images/snl.webp',
                      'lib/images/archery.webp',
                      'lib/images/basketball.webp',
                      'lib/images/pool.webp',
                      'lib/images/ludo.webp',
                    ],
                    color: Colors.white12,
                    titleStyle: TextStyle(color: Colors.white),
                    height: 128,
                  ),
                  const CategorySection(
                    title: 'NewGames',
                    items: [
                      'lib/images/carrom.webp',
                      'lib/images/snl.webp',
                      'lib/images/archery.webp',
                      'lib/images/basketball.webp',
                    ],
                    color: Colors.white12,
                    titleStyle: TextStyle(color: Colors.white),
                  ),
                  const CategorySection(
                    title: 'CardGames',
                    items: [
                      'lib/images/carrom.webp',
                      'lib/images/snl.webp',
                      'lib/images/archery.webp',
                      'lib/images/basketball.webp',
                      'lib/images/pool.webp',
                    ],
                    color: Colors.white12,
                    titleStyle: TextStyle(color: Colors.white),
                  ),
                  const CategorySection(
                    title: 'BoardGames',
                    items: [
                      'lib/images/carrom.webp',
                      'lib/images/basketball.webp',
                      'lib/images/pool.webp',
                      'lib/images/snl.webp',
                      'lib/images/archery.webp',
                    ],
                    color: Colors.white12,
                    titleStyle: TextStyle(color: Colors.white),
                  ),
                  const CategorySection(
                    title: 'CricketGames',
                    items: [
                      'lib/images/archery.webp',
                      'lib/images/basketball.webp',
                      'lib/images/pool.webp',
                      'lib/images/ludo.webp',
                    ],
                    color: Colors.white12,
                    titleStyle: TextStyle(color: Colors.white),
                  ),
                  TestimonialsSlider(),
                  // const CategorySection(
                  //   title: 'CasualGames',
                  //   items: [
                  //     'lib/images/snl.webp',
                  //     'lib/images/archery.webp',
                  //     'lib/images/basketball.webp',
                  //     'lib/images/pool.webp',
                  //     'lib/images/ludo.webp',
                  //   ],
                  //   color: Colors.white12,
                  //   titleStyle: TextStyle(color: Colors.white),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PromotionBanner extends StatelessWidget {
  const PromotionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'lib/images/aag.png',
                height: 50,
                width: 0,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'WIN & WITHDRAW CASH INSTANTLY',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 30),
            GradientHoverButton(
              onPressed: () {
                // Your button press logic here
              },
              text: 'Register Now',
            ), // Use HoverButton here
          ],
        ),
      ),
    );
  }
}

class HoverCard extends StatefulWidget {
  final String imagePath;
  final String title;

  const HoverCard({
    required this.imagePath,
    required this.title,
    super.key,
  });

  @override
  HoverCardState createState() => HoverCardState();
}

class HoverCardState extends State<HoverCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              imagePath: widget.imagePath,
              title: widget.title,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: isHovered
                ? (Matrix4.identity()..scale(1.1))
                : Matrix4.identity(),
            child: Card(
              child: Column(
                children: [
                  Image.asset(widget.imagePath, height: 100, width: 100),
                  const SizedBox(height: 8),
                  Text(
                    widget.imagePath.split('/').last.split('.').first,
                    style: const TextStyle(fontSize: 0),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String imagePath;
  final String title;

  const DetailScreen({required this.imagePath, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Image.asset(imagePath),
      ),
    );
  }
}

class PrizesSlider extends StatefulWidget {
  final List<Map<String, String>> prizes = [
    {
      'text': 'First Prize',
      'author': 'Amount 1',
    },
    {
      'text': 'Refer and earn',
      'author': "Upto thousands",
    },
    {
      'text': 'Second Prize',
      'author': 'Amount 2',
    },
    {
      'text': 'Third Prize',
      'author': 'Amount 2',
    },
    {
      'text': 'And Many',
      'author': 'More with Millions',
    },
  ];

  PrizesSlider({super.key});

  @override
  _PrizesSliderState createState() => _PrizesSliderState();
}

class _PrizesSliderState extends State<PrizesSlider> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_currentPage < widget.prizes.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140, // Adjust height as needed
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.prizes.length,
        itemBuilder: (context, index) {
          final prizes = widget.prizes[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 100, // Adjust width as needed
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.monetization_on,
                      size: 40, color: Colors.green),
                  const SizedBox(height: 10),
                  Text(
                    prizes['text'] ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    prizes['author'] ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PromotionalsSlider extends StatefulWidget {
  final List<Map<String, String>> promotions = [
    {
      'image': 'lib/images/promo1.jpg',
    },
    {
      'image': 'lib/images/promo2.jpg',
    },
    {
      'image': 'lib/images/promo3.jpg',
    },
    {
      'image': 'lib/images/promo2.jpg',
    }
  ];

  PromotionalsSlider({super.key});

  @override
  _PromotionalsSliderState createState() => _PromotionalsSliderState();
}

class _PromotionalsSliderState extends State<PromotionalsSlider> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < widget.promotions.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Adjust height as needed
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.promotions.length,
        itemBuilder: (context, index) {
          final promotion = widget.promotions[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 300, // Adjust width as needed
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    promotion['image'] ?? '',
                    height: 160, // Adjust height as needed
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final String title;
  final List<String> items;
  final Color color;
  final TextStyle titleStyle;
  final double height;

  const CategorySection({
    super.key,
    required this.title,
    required this.items,
    required this.color,
    required this.titleStyle,
    this.height = 128,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        color: color,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: titleStyle,
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: height, // Adjust height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return HoverCard(
                    imagePath: items[index],
                    title: title,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TestimonialsSlider extends StatefulWidget {
  final List<Map<String, String>> testimonials = [
    {
      'text': 'Great game!',
      'author': 'User 1',
    },
    {
      'text': 'Love the gameplay',
      'author': "User 2",
    },
    {
      'text': 'Very addictive',
      'author': 'User 3',
    },
    {
      'text': 'Amazing graphics',
      'author': 'User 4',
    },
    {
      'text': 'Best game ever',
      'author': 'User 5',
    },
  ];

  TestimonialsSlider({super.key});

  @override
  _TestimonialsSliderState createState() => _TestimonialsSliderState();
}

class _TestimonialsSliderState extends State<TestimonialsSlider> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_currentPage < widget.testimonials.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150, // Adjust height as needed
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.testimonials.length,
        itemBuilder: (context, index) {
          final testimonial = widget.testimonials[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 300, // Adjust width as needed
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.person, size: 40, color: Colors.white),
                  const SizedBox(height: 10),
                  Text(
                    testimonial['text'] ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    testimonial['author'] ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class GradientHoverButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;

  const GradientHoverButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  _GradientHoverButtonState createState() => _GradientHoverButtonState();
}

class _GradientHoverButtonState extends State<GradientHoverButton> {
  bool _isHovering = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _isPressed
                  ? [
                      const Color(0xFF4CAF50),
                      const Color(0xFF2E7D32)
                    ] // Darker green when pressed
                  : _isHovering
                      ? [
                          const Color(0xFF66BB6A),
                          const Color(0xFF43A047)
                        ] // Slightly darker when hovering
                      : [
                          const Color(0xFF81C784),
                          const Color(0xFF4CAF50)
                        ], // Normal state
            ),
            boxShadow: [
              BoxShadow(
                color: _isPressed
                    ? Colors.green.withOpacity(0.4)
                    : _isHovering
                        ? Colors.green.withOpacity(0.6)
                        : Colors.green.withOpacity(0.3),
                spreadRadius: _isPressed ? 1 : 2,
                blurRadius: _isPressed ? 3 : 6,
                offset: _isPressed ? const Offset(0, 1) : const Offset(0, 3),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onPressed,
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Text(
                  widget.text,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
