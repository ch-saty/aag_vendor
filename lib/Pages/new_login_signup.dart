// ignore_for_file: unused_import

import 'package:AAG/HomeScreen/new_homescreen.dart';
import 'package:AAG/Pages/loading.dart';
import 'package:AAG/Pages/login_vendor.dart';
import 'package:AAG/Pages/otp_veri.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4A148C), // Deep Purple
              Colors.black,
              Color(0xFF6A1B9A), // Purple
            ],
            stops: [0.0, 0.5, 1.0], // Optional: control color distribution
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        'lib/images/aag_white.png',
                        height: 80,
                      ),
                    ),
                    SizedBox(height: 64),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white10,
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginVendor(
                                          selectedPlan: '',
                                        )),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white10,
                              minimumSize: Size(double.infinity, 50),
                              side: BorderSide(color: Colors.white24),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.white24)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Sign in with',
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.white24)),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _socialLoginButton(context, FontAwesomeIcons.google),
                        SizedBox(width: 16),
                        _socialLoginButton(context, FontAwesomeIcons.facebook),
                        SizedBox(width: 16),
                        _socialLoginButton(context, FontAwesomeIcons.apple),
                      ],
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

  Widget _socialLoginButton(BuildContext context, IconData icon) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white24),
      ),
      child: IconButton(
        icon: FaIcon(icon, color: Colors.white),
        onPressed: () {
          // Social login logic
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const NewHomescreen()),
          );
        },
      ),
    );
  }
}
