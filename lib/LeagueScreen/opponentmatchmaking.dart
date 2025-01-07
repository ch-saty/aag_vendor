// ignore_for_file: unused_import, unused_local_variable, use_build_context_synchronously

import 'dart:math';

import 'package:AAG/LeagueScreen/Opponent_SearchScreen.dart/overlay.dart';
import 'package:AAG/LeagueScreen/challenger_waiting_page.dart';
import 'package:AAG/LeagueScreen/publishedleaguescreen.dart';
import 'package:AAG/LeagueScreen/scheduledleaguescreen.dart';
import 'package:AAG/tobeadded/opponent_status_overlay.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:AAG/PublishGameScreen/publishgamescreen.dart';
import 'package:AAG/PublishGameScreen/scheduledgamescreen.dart';
import 'package:AAG/tobeadded/gradient_button.dart';
import 'package:intl/intl.dart';

import '../TournamentScreen/scheduletournamentscreen_2.dart';

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
  final String poolPrize;

  const OpponentSearchScreen({super.key, required this.poolPrize});

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
  bool _isSearching = false;
  int _remainingTime = 25;
  Timer? _timer;
  String? _opponentName;
  bool _showInitialIcons = true;
  bool _showAllChIcons = false;
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
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.51,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Available Challengers',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // IconButton(
                          //   icon: const Icon(Icons.close, color: Colors.black),
                          //   onPressed: () => Navigator.pop(context),
                          // ),
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
                                          const TextStyle(color: Colors.black),
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
                                                : Colors.orange),
                                      ),
                                      child: Icon(
                                        Icons.check_circle,
                                        color: isSelected
                                            ? Colors.green
                                            : Colors.orange,
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
                                    builder: (context) => ChallengeWaitTime(
                                        selectedPlayer:
                                            players[selectedPlayer!])),
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
                  child: Material(
                    // Add Material widget to ensure proper rendering
                    color: Colors.transparent,
                    child: TweenAnimationBuilder(
                      tween: Tween(begin: -100.0, end: 0.0),
                      duration: const Duration(milliseconds: 500),
                      builder: (context, double value, child) {
                        return Transform.translate(
                          offset: Offset(0, value),
                          child: Container(
                            margin: const EdgeInsets.all(16),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                                color: Colors.black87,
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
                )
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
                                  const EditableScheduledLeagueScreen(),
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

  void _startSearch() {
    setState(() {
      _isSearching = true;
      _remainingTime = 30;
      _opponentName = null;
      _showInitialIcons = false;
      _showAllChIcons = true;
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
      _showAllChIcons = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String entryfee = widget.poolPrize;
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
          "LEAGUES",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 102, 44, 144),
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
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
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 104,
                      width: 280,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color.fromRGBO(255, 146, 29, 1),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                'lib/images/ludo.png',
                                height: 90,
                                width: 60,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                          // const SizedBox(width: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'LUDO',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(255, 146, 29, 1),
                                      ),
                                    ),
                                  ],
                                ),
                                // SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'DEFAULT THEME',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Color.fromRGBO(255, 146, 29, 1),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Add your onTap functionality here
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              255, 146, 29, 1),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Entry Fee',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '₹${widget.poolPrize.toString()}', // Convert int to String
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (_challengeAccepted)
                    Column(
                      children: [
                        OpponentStatusContainer2(
                          text: 'YOUR\nCHALLENGER',
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('lib/images/mycard.png',
                                width: 100, height: 275, fit: BoxFit.fill),
                            const SizedBox(width: 20),
                            _buildVsImage(),
                            const SizedBox(width: 20),
                            Image.asset('lib/images/oppcard.png',
                                width: 100, height: 275, fit: BoxFit.fill),
                          ],
                        ),
                      ],
                    )
                  else if (_opponentFound)
                    Column(
                      children: [
                        OpponentStatusContainer2(
                          text: 'FOUND YOUR\nCHALLENGER',
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('lib/images/oppcard.png',
                                width: 100, height: 275, fit: BoxFit.fill),
                          ],
                        ),
                      ],
                    )
                  //Finding Challenger
                  else if (_showAllChIcons)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OpponentStatusContainer2(
                            text: 'FINDING YOUR\nCHALLENGER......',
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                height: 300,
                                child: Image.asset(
                                  'lib/images/mycard.png',
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              const SizedBox(width: 30),
                              _buildVsImage(),
                              const SizedBox(width: 30),
                              Container(
                                  width: 100,
                                  height: 300,
                                  child: FadeTransition(
                                    opacity: _flickerController,
                                    child: Image.asset(
                                        'lib/images/bluecard.png',
                                        fit: BoxFit.fill),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    )

                  // FIND Challenger
                  else if (_showInitialIcons && !_opponentFound)
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OpponentStatusContainer2(
                            text: 'FIND YOUR\nCHALLENGER',
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                height: 300,
                                child: Image.asset(
                                  'lib/images/mycard.png',
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              const SizedBox(width: 30),
                              _buildVsImage(),
                              const SizedBox(width: 30),
                              Container(
                                width: 100,
                                height: 300,
                                child: Image.asset(
                                  'lib/images/bluecard.png',
                                  fit: BoxFit.fill,
                                  // width: double.infinity,
                                  // Sheight: double.infinity,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 20),

                  // Status and button logic
                  if (_isSearching && _opponentName == null) ...[
                    Container(
                      padding: EdgeInsets.all(16),
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('lib/images/union.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'MATCHMAKING',
                            style: GoogleFonts.russoOne(
                              textStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '$_remainingTime',
                            style: const TextStyle(
                                color: Colors.orange, fontSize: 36),
                          ),
                          const SizedBox(height: 8),
                          CustomButton(
                            onTap: _stopSearch,
                            text: 'Cancel',
                          ),
                        ],
                      ),
                    )
                  ] else if (_opponentName != null && !_challengeAccepted) ...[
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      width: double.infinity,
                      // padding: EdgeInsets.all(16),
                      height: 280,
                      // height: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('lib/images/union.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Challenger Found',
                            style: GoogleFonts.russoOne(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _opponentName!,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(height: 16),
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
                        ],
                      ),
                    )
                  ] else if (_challengeAccepted) ...[
                    Container(
                      padding: EdgeInsets.all(24),
                      width: double.infinity,
                      // padding: EdgeInsets.all(16),
                      height: 280,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('lib/images/union.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 53,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'League Hosted',
                                style: GoogleFonts.russoOne(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const LeaguePublishedScreen(),
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
                          )
                        ],
                      ),
                    ),
                  ] else if (_showInitialIcons && !_opponentFound) ...[
                    Container(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('lib/images/union.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Choose a type of  Challenger',
                                style: GoogleFonts.russoOne(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
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
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
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
