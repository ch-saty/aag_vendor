import 'package:AAG/Pages/new_login_signup.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessVerificationScreen extends StatelessWidget {
  const SuccessVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          'lib/images/aag.png',
          height: 40,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        // Stack to position the button at the bottom
        children: [
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 500),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 50 * (1 - value)),
                  child: child,
                ),
              );
            },
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Lottie.asset(
                      'assets/ani5.json',
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.width * 0.6,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black, Color(0xFF4A148C), // Deep Purple

                          Color(0xFF6A1B9A), // Purple
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            const Text(
                              'Your Profile is Under Verification.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'You will Receive Mail Shortly.',
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 40),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Home',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
