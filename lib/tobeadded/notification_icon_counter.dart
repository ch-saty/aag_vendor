import 'package:AAG/Notification_Screen/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:math';
import 'dart:async';

class NotificationIconWithCounter extends StatefulWidget {
  const NotificationIconWithCounter({super.key});

  @override
  State<NotificationIconWithCounter> createState() =>
      _NotificationIconWithCounterState();
}

class _NotificationIconWithCounterState
    extends State<NotificationIconWithCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _wiggleController;
  late Timer _wiggleTimer;

  final AudioPlayer _audioPlayer = AudioPlayer();

  int _counter = 0;

  Future<void> _playSound() async {
    try {
      await _audioPlayer.setAsset('assets/sounds/dice-142528.mp3');
      await _audioPlayer.play();
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    _wiggleController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _wiggleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _counter++;
          _playSound();
        });
      }
    });

    // Start periodic timer to trigger wiggle every 10 seconds
    _wiggleTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _wiggleController.forward().then((_) => _wiggleController.reset());
    });
  }

  @override
  void dispose() {
    _wiggleTimer.cancel();
    _wiggleController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NotificationScreen(),
          ),
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedBuilder(
            animation: _wiggleController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(sin(_wiggleController.value * 2 * pi) * 10, 0),
                child: Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.white,
                  size: screenSize.height * 0.036,
                ),
              );
            },
          ),
          if (_counter > 0)
            Positioned(
              right: -8,
              top: -8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  _counter.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
