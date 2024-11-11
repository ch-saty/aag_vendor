// ignore_for_file: unused_import, use_build_context_synchronously, sized_box_for_whitespace

import 'package:AAG/HomeScreen/homescreen_game.dart';
import 'package:AAG/Pages/login_vendor.dart';
import 'package:AAG/Pages/loginsignup.dart';
import 'package:AAG/Pages/otp_veri.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:AAG/Pages/signup.dart';
import 'package:AAG/tobeadded/gradient_button.dart';
import 'package:AAG/tobeadded/promo_slider.dart';

class LoginVendor2 extends StatefulWidget {
  final String phoneNumber;
  final String selectedPlan;

  const LoginVendor2(
      {super.key, required this.phoneNumber, required this.selectedPlan});

  @override
  _LoginVendor2State createState() => _LoginVendor2State();
}

class _LoginVendor2State extends State<LoginVendor2> {
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  int _timerSeconds = 30;
  Timer? _timer;
  double _initialChildSize = 0.5;
  bool _isOtpInvalid = false;
  Color _otpTextColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _startTimer();
    for (var node in _focusNodes) {
      node.addListener(_onFocusChange);
    }
  }

  void _onFocusChange() {
    setState(() {
      _initialChildSize = _focusNodes.any((node) => node.hasFocus) ? 0.8 : 0.5;
    });
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

  void _verifyOtp() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black,
          child: Container(
            height: 600,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('lib/images/aag_white.png', height: 60),
                const SizedBox(height: 20),
                const Text(
                  'Please wait \n Vendor Validating',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop(); // Close the dialog
      setState(() {
        _otpTextColor = Colors.red;
        _isOtpInvalid = true;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GameHomepage()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent, // Make background transparent
      //   elevation: 0, // Remove shadow/elevation
      //   centerTitle: true, // Center the title (image in this case)
      //   title: Image.asset(
      //     'lib/images/aag_white.png',
      //     height: 50, // Set the height of the image
      //   ),
      // ),
      body: Stack(
        children: [
          // Background with the PromotionalSlider
          Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  child: PromotionalsSlider(),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(),
              ),
            ],
          ),

          // The form in DraggableScrollableSheet
          DraggableScrollableSheet(
            initialChildSize: _initialChildSize,
            minChildSize: 0.5,
            maxChildSize: 0.6,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/images/idkbg.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white30,
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '+91 ${widget.phoneNumber} ',
                                style: const TextStyle(
                                    color: Colors.orange, fontSize: 18),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => LoginVendor(
                                        selectedPlan: widget.selectedPlan,
                                      ),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.edit_square,
                                  color: Colors.orange,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Center(
                          child: Text(
                            'Enter 4 digit OTP',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            4,
                            (index) => Container(
                              width: 50,
                              height: 50,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: TextField(
                                controller: _otpControllers[index],
                                focusNode: _focusNodes[index],
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                style: TextStyle(color: _otpTextColor),
                                decoration: InputDecoration(
                                  counterText: '',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.purple.shade200),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.purple),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    if (index < 3) {
                                      FocusScope.of(context)
                                          .requestFocus(_focusNodes[index + 1]);
                                    } else {
                                      FocusScope.of(context).unfocus();
                                    }
                                  } else {
                                    if (index > 0) {
                                      FocusScope.of(context)
                                          .requestFocus(_focusNodes[index - 1]);
                                    }
                                  }
                                },
                                onSubmitted: (_) {
                                  if (index == 3) _verifyOtp();
                                },
                              ),
                            ),
                          ),
                        ),
                        if (_isOtpInvalid)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: const Center(
                                child: Text(
                                  "Invalid verification code \n Click here ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.red,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 50),
                        Center(
                          child: CustomButton(
                            onTap: _verifyOtp,
                            text: 'Verify OTP',
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Resend OTP in:',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              ' ${_timerSeconds}s',
                              style: const TextStyle(
                                  color: Colors.orange, fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'lib/images/aag_white.png', // Replace with your image path
                height: 30,
                width: 80, // Adjust the height as needed
              ),
            ),
          ),
          Positioned(
              top: 50, // 15 pixels from the top
              left: -(MediaQuery.of(context).size.width * 0.84),
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginVendor(
                        selectedPlan: widget.selectedPlan,
                      ),
                    ),
                  );
                },
                child: const Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.white,
                ),
              ) // Adjust the height as needed
              ),
        ],
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
      node.dispose();
    }
    super.dispose();
  }
}
