import 'package:AAG/ActiveSession_Screen/leaguespage.dart';
import 'package:AAG/ActiveSession_Screen/ludopopup.dart';
import 'package:AAG/ActiveSession_Screen/tournamentpopup.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ActiveSessionsScreen extends StatefulWidget {
  const ActiveSessionsScreen({super.key});

  @override
  _ActiveSessionsScreenState createState() => _ActiveSessionsScreenState();
}

class _ActiveSessionsScreenState extends State<ActiveSessionsScreen> {
  Timer? _timer;
  int _secondsRemaining = 150;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Active Sessions ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 102, 44, 144),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Games Section
              _buildGamesSection(),

              SizedBox(width: 16),

              // Leagues Section
              _buildLeaguesSection(),

              SizedBox(width: 16),

              // Tournament Section
              _buildTournamentSection(),

              SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGamesSection() {
    return Card(
      elevation: 3,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 15, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'lib/images/Games.png',
                  height: 28,
                  width: 28,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 8),
                Text(
                  'GAMES',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  5,
                  (index) => Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ActiveLudoPopUpScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        child: Image.asset(index.isEven
                            ? 'lib/images/ludo.png'
                            : 'lib/images/snakes.png'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaguesSection() {
    return Padding(
      padding: EdgeInsets.only(top: 16.0, bottom: 10, left: 14, right: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'lib/images/leagues-01.png',
                height: 30,
                width: 30,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 8),
              Text(
                'LEAGUES',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 8),
          Column(
            children: List.generate(
              2,
              (index) => Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ActiveLeaguesPage(),
                      ),
                    );
                  },
                  child: Container(
                    // height: 120,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 102, 44, 144)
                              .withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            _playerCard('lib/images/mycard.png'),
                            _playerCard('lib/images/vssss.png'),
                            _playerCard('lib/images/oppcard.png'),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Time Left',
                              style: TextStyle(
                                color: Color.fromARGB(255, 102, 44, 144),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              formatTime(_secondsRemaining),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 102, 44, 144),
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _ludoGameCard('lib/images/ludo.png'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTournamentSection() {
    return Padding(
      padding: EdgeInsets.only(top: 16.0, bottom: 16, left: 14, right: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'lib/images/Tournament.png',
                height: 30,
                width: 30,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 8),
              Text(
                'TOURNAMENT',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 8),
          Column(
            children: List.generate(
              2,
              (index) => Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ActiveTournamentScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 102, 44, 144)
                              .withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // const SizedBox(
                        //   width: 25,
                        // ),
                        Row(
                          children: [
                            Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _ludoGameCard('lib/images/ludo.png'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _prizeCard('lib/images/prizee.png'),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _playerCard('lib/images/mycard.png'),
                              ],
                            ),
                          ],
                        ),
                        // const SizedBox(
                        //   width: 40,
                        // ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Starting in',
                              style: TextStyle(
                                color: Color.fromARGB(255, 102, 44, 144),
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              formatTime(_secondsRemaining),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 102, 44, 144),
                                fontSize: 26,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _playerCard(String imagePath) {
    return Container(
      width: 55,
      height: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.contain,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _ludoGameCard(String imagePath) {
    return Container(
      width: 65,
      height: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.contain,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _prizeCard(String imagePath) {
    return Container(
      width: 80,
      height: 60,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.contain,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
