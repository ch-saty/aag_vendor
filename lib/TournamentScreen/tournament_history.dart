import 'package:AAG/tobeadded/opponent_status_overlay.dart';
import 'package:flutter/material.dart';

class TournamentHistory extends StatefulWidget {
  const TournamentHistory({super.key});

  @override
  State<TournamentHistory> createState() => _TournamentHistoryState();
}

class _TournamentHistoryState extends State<TournamentHistory> {
  double _selectedRound = 10;
  List<Map<String, dynamic>> winnersList = [];

  @override
  void initState() {
    super.initState();
    // Initialize winners list with dummy data
    winnersList = List.generate(
        8,
        (index) => {
              'round': 10 - index,
              'name': 'Shivam',
              'rank': index + 1,
              'prize': 1500 - (index * 100),
            });
  }

  void _showFilterModal() {
    // final screenSize = MediaQuery.of(context).size;
    // final isSmallScreen = screenSize.width < 360;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                // Main Bottom Sheet
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: MediaQuery.of(context).size.height * 0.42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Header
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 102, 44, 144),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'FILTER',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Rounds',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: const Color(0xFF712FA0),
                                inactiveTrackColor: Colors.grey.shade200,
                                thumbColor: const Color(0xFF712FA0),
                                overlayColor:
                                    const Color(0xFF712FA0).withOpacity(0.2),
                              ),
                              child: Slider(
                                value: _selectedRound,
                                min: 1,
                                max: 10,
                                divisions: 9,
                                label: _selectedRound.round().toString(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedRound = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedRound = 10;
                                      });
                                    },
                                    child: const Text(
                                      'Clear Filters',
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 146, 29, 1),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(255, 146, 29, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () {
                                      // Filter and update winners list with proper type casting
                                      final selectedRound =
                                          _selectedRound.round();
                                      setState(() {
                                        winnersList = List.generate(
                                                8,
                                                (index) => {
                                                      'round': 10 - index,
                                                      'name': 'Shivam',
                                                      'rank': index + 1,
                                                      'prize':
                                                          1500 - (index * 100),
                                                    })
                                            .where((winner) =>
                                                (winner['round'] as int) <=
                                                selectedRound)
                                            .toList();
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12),
                                      child: Text(
                                        'Apply',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Floating Close Button
                Positioned(
                  top: -50,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF712FA0),
                              Color(0xFF362F91),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "TOURNAMENT",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 102, 44, 144),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: screenSize.height * 0.02),
                    OpponentStatusContainer(text: "TOTAL ROUNDS\n4"),
                    _buildMatchInfo(),
                    const SizedBox(height: 16),
                    _buildPrizeInfo(),
                    const SizedBox(height: 16),
                    _buildEntryFeeButton(),
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
              GestureDetector(
                onTap: _showFilterModal,
                child: Icon(
                  Icons.format_list_bulleted,
                  color: Colors.grey.shade500,
                  size: 28,
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: winnersList.length,
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
          _buildWinnerPrize(index),
        ],
      ),
    );
  }

  Widget _buildWinnerInfo(int index) {
    final winner = winnersList[index];
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Round',
                  style: TextStyle(color: Colors.black54),
                ),
                Text(
                  '#${winner['round']}',
                  style: const TextStyle(color: Colors.black54),
                )
              ],
            ),
            const SizedBox(width: 8),
            Image.asset('lib/images/ch.png', height: 40),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${winner['name']} \n #${winner['rank']}',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWinnerPrize(int index) {
    final winner = winnersList[index];
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const Text(
              'WINNING',
              style: TextStyle(color: Colors.black45),
            ),
            Text(
              '₹${winner['prize']}',
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
