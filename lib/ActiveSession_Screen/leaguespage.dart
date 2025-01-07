import 'package:AAG/ActiveSession_Screen/animated_score_graph.dart';
import 'package:AAG/tobeadded/opponent_status_overlay.dart';
import 'package:flutter/material.dart';

class ActiveLeaguesPage extends StatefulWidget {
  const ActiveLeaguesPage({super.key});

  @override
  State<ActiveLeaguesPage> createState() => _ActiveLeaguesPageState();
}

class _ActiveLeaguesPageState extends State<ActiveLeaguesPage> {
  final bool _showList = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "LEAGUES",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 102, 44, 144),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Main Content
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AnimatedTeamScore(
                                team: 'My TEAM',
                                score: 3800,
                                color: const Color.fromARGB(255, 213, 98, 45),
                                isLeft: true,
                                imagePath: 'lib/images/mycard.png',
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset('lib/images/verses.png', height: 100),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AnimatedTeamScore(
                                team: 'KOHLI TEAM',
                                score: 2500,
                                color: Colors.blue,
                                isLeft: false,
                                imagePath: 'lib/images/oppcard.png',
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Container(
                      //   color: Color.fromARGB(255, 102, 44, 144),
                      //   height: 1,
                      //   width: double.infinity,
                      // ),

                      OpponentStatusContainer(text: "LUDO\nDEFAULT THEME"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  'lib/images/prize.png',
                                  width: 30,
                                  height: 40,
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      'Prize Pool',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    const Text(
                                      '₹3373',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  'lib/images/team.png',
                                  width: 30,
                                  height: 40,
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      'Top Players',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    const Text(
                                      '1247',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color.fromRGBO(255, 146, 29, 1),
                                width: 1,
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: Colors.white,
                                elevation: 1,
                              ),
                              child: const Text(
                                'Entry Fee ₹3',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                      _buildCountdownOrList(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountdownOrList() {
    final tournamentStartTime = DateTime.now().add(Duration(seconds: 10));

    return StreamBuilder(
      stream: Stream.periodic(Duration(seconds: 1)),
      builder: (context, snapshot) {
        final now = DateTime.now();
        final remaining = tournamentStartTime.difference(now);

        if (remaining.isNegative) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!_showList) {
              // _onTimerComplete();
            }
          });
          return _buildTopWinnersList();
        }
        final hours = remaining.inHours;
        final minutes = remaining.inMinutes.remainder(60);
        final seconds = remaining.inSeconds.remainder(60);

        return Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            children: [
              Text(
                'Tournament Starts In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTimeUnit(hours.toString().padLeft(2, '0'), 'Hours'),
                  _buildTimeSeparator(),
                  _buildTimeUnit(minutes.toString().padLeft(2, '0'), 'Minutes'),
                  _buildTimeSeparator(),
                  _buildTimeUnit(seconds.toString().padLeft(2, '0'), 'Seconds'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimeUnit(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSeparator() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        ':',
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTopWinnersList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'TOP WINNERS',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Icon(
              //   Icons.format_list_bulleted,
              //   color: Colors.grey.shade500,
              //   size: 28,
              // )
            ],
          ),
          const SizedBox(height: 8),
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: 8,
            itemBuilder: (context, index) {
              return _buildWinnerItem(index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWinnerItem(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: Colors.grey.shade300)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildWinnerInfo(index),
          // _buildWinnerPlays(index),
          _buildWinnerPrize(index),
        ],
      ),
    );
  }

  Widget _buildWinnerInfo(int index) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          // gradient: const LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     Color(0xFF712FA0),
          //     Color(0xFF362F91),
          //   ],
          // ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Round',
                  style: TextStyle(color: Colors.black54),
                ),
                Text(
                  '#${10 - index}',
                  style: TextStyle(color: Colors.black54),
                )
              ],
            ),
            const SizedBox(width: 8),
            Image.asset('lib/images/ch.png', height: 40),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Shivam \n #${index + 1}',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Image.asset('lib/images/gold.png', height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildWinnerPrize(int index) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              'WINNING',
              style: TextStyle(color: Colors.black45),
            ),
            Text(
              '₹${1500 - (index * 100)}',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
