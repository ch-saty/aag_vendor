import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PublishedTournamentScreen extends StatefulWidget {
  const PublishedTournamentScreen({super.key});

  @override
  _PublishedTournamentScreenState createState() =>
      _PublishedTournamentScreenState();
}

class _PublishedTournamentScreenState extends State<PublishedTournamentScreen>
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

  Widget _buildShareButton(IconData icon) {
    return IconButton(
      icon: FaIcon(icon, size: 24),
      color: Colors.grey[600],
      onPressed: () {},
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
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
          onPressed: () => Navigator.pop(context),
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
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.privacy_tip,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Tournament Successfully Published',
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
                backgroundColor: Colors.black,
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
            SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildShareButton(FontAwesomeIcons.envelope),
                SizedBox(width: 32),
                _buildShareButton(FontAwesomeIcons.calendar),
                SizedBox(width: 32),
                _buildShareButton(FontAwesomeIcons.microsoft),
                SizedBox(width: 32),
                _buildShareButton(FontAwesomeIcons.slack),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Share meeting link',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
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
