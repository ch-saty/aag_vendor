import 'package:AAG/Pages/loading.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isSoundEnabled = false;
  final Map<String, TextEditingController> _urlControllers = {
    'Facebook': TextEditingController(),
    'Instagram': TextEditingController(),
    'Twitter': TextEditingController(),
    'YouTube': TextEditingController(),
    'Snapchat': TextEditingController(),
  };

  final Map<String, bool> _showUrlInput = {
    'Facebook': false,
    'Instagram': false,
    'Twitter': false,
    'YouTube': false,
    'Snapchat': false,
  };

  final Map<String, bool> _socialMediaConnected = {
    'Facebook': false,
    'Instagram': false,
    'Twitter': false,
    'YouTube': false,
    'Snapchat': false,
  };

  final Map<String, bool> _isEditing = {
    'Facebook': false,
    'Instagram': false,
    'Twitter': false,
    'YouTube': false,
    'Snapchat': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:
          true, // Extends the background image behind the app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Makes the app bar transparent
        elevation: 0, // Removes shadow
        title: const Text(
          'SETTINGS',
          style: TextStyle(
            color: Colors.white, // Sets title color to white for visibility
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white, // Sets back arrow color to white
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Navigates back when pressed
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/idkbg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(50, 113, 47, 160),
                      Color.fromARGB(50, 54, 47, 145),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    _buildSettingsItem(
                      'Share AAG App',
                      'lib/images/share_icon.png',
                      () => _showSharePopup(context),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    _buildSettingsItem(
                      'Change Language',
                      'lib/images/language_icon.png',
                      () => _showLanguagePopup(context),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    _buildSettingsItem(
                      'Sound Manager',
                      'lib/images/sound_icon.png',
                      () => _showSoundPopup(context),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    _buildSettingsItem(
                      'KYC Details',
                      'lib/images/kyc_icon.png',
                      () => _showKYCPopup(context),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    _buildSettingsItem(
                      'Ticket History',
                      'lib/images/ticket_icon.png',
                      () {},
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    _buildSettingsItem(
                      'Manage Permissions',
                      'lib/images/permissions_icon.png',
                      () => _showpermissionPopup(context),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    _buildSettingsItem(
                      'Manage Social Media',
                      'lib/images/social_icon.png',
                      () => _showsocialPopup(context),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showsocialPopup(BuildContext context) {
    // Get screen size
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            backgroundColor: Colors.transparent,
            // Make dialog size responsive
            insetPadding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.05,
              vertical: screenSize.height * 0.05,
            ),
            child: SingleChildScrollView(
              // Add scrolling capability
              child: Container(
                width: screenSize.width * (isSmallScreen ? 0.95 : 0.9),
                constraints: BoxConstraints(
                  maxHeight: screenSize.height * 0.8, // Limit maximum height
                ),
                padding: EdgeInsets.all(isSmallScreen ? 12 : 20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF35035A),
                      Color(0xFF510985),
                      Color(0xFF35035A),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          // Wrap with Flexible to prevent overflow
                          child: Text(
                            'MANAGE SOCIAL MEDIA',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isSmallScreen ? 16 : 20,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: isSmallScreen ? 20 : 24,
                          ),
                          onPressed: () => Navigator.pop(context),
                          constraints: BoxConstraints(
                            minWidth: isSmallScreen ? 35 : 40,
                            minHeight: isSmallScreen ? 35 : 40,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isSmallScreen ? 12 : 20),
                    // Social Media List
                    Flexible(
                      child: SingleChildScrollView(
                        // Make list scrollable
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildSocialMediaRow(
                                'Facebook',
                                'lib/images/Facebook.png',
                                setState,
                                screenSize),
                            _buildSocialMediaRow(
                                'Instagram',
                                'lib/images/Instagram.png',
                                setState,
                                screenSize),
                            _buildSocialMediaRow(
                                'Twitter',
                                'lib/images/Elemento.png',
                                setState,
                                screenSize),
                            _buildSocialMediaRow('YouTube',
                                'lib/images/YouTube.png', setState, screenSize),
                            _buildSocialMediaRow(
                                'Snapchat',
                                'lib/images/Snapchat.png',
                                setState,
                                screenSize),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Widget _buildSocialMediaRow(String platform, String imagePath,
      StateSetter setState, Size screenSize) {
    final isSmallScreen = screenSize.width < 360;

    return Container(
      margin: EdgeInsets.only(bottom: isSmallScreen ? 8 : 10),
      padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                // Wrap with Expanded to prevent overflow
                child: Row(
                  children: [
                    Image.asset(
                      imagePath,
                      width: isSmallScreen ? 60 : 80,
                      height: isSmallScreen ? 60 : 80,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: isSmallScreen ? 8 : 12),
                    Flexible(
                      // Wrap with Flexible to prevent overflow
                      child: Text(
                        platform,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isSmallScreen ? 14 : 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              if (!_showUrlInput[platform]!)
                _socialMediaConnected[platform]!
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _isEditing[platform] = true;
                            _showUrlInput[platform] = true;
                            _socialMediaConnected[platform] = false;
                          });
                        },
                        child: Container(
                          width: isSmallScreen ? 25 : 30,
                          height: isSmallScreen ? 25 : 30,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 233, 116, 17),
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: isSmallScreen ? 16 : 20,
                          ),
                        ),
                      )
                    : SizedBox(
                        height: isSmallScreen ? 32 : 36,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _showUrlInput[platform] = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 233, 116, 17),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 12 : 16,
                            ),
                          ),
                          child: Text(
                            'Connect',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isSmallScreen ? 12 : 14,
                            ),
                          ),
                        ),
                      ),
            ],
          ),
          if (_showUrlInput[platform]!)
            Padding(
              padding: EdgeInsets.only(top: isSmallScreen ? 8 : 10),
              child: Row(
                children: [
                  Expanded(
                    child: _buildUrlTextField(platform, isSmallScreen),
                  ),
                  SizedBox(width: isSmallScreen ? 8 : 10),
                  SizedBox(
                    height: isSmallScreen ? 32 : 36,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _socialMediaConnected[platform] = true;
                          _showUrlInput[platform] = false;
                          _isEditing[platform] = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 233, 116, 17),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 12 : 16,
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isSmallScreen ? 12 : 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildUrlTextField(String platform, bool isSmallScreen) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
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
        controller: _urlControllers[platform],
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: 'Paste Your URL',
          hintStyle: TextStyle(color: Colors.white70),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {bool enabled = true}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15),
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
        enabled: enabled,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white70),
          border: InputBorder.none,
        ),
      ),
    );
  }

  void _showKYCPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: const BoxDecoration(
                color: Color(0xFF2D0F5C),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color(0xFF83410A),
                            Color(0xFFE97411),
                            Color(0xFF88440A),
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                            const Text(
                              'KYC DETAILS',
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
                    const TabBar(
                      tabs: [
                        Tab(text: 'AADHAR CARD'),
                        Tab(text: 'PAN CARD'),
                      ],
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.orange,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildAadharView(context),
                          _buildPanView(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showOTPVerification(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: const BoxDecoration(
            color: Color(0xFF2D0F5C),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Enter 4 digit OTP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) => Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(22, 13, 37, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: TextFormField(
                        onChanged: (value) {
                          if (value.length == 1 && index < 3) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                        maxLength: 1,
                        decoration: const InputDecoration(
                          counterText: '', // Hides counter
                          border: InputBorder.none, // Removes border
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Loadscreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF712FA0), Color(0xFF362F91)],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text(
                          'VERIFY OTP',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Re-send OTP in 0:20s',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAadharView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildTextField('Enter your 12 digit Aadhar number'),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () => _showOTPVerification(context),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.zero,
                  ).copyWith(
                    backgroundColor:
                        WidgetStateProperty.all(Colors.transparent),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF712FA0), Color(0xFF362F91)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text(
                        'SEND OTP',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.warning_amber_rounded,
                        color: Colors.orange, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Providing fake documents may lead to permanent\naccount blocking',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPanView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildTextField('Enter your PAN Number'),
          const SizedBox(height: 16),
          _buildTextField('DD/MM/YYYY'),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 20),
              SizedBox(width: 8),
              Text(
                'Providing fake documents may lead to permanent\naccount blocking',
                style: TextStyle(color: Colors.grey, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Loadscreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.zero,
            ).copyWith(
              backgroundColor: WidgetStateProperty.all(Colors.transparent),
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF712FA0), Color(0xFF362F91)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  'PROCEED',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(String title, String iconPath, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Image.asset(iconPath, width: 24, height: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                Image.asset(
                  'lib/images/r_arrow.png',
                  width: 20,
                  height: 20,
                  color: const Color.fromRGBO(233, 116, 17, 1),
                ),
              ],
            ),
          ),
          // Horizontal line
          Container(
            height: 0.5,
            color: const Color.fromARGB(255, 233, 116, 17),
          )
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
                    icon: 'assets/whatsapp_icon.png',
                    label: 'WhatsApp',
                    onTap: () {
                      // Add WhatsApp sharing logic
                      Navigator.pop(context);
                    },
                  ),
                  _buildShareOption(
                    icon: 'assets/notion_icon.png',
                    label: 'Notion',
                    onTap: () {
                      // Add Notion sharing logic
                      Navigator.pop(context);
                    },
                  ),
                  _buildShareOption(
                    icon: 'assets/facebook_icon.png',
                    label: 'Facebook',
                    onTap: () {
                      // Add Facebook sharing logic
                      Navigator.pop(context);
                    },
                  ),
                  _buildShareOption(
                    icon: 'assets/more_icon.png',
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

  void _showLanguagePopup(BuildContext context) {
    // Get screen size
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    showDialog(
      context: context,
      builder: (context) => FadeTransition(
        opacity: AlwaysStoppedAnimation(1.0),
        child: Dialog(
          backgroundColor: Colors.transparent,
          // Make dialog size responsive
          insetPadding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.05,
            vertical: screenSize.height * 0.05,
          ),
          child: SingleChildScrollView(
            // Add scrolling capability
            child: Container(
              width: screenSize.width * (isSmallScreen ? 0.95 : 0.9),
              constraints: BoxConstraints(
                maxHeight: screenSize.height * 0.6, // Adjust maximum height
                minHeight: screenSize.height * 0.3,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF35035A),
                    Color(0xFF510985),
                    Color(0xFF35035A),
                  ],
                  stops: [0.1572, 0.5, 0.8753],
                ),
                border: Border.all(
                  color: const Color.fromRGBO(233, 116, 17, 1),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Spacer(),
                        Text(
                          'LANGUAGE',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 20 : 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            padding: EdgeInsets.all(isSmallScreen ? 4 : 8),
                            child: Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: isSmallScreen ? 18 : 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenSize.height * 0.04,
                    ),
                    // Language Buttons
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildLanguageButton(
                              'Continue in English',
                              screenSize,
                              isSmallScreen,
                            ),
                            SizedBox(height: isSmallScreen ? 12 : 16),
                            _buildLanguageButton(
                              'Continue in Hindi',
                              screenSize,
                              isSmallScreen,
                            ),
                            SizedBox(height: isSmallScreen ? 12 : 16),
                            _buildLanguageButton(
                              'Continue in Malayalam',
                              screenSize,
                              isSmallScreen,
                            ),
                            SizedBox(height: isSmallScreen ? 12 : 16),
                            _buildLanguageButton(
                              'Continue in Kannada',
                              screenSize,
                              isSmallScreen,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageButton(
      String text, Size screenSize, bool isSmallScreen) {
    return Container(
      width: screenSize.width * (isSmallScreen ? 0.6 : 0.5),
      constraints: BoxConstraints(
        maxWidth: 300, // Maximum width for larger screens
        minWidth: 200, // Minimum width for smaller screens
      ),
      margin: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 12 : 16,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(113, 47, 160, 1),
            Color.fromRGBO(54, 47, 145, 1),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: () => Navigator.pop(context),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: isSmallScreen ? 8 : 12,
            horizontal: isSmallScreen ? 12 : 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: const Color.fromRGBO(233, 116, 17, 1),
            fontSize: isSmallScreen ? 14 : 16,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  void _showSoundPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.width * 0.5,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF35035A),
                  Color(0xFF510985),
                  Color(0xFF35035A),
                ],
                stops: [0.1572, 0.5, 0.8753],
              ),
              border: Border.all(
                color: Color.fromRGBO(233, 116, 17, 1),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'SOUND MANAGER',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.079,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.085,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'lib/images/sound.png',
                          height: 80,
                          width: 40,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // Row(
                        //   children: [
                        //     Text(
                        //       'System',
                        //       style: TextStyle(
                        //         color: Color.fromRGBO(233, 116, 17, 1),
                        //         fontSize: 16,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Row(
                          children: [
                            Text(
                              'Permission required to play\nsounds during system interactions\nlike clicks',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Switch(
                          value: isSoundEnabled,
                          onChanged: (value) {
                            setState(() {
                              isSoundEnabled = value;
                            });
                          },
                          activeColor: Colors.green,
                          inactiveTrackColor: Colors.red.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showpermissionPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: PermissionPopup(),
      ),
    );
  }
}

class PermissionPopup extends StatefulWidget {
  const PermissionPopup({super.key});

  @override
  _PermissionPopupState createState() => _PermissionPopupState();
}

class _PermissionPopupState extends State<PermissionPopup> {
  bool whatsappEnabled = false;
  bool smsEnabled = false;
  Map<String, bool> systemPermissions = {
    'Location': false,
    'Contacts': false,
    'Call Logs': false,
    'Manage Calls': false,
    'Camera': false,
    'Notifications': false,
    'Microphone': false,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF35035A),
            Color(0xFF510985),
            Color(0xFF35035A),
          ],
          stops: [0.1572, 0.5, 0.8753],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title Section
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xFF83410A),
                    Color(0xFFE97411),
                    Color(0xFF88440A),
                  ],
                  stops: [0.071, 0.491, 0.951],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'MANAGE PERMISSIONS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Permission required to send transactional and promotional communication',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Manrope',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            // Communication Permissions
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 0.052),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  _buildCommunicationItem(
                    'WhatsApp',
                    'lib/images/whatsapp.png',
                    whatsappEnabled,
                    (value) => setState(() => whatsappEnabled = value),
                  ),
                  Divider(color: Colors.white24, height: 1),
                  _buildCommunicationItem(
                    'SMS',
                    'lib/images/sms.png',
                    smsEnabled,
                    (value) => setState(() => smsEnabled = value),
                  ),
                ],
              ),
            ),

            // System Permissions Section
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'System Permissions',
                    style: TextStyle(
                      color: Color(0xFFE97411),
                      fontFamily: 'Manrope',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'System permissions required for critical app features to function properly',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // System Permission Items
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  _buildSystemPermissionItem(
                      'Location', 'lib/images/location.png'),
                  _buildSystemPermissionItem(
                      'Contacts', 'lib/images/contacts.png'),
                  _buildSystemPermissionItem(
                      'Call Logs', 'lib/images/call.png'),
                  _buildSystemPermissionItem(
                      'Manage Calls', 'lib/images/manage.png'),
                  _buildSystemPermissionItem('Camera', 'lib/images/camera.png'),
                  _buildSystemPermissionItem(
                      'Notifications', 'lib/images/notification.png'),
                  _buildSystemPermissionItem(
                      'Microphone', 'lib/images/mic.png'),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildCommunicationItem(
    String title,
    String iconPath,
    bool value,
    Function(bool) onChanged,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Image.asset(iconPath, width: 24, height: 24),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.green,
            inactiveTrackColor: Colors.red.withOpacity(0.5),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemPermissionItem(String title, String iconPath) {
    bool isAllowed = systemPermissions[title] ?? false;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Image.asset(iconPath, width: 24, height: 24),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'To enable relevant features',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    systemPermissions[title] = !isAllowed;
                  });
                },
                style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all(Size(80, 36)),
                  backgroundColor: WidgetStateProperty.all(
                    isAllowed
                        ? Color.fromARGB(255, 55, 20, 80)
                        : Color.fromARGB(149, 148, 54, 215),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                child: Text(
                  isAllowed ? 'ALLOWED' : 'ALLOW',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (title != 'Microphone') Divider(color: Colors.white24, height: 1),
      ],
    );
  }
}
