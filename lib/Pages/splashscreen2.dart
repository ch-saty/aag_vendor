// ignore_for_file: unused_import, duplicate_ignore

import 'dart:async';
import 'package:AAG/Pages/login_vendor_2.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:AAG/main.dart';
// import 'package:lottie/lottie.dart';
import 'package:AAG/Pages/loginsignup.dart';
// ignore: unused_import
import 'package:AAG/tobeadded/onboardingscreen.dart';

class Splashscreen2 extends StatefulWidget {
  final String phoneNumber;
  final String selectedPlan;
  const Splashscreen2(
      {super.key, required this.phoneNumber, required this.selectedPlan});

  @override
  State<Splashscreen2> createState() => _SplashscreenState2();
}

class _SplashscreenState2 extends State<Splashscreen2> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginVendor2(
            phoneNumber: _phoneController.text,
            selectedPlan: widget.selectedPlan,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('lib/images/idkbg.jpg'),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'lib/images/aag_white.png',
                height: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Logging in...."),
              // const SizedBox(
              //     height: 120),
              // Lottie.asset(
              //   './assets/loader.json',
              //   width: 250,
              //   height: 250,
              //   fit: BoxFit.cover,
              // ),
              // const SizedBox(height: 20),
              // Adjusted this height to maintain overall spacing
            ],
          ),
        ),
      ),
    );
  }
}
