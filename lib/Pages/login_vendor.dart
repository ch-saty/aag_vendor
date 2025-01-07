// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:AAG/Otp_Services/new_otp_services.dart';
import 'package:AAG/Pages/forgot_password_page.dart';
import 'package:AAG/Pages/new_login_signup.dart';
import 'package:AAG/Pages/otp_login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../HomeScreen/new_homescreen.dart';

class LoginVendor extends StatefulWidget {
  final String selectedPlan;

  const LoginVendor({super.key, required this.selectedPlan});

  @override
  State<LoginVendor> createState() => _LoginVendorState();
}

class _LoginVendorState extends State<LoginVendor> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final OtpService _otpService = OtpService();
  String selectedCountryCode = '+91';
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  final List<Map<String, String>> countryCodes = [
    {'code': '+1', 'country': 'USA'},
    {'code': '+44', 'country': 'UK'},
    {'code': '+91', 'country': 'India'},
    {'code': '+86', 'country': 'China'},
    {'code': '+81', 'country': 'Japan'},
    {'code': '+82', 'country': 'South Korea'},
    {'code': '+65', 'country': 'Singapore'},
    {'code': '+60', 'country': 'Malaysia'},
  ];

  Future<void> _handleSignIn() async {
    // Validation
    if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter phone number')),
      );
      return;
    }

    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter password')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      print(_phoneController.text);
      print(_passwordController.text);

      print(
          'Attempting login with: ${selectedCountryCode + _phoneController.text}');

      final result = await _otpService.loginWithPassword(
        mobileNumber: selectedCountryCode + _phoneController.text,
        password: _passwordController.text,
        role: UserRole.VENDOR,
      );

      print('Login result: $result');

      if (result['success'] == true) {
        // Navigate to home screen
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const NewHomescreen()),
            (route) => false,
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result['message'] ?? 'Login failed')),
          );
        }
      }
    } catch (e) {
      print('Login error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.grey[50]!,
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please sign in to continue',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[200]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Colors.grey[200]!),
                        ),
                      ),
                      child: DropdownButton<String>(
                        value: selectedCountryCode,
                        underline: const SizedBox(),
                        items: countryCodes.map((country) {
                          return DropdownMenuItem<String>(
                            value: country['code'],
                            child: Text(country['code']!),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCountryCode = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        decoration: const InputDecoration(
                          hintText: 'Enter phone number',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OTPLoginPage()),
                      );
                    },
                    child: const Text(
                      'Login with OTP',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleSignIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey[300])),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Or continue with',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey[300])),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Image.asset(
                      'lib/images/google.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Image.asset(
                      'lib/images/apple.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Image.asset(
                      'lib/images/insta.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign Up',
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
      ),
    );
  }
}
