// ignore_for_file: unused_import, duplicate_ignore

import 'package:AAG/HomeScreen/homescreen_game.dart';
import 'package:AAG/Pages/login_vendor.dart';
import 'package:AAG/tobeadded/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:AAG/Pages/loading.dart';
import 'package:AAG/tobeadded/fauth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:AAG/Pages/package_screen.dart';
import 'package:lottie/lottie.dart';

class AnimatedLottieButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final String lottieAsset;

  const AnimatedLottieButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.lottieAsset,
  });

  @override
  _AnimatedLottieButtonState createState() => _AnimatedLottieButtonState();
}

class _AnimatedLottieButtonState extends State<AnimatedLottieButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = true;
    });
    _animationController.forward().then((_) {
      widget.onPressed();
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isExpanded = false;
          });
          _animationController.reverse();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: _isExpanded ? 200 : 150,
        height: 60,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.purple, Colors.deepPurple],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: _isExpanded
              ? Lottie.asset(
                  widget.lottieAsset,
                  controller: _animationController,
                  width: 50,
                  height: 50,
                )
              : Text(
                  widget.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<void> launchUrlFunction(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/images/idkbg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(height: 30),
                          Image.asset(
                            "lib/images/aag_white.png",
                            width: constraints.maxWidth * 0.5,
                          ),
                          Column(
                            children: [
                              Column(
                                children: [
                                  CustomButton(
                                    onTap: () =>
                                        Navigator.of(context).pushReplacement(
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            const PackageScreen(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          var begin = const Offset(1.0, 0.0);
                                          var end = Offset.zero;
                                          var curve = Curves.easeInOut;
                                          var tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
                                          var offsetAnimation =
                                              animation.drive(tween);
                                          return SlideTransition(
                                              position: offsetAnimation,
                                              child: child);
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 900),
                                      ),
                                    ),
                                    text: 'Sign Up',
                                  ),
                                  const SizedBox(height: 20),
                                  CustomButton(
                                    onTap: () =>
                                        Navigator.of(context).pushReplacement(
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            const LoginVendor(
                                          selectedPlan: '',
                                        ),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          var begin = const Offset(1.0, 0.0);
                                          var end = Offset.zero;
                                          var curve = Curves.easeInOut;
                                          var tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
                                          var offsetAnimation =
                                              animation.drive(tween);
                                          return SlideTransition(
                                              position: offsetAnimation,
                                              child: child);
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 900),
                                      ),
                                    ),
                                    text: 'Log In',
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "Sign in with",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Loadscreen()),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Image.asset(
                                          "lib/images/google.png",
                                          width: 26,
                                          height: 26),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Loadscreen()),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Image.asset("lib/images/fb.png",
                                          width: 26, height: 26),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Loadscreen()),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Image.asset("lib/images/apple.png",
                                          width: 26, height: 26),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              // TextButton(
                              //   onPressed: () {
                              //     Navigator.of(context).pushReplacement(
                              //       MaterialPageRoute(
                              //           builder: (context) =>
                              //               const GameHomepage()),
                              //     );
                              //   },
                              //   child: const Text(
                              //     "Continue as Guest",
                              //     style: TextStyle(color: Colors.orange),
                              //   ),
                              // ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
