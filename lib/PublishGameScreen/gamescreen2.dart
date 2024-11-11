// ignore_for_file: unused_import

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:AAG/PublishGameScreen/publishgamescreen.dart';
import 'package:AAG/PublishGameScreen/scheduledgamescreen.dart';
import 'package:AAG/tobeadded/gradient_button.dart';
import 'package:intl/intl.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  _GamesScreenState createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int selectedThemeIndex = -1;
  int selectedFeeIndex = -1;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? scheduledInfo;
  late AnimationController _gradientAnimationController;
  late Animation<double> _gradientAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation1;
  late Animation<Color?> _colorAnimation2;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _gradientAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _gradientAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * 3.14159, // Full rotation in radians
    ).animate(CurvedAnimation(
      parent: _gradientAnimationController,
      curve: Curves.easeInOutCubic,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _gradientAnimationController,
      curve: Curves.elasticOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _gradientAnimationController,
      curve: Curves.easeInOutSine,
    ));

    _colorAnimation1 = ColorTween(
      begin: Colors.purple[900],
      end: Colors.deepPurple[700],
    ).animate(CurvedAnimation(
      parent: _gradientAnimationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeInOutCubic),
    ));

    _colorAnimation2 = ColorTween(
      begin: Colors.deepPurple[700],
      end: Colors.purple[900],
    ).animate(CurvedAnimation(
      parent: _gradientAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeInOutCubic),
    ));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _gradientAnimationController.dispose();
    super.dispose();
  }

  Future<void> _showSchedulePopup() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (BuildContext context) {
        return AnimatedBuilder(
          animation: _gradientAnimationController,
          builder: (context, child) {
            return ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(25)),
              child: CustomPaint(
                painter: ComplexGradientPainter(
                  animation: _gradientAnimation,
                  rotationAnimation: _rotationAnimation,
                  scaleAnimation: _scaleAnimation,
                  colorAnimation1: _colorAnimation1,
                  colorAnimation2: _colorAnimation2,
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(25)),
                      color: Colors.black.withOpacity(0.1),
                    ),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20,
                            MediaQuery.of(context).viewInsets.bottom + 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Schedule Game',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 8.0,
                                    color: Colors.black26,
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                              ),
                            ),
                            // Add a subtle shimmer effect to the divider
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              height: 1,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(_gradientAnimation.value, 0),
                                  end: Alignment(-_gradientAnimation.value, 0),
                                  colors: const [
                                    Colors.white24,
                                    Colors.white,
                                    Colors.white24,
                                  ],
                                ),
                              ),
                            ),
                            // Rest of your existing popup content
                            ListTile(
                              title: const Text(
                                'Select Date',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                selectedDate != null
                                    ? DateFormat('EEE, MMM d, yyyy')
                                        .format(selectedDate!)
                                    : 'Choose a date',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ),
                              trailing: Icon(
                                Icons.calendar_today,
                                color: Colors.white.withOpacity(0.9),
                              ),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2101),
                                );
                                if (pickedDate != null) {
                                  setState(() {
                                    selectedDate = pickedDate;
                                  });
                                }
                              },
                            ),
                            ListTile(
                              title: const Text(
                                'Select Time',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                selectedTime != null
                                    ? selectedTime!.format(context)
                                    : 'Choose a time',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ),
                              trailing: Icon(
                                Icons.access_time,
                                color: Colors.white.withOpacity(0.9),
                              ),
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (pickedTime != null) {
                                  setState(() {
                                    selectedTime = pickedTime;
                                  });
                                }
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomButton(
                              onTap: () {
                                if (selectedDate != null &&
                                    selectedTime != null) {
                                  setState(() {
                                    scheduledInfo =
                                        "Scheduled on ${DateFormat('EEE, MMM d, yyyy').format(selectedDate!)} at ${selectedTime!.format(context)}";
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ScheduledGameScreen(),
                                    ),
                                  );
                                }
                              },
                              text: 'Schedule',
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
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
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 70),
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.orange,
              indicatorWeight: 3,
              labelColor: Colors.orange,
              unselectedLabelColor: Colors.white,
              onTap: (_) {
                _tabController.index = _tabController.previousIndex;
              },
              tabs: const [
                Tab(text: 'THEMES'),
                Tab(text: 'ENTRY FEES'),
              ],
            ),
            // const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildThemesView(),
                  _buildEntryFeesView(),
                ],
              ),
            ),
            // if (scheduledInfo != null)
            //   Padding(
            //     padding: const EdgeInsets.all(10),
            //     child: Card(
            //       color: Colors.white,
            //       elevation: 4,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       child: Padding(
            //         padding: const EdgeInsets.all(10),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             const Text(
            //               'Scheduled Game',
            //               style: TextStyle(
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.bold,
            //                 color: Colors.black,
            //               ),
            //             ),
            //             const SizedBox(height: 5),
            //             Text(
            //               scheduledInfo!,
            //               style: const TextStyle(
            //                   fontSize: 14, color: Colors.black87),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemesView() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double gridAspectRatio = constraints.maxWidth > 600 ? 0.7 : 0.5;

        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(constraints.maxWidth * 0.04),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constraints.maxWidth > 600 ? 4 : 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: gridAspectRatio,
                  ),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedThemeIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: selectedThemeIndex == index
                                ? Colors.purple
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'lib/images/jungle.jpeg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),

                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.purple,
                                      Colors.deepPurple,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(8),
                                  ),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  index < 2 ? 'DEFAULT' : 'NATURE',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            // Lock overlay for locked themes
                            if (index >= 2)
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black.withOpacity(0.7),
                                ),
                                child: const Center(
                                  child: Icon(Icons.lock,
                                      color: Colors.white, size: 24),
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
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                onTap: () {
                  _tabController.animateTo(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                text: 'Next',
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEntryFeesView() {
    final fees = [2, 3, 4, 5, 6, 8, 10, 50, 100];

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(constraints.maxWidth * 0.04),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constraints.maxWidth > 600 ? 4 : 3,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFeeIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: selectedFeeIndex == index
                                ? Colors.orange
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'lib/images/g1.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.orange, Colors.deepOrange],
                                  ),
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(10),
                                  ),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.currency_rupee,
                                        color: Colors.white, size: 14),
                                    Text(
                                      fees[index].toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GamePublishedScreen(),
                          ),
                        );
                      },
                      text: 'Publish',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomButton(
                      onTap: _showSchedulePopup,
                      text: 'Schedule',
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class ComplexGradientPainter extends CustomPainter {
  final Animation<double> animation;
  final Animation<double> rotationAnimation;
  final Animation<double> scaleAnimation;
  final Animation<Color?> colorAnimation1;
  final Animation<Color?> colorAnimation2;

  ComplexGradientPainter({
    required this.animation,
    required this.rotationAnimation,
    required this.scaleAnimation,
    required this.colorAnimation1,
    required this.colorAnimation2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final center = Offset(size.width / 2, size.height / 2);

    // Create multiple gradient layers
    for (int i = 0; i < 3; i++) {
      final double phase = animation.value + (i * 3.14159 / 3);
      final double scale = scaleAnimation.value + (i * 0.02);

      final Gradient gradient = RadialGradient(
        center: Alignment(
          cos(phase) * 0.5,
          sin(phase) * 0.5,
        ),
        colors: [
          colorAnimation1.value ?? Colors.purple[900]!,
          colorAnimation2.value ?? Colors.deepPurple[700]!,
          Colors.purple[500]!.withOpacity(0.5),
          Colors.deepPurple[900]!.withOpacity(0.8),
        ],
        stops: const [0.0, 0.3, 0.6, 1.0],
        radius: 1.5 * scale,
      );

      final Paint paint = Paint()
        ..shader = gradient.createShader(rect)
        ..blendMode = BlendMode.overlay;

      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(rotationAnimation.value * 0.2 * i);
      canvas.scale(scale);
      canvas.translate(-center.dx, -center.dy);
      canvas.drawRect(rect, paint);
      canvas.restore();
    }

    // Add metallic shine effect
    final Paint shinePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment(cos(animation.value), sin(animation.value)),
        end: Alignment(
            cos(animation.value + 3.14159), sin(animation.value + 3.14159)),
        colors: [
          Colors.white.withOpacity(0.0),
          Colors.white.withOpacity(0.2),
          Colors.white.withOpacity(0.0),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(rect)
      ..blendMode = BlendMode.overlay;

    canvas.drawRect(rect, shinePaint);
  }

  @override
  bool shouldRepaint(ComplexGradientPainter oldDelegate) => true;
}
