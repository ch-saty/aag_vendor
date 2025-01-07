// ignore_for_file: avoid_print

import 'dart:async';

import 'package:AAG/Pages/new_login_signup.dart';
import 'package:AAG/TicketHistoryScreen/tickethistory.dart';
import 'package:AAG/Wallet_Screen/saved_bank_accounts.dart';
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
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "SETTINGS",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 102, 44, 144),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // General Settings Section
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(10),
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(25),
                //   gradient: const LinearGradient(
                //     colors: [
                //       Color.fromARGB(50, 113, 47, 160),
                //       Color.fromARGB(50, 54, 47, 145),
                //     ],
                //   ),
                // ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'General Settings',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildSettingsItem(
                      'Share AAG App',
                      'lib/images/ReferEarn.png',
                      () => _showSharePopup(context),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    _buildSettingsItem(
                      'Change Language',
                      'lib/images/Changelanguage.png',
                      () => _showLanguagePopup(context),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    _buildSettingsItem(
                      'Sound Manager',
                      'lib/images/Sound.png',
                      () => _showSoundPopup(context),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    _buildSettingsItem(
                      'KYC Details',
                      'lib/images/KYC.png',
                      () => _showKYCPopup(context),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    _buildSettingsItem(
                      'Ticket History',
                      'lib/images/TicketHistory.png',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const TicketHistoryScreen()),
                        );
                      },
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    _buildSettingsItem(
                      'Manage Permissions',
                      'lib/images/managepermissions.png',
                      () => _showpermissionPopup(context),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    _buildSettingsItem(
                      'Manage Social Media',
                      'lib/images/ManageSocialMedia.png',
                      () => _showsocialPopup(context),
                    ),
                  ],
                ),
              ),

              // Account Settings Section
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 16, right: 16),
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Account Settings',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildSettingsItem(
                      'Profile',
                      'lib/images/Profile.png',
                      () => _showProfliePopup(context),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    _buildSettingsItem(
                      'Security',
                      'lib/images/Security.png',
                      () => _showSecurityPopup(context),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    _buildSettingsItem(
                      'Manage Bank Accounts',
                      'lib/images/Transactions.png',
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SavedAccountsScreen()),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    _buildSettingsItem(
                      'Pause Account',
                      'lib/images/PauseAccount.png',
                      () => _showPauseAccountBottomSheet(context),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    _buildSettingsItem(
                      'Logout',
                      'lib/images/logO.png',
                      () => _showLogoutPopup(context),
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

  Widget _buildSettingsItem(String title, String iconPath, VoidCallback onTap) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Image.asset(iconPath, width: 24, height: 24),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_sharp,
                    size: 28,
                    color: const Color.fromRGBO(255, 146, 29, 1),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showsocialPopup(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Main Bottom Sheet
            StatefulBuilder(
              builder: (context, setState) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: MediaQuery.of(context).size.height *
                      0.6, // Increased height for social media content
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Header
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 102, 44, 144),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'MANAGE SOCIAL MEDIA',
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

                      SizedBox(height: screenSize.height * 0.04),

                      // Social Media List
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 12 : 16,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildSocialMediaRow(
                                  'Facebook',
                                  'lib/images/f_book.png',
                                  setState,
                                  screenSize,
                                ),
                                const SizedBox(height: 8),
                                _buildSocialMediaRow(
                                  'Instagram',
                                  'lib/images/insta.png',
                                  setState,
                                  screenSize,
                                ),
                                const SizedBox(height: 8),
                                _buildSocialMediaRow(
                                  'Twitter',
                                  'lib/images/X.png',
                                  setState,
                                  screenSize,
                                ),
                                const SizedBox(height: 8),
                                _buildSocialMediaRow(
                                  'YouTube',
                                  'lib/images/youtube.png',
                                  setState,
                                  screenSize,
                                ),
                                // _buildSocialMediaRow(
                                //   'Snapchat',
                                //   'lib/images/Snapchat.png',
                                //   setState,
                                //   screenSize,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Floating Close Button
            Positioned(
              top: -50,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Makes the container circular
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF712FA0),
                          Color(0xFF362F91),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      imagePath,
                      width: isSmallScreen ? 22 : 28,
                      height: isSmallScreen ? 22 : 28,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: isSmallScreen ? 5 : 10),
                    Flexible(
                      child: Text(
                        platform,
                        style: TextStyle(
                          color: Colors.black,
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
                            color: Color.fromRGBO(255, 146, 29, 1),
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
                                const Color.fromRGBO(255, 146, 29, 1),
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
                        backgroundColor: const Color.fromRGBO(255, 146, 29, 1),
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
    return Material(
      elevation: 3, // Adds the elevation
      shadowColor: Colors.black.withOpacity(0.5), // Optional shadow color
      borderRadius: BorderRadius.circular(15), // Matches the container's radius
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white70,
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        child: TextField(
          controller: _urlControllers[platform],
          style: const TextStyle(color: Colors.grey),
          decoration: const InputDecoration(
            hintText: 'Paste Your URL',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  void _showKYCPopup(BuildContext context) {
    // Track if any text field is focused
    bool isTextFieldFocused = false;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        // Get screen dimensions and orientation
        final mediaQuery = MediaQuery.of(context);
        final screenHeight = mediaQuery.size.height;
        final screenWidth = mediaQuery.size.width;
        final orientation = mediaQuery.orientation;

        // Responsive height calculation
        double getResponsiveHeight() {
          if (orientation == Orientation.portrait) {
            return screenHeight * (isTextFieldFocused ? 0.60 : 0.50);
          } else {
            return screenHeight * (isTextFieldFocused ? 0.70 : 0.50);
          }
        }

        // Responsive padding and spacing
        double responsivePadding = screenWidth * 0.04;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Main Bottom Sheet
            StatefulBuilder(
              builder: (context, setState) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: getResponsiveHeight(),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(screenWidth * 0.05),
                      topRight: Radius.circular(screenWidth * 0.05),
                    ),
                  ),
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 102, 44, 144),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(screenWidth * 0.05),
                              topRight: Radius.circular(screenWidth * 0.05),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(responsivePadding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'KYC DETAILS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.045,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        TabBar(
                          tabs: [
                            Tab(
                              child: Text(
                                'AADHAR CARD',
                                style: TextStyle(fontSize: screenWidth * 0.035),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'PAN CARD',
                                style: TextStyle(fontSize: screenWidth * 0.035),
                              ),
                            ),
                          ],
                          labelColor: Colors.orange,
                          unselectedLabelColor: Colors.black,
                          indicatorColor: Colors.orange,
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              _buildAadharView(context, (focused) {
                                setState(() => isTextFieldFocused = focused);
                              }, screenWidth, screenHeight),
                              _buildPanView(context, (focused) {
                                setState(() => isTextFieldFocused = focused);
                              }, screenWidth, screenHeight),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            // Floating Close Button
            Positioned(
              top: -screenHeight * 0.06,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: screenWidth * 0.1,
                    height: screenWidth * 0.1,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF712FA0),
                          Color(0xFF362F91),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: screenWidth * 0.06,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(
      String hint, Function(bool) onFocusChanged, double screenWidth) {
    return Focus(
      onFocusChange: onFocusChanged,
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: screenWidth * 0.035,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.025),
            borderSide: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.025),
            borderSide: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.025),
            borderSide: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
        ),
        style: TextStyle(
          color: Colors.black,
          fontSize: screenWidth * 0.035,
        ),
      ),
    );
  }

  Widget _buildAadharView(BuildContext context, Function(bool) onFocusChanged,
      double screenWidth, double screenHeight) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: _buildTextField(
                'Enter your 12 digit Aadhar number',
                onFocusChanged,
                screenWidth,
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () => _otpVerificationPopup(context),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, screenHeight * 0.07),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(screenWidth * 0.025),
                      ),
                      padding: EdgeInsets.zero,
                    ).copyWith(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.transparent),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 146, 29),
                        borderRadius:
                            BorderRadius.circular(screenWidth * 0.025),
                      ),
                      child: Container(
                        height: screenHeight * 0.07,
                        alignment: Alignment.center,
                        child: Text(
                          'SEND OTP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 46),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                    size: 20,
                  ),
                  SizedBox(width: 5),
                  Row(
                    children: [
                      Text(
                        'Fake documents may lead to permanent account blocking',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPanView(BuildContext context, Function(bool) onFocusChanged,
      double screenWidth, double screenHeight) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: _buildTextField(
                'Enter your PAN number',
                onFocusChanged,
                screenWidth,
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () => _otpVerificationPopup(context),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, screenHeight * 0.07),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(screenWidth * 0.025),
                      ),
                      padding: EdgeInsets.zero,
                    ).copyWith(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.transparent),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 146, 29),
                        borderRadius:
                            BorderRadius.circular(screenWidth * 0.025),
                      ),
                      child: Container(
                        height: screenHeight * 0.07,
                        alignment: Alignment.center,
                        child: Text(
                          'SEND OTP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 46),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                    size: 20,
                  ),
                  SizedBox(width: 5),
                  Row(
                    children: [
                      Text(
                        'Fake documents may lead to permanent account blocking',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _otpVerificationPopup(BuildContext context) {
    List<TextEditingController> codeControllers = List.generate(
      4,
      (index) => TextEditingController(),
    );
    List<FocusNode> focusNodes = List.generate(
      4,
      (index) => FocusNode(),
    );

    int remainingTime = 30;
    Timer? countdownTimer;
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            StatefulBuilder(
              builder: (context, setState) {
                countdownTimer ??=
                    Timer.periodic(Duration(seconds: 1), (timer) {
                  setState(() {
                    if (remainingTime > 0) {
                      remainingTime--;
                    } else {
                      countdownTimer?.cancel();
                    }
                  });
                });

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: MediaQuery.of(context).size.height * 0.50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 102, 44, 144),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // IconButton(
                              //   icon: const Icon(Icons.arrow_back,
                              //       color: Colors.white),
                              //   onPressed: () {
                              //     countdownTimer?.cancel();
                              //     Navigator.pop(context);
                              //   },
                              // ),
                              const Text(
                                'OTP VERIFICATION',
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
                      SizedBox(height: 8),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 12 : 16,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Enter the 4-digit verification code we texted to your phone',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                    4,
                                    (index) => Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.black38,
                                          width: 2,
                                        ),
                                      ),
                                      child: TextField(
                                        controller: codeControllers[index],
                                        focusNode: focusNodes[index],
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        maxLength: 1,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        decoration: InputDecoration(
                                          counterText: "",
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (value) {
                                          if (value.length == 1 && index < 3) {
                                            focusNodes[index + 1]
                                                .requestFocus();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 40),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    // color: Color.fromRGBO(233, 116, 17, 1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      String code = codeControllers
                                          .map((controller) => controller.text)
                                          .join();
                                      print('Submitted code: $code');
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(255, 146, 29, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16),
                                    ),
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Re-send Code in ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '0:${remainingTime}s',
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              top: -50,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    countdownTimer?.cancel();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Makes the container circular
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF712FA0),
                          Color(0xFF362F91),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ).then((_) {
      countdownTimer?.cancel();
    });
  }

  // void _showOTPVerification(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.transparent,
  //     isScrollControlled: true,
  //     enableDrag: true,
  //     builder: (BuildContext context) {
  //       final mediaQuery = MediaQuery.of(context);
  //       final screenHeight = mediaQuery.size.height;
  //       final screenWidth = mediaQuery.size.width;

  //       return Container(
  //         height: screenHeight * 0.5,
  //         decoration: BoxDecoration(
  //           color: const Color(0xFF2D0F5C),
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(screenWidth * 0.05),
  //             topRight: Radius.circular(screenWidth * 0.05),
  //           ),
  //         ),
  //         child: Padding(
  //           padding: EdgeInsets.all(screenWidth * 0.04),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(
  //                 'Enter 4 digit OTP',
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                   fontSize: screenWidth * 0.045,
  //                 ),
  //               ),
  //               SizedBox(height: screenHeight * 0.02),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: List.generate(
  //                   4,
  //                   (index) => Container(
  //                     width: screenWidth * 0.12,
  //                     height: screenWidth * 0.12,
  //                     margin:
  //                         EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
  //                     decoration: BoxDecoration(
  //                       color: const Color.fromRGBO(22, 13, 37, 1),
  //                       borderRadius:
  //                           BorderRadius.circular(screenWidth * 0.025),
  //                     ),
  //                     alignment: Alignment.center,
  //                     child: TextFormField(
  //                       onChanged: (value) {
  //                         if (value.length == 1 && index < 3) {
  //                           FocusScope.of(context).nextFocus();
  //                         }
  //                       },
  //                       keyboardType: TextInputType.number,
  //                       textAlign: TextAlign.center,
  //                       style: TextStyle(
  //                         color: Colors.white,
  //                         fontSize: screenWidth * 0.06,
  //                       ),
  //                       maxLength: 1,
  //                       decoration: const InputDecoration(
  //                         counterText: '',
  //                         border: InputBorder.none,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: screenHeight * 0.02),
  //               Padding(
  //                 padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
  //                 child: ElevatedButton(
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                           builder: (context) => const Loadscreen()),
  //                     );
  //                   },
  //                   style: ElevatedButton.styleFrom(
  //                     minimumSize: Size(double.infinity, screenHeight * 0.07),
  //                     backgroundColor: Colors.transparent,
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius:
  //                           BorderRadius.circular(screenWidth * 0.025),
  //                     ),
  //                     padding: EdgeInsets.zero,
  //                   ),
  //                   child: Ink(
  //                     decoration: BoxDecoration(
  //                       gradient: const LinearGradient(
  //                         begin: Alignment.topCenter,
  //                         end: Alignment.bottomCenter,
  //                         colors: [Color(0xFF712FA0), Color(0xFF362F91)],
  //                       ),
  //                       borderRadius:
  //                           BorderRadius.circular(screenWidth * 0.025),
  //                     ),
  //                     child: Container(
  //                       height: screenHeight * 0.07,
  //                       alignment: Alignment.center,
  //                       child: Text(
  //                         'VERIFY OTP',
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontSize: screenWidth * 0.04,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: screenHeight * 0.01),
  //               Text(
  //                 'Re-send OTP in 0:20s',
  //                 style: TextStyle(
  //                   color: Colors.grey[400],
  //                   fontSize: screenWidth * 0.035,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

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
                    icon: 'lib/images/facebook.png',
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

  void _showLanguagePopup(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;
    String selectedLanguage = 'English'; // Default selected language is English

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                // Main Bottom Sheet
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: MediaQuery.of(context).size.height * 0.42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Header
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 102, 44, 144),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'LANGUAGE',
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

                      SizedBox(height: 16),

                      // Language Buttons
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: isSmallScreen ? 5 : 10),
                          _buildLanguageButton(
                            'English',
                            screenSize,
                            isSmallScreen,
                            isSelected: selectedLanguage == 'English',
                            onPressed: () {
                              setState(() {
                                selectedLanguage = 'English';
                              });
                            },
                          ),
                          SizedBox(height: isSmallScreen ? 8 : 16),
                          _buildLanguageButton(
                            'Hindi',
                            screenSize,
                            isSmallScreen,
                            isSelected: selectedLanguage == 'Hindi',
                            onPressed: () {
                              setState(() {
                                selectedLanguage = 'Hindi';
                              });
                            },
                          ),
                          SizedBox(height: isSmallScreen ? 20 : 30),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Language changed to $selectedLanguage'),
                                  backgroundColor:
                                      const Color.fromRGBO(255, 146, 29, 1),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            child: Container(
                              width: screenSize.width * 0.5,
                              padding: EdgeInsets.symmetric(
                                vertical: isSmallScreen ? 5 : 10,
                                horizontal: 5,
                              ),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 146, 29, 1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      'Continue in $selectedLanguage',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                // Floating Close Button
                Positioned(
                  top: -50,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF712FA0),
                              Color(0xFF362F91),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildLanguageButton(
    String text,
    Size screenSize,
    bool isSmallScreen, {
    required VoidCallback onPressed,
    bool isSelected = false,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: screenSize.width * 0.3,
        padding: EdgeInsets.symmetric(
          vertical: isSmallScreen ? 5 : 10,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? const Color.fromRGBO(255, 146, 29, 1)
                : Colors.black,
            width: isSelected ? 3 : 1,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSoundPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Main Bottom Sheet
            StatefulBuilder(
              builder: (context, setState) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: MediaQuery.of(context).size.height *
                      0.30, // Reduced height since content is smaller
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Header with gradient
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 102, 44, 144),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'SOUND MANAGER',
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

                      const SizedBox(height: 24),

                      // Sound Controls
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'lib/images/soundpermission.png',
                                  height: 80,
                                  width: 40,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      'Permission required to play\nsounds during system \n interactions like clicks',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
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
                                  activeColor:
                                      const Color.fromRGBO(255, 146, 29, 1),
                                  inactiveTrackColor:
                                      const Color.fromARGB(255, 148, 148, 147),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Floating Close Button
            Positioned(
              top: -50, // Position above the bottom sheet
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Makes the container circular
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF712FA0),
                          Color(0xFF362F91),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showpermissionPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Main Bottom Sheet
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: MediaQuery.of(context).size.height * 0.8,
              child: PermissionPopup(),
            ),

            // Floating Close Button
            Positioned(
              top: -50, // Position above the bottom sheet
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Makes the container circular
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF712FA0),
                          Color(0xFF362F91),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPauseAccountBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return _PauseAccountSheet();
      },
    );
  }

  void _showLogoutPopup(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Main Bottom Sheet
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 102, 44, 144),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // IconButton(
                          //   icon: const Icon(Icons.arrow_back,
                          //       color: Colors.white),
                          //   onPressed: () => Navigator.pop(context),
                          // ),
                          const Text(
                            'LOG OUT',
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

                  SizedBox(height: screenSize.height * 0.04),

                  // Logout Options
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 12 : 16,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Any drafts you\'ve saved will still be available on this device.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 146, 29, 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add your logout logic here
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Log out',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                borderRadius: BorderRadius.circular(8),
                                // border: Border.all(
                                //     color: Colors.black, width: 1)
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add your logout logic here
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.orange,
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
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

            // Floating Close Button
            Positioned(
              top: -50,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Makes the container circular
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF712FA0),
                          Color(0xFF362F91),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showProfliePopup(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    nameController.text = 'Satyam';
    passwordController.text = 'satyam@aag';
    emailController.text = 'satyams@gmail.com';
    phoneController.text = '8888888888';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Main Bottom Sheet
            StatefulBuilder(
              builder: (context, setState) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Header
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 102, 44, 144),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // IconButton(
                              //   icon: const Icon(Icons.arrow_back,
                              //       color: Colors.white),
                              //   onPressed: () => Navigator.pop(context),
                              // ),
                              const Text(
                                'PROFILE',
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

                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 12 : 20,
                              vertical: isSmallScreen ? 12 : 20,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage:
                                          AssetImage('lib/images/ch.png'),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        size: 16,
                                        color: Color(0xFF510985),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                _buildEditableField('Name', nameController),
                                PasswordTextField(
                                  label: 'Password',
                                  controller: passwordController,
                                  isPassword: true,
                                ),
                                _buildEditableField(
                                    'Email Id', emailController),
                                _buildEditableField(
                                  'Phone Number',
                                  phoneController,
                                  keyboardType: TextInputType.phone,
                                ),
                                SizedBox(height: 20),
                                InkWell(
                                  onTap: () {
                                    // Handle save profile logic here
                                    print('Name: ${nameController.text}');
                                    print(
                                        'Password: ${passwordController.text}');
                                    print('Email: ${emailController.text}');
                                    print('Phone: ${phoneController.text}');
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color:
                                          const Color.fromRGBO(255, 146, 29, 1),
                                    ),
                                    child: Text(
                                      'SAVE CHANGES',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Floating Close Button
            Positioned(
              top: -50,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Makes the container circular
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF712FA0),
                          Color(0xFF362F91),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller,
      {bool isPassword = false, TextInputType? keyboardType}) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool obscureText = isPassword; // Track password visibility state
        bool hidePassword = true;
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4),
              TextField(
                controller: controller,
                style: TextStyle(color: Colors.black),
                // obscureText: isPassword ? _obscureText : false,
                obscureText: isPassword ? hidePassword : false,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black38),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  suffixIcon: isPassword
                      ? IconButton(
                          icon: Icon(
                            obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.black54,
                          ),
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                        )
                      : null,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSecurityPopup(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Main Bottom Sheet
            StatefulBuilder(
              builder: (context, setState) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Header
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 102, 44, 144),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // IconButton(
                              //   icon: const Icon(Icons.arrow_back,
                              //       color: Colors.white),
                              //   onPressed: () => Navigator.pop(context),
                              // ),
                              const Text(
                                'SECURITY',
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

                      SizedBox(height: screenSize.height * 0.04),

                      // Security Options List
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 12 : 16,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildSecurityOption(
                                  context,
                                  'Private Account',
                                  'lib/images/paccount.png',
                                  () => _showPrivateAccountPopup(context),
                                ),
                                SizedBox(height: isSmallScreen ? 16 : 20),
                                _buildSecurityOption(
                                  context,
                                  '2-Step Verification',
                                  'lib/images/tsv.png',
                                  () => _show2StepVerificationPopup(context),
                                ),
                                SizedBox(height: isSmallScreen ? 16 : 20),
                                _buildSecurityOption(
                                  context,
                                  'Log In Devices',
                                  'lib/images/devices.png',
                                  () => _showLogInDevicesPopup(context),
                                ),
                                SizedBox(height: isSmallScreen ? 16 : 20),
                                _buildSecurityOption(
                                  context,
                                  'Change Password',
                                  'lib/images/changepassword.png',
                                  () => _showChangePasswordPopup(context),
                                ),
                                SizedBox(height: isSmallScreen ? 16 : 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Floating Close Button
            Positioned(
              top: -50,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Makes the container circular
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF712FA0),
                          Color(0xFF362F91),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSecurityOption(BuildContext context, String title,
      String imagePath, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Material(
        elevation: 3, // Add elevation here
        color: Colors.transparent, // Preserve the transparency of the container
        borderRadius: BorderRadius.circular(4), // Optional: Add rounded corners
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4), // Match border radius
          ),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                width: 40,
                height: 40,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.orange,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPrivateAccountPopup(BuildContext context) {
    bool isPrivate = false;
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Main Bottom Sheet
            StatefulBuilder(
              builder: (context, setState) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: MediaQuery.of(context).size.height * 0.32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Header
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 102, 44, 144),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // IconButton(
                              //   icon: const Icon(Icons.arrow_back,
                              //       color: Colors.white),
                              //   onPressed: () => Navigator.pop(context),
                              // ),
                              const Text(
                                'PRIVATE ACCOUNT',
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

                      SizedBox(height: screenSize.height * 0.04),

                      // Content
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 12 : 16,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Private Account',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                Switch(
                                  value: isPrivate,
                                  onChanged: (value) {
                                    setState(() {
                                      isPrivate = true;
                                    });
                                  },
                                  activeColor:
                                      const Color.fromRGBO(255, 146, 29, 1),
                                  inactiveTrackColor:
                                      const Color.fromARGB(255, 148, 148, 147),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'When your account is public, your profile and Publish Game can be seen by anyone, on or off AAG App, even if they don\'t have an AAG account',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Floating Close Button
            Positioned(
              top: -50,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Makes the container circular
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF712FA0),
                          Color(0xFF362F91),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _show2StepVerificationPopup(BuildContext context) {
    List<TextEditingController> codeControllers = List.generate(
      4,
      (index) => TextEditingController(),
    );
    List<FocusNode> focusNodes = List.generate(
      4,
      (index) => FocusNode(),
    );

    int remainingTime = 30;
    Timer? countdownTimer;
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            StatefulBuilder(
              builder: (context, setState) {
                countdownTimer ??=
                    Timer.periodic(Duration(seconds: 1), (timer) {
                  setState(() {
                    if (remainingTime > 0) {
                      remainingTime--;
                    } else {
                      countdownTimer?.cancel();
                    }
                  });
                });

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: MediaQuery.of(context).size.height * 0.50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 102, 44, 144),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // IconButton(
                              //   icon: const Icon(Icons.arrow_back,
                              //       color: Colors.white),
                              //   onPressed: () {
                              //     countdownTimer?.cancel();
                              //     Navigator.pop(context);
                              //   },
                              // ),
                              const Text(
                                '2-STEP VERIFICATION',
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
                      SizedBox(height: 8),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 12 : 16,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Enter the 4-digit verification code we texted to your phone',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                    4,
                                    (index) => Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.black38,
                                          width: 2,
                                        ),
                                      ),
                                      child: TextField(
                                        controller: codeControllers[index],
                                        focusNode: focusNodes[index],
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        maxLength: 1,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        decoration: InputDecoration(
                                          counterText: "",
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (value) {
                                          if (value.length == 1 && index < 3) {
                                            focusNodes[index + 1]
                                                .requestFocus();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 40),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    // color: Color.fromRGBO(233, 116, 17, 1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      String code = codeControllers
                                          .map((controller) => controller.text)
                                          .join();
                                      print('Submitted code: $code');
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(255, 146, 29, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16),
                                    ),
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Re-send Code in ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '0:${remainingTime}s',
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              top: -50,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    countdownTimer?.cancel();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Makes the container circular
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF712FA0),
                          Color(0xFF362F91),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ).then((_) {
      countdownTimer?.cancel();
    });
  }

  void _showLogInDevicesPopup(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Main Bottom Sheet
            StatefulBuilder(
              builder: (context, setState) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Header
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 102, 44, 144),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // IconButton(
                              //   icon: const Icon(Icons.arrow_back,
                              //       color: Colors.white),
                              //   onPressed: () => Navigator.pop(context),
                              // ),
                              const Text(
                                'LOG IN DEVICES',
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

                      SizedBox(height: screenSize.height * 0.04),

                      // Devices List
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 12 : 16,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildDeviceItem(context),
                                _buildDeviceItem(context),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Floating Close Button
            Positioned(
              top: -50,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Makes the container circular
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF712FA0),
                          Color(0xFF362F91),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showChangePasswordPopup(BuildContext context) {
    bool newPasswordVisible = false;
    bool confirmPasswordVisible = false;
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            StatefulBuilder(
              builder: (context, setState) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 102, 44, 144),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // IconButton(
                              //   icon: const Icon(Icons.arrow_back,
                              //       color: Colors.white),
                              //   onPressed: () => Navigator.pop(context),
                              // ),
                              const Text(
                                'CHANGE PASSWORD',
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
                      SizedBox(height: screenSize.height * 0.04),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 12 : 16,
                            ),
                            child: Column(
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Current Password',
                                    labelStyle:
                                        TextStyle(color: Colors.grey.shade500),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                  style: TextStyle(color: Colors.grey.shade500),
                                ),
                                SizedBox(height: 16),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'New Password',
                                    labelStyle:
                                        TextStyle(color: Colors.grey.shade500),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        newPasswordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color:
                                            Color.fromARGB(255, 102, 44, 144),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          newPasswordVisible =
                                              !newPasswordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                  obscureText: !newPasswordVisible,
                                  style: TextStyle(color: Colors.grey.shade500),
                                ),
                                SizedBox(height: 16),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    labelStyle:
                                        TextStyle(color: Colors.grey.shade500),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        confirmPasswordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color:
                                            Color.fromARGB(255, 102, 44, 144),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          confirmPasswordVisible =
                                              !confirmPasswordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                  obscureText: !confirmPasswordVisible,
                                  style: TextStyle(color: Colors.deepPurple),
                                ),
                                SizedBox(height: 24),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(255, 146, 29, 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Implement save changes logic here
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      minimumSize: Size(double.infinity, 48),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      'SAVE CHANGES',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              top: -50,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Makes the container circular
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF712FA0),
                          Color(0xFF362F91),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDeviceItem(BuildContext context) {
    return InkWell(
      onTap: () => _showSignOutDevicePopup(context),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Image.asset(
              'lib/images/pho.png',
              width: 40,
              height: 40,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1 Session on Android Phone',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Vivo 1920',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Lucknow, Uttar Pradesh, India',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Last activity: Sep 30',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.orange,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  //
  void _showSignOutDevicePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'LOG IN DEVICES',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // IconButton(
                      //   icon: Icon(Icons.close, color: Colors.white),
                      //   onPressed: () => Navigator.pop(context),
                      // ),
                    ],
                  ),
                ),
                _buildDeviceDetails(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 146, 29, 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // Implement sign-out logic here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors
                                .transparent, // Make button background transparent
                            shadowColor: Colors.transparent, // Remove shadow
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 5),
                          ),
                          child: Text(
                            'Sign out',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.black),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: const Color.fromRGBO(255, 146, 29, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDeviceDetails() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Image.asset(
            'lib/images/pho.png',
            width: 40,
            height: 40,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1 Session on Android Phone',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Vivo 1920',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Lucknow, Uttar Pradesh, India',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Last activity: Sep 30',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PauseAccountSheet extends StatefulWidget {
  @override
  _PauseAccountSheetState createState() => _PauseAccountSheetState();
}

class _PauseAccountSheetState extends State<_PauseAccountSheet> {
  final PageController _pageController = PageController();
  String? selectedReason;
  final TextEditingController _passwordController = TextEditingController();
  Map<String, bool> selectedOptions = {
    'break': false,
    'trouble': false,
    'data': false,
    'privacy': false,
    'busy': false,
    'else': false,
  };

  String otherReason = '';

  void _nextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Header with gradient
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 102, 44, 144),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // IconButton(
                      //   icon: const Icon(Icons.arrow_back, color: Colors.white),
                      //   onPressed: () => Navigator.pop(context),
                      // ),
                      const Text(
                        'PAUSE ACCOUNT',
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

              // PageView for different sections
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    _buildInitialPage(),
                    _buildReasonSelectionPage(),
                    _buildPasswordVerificationPage(),
                    _buildFinalConfirmationPage(),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Floating Close Button
        Positioned(
          top: -50,
          left: 0,
          right: 0,
          child: Center(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Makes the container circular
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF712FA0),
                      Color(0xFF362F91),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInitialPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SizedBox(height: 40),
            Text(
              'Pause your account',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'If you want to take a break from AAG account, you can temporarily pause this account',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Set the color to white
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.1), // Shadow color with some opacity
                    blurRadius: 3, // Blur radius for shadow
                    offset: Offset(0, 3), // Offset to give elevation effect
                  ),
                ],
              ),
              child: RadioListTile<String>(
                title: Text(
                  'Select to confirm and proceed',
                  style: TextStyle(color: Colors.black),
                ),
                value: 'confirm',
                groupValue: selectedReason,
                activeColor: const Color.fromRGBO(255, 146, 29, 1),
                onChanged: (String? value) {
                  setState(() {
                    selectedReason = value;
                  });
                },
              ),
            ),
            SizedBox(height: 75),
            _buildActionButtons(
              onCancel: () => Navigator.pop(context),
              onContinue: _nextPage,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReasonSelectionPage() {
    // Create scroll controller for the container
    final ScrollController containerScrollController = ScrollController();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pause your AAG account',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 300, // Fixed height for scrollable container
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                controller: containerScrollController,
                child: Column(
                  children: selectedOptions.keys.map((key) {
                    return Column(
                      children: [
                        _buildCheckboxOption(
                          key,
                          onOptionSelected: () {
                            if (key == 'busy') {
                              // Scroll to bottom after widget is built
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                containerScrollController.animateTo(
                                  containerScrollController
                                      .position.maxScrollExtent,
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.easeOut,
                                );
                              });
                            }
                          },
                        ),
                        if (key == 'busy' && selectedOptions[key] == true)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: TextField(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Please specify your reason',
                                hintStyle: TextStyle(
                                  color: Colors.grey[600],
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                              maxLines: 3,
                              onChanged: (value) {
                                setState(() {
                                  otherReason = value;
                                });
                              },
                            ),
                          ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildActionButtons(
              onCancel: () => Navigator.pop(context),
              onContinue: _nextPage,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxOption(String key, {Function? onOptionSelected}) {
    String title = key == 'break'
        ? 'Just need a break'
        : key == 'trouble'
            ? 'Trouble getting started'
            : key == 'data'
                ? 'Concerned about my data'
                : key == 'privacy'
                    ? 'Privacy Concerns'
                    : key == 'busy'
                        ? 'Something else'
                        : 'Too busy/ too distracting';

    return CheckboxListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
      ),
      value: selectedOptions[key],
      activeColor: const Color.fromRGBO(255, 146, 29, 1),
      checkColor: Colors.white,
      onChanged: (bool? value) {
        setState(() {
          selectedOptions[key] = value ?? false;
          if (key == 'other') {
            if (value == true) {
              onOptionSelected?.call();
            } else {
              otherReason = ''; // Clear the text when unchecking
            }
          }
        });
      },
    );
  }

  Widget _buildPasswordVerificationPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('lib/images/ch.png'),
              radius: 30,
            ),
            SizedBox(height: 40),
            Text(
              'For your security, please re-enter your password to continue',
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            PasswordTextField(
              label: 'Password',
              controller: _passwordController,
              isPassword: true,
            ),
            SizedBox(height: 40),
            _buildActionButtons(
              onCancel: () => Navigator.pop(context),
              onContinue: _nextPage,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinalConfirmationPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Confirm temporary account pause',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You\'re about to temporarily pause your account. You can reactivate your account at any time through Accounts Center or by logging into your AAG account.',
                  style: TextStyle(fontSize: 20, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 64),
            _buildActionButtons(
              onCancel: () => Navigator.pop(context),
              onContinue: () {
                Navigator.of(context, rootNavigator: true)
                    .popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons({
    required VoidCallback onCancel,
    required VoidCallback onContinue,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 120,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white70, // Set the color to white
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.1), // Shadow color with some opacity
                blurRadius: 3, // Blur radius for shadow
                offset: Offset(0, 3), // Offset to give elevation effect
              ),
            ],
          ),
          child: TextButton(
            onPressed: onCancel,
            child: Text(
              'CANCEL',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color:
                const Color.fromRGBO(255, 146, 29, 1), // Set the color to white
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.1), // Shadow color with some opacity
                blurRadius: 3, // Blur radius for shadow
                offset: Offset(0, 3), // Offset to give elevation effect
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: onContinue,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              backgroundColor: const Color.fromRGBO(255, 146, 29, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'CONTINUE',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType? keyboardType;

  const PasswordTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.keyboardType,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 4),
          TextField(
            controller: widget.controller,
            style: TextStyle(color: Colors.black),
            obscureText: widget.isPassword ? _hidePassword : false,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              // focusedBorder: UnderlineInputBorder(
              //   borderSide: BorderSide(color: Colors.white),
              // ),
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _hidePassword ? Icons.visibility_off : Icons.visibility,
                        color: Color.fromARGB(255, 102, 44, 144),
                      ),
                      onPressed: () {
                        setState(() {
                          _hidePassword = !_hidePassword;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ],
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
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title Section
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 102, 44, 144),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // IconButton(
                  //   icon: const Icon(Icons.arrow_back, color: Colors.white),
                  //   onPressed: () => Navigator.pop(context),
                  // ),
                  const Text(
                    'MANAGE PERMISSIONS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Permission required to send transactional and promotional communication',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            // Communication Permissions
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 0.052),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  _buildCommunicationItem(
                    'WhatsApp',
                    'lib/images/app.png',
                    whatsappEnabled,
                    (value) => setState(() => whatsappEnabled = value),
                  ),
                  const Divider(color: Colors.white24, height: 1),
                  _buildCommunicationItem(
                    'SMS',
                    'lib/images/SMS.png',
                    smsEnabled,
                    (value) => setState(() => smsEnabled = value),
                  ),
                ],
              ),
            ),

            // System Permissions Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'System Permissions',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'System permissions required for critical app features to function properly',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            // System Permission Items
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  _buildSystemPermissionItem(
                      'Location', 'lib/images/Location.png'),
                  _buildSystemPermissionItem(
                      'Contacts', 'lib/images/Contacts.png'),
                  _buildSystemPermissionItem(
                      'Call Logs', 'lib/images/Call.png'),
                  _buildSystemPermissionItem(
                      'Manage Calls', 'lib/images/Managecalls.png'),
                  _buildSystemPermissionItem('Camera', 'lib/images/Camera.png'),
                  _buildSystemPermissionItem(
                      'Notifications', 'lib/images/Notification.png'),
                  _buildSystemPermissionItem(
                      'Microphone', 'lib/images/Microphone.png'),
                ],
              ),
            ),
            const SizedBox(height: 16),
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
      padding: const EdgeInsets.only(bottom: 12), // Added bottom margin
      child: Material(
        elevation: 3, // Elevation is already set, but confirming
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Image.asset(iconPath, width: 24, height: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Switch(
                value: value,
                onChanged: onChanged,
                activeColor: const Color.fromRGBO(255, 146, 29, 1),
                inactiveTrackColor: const Color.fromARGB(255, 148, 148, 147),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSystemPermissionItem(String title, String iconPath) {
    bool isAllowed = systemPermissions[title] ?? false;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12), // Added bottom margin
      child: Column(
        children: [
          Material(
            elevation: 3, // Elevation is already set, but confirming
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Image.asset(iconPath, width: 24, height: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        const Text(
                          'To enable relevant features',
                          style: TextStyle(
                            color: Colors.black54,
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
                      minimumSize: WidgetStateProperty.all(const Size(80, 36)),
                      backgroundColor: WidgetStateProperty.all(
                        const Color.fromRGBO(255, 146, 29, 1),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    child: Text(
                      isAllowed ? 'ALLOWED' : 'ALLOW',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (title != 'Microphone')
            const Divider(color: Colors.white24, height: 1),
        ],
      ),
    );
  }
}
