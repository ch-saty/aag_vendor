// fauth.dart
// ignore_for_file: avoid_print, unused_element

import 'package:AAG/Pages/loginsignup.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:AAG/Pages/homescreen.dart';

class Fauth extends StatefulWidget {
  const Fauth({super.key});
  @override
  _FauthState createState() => _FauthState();
}

class _FauthState extends State<Fauth> {
  bool _showPinInput = false;
  String _pin = '';
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      authenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate to access your account',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print(e);
    }
    if (authenticated) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/idkbg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('lib/images/aag.png', height: 50),
              ),
              const Text(
                'Hi, Rwan Adams',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'random.user@email.com',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              if (!_showPinInput) ...[
                const Text(
                  'Enter PIN',
                  style: TextStyle(color: Colors.orange, fontSize: 18),
                ),
                const SizedBox(height: 60),
                const Icon(
                  Icons.fingerprint,
                  size: 70,
                  color: Colors.white,
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showPinInput = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  child: const Text(
                    'Enter PIN?',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ] else ...[
                const Text(
                  'Verify 4-digit security PIN',
                  style: TextStyle(color: Colors.orange, fontSize: 18),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) => Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _pin.length > index ? Colors.white : Colors.white30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Use Touch ID',
                  style: TextStyle(color: Colors.orange),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    children: List.generate(12, (index) {
                      if (index == 9) return Container();
                      if (index == 10) return _buildKeypadButton('0');
                      if (index == 11) {
                        return _buildKeypadButton('⌫', isDelete: true);
                      }
                      return _buildKeypadButton('${index + 1}');
                    }),
                  ),
                ),
              ],
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeypadButton(String text, {bool isDelete = false}) {
    return TextButton(
      onPressed: () {
        if (isDelete) {
          if (_pin.isNotEmpty) {
            setState(() {
              _pin = _pin.substring(0, _pin.length - 1);
            });
          }
        } else if (_pin.length < 4) {
          setState(() {
            _pin += text;
          });
          if (_pin.length == 4) {
            // Implement PIN verification logic here
            // For now, let's assume the PIN is correct and navigate to HomeScreen
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }
        }
      },
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }
}
