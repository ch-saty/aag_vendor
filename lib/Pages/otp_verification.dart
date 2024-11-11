import 'package:AAG/Pages/otp_veri.dart';
import 'package:AAG/Pages/signup.dart';
import 'package:AAG/tobeadded/gradient_button.dart';
import 'package:AAG/tobeadded/promo_slider.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class OTPVerificationPage extends StatefulWidget {
  final String phoneNumber;
  final String selectedPlan;

  const OTPVerificationPage(
      {super.key, required this.phoneNumber, required this.selectedPlan});

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  int _timerSeconds = 30;
  Timer? _timer;
  double _initialChildSize = 0.5;

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
    setState(() {
      _initialChildSize = _focusNodes.any((node) => node.hasFocus) ? 0.8 : 0.5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
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
                        const Center(
                          child: Text(
                            'OTP Verification',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '+91-${widget.phoneNumber} ',
                              style: const TextStyle(
                                  color: Colors.orange, fontSize: 18),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SignUpPage(
                                        selectedPlan: widget.selectedPlan),
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.edit_outlined,
                                color: Colors.orange,
                              ),
                            ),
                          ],
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
                                style: const TextStyle(color: Colors.white),
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
                                  if (value.length == 1 && index < 3) {
                                    FocusScope.of(context)
                                        .requestFocus(_focusNodes[index + 1]);
                                  } else if (value.isEmpty && index > 0) {
                                    FocusScope.of(context)
                                        .requestFocus(_focusNodes[index - 1]);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Center(
                          child: CustomButton(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage2(
                                    selectedPlan: widget.selectedPlan,
                                    phoneNumber: widget.phoneNumber,
                                  ),
                                ),
                              );
                            },
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
                'lib/images/aag_white.png',
                height: 30,
                width: 80,
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
                    builder: (context) =>
                        SignUpPage(selectedPlan: widget.selectedPlan),
                  ),
                );
              },
              child: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
              ),
            ),
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
      node.removeListener(_onFocusChange);
      node.dispose();
    }
    super.dispose();
  }
}
