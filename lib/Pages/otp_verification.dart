// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:AAG/Otp_Services/new_otp_services.dart';
import 'package:AAG/Pages/package_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:convert';

class OTPVerificationPage extends StatefulWidget {
  final String phoneNumber;

  const OTPVerificationPage({
    super.key,
    required this.phoneNumber,
  });

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  // OTP Service instance
  final OtpService _otpService = OtpService();

  // OTP Controllers and Focus Nodes
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  // Timer and loading state
  int _timerSeconds = 60;
  Timer? _timer;
  bool _isLoading = false;

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

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(1, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  // Method to verify OTP
  Future<void> _verifyOtp() async {
    // Combine OTP digits
    String otpEntered =
        _otpControllers.map((controller) => controller.text).join();

    // Validate OTP length
    if (otpEntered.length != 4) {
      _otpService.showErrorDialog(
          context, 'Please enter a complete 4-digit OTP');
      return;
    }

    // Set loading state
    setState(() {
      _isLoading = true;
    });

    try {
      // Verify OTP
      final response = await _otpService.verifyOtp(
          mobileNumber: widget.phoneNumber,
          role: UserRole.VENDOR, // Adjust role as per your signup flow
          otpEntered: otpEntered);

      // Hide loading state
      setState(() {
        _isLoading = false;
      });

      // Check response
      if (response['success']) {
        json.decode(response['body']);

        // Navigate to Package Screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                PackageScreen(mobilenumber: widget.phoneNumber),
          ),
        );
      } else {
        // Show error dialog if OTP verification failed
        _otpService.showErrorDialog(context, response['message']);
      }
    } catch (e) {
      // Hide loading state
      setState(() {
        _isLoading = false;
      });

      // Show error dialog
      _otpService.showErrorDialog(context, 'An unexpected error occurred');
    }
  }

  // Method to resend OTP
  Future<void> _resendOtp() async {
    try {
      // Send vendor signup OTP
      final response =
          await _otpService.sendVendorSignupOtp(widget.phoneNumber);

      if (response['success']) {
        // Reset timer
        setState(() {
          _timerSeconds = 60;
        });
        _startTimer();

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP resent successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Show error dialog
        _otpService.showErrorDialog(context, response['message']);
      }
    } catch (e) {
      _otpService.showErrorDialog(context, 'Failed to resend OTP');
    }
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
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter the 4-digit code sent to\n${widget.phoneNumber}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          // Move focus to next field
                          if (index < 3) {
                            FocusScope.of(context)
                                .requestFocus(_focusNodes[index + 1]);
                          }
                        }
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Verify OTP',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive code? ",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  GestureDetector(
                    onTap: _timerSeconds == 0 ? _resendOtp : null,
                    child: Text(
                      'Resend',
                      style: TextStyle(
                        color: _timerSeconds == 0 ? Colors.black : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    ' (${_formatTime(_timerSeconds)})',
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
