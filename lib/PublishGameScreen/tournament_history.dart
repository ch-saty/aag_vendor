import 'package:flutter/material.dart';
import 'dart:async';

class TournamentHistoryScreen extends StatefulWidget {
  const TournamentHistoryScreen({super.key});

  @override
  State<TournamentHistoryScreen> createState() =>
      _TournamentHistoryScreenState();
}

class _TournamentHistoryScreenState extends State<TournamentHistoryScreen> {
  // bool _showList = false;

  // void _onTimerComplete() {
  //   setState(() {
  //     _showList = true;
  //   });
  // }

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
                    _buildHeader(),
                    _buildMatchInfo(),
                    SizedBox(
                      height: 16,
                    ),
                    _buildPrizeInfo(),
                    SizedBox(
                      height: 16,
                    ),
                    _buildEntryFeeButton(),
                    // _buildCountdownTimer(),
                    _buildTopWinnersList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 2,
          margin: const EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 102, 44, 144),
                Colors.orange.withOpacity(0.7),
                Color.fromARGB(255, 102, 44, 144),
              ],
            ),
          ),
        ),
        CustomPaint(
          size: const Size(180, 50),
          painter: HexagonPainter(
            color: Color.fromARGB(255, 102, 44, 144),
          ),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                'TOTAL ROUNDS',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMatchInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      // padding: const EdgeInsets.only(top: 35),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
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
        border: Border.all(
          color: const Color(0xFFE97411),
          width: 1,
        ),
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

  // Widget _buildCountdownTimer() {
  //   return Column(
  //     children: [
  //       const Text(
  //         'Starting in',
  //         style: TextStyle(color: Colors.white),
  //       ),
  //       CountdownTimer(onComplete: _onTimerComplete),
  //     ],
  //   );
  // }

  Widget _buildTopWinnersList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TOP WINNERS',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
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

class CountdownTimer extends StatefulWidget {
  final VoidCallback onComplete;

  const CountdownTimer({super.key, required this.onComplete});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  int _timeLeft = 5; // 2:30 in seconds

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer.cancel();
          widget.onComplete();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get timerText {
    int minutes = _timeLeft ~/ 60;
    int seconds = _timeLeft % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      timerText,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 30,
        fontWeight: FontWeight.bold,
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
