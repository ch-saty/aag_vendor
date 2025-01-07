// ignore_for_file: unused_import

import 'package:AAG/HomeScreen/homescreen_game.dart';
import 'package:AAG/Pages/otp_veri.dart';
import 'package:AAG/Pages/signup.dart';
import 'package:AAG/tobeadded/gradient_button.dart';
import 'package:AAG/tobeadded/promo_slider.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../HomeScreen/new_homescreen.dart';

class OTPLoginVerificationPage extends StatefulWidget {
  final String phoneNumber;
  final String selectedPlan;

  const OTPLoginVerificationPage(
      {super.key, required this.phoneNumber, required this.selectedPlan});

  @override
  _OTPLoginVerificationPageState createState() =>
      _OTPLoginVerificationPageState();
}

class _OTPLoginVerificationPageState extends State<OTPLoginVerificationPage> {
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  int _timerSeconds = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    for (var node in _focusNodes) {
      node.addListener(_onFocusChange);
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerSeconds > 0) {
          _timerSeconds--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Image.asset(
            'lib/images/aag.png',
            height: 40,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Please Verify OTP',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Enter the 4-digit code sent to\nyour mobile number',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) => _OTPTextField()),
              ),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NewHomescreen(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Verify OTP',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive code? ",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle resend code
                    },
                    child: Text(
                      'Resend',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    ' (1:45)',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.removeListener(_onFocusChange);
      node.dispose();
    }
    super.dispose();
  }
}

class _OTPTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: TextField(
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        maxLength: 1,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}
