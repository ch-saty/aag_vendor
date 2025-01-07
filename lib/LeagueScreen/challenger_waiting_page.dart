// ignore_for_file: use_build_context_synchronously

import 'package:AAG/HomeScreen/new_homescreen.dart';
import 'package:AAG/LeagueScreen/publish_schedule_challenger.dart';
import 'package:AAG/Pages/animated_pulsating_image.dart'; // Added import for new screen
import 'package:flutter/material.dart';

class ChallengeWaitTime extends StatefulWidget {
  final String? selectedPlayer;

  const ChallengeWaitTime({super.key, required this.selectedPlayer});

  @override
  _ChallengeWaitTimeState createState() => _ChallengeWaitTimeState();
}

class _ChallengeWaitTimeState extends State<ChallengeWaitTime> {
  int _countdown = 5; // 10 minutes

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _countdown--;
        });

        if (_countdown > 0) {
          _startCountdown();
        } else {
          // Timer completed
          _onTimerComplete();
        }
      }
    });
  }

  void _onTimerComplete() {
    setState(() {});

    // Show SnackBar and navigate to EditableScheduledLeagueScreen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Challenge accepted'),
        duration: Duration(seconds: 2),
      ),
    );

    // Delay navigation to allow SnackBar to be visible  EditableScheduledLeagueScreen
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ChallengerScreen(
            selectedPlayer: widget.selectedPlayer,
          ),
        ),
      );
    });
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
        backgroundColor: const Color.fromARGB(255, 102, 44, 144),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 32),
          // Spacer(),
          Text(
            "Challenger Name",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            widget.selectedPlayer ?? "",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
          ),
          SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("lib/images/mycard.png", width: 100),
              AnimatedPulseImage(
                imagePath: 'lib/images/vssss.png',
                height: 50,
                width: 50,
                animationDuration: Duration(seconds: 2),
              ),
              Image.asset("lib/images/oppcard.png", width: 100),
            ],
          ),
          SizedBox(height: 32),
          Text(
            "Status: Pending.....",
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 32),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.lock_clock_outlined,
                  size: 30,
                  color: Colors.black,
                ),
                SizedBox(width: 10),
                Text(
                  _formatTime(_countdown),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 64),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewHomescreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 255, 146, 29),
              fixedSize: Size(158, 46),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
            child: Text(
              "Home",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }
}
