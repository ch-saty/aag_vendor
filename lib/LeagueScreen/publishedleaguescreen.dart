import 'package:AAG/tobeadded/gradient_button.dart';
import 'package:flutter/material.dart';

class LeaguePublishedScreen extends StatefulWidget {
  const LeaguePublishedScreen({super.key});

  @override
  _LeaguePublishedScreenState createState() => _LeaguePublishedScreenState();
}

class _LeaguePublishedScreenState extends State<LeaguePublishedScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    // Initialize Animation Controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true); // Makes the scale animation pulse

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Delay to trigger fade-in effect
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/idkbg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Top section with WAR image
            Expanded(
              flex: 3,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated Fade-in with Pulsating Image
                    AnimatedOpacity(
                      opacity: _visible ? 1.0 : 0.0,
                      duration: const Duration(seconds: 1),
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Image.asset(
                          'lib/images/war.png',
                          height: 306,
                          width: 311,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Your League has\n  been  Published',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Bottom section with link and social icons
            Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(30, 15, 50, 0.85),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Link text field without the embedded Copy button
                      _buildTextField('https://game.aag.com/jw2-zesm-pzb'),

                      // Copy button below the text field
                      CustomButton(onTap: () {}, text: "Copy"),

                      // Row for social media icons with spacing
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('lib/images/Facebook.png', height: 80),
                          Image.asset('lib/images/Instagram.png', height: 80),
                          Image.asset('lib/images/Elemento.png', height: 80),
                          Image.asset('lib/images/Snapchat.png', height: 80),
                        ],
                      ), // Share the link text
                      const Text(
                        'Share the special invite link',
                        style: TextStyle(
                          color: Colors.white24,
                          fontSize: 16,
                        ),
                      ),
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

  // Text field without the embedded copy button
  Widget _buildTextField(String hint) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromRGBO(22, 13, 37, 1),
        border: const Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 145, 30, 233),
            width: 2.0,
          ),
        ),
      ),
      child: TextField(
        enabled: false,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white70),
          border: InputBorder.none,
        ),
      ),
    );
  }

  // Separate Copy button
  // Widget _buildCopyButton() {
  //   return Container(
  //     width: MediaQuery.of(context).size.width * 0.3,
  //     height: 45,
  //     decoration: BoxDecoration(
  //       gradient: const LinearGradient(
  //         colors: [Colors.purple, Colors.blue],
  //         begin: Alignment.topLeft,
  //         end: Alignment.bottomRight,
  //       ),
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     child: ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor:
  //             Colors.transparent, // Ensure button background is transparent
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //       ),
  //       onPressed: () {
  //         // Add copy functionality here
  //       },
  //       child: const Text(
  //         'Copy',
  //         style: TextStyle(
  //           color: Colors.white,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Build social icons dynamically with size adjustments
  // List<Widget> _buildSocialIcons(List<String> imagePaths) {
  //   return imagePaths
  //       .map((path) => Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 5),
  //             child: InkWell(
  //               onTap: () {},
  //               child: Image.asset(
  //                 path,
  //                 width: 70,
  //                 height: 70,
  //               ),
  //             ),
  //           ))
  //       .toList();
  // }
}
