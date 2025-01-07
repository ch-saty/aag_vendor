import 'package:AAG/Refer%20and%20Earn/top_invitees.dart';
import 'package:AAG/tobeadded/promo_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReferAndEarnPage extends StatefulWidget {
  const ReferAndEarnPage({super.key});

  @override
  State<ReferAndEarnPage> createState() => _ReferAndEarnPageState();
}

class _ReferAndEarnPageState extends State<ReferAndEarnPage> {
  bool isCopied = false;
  final String referralCode = "ABCD123";

  // Font family constant
  static const String fontFamily = 'Roboto';

  // Text styles with Roboto font
  final TextStyle titleStyle = const TextStyle(
    fontFamily: fontFamily,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  final TextStyle headingStyle = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  final TextStyle subheadingStyle = const TextStyle(
    fontFamily: fontFamily,
    color: Colors.white,
    fontSize: 12,
  );

  final TextStyle rewardTextStyle = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 102, 44, 144),
  );

  final TextStyle labelStyle = const TextStyle(
    fontFamily: fontFamily,
    color: Colors.grey,
    fontSize: 14,
  );

  final TextStyle buttonTextStyle = const TextStyle(
    fontFamily: fontFamily,
    color: Colors.white,
  );

  final TextStyle referralCodeStyle = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 102, 44, 144),
  );

  final TextStyle statsValueStyle = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 102, 44, 144),
  );

  final TextStyle socialLabelStyle = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    color: Colors.grey,
  );

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: referralCode));
    setState(() {
      isCopied = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Referral code copied',
          style: TextStyle(fontFamily: fontFamily),
        ),
        duration: const Duration(seconds: 2),
      ),
    );

    Future.delayed(const Duration(seconds: 5), () {
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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "REFER & EARN",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF662C90),
      ),
      body: Container(
        width: double.infinity,
        color: const Color(0xFFF3E5F5),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Refer a Friend Card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF662C90), Color(0xFF9C27B0)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'REFER A FRIEND!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              'Share and earn rewards for every successful referral',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 8),
                            child: const Text(
                              '₹50',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Reward per referral',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF921D),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'REFER NOW & EARN',
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

                const SizedBox(height: 16), // Reduced spacing

                // Top Invitees Section
                Container(
                  width: double.infinity,
                  child: TopInviteesSection(),
                ),

                const SizedBox(height: 16), // Reduced spacing

                // Stats Row
                Row(
                  children: [
                    Expanded(
                      child: _buildStatsCard('TOTAL REFERRALS', '1'),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatsCard('TOTAL EARNING', '₹50'),
                    ),
                  ],
                ),

                const SizedBox(height: 16), // Reduced spacing

                // Referral Code Section
                Column(
                  children: [
                    Text(
                      'Your Referral Code',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'ABCDR4566',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: () {
                              copyToClipboard;
                              _showSharePopup(context);
                            },
                            child: const Icon(
                              Icons.share,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    PromotionalsSlider()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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
