import 'package:flutter/material.dart';

class CustomPopup extends StatelessWidget {
  final String title;

  const CustomPopup({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment(0.17, 0.98),
            end: Alignment(0.17, -0.02),
            colors: [
              Color(0xFF712FA0),
              Color(0xFF362F91),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black26, width: 2),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Image.asset(
                    //   'assets/crane_icon.png', // You'll need to add this icon
                    //   height: 40,
                    //   width: 40,
                    // ),
                    const SizedBox(width: 10),
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'WEBSITE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'UNDER',
                          style: TextStyle(
                            color: Colors.pink,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'CONSTRUCTION',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
