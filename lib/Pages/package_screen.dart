// ignore_for_file: unused_import

import 'package:AAG/tobeadded/movingbutton.dart';
import 'package:flutter/material.dart';
import 'package:AAG/Pages/loginsignup.dart';
import 'package:AAG/Pages/otp_veri.dart';
// import 'package:rive/rive.dart' hide LinearGradient, Image;

import 'package:AAG/tobeadded/rivebutton.dart';

class PackageScreen extends StatelessWidget {
  const PackageScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'lib/images/idkbg.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        )),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'SUBSCRIPTION',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          child: Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            alignment: WrapAlignment.center,
                            children: [
                              // ₹/month
                              _buildPackageOption(
                                context,
                                'Standard',
                                '100K+ Followers',
                                '₹10,000/month',
                                'month',
                                const Color.fromARGB(255, 113, 47, 160),
                                const Color.fromARGB(255, 54, 47, 145),
                                constraints,
                              ),
                              _buildPackageOption(
                                context,
                                'Pro',
                                '500K+ Followers',
                                '₹20,000/month',
                                'month',
                                const Color.fromARGB(255, 239, 38, 209),
                                const Color.fromARGB(255, 255, 111, 79),
                                constraints,
                              ),
                              _buildPackageOption(
                                context,
                                'Elite',
                                '1M+ Followers',
                                '₹30,000/month',
                                'month',
                                const Color.fromARGB(155, 239, 105, 82),
                                const Color.fromARGB(155, 255, 249, 71),
                                constraints,
                              ),
                              _buildPackageOption(
                                context,
                                'Enterprise',
                                '100K+ Followers',
                                'Contact us for details',
                                'month',
                                const Color.fromARGB(255, 3, 189, 156),
                                const Color.fromARGB(255, 3, 87, 12),
                                constraints,
                              ),
                            ],
                          ),
                        );
                      },
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

  Widget _buildPackageOption(
    BuildContext context,
    String title,
    String subtitle,
    String price,
    String time,
    Color gradientColor1,
    Color gradientColor2,
    BoxConstraints constraints,
  ) {
    double cardWidth =
        constraints.maxWidth > 600 ? 255 : constraints.maxWidth * 0.8;
    return GestureDetector(
      onTap: () => _showPackageDetails(
          context, title, price, gradientColor1, gradientColor2),
      child: MovingGradientBorder(
        width: cardWidth,
        height: 90,
        gradientColors: [
          gradientColor1,
          gradientColor2,
          gradientColor1,
        ],
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: Text(
                  'Must Have $subtitle',
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPackageDetails(BuildContext context, String title, String price,
      Color gradientColor1, Color gradientColor2) {
    showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        return TweenAnimationBuilder(
          duration: const Duration(milliseconds: 300),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (BuildContext context, double value, Widget? child) {
            return Transform.scale(
              scale: value,
              child: Opacity(
                opacity: value,
                child: Dialog(
                  backgroundColor: Colors.transparent,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double maxWidth = constraints.maxWidth > 650
                          ? 500
                          : constraints.maxWidth;
                      double maxHeight = constraints.maxHeight > 900
                          ? 780
                          : constraints.maxHeight * 0.75;
                      Color gradientColor3 = Colors.red;
                      Color gradientColor4 =
                          const Color.fromARGB(255, 231, 57, 44);
                      return Container(
                        constraints: BoxConstraints(
                            maxWidth: maxWidth, maxHeight: maxHeight),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: const Color.fromARGB(138, 250, 250, 250),
                              width: 1.2),
                        ),
                        child: MovingGradientBorder(
                          width: maxWidth,
                          height: maxHeight,
                          gradientColors: [
                            gradientColor1.withOpacity(0.90),
                            gradientColor2.withOpacity(0.90),
                            gradientColor1.withOpacity(0.90),
                          ],
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const SizedBox(height: 20),
                                      Text(
                                        title.toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.orange,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      ..._getFeatures(title, gradientColor1,
                                          gradientColor2),
                                      ..._getFeatures2(title, gradientColor3,
                                          gradientColor4),
                                      const SizedBox(height: 30),
                                      MovingGradientBorder2(
                                        width: maxWidth,
                                        height: 40,
                                        gradientColors: [
                                          gradientColor1,
                                          gradientColor2,
                                          gradientColor1,
                                        ],
                                        child: Center(
                                          child: Text(
                                            price,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      PremiumShimmerButton(
                                        width: 160,
                                        height: 40,
                                        gradientColors: [
                                          gradientColor1,
                                          gradientColor2,
                                          gradientColor3
                                        ],
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) => SignUpPage(
                                                  selectedPlan: title),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'Subscribe',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      GestureDetector(
                                        onTap: () =>
                                            Navigator.of(context).pop(),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.transparent,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(7.0),
                                            child: TextButton(
                                              onPressed: null,
                                              child: Text(
                                                "Choose other Plan",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.white24,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
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
              ),
            );
          },
        );
      },
    );
  }

  // String _formatPrice(int price) {
  //   return price.toString().replaceAllMapped(
  //         RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
  //         (Match m) => '${m[1]},',
  //       );
  // }

  List<Widget> _getFeatures(
      String title, Color gradientColor1, Color gradientColor2) {
    List<String> features;
    switch (title.toLowerCase()) {
      case 'standard':
        features = [
          'Must Have 100K+ Followers.',
          'Upto 4 Themes/Skins for the game',
          'Monthly Feature Slots for the games.',
          'Performance-Based Event Unlock.',
          'Referral Bonus',
          'Analytics Dashboard',
          'Priority Support',
          'Unique Game invite link.',
          'Limited Games Access.'
        ];
        break;
      case 'pro':
        features = [
          'Must Have 500K+ Followers.',
          'Updated Daily Game Publish Limit.',
          'Upto 6 Themes/Skins for the game',
          'Daily/Monthly Feature Slots for the games.',
          'Performance-Based Events Unlock.',
          'Referral Bonus',
          'Analytics Dashboard',
          'Priority Support',
          'Unique Game invite link.',
          'Daily/ Weekly League Access option.',
          'Limited Time Tournament Access option.',
          'Weekly/Monthly Promotional Activities.',
          'Updated Games Access.',
        ];
        break;
      case 'elite':
        features = [
          'Must-Have 1M+ Followers.',
          'Updated Daily Game Publish Limit.',
          'Upto 12 Themes/Skins for the game',
          'Daily/Weekly/Monthly Feature Slots for the games.',
          'Daily/ Weekly/Monthly League Access option.',
          'Daily/Weekly/Monthly Tournament Access option.',
          'Daily/Weekly/Monthly Promotional Activities.',
          'Special Events Access.',
          'Referral Bonus',
          'Analytics Dashboard',
          'Customized Game invite link.',
          'All Platform Games Access.',
          'Priority Access to Beta Features.',
          'Additional Event Customization Options',
          'Dedicated Relationship Manager'
        ];
        break;
      case 'enterprise':
      default:
        features = [
          'Customized Features and Plan Details',
          'Custom Plans For Business Individuals Only',
          '10x Return',
        ];
        break;
    }

    return features.map((feature) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            GradientCheckbox(
              gradientColors: [gradientColor1, gradientColor2],
              value: true,
              onChanged: (bool? value) {},
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                feature,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  List<Widget> _getFeatures2(
      String title, Color gradientColor1, Color gradientColor2) {
    List<String> features;
    switch (title.toLowerCase()) {
      case 'standard':
        features = [
          'No Daily/ Weekly League Access option.',
          'No Daily/ Weekly Tournament Access option.',
          'No Dedicated Relationship Manager',
          'No Daily/ Weekly Promotional Activities.',
          'No Event Customization Option',
        ];
        break;
      case 'pro':
        features = [
          'Limited Event Customization Options',
          'No Dedicated Relationship Manager'
        ];
        break;
      case 'elite':
        features = [];
        break;
      case 'enterprise':
      default:
        features = [];
        break;
    }

    return features.map((feature) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            GradientCheckbox2(
              gradientColors: [gradientColor1, gradientColor2],
              value: true,
              onChanged: (bool? value) {},
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                feature,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}

class MovingGradientBorder extends StatefulWidget {
  final Widget child;
  final double width;
  final double height;
  final List<Color> gradientColors;

  const MovingGradientBorder({
    super.key,
    required this.child,
    required this.width,
    required this.height,
    required this.gradientColors,
  });

  @override
  _MovingGradientBorderState createState() => _MovingGradientBorderState();
}

class _MovingGradientBorderState extends State<MovingGradientBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              width: widget.width + 1,
              height: widget.height + 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: widget.gradientColors,
                  stops: [
                    _animation.value - 0.2,
                    _animation.value,
                    _animation.value + 0.2,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            );
          },
        ),
        Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: const Color.fromARGB(86, 0, 0, 0),
            borderRadius: BorderRadius.circular(16),
          ),
          child: widget.child,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class MovingGradientBorder2 extends StatefulWidget {
  final Widget child;
  final double width;
  final double height;
  final List<Color> gradientColors;

  const MovingGradientBorder2({
    super.key,
    required this.child,
    required this.width,
    required this.height,
    required this.gradientColors,
  });

  @override
  _MovingGradientBorder2State createState() => _MovingGradientBorder2State();
}

class _MovingGradientBorder2State extends State<MovingGradientBorder2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              width: widget.width + 1,
              height: widget.height + 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                gradient: LinearGradient(
                  colors: widget.gradientColors,
                  stops: [
                    _animation.value - 0.2,
                    _animation.value,
                    _animation.value + 0.2,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            );
          },
        ),
        Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(0),
          ),
          child: widget.child,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class GradientCheckbox extends StatelessWidget {
  final List<Color> gradientColors;
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const GradientCheckbox({
    super.key,
    required this.gradientColors,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onChanged != null) {
          onChanged!(!value);
        }
      },
      child: Container(
        width: 13,
        height: 13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: value
            ? const Icon(
                Icons.check_circle_outline_sharp,
                size: 15,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}

class GradientCheckbox2 extends StatelessWidget {
  final List<Color> gradientColors;
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const GradientCheckbox2({
    super.key,
    required this.gradientColors,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onChanged != null) {
          onChanged!(!value);
        }
      },
      child: Container(
        width: 13,
        height: 13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: value
            ? const Icon(
                Icons.remove_circle_outline_sharp,
                size: 15,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
