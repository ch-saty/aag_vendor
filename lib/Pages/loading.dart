import 'dart:async';
import 'package:AAG/HomeScreen/homescreen_game.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:AAG/main.dart';
import 'package:lottie/lottie.dart';
// ignore: unused_import
import 'package:AAG/tobeadded/onboardingscreen.dart';

class Loadscreen extends StatefulWidget {
  const Loadscreen({super.key});

  @override
  State<Loadscreen> createState() => LoadscreenState();
}

class LoadscreenState extends State<Loadscreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const GameHomepage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/idkbg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Added a small gap between image and animation

              const SizedBox(height: 20),
              Lottie.asset(
                './assets/loader2.json',
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Lottie.asset(
                './assets/sus.json',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),

              // Adjusted this height to maintain overall spacing
            ],
          ),
        ),
      ),
    );
  }
}
