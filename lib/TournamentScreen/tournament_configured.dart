// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:AAG/TournamentScreen/publishedtournamentscreen.dart';
import 'package:AAG/TournamentScreen/scheduletournamentscreen_2.dart';
import 'package:AAG/tobeadded/gradient_button.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class TournamentConfiguredScreen extends StatefulWidget {
  const TournamentConfiguredScreen({super.key});

  @override
  State<TournamentConfiguredScreen> createState() =>
      _TournamentConfiguredScreenState();
}

class _TournamentConfiguredScreenState extends State<TournamentConfiguredScreen>
    with SingleTickerProviderStateMixin {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  late AnimationController _gradientAnimationController;

  @override
  void initState() {
    super.initState();
    _gradientAnimationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _gradientAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "TOURNAMENT",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 102, 44, 144),
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 129,
                      height: 208,
                      child: Image.asset(
                        'lib/images/mycard.png',
                        fit: BoxFit.contain,
                      )),
                  const SizedBox(height: 24),
                  const Text(
                    'Your Tournament has\n  been Configured',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        text: 'Publish',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const TournamentPublishedScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 20),
                      CustomButton(
                        text: 'Schedule',
                        onTap: () => _showSchedulePopup(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const EditableScheduledTournamentScreen(),
                          ),
                        );
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
}

class ConcentricCirclesPainter extends CustomPainter {
  final Animation<double> animation;
  final Animation<double> rotationAnimation;
  final Animation<double> scaleAnimation;
  final Animation<Color?> colorAnimation1;
  final Animation<Color?> colorAnimation2;

  ConcentricCirclesPainter({
    required this.animation,
    required this.rotationAnimation,
    required this.scaleAnimation,
    required this.colorAnimation1,
    required this.colorAnimation2,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width * 0.8;

    for (int i = 5; i >= 1; i--) {
      final radius = maxRadius * (i / 5) * scaleAnimation.value;
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..shader = LinearGradient(
          colors: [
            colorAnimation1.value ?? Colors.transparent.withOpacity(0.1),
            colorAnimation2.value ?? Colors.transparent.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Rect.fromCircle(center: center, radius: radius));

      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(rotationAnimation.value * (i % 2 == 0 ? 1 : -1));
      canvas.translate(-center.dx, -center.dy);
      canvas.drawCircle(center, radius, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(ConcentricCirclesPainter oldDelegate) => true;
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
  }) : super(repaint: animation);

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
