// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:AAG/PublishGameScreen/schedulegamescreen_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduledGameScreen extends StatefulWidget {
  const ScheduledGameScreen({super.key});

  @override
  _ScheduledGameScreenState createState() => _ScheduledGameScreenState();
}

class _ScheduledGameScreenState extends State<ScheduledGameScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _visible = false;

  // Add animations for schedule popup
  late AnimationController _gradientAnimationController;
  String? scheduledInfo;

  @override
  void initState() {
    super.initState();

    // Initialize Animation Controller for main screen
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Initialize Animation Controller for schedule popup
    _gradientAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    // Delay to trigger fade-in effect
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
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
                          // Close the bottom sheet first
                          Navigator.pop(context);

                          // Create the scheduled info
                          String formattedSchedule =
                              "Scheduled for ${DateFormat('EEE, MMM d, yyyy').format(selectedDate!)} at ${selectedTime!.format(context)}";

                          // Show SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(formattedSchedule),
                              duration: const Duration(seconds: 2),
                            ),
                          );

                          // Navigate to EditableScheduledTournamentScreen after 2 seconds
                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditableScheduledGameScreen(),
                              ),
                            );
                          });
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
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
            Expanded(
              flex: 3,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedOpacity(
                      opacity: _visible ? 1.0 : 0.0,
                      duration: const Duration(seconds: 1),
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Image.asset(
                          'lib/images/war.png',
                          height: 306,
                          width: 311,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'Your Game has \n     Scheduled',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(30, 15, 50, 0.85),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 20, bottom: 10, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              'Edit',
                              style:
                                  TextStyle(color: Colors.orange, fontSize: 14),
                            ),
                            GestureDetector(
                              onTap: _showSchedulePopup,
                              child: const Icon(
                                Icons.edit_calendar_outlined,
                                color: Colors.orange,
                                size: 14,
                              ),
                            )
                          ],
                        ),
                      ),
                      _buildTextField('https://game.aag.com/jw2-zesm-pzb'),
                      _buildCopyButton(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('lib/images/Facebook.png', height: 80),
                          Image.asset('lib/images/Instagram.png', height: 80),
                          Image.asset('lib/images/Elemento.png', height: 80),
                          Image.asset('lib/images/Snapchat.png', height: 80),
                        ],
                      ),
                      const Text(
                        'Share the special invite link',
                        style: TextStyle(
                          color: Colors.white24,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromRGBO(22, 13, 37, 1),
        border: const Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 145, 30, 233),
            width: 2.0,
          ),
        ),
      ),
      child: TextField(
        enabled: false,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white70),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildCopyButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: 45,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.purple, Colors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          // Add copy functionality here
        },
        child: const Text(
          'Copy',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Custom Painter for gradient effects

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
