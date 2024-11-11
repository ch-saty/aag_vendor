import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page2'),
      ),
      body: const Column(
        children: [
          Text(
            'Welcome',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 11,
          ),
          // ElevatedButton(onPressed: onPressed, child: Text('Next'))
        ],
      ),
    );
  }
}
