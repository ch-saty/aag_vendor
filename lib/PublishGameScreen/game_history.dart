import 'package:flutter/material.dart';

class GameHistoryScreen extends StatelessWidget {
  const GameHistoryScreen({super.key});

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
          "GAMES",
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
                    const SizedBox(height: 16),
                    Container(
                      height: 125,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 102, 44, 144),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 108,
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(12),
                              // ),
                              child: Image.asset(
                                'lib/images/g1.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'lib/images/prize.png',
                                      height: 24,
                                      width: 30,
                                    ),
                                    const SizedBox(width: 3),
                                    const Text(
                                      'Prize Pool\n₹3373',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Image.asset(
                                      'lib/images/team.png',
                                      height: 16,
                                      width: 30,
                                    ),
                                    const SizedBox(width: 3),
                                    const Text(
                                      'Total Players\n1500',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                            const SizedBox(width: 0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'LUDO',
                                        style: TextStyle(
                                            //rgba(255, 146, 29, 1)
                                            color: const Color.fromARGB(
                                                255, 255, 146, 29),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        'DEFAULT THEME',
                                        style: TextStyle(
                                            //rgba(255, 146, 29, 1)
                                            color: const Color.fromARGB(
                                                255, 255, 146, 29),
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
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
                                      child: Column(
                                        children: [
                                          const Text(
                                            'Entry Fee',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Text(
                                            '₹3',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
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
                    const SizedBox(height: 16),
                    Padding(
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
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 15,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
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
                                                'Shivam \n #${index + 1}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            // Image.asset('lib/images/gold.png',
                                            //     height: 24),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Expanded(
                                    //   child: Container(
                                    //     padding: const EdgeInsets.all(8),
                                    //     color: const Color(0x80E97411),
                                    //     child: Center(
                                    //       child: Text(
                                    //         '${10 - index} ',
                                    //         style: const TextStyle(
                                    //           color: Colors.white,
                                    //           fontWeight: FontWeight.bold,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Prize',
                                              style: const TextStyle(
                                                color: Colors.black54,
                                                // fontWeight: FontWeight.bold,
                                              ),
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
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
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
