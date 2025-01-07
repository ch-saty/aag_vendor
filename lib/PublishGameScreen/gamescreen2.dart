// ignore_for_file: unused_import, use_build_context_synchronously

import 'dart:math';

import 'package:AAG/LeagueScreen/scheduledleaguescreen.dart';
import 'package:AAG/PublishGameScreen/schedulegamescreen_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:AAG/PublishGameScreen/publishgamescreen.dart';
import 'package:AAG/PublishGameScreen/scheduledgamescreen.dart';
import 'package:AAG/tobeadded/gradient_button.dart';
import 'package:intl/intl.dart';

class PublishLudoScreen extends StatefulWidget {
  const PublishLudoScreen({super.key});

  @override
  _PublishLudoScreenState createState() => _PublishLudoScreenState();
}

class _PublishLudoScreenState extends State<PublishLudoScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int selectedThemeIndex = -1;
  int selectedFeeIndex = -1;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? scheduledInfo;
  late AnimationController _gradientAnimationController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _gradientAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _gradientAnimationController.dispose();
    super.dispose();
  }

  Future<void> _showSchedulePopup() async {
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color.fromARGB(255, 102, 44, 144),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Schedule Game',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      height: 1,
                      color: Colors.white24,
                    ),
                    ListTile(
                      title: const Text(
                        'Select Date',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedDate != null
                                ? DateFormat('EEE, MMM d, yyyy')
                                    .format(selectedDate!)
                                : 'Choose a date',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
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
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedTime != null
                                ? selectedTime!.format(context)
                                : 'Choose a time',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
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
                    ElevatedButton(
                      onPressed: () {
                        if (selectedDate != null && selectedTime != null) {
                          setState(() {
                            scheduledInfo =
                                "Scheduled on ${DateFormat('EEE, MMM d, yyyy').format(selectedDate!)} at ${selectedTime!.format(context)}";
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const EditableScheduledGameScreen(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Schedule'),
                    ),
                  ],
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
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "PUBLISH GAMES",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 102, 44, 144),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.orange,
              indicatorWeight: 3,
              labelColor: Colors.orange, // Active tab font color
              unselectedLabelColor: Colors.black, // Inactive tab font color
              tabs: const [
                Tab(
                  text: 'THEMES',
                ),
                Tab(
                  text: 'ENTRY FEES',
                ),
              ],
            ),
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
                padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.04,
                    vertical: constraints.maxWidth * 0.08),
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
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: selectedThemeIndex == index
                                ? Color.fromRGBO(255, 146, 29, 1)
                                : Color.fromARGB(255, 102, 44, 144),
                            /**
                                 * Color.fromRGBO(255, 146, 29, 1),


       Color.fromARGB(255, 102, 44, 144),
                                 */
                            width: selectedThemeIndex == index ? 4 : 1,
                          ),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
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
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.black.withOpacity(0.7),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.lock,
                                        color: Colors.white, size: 20),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    _buildHeader(constraints),
                                  ],
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
                padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.04,
                    vertical: constraints.maxWidth * 0.08),
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
                          borderRadius: BorderRadius.circular(8),
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
                              borderRadius: BorderRadius.circular(8),
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
                                    bottom: Radius.circular(4),
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
                            builder: (context) => const PublishedGameScreen(),
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

  Widget _buildHeader(BoxConstraints constraints) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 2,
          margin: const EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 102, 44, 144),
                Colors.orange.withOpacity(0.7),
                Color.fromARGB(255, 102, 44, 144),
              ],
            ),
          ),
        ),
        CustomPaint(
          painter: HexagonPainter(
              color: Color.fromARGB(255, 102, 44, 144),
              gridAspectRatio: constraints.maxWidth > 600 ? 0.7 : 0.5,
              constraintMaxWidth: constraints.maxWidth),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '  LEVEL B',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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

class HexagonPainter extends CustomPainter {
  final Color color;
  final double gridAspectRatio;
  final double constraintMaxWidth;

  HexagonPainter(
      {required this.color,
      required this.gridAspectRatio,
      required this.constraintMaxWidth});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Calculate card width based on grid constraints
    double cardWidth = constraintMaxWidth > 600
        ? (constraintMaxWidth * 0.92) / 4 // 4 columns on wider screens
        : (constraintMaxWidth * 0.92) / 3; // 3 columns on narrower screens

    // Adjust path to match card width proportions
    Path path = Path();
    path.moveTo(cardWidth * 0.2, size.height * 0.5);
    path.lineTo(cardWidth * 0.3, 0);
    path.lineTo(cardWidth * 0.7, 0);
    path.lineTo(cardWidth * 0.8, size.height * 0.5);
    path.lineTo(cardWidth * 0.7, size.height);
    path.lineTo(cardWidth * 0.3, size.height);
    path.close();

    canvas.drawPath(path, paint);

    Paint borderPaint = Paint()
      ..color = const Color(0xFFE97411)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
