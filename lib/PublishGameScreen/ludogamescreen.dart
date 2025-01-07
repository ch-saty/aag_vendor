import 'package:AAG/ActiveSession_Screen/tournamentpopup.dart';
import 'package:flutter/material.dart';

class LudoPopUpScreen extends StatelessWidget {
  const LudoPopUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/idkbg.jpg'),
            fit: BoxFit.fill,
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
                    'LUDO',
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Default Theme Header
                    // SizedBox(height: screenSize.height * 0.05),
                    Center(
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
                                  'DEFAULT THEME',
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
                    const SizedBox(height: 10),
                    // Game Info Container
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Game Icon
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Image.asset('lib/images/g1.png'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Game Info
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'lib/images/prize.png',
                                        height: 24,
                                        width: 40,
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Prize Pool\n₹3373',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Image.asset('lib/images/team.png',
                                          height: 24),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Total Players\n1500',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  GestureDetector(
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
                                          color: const Color.fromRGBO(
                                              233, 116, 17, 1),
                                          width: 1.0,
                                        ),
                                      ),
                                      child: const Text(
                                        'Entry Fee ₹3',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Column(
                    //   children: [
                    //     const Text(
                    //       'Time Left',
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //     CountdownTimer2(),
                    //   ],
                    // ),
                    const SizedBox(height: 5),
                    // Top Winners List
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          const SizedBox(height: 8),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 15,
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
                                            const SizedBox(width: 8),
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
                    // Add some bottom padding for better scrolling
                    const SizedBox(height: 20),
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
