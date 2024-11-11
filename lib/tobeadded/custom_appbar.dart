import 'package:AAG/DailyTaskScreen/dailytaskscreen.dart';
import 'package:AAG/Notification_Screen/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'dart:math';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 2);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>
    with TickerProviderStateMixin {
  late AnimationController _wiggleController;
  late AnimationController _spinController;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();

    // Initialize audio player
    _audioPlayer = AudioPlayer();

    // Wiggle animation controller
    _wiggleController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Spin animation controller
    _spinController = AnimationController(
      duration: const Duration(milliseconds: 10000),
      vsync: this,
    );

    // Initial delay of 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      startAnimations();
    });

    // Repeat animations every 20 seconds
    Timer.periodic(const Duration(seconds: 20), (timer) {
      startAnimations();
    });
  }

  void startAnimations() async {
    // Play wiggle animation
    _wiggleController.forward().then((_) => _wiggleController.reverse());

    // Play spin animation
    _spinController.forward().then((_) => _spinController.reverse());

    // Play notification sound
    await _audioPlayer.play(AssetSource('images/bell_ring.mp3'));
  }

  @override
  void dispose() {
    _wiggleController.dispose();
    _spinController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return AppBar(
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        child: Container(
          width: 20,
          height: screenSize.height * 0.04,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            'lib/images/ch.png',
            height: 30,
            // width: 20,
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'lib/images/aag_white.png',
              height: screenSize.height * 0.04,
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            // Animated bell icon
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationScreen()),
                );
              },
              child: AnimatedBuilder(
                animation: _wiggleController,
                builder: (context, child) {
                  return Transform.translate(
                    offset:
                        Offset(sin(_wiggleController.value * 2 * pi) * 10, 0),
                    child: Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.white,
                      size: screenSize.height * 0.036,
                    ),
                  );
                },
              ),
            ),
            // Animated chakra
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DailyTaskScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: AnimatedBuilder(
                  animation: _spinController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _spinController.value * 2 * pi,
                      child: Image.asset(
                        'lib/images/chakra.png',
                        height: screenSize.height * 0.25,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(
          height: 4,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(239, 119, 17, 0),
                Color.fromRGBO(239, 119, 17, 1),
                Color.fromRGBO(239, 119, 17, 0),
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}
