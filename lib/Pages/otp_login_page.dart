import 'package:AAG/Pages/login_vendor.dart';
import 'package:AAG/Pages/otp_login_verification.dart';
import 'package:flutter/material.dart';

class OTPLoginPage extends StatefulWidget {
  const OTPLoginPage({super.key});

  @override
  _OTPLoginPageState createState() => _OTPLoginPageState();
}

class _OTPLoginPageState extends State<OTPLoginPage> {
  String selectedCountryCode = '+1';
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[50]!, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Login with OTP',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "We've sent you a one-time password",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[200]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          // CountryCodePicker(
                          //   onChanged: (CountryCode countryCode) {
                          //     setState(() {
                          //       selectedCountryCode = countryCode.dialCode!;
                          //     });
                          //   },
                          //   initialSelection: 'US',
                          //   favorite: const ['+1', '+44', '+91'],
                          //   showCountryOnly: false,
                          //   showOnlyCountryWhenClosed: false,
                          //   alignLeft: false,
                          // ),
                          // Container(
                          //   width: 1,
                          //   height: 30,
                          //   color: Colors.grey[200],
                          // ),
                          Expanded(
                            child: TextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                hintText: 'Enter phone number',
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const OTPLoginVerificationPage(
                                phoneNumber: '',
                                selectedPlan: '',
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Send OTP',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Column(
                        children: [
                          // const Text(
                          //   'Already have an account?',
                          //   style: TextStyle(color: Colors.grey),
                          // ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginVendor(
                                    selectedPlan: '',
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'Sign in with password?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
