// ignore_for_file: use_build_context_synchronously, unused_field, unused_import

import 'package:AAG/Otp_Services/new_otp_services.dart';
import 'package:AAG/Pages/login_vendor.dart';
import 'package:AAG/Pages/new_login_signup.dart';
import 'package:AAG/Pages/package_screen.dart'; // Import the OtpService
import 'package:AAG/tobeadded/homescreen_slider.dart';
import 'package:AAG/tobeadded/promo_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../tobeadded/gradient_button.dart';
import 'otp_verification.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  // final String selectedPlan;
  const SignUpPage({
    super.key,
  });

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Text controller for mobile number
  final TextEditingController _mobileController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  bool _showReferralField = false;
  final TextEditingController _referralController = TextEditingController();

  // OTP Service instance
  final OtpService _otpService = OtpService();

  // Loading state
  bool _isLoading = false;

  // Method to send OTP
  Future _sendOtp() async {
    String mobileNumber = _mobileController.text.trim();

    // Enhanced validation
    if (mobileNumber.isEmpty) {
      _otpService.showErrorDialog(context, 'Please enter a mobile number');
      return;
    }

    if (!RegExp(r'^[0-9]{10}$').hasMatch(mobileNumber)) {
      _otpService.showErrorDialog(
          context, 'Please enter a valid 10-digit mobile number');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _otpService.sendVendorSignupOtp(mobileNumber);

      setState(() {
        _isLoading = false;
      });

      if (response['success']) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => OTPVerificationPage(
              phoneNumber: mobileNumber,
            ),
          ),
        );
      } else {
        _otpService.showErrorDialog(context, response['message']);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _otpService.showErrorDialog(context, 'An unexpected error occurred');
    }
  }

  @override
  void dispose() {
    // Clean up controller
    _referralController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                PromotionalsSlider2(),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: _mobileController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        decoration: InputDecoration(
                          hintText: 'Enter phone number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _showReferralField = !_showReferralField;
                            });
                          },
                          child: Text(
                            'Have a referral code?',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      if (_showReferralField) ...[
                        const SizedBox(height: 16),
                        TextField(
                          controller: _referralController,
                          decoration: InputDecoration(
                            hintText: 'Enter your referral code',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _sendOtp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text(
                                  'Send OTP',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginVendor(selectedPlan: ''),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
