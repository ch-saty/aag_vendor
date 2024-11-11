// ignore_for_file: unused_import

import 'dart:async';
import 'package:AAG/Account_Screen/account_screen.dart';
import 'package:AAG/ActiveSession_Screen/activesession_screen.dart';
import 'package:AAG/DailyTaskScreen/dailytaskscreen.dart';
import 'package:AAG/Notification_Screen/notification_screen.dart';
import 'package:AAG/Pages/login_vendor.dart';
import 'package:AAG/PublishGameScreen/gamescreen.dart';
import 'package:AAG/PublishGameScreen/gamescreen2.dart';
import 'package:AAG/PublishGameScreen/publishgamescreen.dart';
import 'package:AAG/PublishGameScreen/scheduledgamescreen.dart';
import 'package:AAG/PublishGameScreen/schedulegamescreen_2.dart';
import 'package:AAG/PublishGameScreen/subscriptionscreen.dart';
import 'package:AAG/HomeScreen/game_home_screen.dart';
import 'package:AAG/HomeScreen/homescreen_game.dart';
import 'package:AAG/LeagueScreen/leaguescreen_one.dart';
import 'package:AAG/LeagueScreen/opponentmatchmaking.dart';
import 'package:AAG/LeagueScreen/scheduledevents_screen.dart';
import 'package:AAG/Pages/leaderboardpage.dart';
import 'package:AAG/Pages/otp_veri.dart';
import 'package:AAG/Pages/package_screen.dart';
import 'package:AAG/Pages/signup.dart';
import 'package:AAG/Pages/transaction_page.dart';
import 'package:AAG/Refer%20and%20Earn/referandearnscreen.dart';
import 'package:AAG/SettingPage/settingspage.dart';
import 'package:AAG/TournamentScreen/tournamentscreen_one.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:AAG/Pages/loginsignup.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    Timer(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const GameHomepage(),
          // LoginScreen()
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'lib/images/aag.png',
                  height: 100,
                ),
                // const SizedBox(height: 20),
                // Lottie.asset(
                //   './assets/loader.json',
                //   width: 250,
                //   height: 250,
                //   fit: BoxFit.cover,
                // ),
                // const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
