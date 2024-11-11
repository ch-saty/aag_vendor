import 'dart:math';

import 'package:AAG/TournamentScreen/publishedtournamentscreen.dart';
import 'package:AAG/TournamentScreen/scheduletournamentscreen_2.dart';
import 'package:AAG/tobeadded/gradient_button.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

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
  late Animation<double> _gradientAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation1;
  late Animation<Color?> _colorAnimation2;

  @override
  void initState() {
    super.initState();
    _gradientAnimationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _gradientAnimation = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _gradientAnimationController,
        curve: Curves.linear,
      ),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * 3.14159).animate(
      CurvedAnimation(
        parent: _gradientAnimationController,
        curve: Curves.linear,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(
        parent: _gradientAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _colorAnimation1 = ColorTween(
      begin: Colors.purple.shade400,
      end: Colors.purple.shade800,
    ).animate(_gradientAnimationController);

    _colorAnimation2 = ColorTween(
      begin: Colors.deepPurple.shade400,
      end: Colors.deepPurple.shade800,
    ).animate(_gradientAnimationController);
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'TOURNAMENT',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'lib/images/idkbg.jpg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.purple.withOpacity(0.1),
                  Colors.deepPurple.withOpacity(0.1),
                ],
              ),
            ),
          ),
          // Animated background with concentric circles
          // CustomPaint(
          //   size: Size(MediaQuery.of(context).size.width,
          //       MediaQuery.of(context).size.height),
          //   painter: ConcentricCirclesPainter(
          //     animation: _gradientAnimationController,
          //     rotationAnimation: _rotationAnimation,
          //     scaleAnimation: _scaleAnimation,
          //     colorAnimation1: _colorAnimation1,
          //     colorAnimation2: _colorAnimation2,
          //   ),
          // ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage('lib/images/ch.png'),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
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
    );
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
                            'Schedule Tournament',
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
                              final DateTime? pickedDate = await showDatePicker(
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
                              final TimeOfDay? pickedTime =
                                  await showTimePicker(
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const EditableScheduledTournamentScreen(),
                                  ),
                                );
                              }
                            },
                            text: 'Schedule',
                          ),
                        ],
                      ),
                    ),
                  ),
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
