import 'package:flutter/material.dart';

class TournamentScreenPopup extends StatelessWidget {
  const TournamentScreenPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/idkbg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Custom AppBar (Fixed)
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 8,
                left: 8,
                right: 8,
                bottom: 8,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    'Tournament',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Scrollable content
            const SizedBox(height: 5),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Stack with Hexagon
                    Transform.translate(
                      offset: const Offset(0, 25),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 2,
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.orange.withOpacity(0.7),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                          CustomPaint(
                            size: const Size(180, 50),
                            painter:
                                HexagonPainter(color: const Color(0xFF4B2B7F)),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 8),
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
                      ),
                    ),

                    // Tournament Rounds Container
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 30,
                              )
                            ],
                          ),
                          Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'lib/images/match.png',
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Prize Pool and Players Row
                    Container(
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
                          Row(
                            children: [
                              Image.asset(
                                'lib/images/prize.png',
                                height: 30,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Prize Pool',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '₹3373',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'lib/images/team.png',
                                height: 30,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Total Players',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '32',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // Entry Fee Button
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      width: 140,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFE97411),
                          width: 1.5,
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Entry Fee:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '₹3',
                            style: TextStyle(
                              color: Colors.white,
                              // fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Top Winners Section
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'TOP WINNERS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 8,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF652F9D),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0xFF712FA0),
                                              Color(0xFF362F91),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset('lib/images/ch.png',
                                                height: 40),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                'Shivam #${index + 1}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Image.asset('lib/images/gold.png',
                                                height: 24),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        color: const Color(0x80E97411),
                                        child: Center(
                                          child: Text(
                                            '${10 - index} ',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        child: Center(
                                          child: Text(
                                            '₹${1500 - (index * 100)}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
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

    // Draw border
    Paint borderPaint = Paint()
      ..color = const Color(0xFFE97411)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
