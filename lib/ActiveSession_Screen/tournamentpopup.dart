import 'package:AAG/tobeadded/opponent_status_overlay.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ActiveTournamentScreen extends StatefulWidget {
  const ActiveTournamentScreen({super.key});

  @override
  State<ActiveTournamentScreen> createState() => _ActiveTournamentScreenState();
}

class _ActiveTournamentScreenState extends State<ActiveTournamentScreen> {
  final bool _showList = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

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
          "TOURNAMENT",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 102, 44, 144),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: screenSize.height * 0.02),
                    // _buildHeader(),
                    // Container(
                    //   color: Color.fromARGB(255, 102, 44, 144),
                    //   height: 2,
                    //   width: double.infinity,
                    // ),

                    OpponentStatusContainer(text: "TOURNAMENT\nTOTAL ROUNDS"),
                    _buildMatchInfo(),
                    SizedBox(
                      height: 16,
                    ),
                    _buildPrizeInfo(),
                    SizedBox(
                      height: 16,
                    ),
                    Column(
                      children: [
                        Text(
                          'LUDO',
                          style: TextStyle(
                              //rgba(255, 146, 29, 1)
                              color: const Color.fromARGB(255, 255, 146, 29),
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                        Text(
                          'DEFAULT THEME',
                          style: TextStyle(
                              //rgba(255, 146, 29, 1)
                              color: const Color.fromARGB(255, 255, 146, 29),
                              // fontWeight: FontWeight.w300,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    _buildEntryFeeButton(),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    _buildCountdownOrList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchInfo() {
    return Container(
      height: 150,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      // padding: const EdgeInsets.only(top: 35),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage('lib/images/vector.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Image.asset(
          'lib/images/match.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildPrizeInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // border: Border.all(
        //   // color: const Color(0xFFE97411),
        //   width: 1,
        // ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInfoRow(
            iconPath: 'lib/images/prize.png',
            label: 'Prize Pool',
            value: '₹3373',
          ),
          _buildInfoRow(
            iconPath: 'lib/images/team.png',
            label: 'Total Players',
            value: '32',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required String iconPath,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Image.asset(iconPath, height: 30),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEntryFeeButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color.fromRGBO(233, 116, 17, 1),
            width: 1.0,
          ),
        ),
        child: const Text(
          'Entry Fee ₹3',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildCountdownOrList() {
    // Assuming we have a target DateTime for the tournament
    final tournamentStartTime =
        DateTime.now().add(Duration(seconds: 10)); // Example duration

    return StreamBuilder(
      stream: Stream.periodic(Duration(seconds: 1)),
      builder: (context, snapshot) {
        final now = DateTime.now();
        final remaining = tournamentStartTime.difference(now);

        // Show list if timer has completed
        if (remaining.isNegative) {
          // Call _onTimerComplete only once when the timer first expires
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!_showList) {
              // _onTimerComplete();
            }
          });
          return _buildTopWinnersList();
        }

        // Calculate remaining time components
        final hours = remaining.inHours;
        final minutes = remaining.inMinutes.remainder(60);
        final seconds = remaining.inSeconds.remainder(60);

        return Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          // decoration: BoxDecoration(
          //   color: Color.fromARGB(255, 102, 44, 144),
          //   borderRadius: BorderRadius.circular(8),
          // ),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

  // Widget _buildWinnerPlays(int index) {
  //   return Expanded(
  //     child: Container(
  //       padding: const EdgeInsets.all(8),
  //       color: const Color(0x80E97411),
  //       child: Center(
  //         child: Text(
  //           '${10 - index}',
  //           style: const TextStyle(
  //             color: Colors.white,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

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

class HexagonPainter extends CustomPainter {
  final Color color;

  HexagonPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(size.width * 0.2, size.height * 0.5);
    path.lineTo(size.width * 0.3, 0);
    path.lineTo(size.width * 0.7, 0);
    path.lineTo(size.width * 0.8, size.height * 0.5);
    path.lineTo(size.width * 0.7, size.height);
    path.lineTo(size.width * 0.3, size.height);
    path.close();

    canvas.drawPath(path, paint);

    Paint borderPaint = Paint()
      ..color = const Color(0xFFE97411)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
