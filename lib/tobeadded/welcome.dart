import 'dart:async';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:AAG/Pages/homescreen.dart';
import 'package:lottie/lottie.dart';
// ignore: unused_import
import 'package:AAG/tobeadded/onboardingscreen.dart';

class Welcomescreen extends StatefulWidget {
  const Welcomescreen({super.key});

  @override
  State<Welcomescreen> createState() => WelcomescreenState();
}

class WelcomescreenState extends State<Welcomescreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    });
  }

// import 'package:myfapp/onboardingscreen.dart';
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
              Lottie.asset(
                './assets/loader2.json',
                width: 300,
                height: 300,
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
