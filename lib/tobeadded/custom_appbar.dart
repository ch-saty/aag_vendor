import 'package:AAG/DailyTaskScreen/dailytaskscreen.dart';
import 'package:AAG/tobeadded/notification_icon_counter.dart';
import 'package:flutter/material.dart';
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
  // final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    // Initialize audio player
    // _audioPlayer.setSource(AssetSource('assets/sounds/bell_ring2.mp3'));
    // _audioPlayer.setVolume(1.0);

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

  // void _playSound() async {
  //   await _audioPlayer.play(AssetSource('assets/sounds/bell_ring2.mp3'));
  // }

  void startAnimations() async {
    // Play bell sound
    // _playSound();

    // Play wiggle animation
    _wiggleController.forward().then((_) => _wiggleController.reverse());

    // Play spin animation
    _spinController.forward().then((_) => _spinController.reverse());
  }

  @override
  void dispose() {
    _wiggleController.dispose();
    _spinController.dispose();
    // _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return AppBar(
      backgroundColor: const Color.fromARGB(255, 102, 44, 144),
      leading: GestureDetector(
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Image.asset(
            'lib/images/ch.png',
            height: 16,
            fit: BoxFit.contain,
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'lib/images/aag_white.png',
              height: 32,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            const NotificationIconWithCounter(),
            GestureDetector(
              onTap: () {
                // _playSound();
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
    );
  }
}
