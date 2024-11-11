// ignore_for_file: unused_import, unused_local_variable, use_build_context_synchronously

import 'dart:math';
import 'dart:ui';

import 'package:AAG/LeagueScreen/publishedleaguescreen.dart';
import 'package:AAG/LeagueScreen/scheduledleaguescreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:AAG/PublishGameScreen/publishgamescreen.dart';
import 'package:AAG/PublishGameScreen/scheduledgamescreen.dart';
import 'package:AAG/tobeadded/gradient_button.dart';
import 'package:intl/intl.dart';

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

class OpponentSearchScreen extends StatefulWidget {
  const OpponentSearchScreen({super.key});

  @override
  _OpponentSearchScreenState createState() => _OpponentSearchScreenState();
}

class _OpponentSearchScreenState extends State<OpponentSearchScreen>
    with TickerProviderStateMixin {
  late AnimationController _rippleController;
  late AnimationController _pulsateController;
  String? scheduledInfo;
  late AnimationController _vsScaleController;
  late Animation<double> _vsScaleAnimation;
  late List<Animation<double>> _rippleAnimations;
  late AnimationController _flickerController;
  late AnimationController _gradientAnimationController;
  late Animation<double> _gradientAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation1;
  late Animation<Color?> _colorAnimation2;
  bool _isSearching = false;
  int _remainingTime = 25;
  Timer? _timer;
  String? _opponentName;
  bool _showInitialIcons = true;
  bool _showAllChIcons = false;
  bool _showOnlyCenterIcon = false;
  bool _opponentFound = false;
  bool _challengeAccepted = false;
  bool _vsVisible = false;

  @override
  void initState() {
    super.initState();
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
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _flickerController = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 1000), // 2.5 times per second = 400ms
    );

    _pulsateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _vsScaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _vsScaleAnimation = Tween<double>(begin: 1.25, end: 2.5).animate(
      CurvedAnimation(parent: _vsScaleController, curve: Curves.easeInOut),
    );

    _rippleAnimations = List.generate(
      20,
      (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _rippleController,
          curve:
              Interval(index * 0.1, (index + 1) * 0.1, curve: Curves.easeInOut),
        ),
      ),
    );

    // Delay to trigger fade-in effect for VS image
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _vsVisible = true;
      });
    });
  }

  @override
  void dispose() {
    _rippleController.dispose();
    _pulsateController.dispose();
    _vsScaleController.dispose();
    _flickerController.dispose();
    _gradientAnimationController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _showAvailableOpponentsPopup() {
    // List of random player names
    final List<String> players = [
      'Richima Singh',
      'John Doe',
      'Alice Walker',
      'Mike Ross',
      'Emma Thompson'
    ];

    // State variables
    int? selectedPlayer;
    bool showNotification = false;
    String? challengeMessage;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Stack(
            children: [
              Dialog(
                backgroundColor: Colors.transparent,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.61,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(53, 3, 90, 1),
                        Color.fromRGBO(81, 9, 133, 1),
                        Color.fromRGBO(53, 3, 90, 1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Available Challengers',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: players.length,
                          itemBuilder: (context, index) {
                            final bool isSelected = selectedPlayer == index;

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  Image.asset('lib/images/ch.png',
                                      width: 40, height: 40),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Text(
                                      players[index],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (selectedPlayer == index) {
                                          selectedPlayer = null;
                                        } else {
                                          selectedPlayer = index;
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: isSelected
                                                ? Colors.green
                                                : Colors.white),
                                      ),
                                      child: Icon(
                                        Icons.check_circle,
                                        color: isSelected
                                            ? Colors.green
                                            : Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        onTap: () {
                          if (selectedPlayer != null) {
                            setState(() {
                              showNotification = true;
                              challengeMessage =
                                  'Challenge request sent to ${players[selectedPlayer!]}';
                            });

                            // Hide notification after 3 seconds
                            Future.delayed(const Duration(seconds: 3), () {
                              if (mounted) {
                                setState(() {
                                  showNotification = false;
                                });
                              }
                            });

                            // Navigate after a short delay
                            Future.delayed(const Duration(seconds: 3), () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ScheduledLeagueScreen(),
                                ),
                              );
                            });
                          }
                        },
                        text: 'Request',
                      ),
                    ],
                  ),
                ),
              ),
              if (showNotification)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: -100, end: 0),
                    duration: const Duration(milliseconds: 500),
                    builder: (context, double value, child) {
                      return Transform.translate(
                        offset: Offset(0, value),
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(53, 3, 90, 1),
                                Color.fromRGBO(81, 9, 133, 1),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            challengeMessage ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        });
      },
    );
  }

  Future<void> _showSchedulePopup() async {
    DateTime? selectedDate;
    TimeOfDay? selectedTime;
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

  void _startSearch() {
    setState(() {
      _isSearching = true;
      _remainingTime = 30;
      _opponentName = null;
      _showInitialIcons = false;
      _showAllChIcons = true;
      _showOnlyCenterIcon = false;
      _opponentFound = false;
      _challengeAccepted = false;
    });
    _startTimer();
    _rippleController.reset();
    _rippleController.repeat();
    _flickerController.repeat(reverse: true);
    _pulsateController.repeat(reverse: true);
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _timer?.cancel();
      _showInitialIcons = true;
      _showAllChIcons = false;
      _showOnlyCenterIcon = false;
    });
    _rippleController.stop();
    _pulsateController.stop();
    _flickerController.stop();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime >= 0) {
          _remainingTime--;
        } else {
          _stopSearch();
        }
      });

      // Simulating finding an opponent after 10 seconds
      if (_remainingTime == 20) {
        setState(() {
          _opponentName = "Rohit Sethi";
          _showAllChIcons = false;
          _showOnlyCenterIcon = true;
          _opponentFound = true;
          _showInitialIcons = false;
          _isSearching = false;
        });
        _rippleController.stop();
        _pulsateController.stop();
      }
    });
  }

  void _acceptChallenge() {
    setState(() {
      _challengeAccepted = true;
      _showInitialIcons = false;
      _showOnlyCenterIcon = false;
      _showAllChIcons = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'LEAGUES',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'lib/images/idkbg.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          if (_isSearching && !_opponentFound)
            AnimatedBuilder(
              animation: _rippleController,
              builder: (context, child) {
                return CustomPaint(
                  painter: RipplePainter(_rippleAnimations),
                  child: Container(),
                );
              },
            ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 200,
                ),
                if (_challengeAccepted)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('lib/images/mycard.png',
                          width: 100, height: 200),
                      const SizedBox(width: 20),
                      _buildVsImage(),
                      const SizedBox(width: 20),
                      Image.asset('lib/images/oppcard.png',
                          width: 100, height: 200),
                    ],
                  )
                else if (_showOnlyCenterIcon && _opponentFound)
                  Image.asset('lib/images/oppcard.png', width: 100, height: 200)
                else if (_showAllChIcons)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('lib/images/card.png',
                          width: 100, height: 200),
                      const SizedBox(width: 20),
                      _buildVsImage(),
                      const SizedBox(width: 20),
                      FadeTransition(
                        opacity: _flickerController,
                        child: Image.asset('lib/images/bluecard.png',
                            width: 100, height: 200),
                      )
                    ],
                  )
                else if (_showInitialIcons && !_opponentFound)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('lib/images/mycard.png',
                          width: 100, height: 200),
                      const SizedBox(width: 30),
                      _buildVsImage(),
                      const SizedBox(width: 30),
                      Image.asset('lib/images/bluecard.png',
                          width: 100, height: 200),
                    ],
                  ),
                const SizedBox(height: 20),

                // Status and button logic
                if (_isSearching && _opponentName == null) ...[
                  const Text(
                    'Matchmaking',
                    style: TextStyle(color: Colors.orange, fontSize: 24),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    '$_remainingTime',
                    style: const TextStyle(color: Colors.white, fontSize: 36),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    onTap: _stopSearch,
                    text: 'Cancel',
                  ),
                ] else if (_opponentName != null && !_challengeAccepted) ...[
                  const Text(
                    'Challenger Found',
                    style: TextStyle(color: Colors.orange, fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _opponentName!,
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        onTap: _acceptChallenge,
                        text: 'Challenge',
                      ),
                      const SizedBox(width: 20),
                      CustomButton(
                        onTap: _startSearch,
                        text: 'New?',
                      ),
                    ],
                  ),
                ] else if (_challengeAccepted) ...[
                  Column(
                    children: [
                      Text(
                        'Your Challenger',
                        style:
                            const TextStyle(color: Colors.orange, fontSize: 24),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        _opponentName!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LeaguePublishedScreen(),
                            ),
                          );
                        },
                        text: 'Publish',
                      ),
                      const SizedBox(width: 50),
                      CustomButton(
                        onTap: () {
                          _showSchedulePopup();
                        },
                        text: 'Schedule',
                      ),
                    ],
                  ),
                ] else if (_showInitialIcons && !_opponentFound) ...[
                  Column(
                    children: [
                      const Text(
                        'Find Challenger',
                        style: TextStyle(color: Colors.orange, fontSize: 24),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      CustomButton(
                        onTap: _startSearch,
                        text: 'Random',
                      ),
                      const SizedBox(width: 20),
                      CustomButton(
                        onTap: _showAvailableOpponentsPopup,
                        text: 'Available',
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVsImage() {
    return AnimatedOpacity(
      opacity: _vsVisible ? 1.0 : 0.0,
      duration: const Duration(seconds: 1),
      child: ScaleTransition(
        scale: _vsScaleAnimation,
        child: Image.asset('lib/images/vs2.png', width: 40, height: 40),
      ),
    );
  }
}

class RipplePainter extends CustomPainter {
  final List<Animation<double>> animations;
  final int circlesPerRing = 1; // Number of circles per animation
  final double spacingFactor = 0.5;

  RipplePainter(this.animations);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromRGBO(206, 138, 255, 1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius =
        math.sqrt(size.width * size.width + size.height * size.height) / 2;

    for (var anim in animations) {
      // Draw multiple circles for each animation value
      for (int i = 0; i < circlesPerRing; i++) {
        final adjustedValue = anim.value - (i * spacingFactor);
        if (adjustedValue > 0 && adjustedValue <= 1) {
          final radius = maxRadius * adjustedValue;
          paint.color = const Color.fromRGBO(206, 138, 255, 1)
              .withOpacity(1 - adjustedValue);
          canvas.drawCircle(center, radius, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
