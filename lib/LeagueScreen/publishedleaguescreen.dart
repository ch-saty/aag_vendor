import 'package:AAG/HomeScreen/new_homescreen.dart';
import 'package:AAG/Pages/animated_pulsating_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LeaguePublishedScreen extends StatefulWidget {
  const LeaguePublishedScreen({super.key});

  @override
  _LeaguePublishedScreenState createState() => _LeaguePublishedScreenState();
}

class _LeaguePublishedScreenState extends State<LeaguePublishedScreen>
    with SingleTickerProviderStateMixin {
  bool isCopied = false;
  final String gameLink = 'https://game.example.com/jw2-zesm-pzb';
  String? scheduledInfo;

  late AnimationController _gradientAnimationController;

  @override
  void initState() {
    super.initState();
    _gradientAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _gradientAnimationController.dispose();
    super.dispose();
  }

  void _copyLink() {
    Clipboard.setData(ClipboardData(text: gameLink));
    setState(() {
      isCopied = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isCopied = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.grey[700]),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NewHomescreen(),
              ),
            );
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[300],
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(height: 20),
            // Container(
            AnimatedPulseImage(
              imagePath: 'lib/images/war.png',
              // Optional: customize parameters
              height: 250,
              width: 250,
              animationDuration: Duration(seconds: 2),
            ),
            SizedBox(height: 32),
            Text(
              'League Successfully Published',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            if (scheduledInfo != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  scheduledInfo!,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                gameLink,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _copyLink,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(255, 146, 29, 1),
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                isCopied ? 'Copied!' : 'Copy Link',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            // ElevatedButton.icon(
            //   onPressed: _showSchedulePopup,
            //   icon: Icon(Icons.edit_calendar_outlined, size: 16),
            //   label: Text('Edit Schedule'),
            //   style: ElevatedButton.styleFrom(
            //     foregroundColor: Colors.grey[700],
            //     backgroundColor: Colors.grey[100],
            //     minimumSize: Size(double.infinity, 48),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //   ),
            // ),

            SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    height: 40,
                    width: 40,
                    child: Image.asset(
                      'lib/images/insta.png',
                      fit: BoxFit.contain,
                    )),
                Container(
                    height: 50,
                    width: 50,
                    child: Image.asset(
                      'lib/images/whatsapp.png',
                      fit: BoxFit.contain,
                    )),
                Container(
                    height: 40,
                    width: 40,
                    child: Image.asset(
                      'lib/images/f_book.png',
                      fit: BoxFit.contain,
                    )),
                Container(
                    height: 40,
                    width: 40,
                    child: Image.asset(
                      'lib/images/X.png',
                      fit: BoxFit.contain,
                    )),
                // _socialLoginButton(Icons.g_mobiledata, Colors.black),
                // _socialLoginButton(Icons.apple, Colors.black),
                // _socialLoginButton(Icons.facebook, Colors.black),
              ],
            ),

            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Share the published league link',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () => _showSharePopup(context),
                  child: Container(
                    width: 22,
                    height: 22,
                    child: Image.asset(
                      'lib/images/ReferEarn.png',
                      fit: BoxFit.contain,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showSharePopup(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Apps row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildShareOption(
                    icon: 'lib/images/whatsapp_icon.png',
                    label: 'WhatsApp',
                    onTap: () {
                      // Add WhatsApp sharing logic
                      Navigator.pop(context);
                    },
                  ),
                  _buildShareOption(
                    icon: 'lib/images/notion_icon.png',
                    label: 'Notion',
                    onTap: () {
                      // Add Notion sharing logic
                      Navigator.pop(context);
                    },
                  ),
                  _buildShareOption(
                    icon: 'lib/images/f_book.png',
                    label: 'Facebook',
                    onTap: () {
                      // Add Facebook sharing logic
                      Navigator.pop(context);
                    },
                  ),
                  _buildShareOption(
                    icon: 'lib/images/more_icon.png',
                    label: 'More',
                    onTap: () {
                      // Show more sharing options
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),

            // Actions row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionOption(
                    icon: Icons.screenshot_outlined,
                    label: 'Screenshot',
                    onTap: () {
                      // Add screenshot logic
                      Navigator.pop(context);
                    },
                  ),
                  _buildActionOption(
                    icon: Icons.crop,
                    label: 'Long\nScreenshot',
                    onTap: () {
                      // Add long screenshot logic
                      Navigator.pop(context);
                    },
                  ),
                  _buildActionOption(
                    icon: Icons.link,
                    label: 'Copy link',
                    onTap: () {
                      // Add copy link logic
                      Navigator.pop(context);
                    },
                  ),
                  _buildActionOption(
                    icon: Icons.devices,
                    label: 'Send to your\ndevices',
                    onTap: () {
                      // Add send to devices logic
                      Navigator.pop(context);
                    },
                  ),
                  _buildActionOption(
                    icon: Icons.qr_code,
                    label: 'QR',
                    onTap: () {
                      // Add QR code logic
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOption({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                icon,
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 24,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black87,
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class ComplexGradientPainter extends CustomPainter {
  final Animation<double> animation;
  final Animation<double> rotationAnimation;
  final Animation<double> scaleAnimation;
  final Animation<Color?> colorAnimation1;
  final Animation<Color?> colorAnimation2;

  ComplexGradientPainter({
    required this.animation,
    required this.rotationAnimation,
    required this.scaleAnimation,
    required this.colorAnimation1,
    required this.colorAnimation2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Paint paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          colorAnimation1.value ?? Colors.blue,
          colorAnimation2.value ?? Colors.purple,
        ],
      ).createShader(rect);

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(rotationAnimation.value);
    canvas.scale(scaleAnimation.value);
    canvas.translate(-size.width / 2, -size.height / 2);
    canvas.drawRect(rect, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(ComplexGradientPainter oldDelegate) => true;
}
