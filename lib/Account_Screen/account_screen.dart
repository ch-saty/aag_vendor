// ignore_for_file: avoid_print

import 'dart:async';
// import 'dart:math';

import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/images/idkbg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'ACCOUNT',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
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
              child: Container(
                width: MediaQuery.of(context).size.width * 0.90,
                height: MediaQuery.of(context).size.height * 0.30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSettingsItem(
                      'Profile',
                      'lib/images/profile_icon.png',
                      () => _showProfliePopup(context),
                    ),
                    _buildSettingsItem(
                      'Security',
                      'lib/images/security_icon.png',
                      () => _showSecurityPopup(context),
                    ),
                    _buildSettingsItem(
                      'Pause Account',
                      'lib/images/pause_icon.png',
                      () => _showPauseAccountBottomSheet(context),
                    ),
                    _buildSettingsItem(
                      'Logout',
                      'lib/images/logout.png',
                      () => _showLogoutPopup(context),
                      showDivider: false,
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
      backgroundColor: Colors.transparent,
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
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF35035A),
                    Color(0xFF510985),
                    Color(0xFF35035A),
                  ],
                  stops: [0.1572, 0.5, 0.8753],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
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
                              'Any drafts you\'ve saved will still be\navailable on this device.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF83410A),
                                    Color(0xFFE97411),
                                    Color(0xFF88440A)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add your logout logic here
                                  Navigator.of(context).pop();
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
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFFE97411),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(
                                    color: Color(0xFFE97411),
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
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

    nameController.text = 'Satyam ';
    passwordController.text = 'satyam@aag';
    emailController.text = 'satyams@gmail.com';
    phoneController.text = '8888888888';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
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
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF35035A),
                        Color(0xFF510985),
                        Color(0xFF35035A),
                      ],
                      stops: [0.1572, 0.50, 0.8753],
                    ),
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
                                      gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xFF83410A),
                                          Color(0xFFE97411),
                                          Color(0xFF88440A),
                                        ],
                                        stops: [0.071, 0.491, 0.951],
                                      ),
                                    ),
                                    child: Text(
                                      'EDIT PROFILE',
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
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4),
              TextField(
                controller: controller,
                style: TextStyle(color: Colors.white),
                // obscureText: isPassword ? _obscureText : false,
                obscureText: isPassword ? hidePassword : false,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white30),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  suffixIcon: isPassword
                      ? IconButton(
                          icon: Icon(
                            obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white70,
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

  Widget _buildSettingsItem(
    String title,
    String iconPath,
    VoidCallback onTap, {
    bool showDivider = true,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Image.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16, // Match font size to _buildSettingsItem2
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
          // Horizontal divider
          // if (showDivider)
          //   Container(
          //     height: 0.5,
          //     color: const Color.fromARGB(255, 233, 116, 17),
          //   ),
        ],
      ),
    );
  }

  void _showSecurityPopup(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
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
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF35035A),
                        Color(0xFF510985),
                        Color(0xFF35035A),
                      ],
                      stops: [0.1572, 0.5, 0.8753],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
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
                                  'lib/images/private.png',
                                  () => _showPrivateAccountPopup(context),
                                ),
                                SizedBox(height: isSmallScreen ? 16 : 20),
                                _buildSecurityOption(
                                  context,
                                  '2-Step Verification',
                                  'lib/images/2-step.png',
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
                                  'lib/images/change_password.png',
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
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(color: Colors.white10),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 40,
              height: 40,
              color: Colors.orange,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.orange,
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
    );
  }

  void _showPrivateAccountPopup(BuildContext context) {
    bool isPrivate = false;
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
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
                  height: MediaQuery.of(context).size.height * 0.45,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF35035A),
                        Color(0xFF510985),
                        Color(0xFF35035A),
                      ],
                      stops: [0.1572, 0.5, 0.8753],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
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
                                    color: Colors.orange,
                                    fontSize: 16,
                                  ),
                                ),
                                Switch(
                                  value: isPrivate,
                                  activeColor: Colors.green,
                                  inactiveThumbColor: Colors.red,
                                  inactiveTrackColor:
                                      Colors.red.withOpacity(0.5),
                                  onChanged: (bool value) {
                                    setState(() {
                                      isPrivate = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'When your account is public, your profile and Publish Game can be seen by anyone, on or off AAG App, even if they don\'t have an AAG account',
                              style: TextStyle(
                                color: Colors.white,
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
      backgroundColor: Colors.transparent,
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
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF35035A),
                        Color(0xFF510985),
                        Color(0xFF35035A),
                      ],
                      stops: [0.1572, 0.5, 0.8753],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
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
                      SizedBox(height: screenSize.height * 0.04),
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
                                    color: Colors.orange,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 24),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                    4,
                                    (index) => Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.purple.shade300,
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
                                          color: Colors.white,
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
                                SizedBox(height: 24),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF712FA0),
                                        Color(0xFF362F91),
                                      ],
                                      stops: [0.0155, 0.9845],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      String code = codeControllers
                                          .map((controller) => controller.text)
                                          .join();
                                      print('Submitted code: $code');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
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
                                        color: Colors.white,
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
      backgroundColor: Colors.transparent,
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
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF35035A),
                        Color(0xFF510985),
                        Color(0xFF35035A),
                      ],
                      stops: [0.1572, 0.5, 0.8753],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
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
      backgroundColor: Colors.transparent,
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
                  height: MediaQuery.of(context).size.height * 0.7,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF35035A),
                        Color(0xFF510985),
                        Color(0xFF35035A),
                      ],
                      stops: [0.1572, 0.5, 0.8753],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
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
                                    labelStyle: TextStyle(color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 16),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'New Password',
                                    labelStyle: TextStyle(color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        newPasswordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.white,
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
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 16),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    labelStyle: TextStyle(color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        confirmPasswordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.white,
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
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 24),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF83410A),
                                        Color(0xFFE97411),
                                        Color(0xFF88440A),
                                      ],
                                      stops: [0.071, 0.491, 0.951],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
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
                      color: Colors.orange,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Vivo 1920',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Lucknow, Uttar Pradesh, India',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Last activity: Sep 30',
                    style: TextStyle(
                      color: Colors.white,
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
              gradient: LinearGradient(
                colors: [
                  Color(0xFF35035A),
                  Color(0xFF510985),
                  Color(0xFF35035A),
                ],
                stops: [0.1572, 0.5, 0.8753],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
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
                          color: Colors.white,
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
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF83410A),
                              Color(0xFFE97411),
                              Color(0xFF88440A),
                            ],
                            stops: [0.071, 0.491, 0.951],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
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
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.purple),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
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
                    color: Colors.orange,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Vivo 1920',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Lucknow, Uttar Pradesh, India',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Last activity: Sep 30',
                  style: TextStyle(
                    color: Colors.white,
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
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 4),
          TextField(
            controller: widget.controller,
            style: TextStyle(color: Colors.white),
            obscureText: widget.isPassword ? _hidePassword : false,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white30),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _hidePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white70,
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

class _PauseAccountPopup extends StatefulWidget {
  @override
  _PauseAccountPopupState createState() => _PauseAccountPopupState();
}

class _PauseAccountPopupState extends State<_PauseAccountPopup> {
  String? selectedReason;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'PAUSE ACCOUNT',
                      style: TextStyle(
                        color: Colors.white,
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
                SizedBox(height: 10),
                Text(
                  'If you want to take a break from AAG account, you can temporarily pause this account',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(71, 113, 47, 160),
                        Color.fromARGB(79, 54, 47, 145),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      _buildRadioOption('Select to confirm and proceed'),
                      // _buildRadioOption('Trouble getting started'),
                      // _buildRadioOption('Concerned about my data'),
                      // _buildRadioOption('Privacy Concerns'),
                      // _buildRadioOption('To busy/ too distracting'),
                      // _buildRadioOption('Something else'),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 120,
                      height: 44,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(
                              233, 116, 17, 1), // rgba(233, 116, 17, 1)
                          width: 2, // Set border width as desired
                        ),
                        borderRadius: BorderRadius.circular(
                            4), // Optional: Rounded corners
                      ),
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'CANCEL',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF83410A),
                            Color(0xFFE97411),
                            Color(0xFF88440A),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ElevatedButton(
                        onPressed: () => _showReason(context),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'CONTINUE',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
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

  Widget _buildRadioOption(String title) {
    return RadioListTile<String>(
      title: Text(title, style: TextStyle(color: Colors.white)),
      value: title,
      groupValue: selectedReason,
      activeColor: Color(0xFFE97411),
      onChanged: (String? value) {
        setState(() {
          selectedReason = value;
        });
      },
    );
  }
}

void _showPasswordVerification(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      bool isPasswordVisible = false; // State variable for password visibility

      return StatefulBuilder(// Wrap Dialog with StatefulBuilder
          builder: (context, setState) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
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
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('lib/images/ch.png'),
                    radius: 30,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'For your security, please re-enter your password to continue',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    obscureText: !isPasswordVisible, // Toggle based on state
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white54),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: IconButton(
                        // Changed to IconButton
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            // Toggle visibility
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF83410A),
                          Color(0xFFE97411),
                          Color(0xFF88440A),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ElevatedButton(
                      onPressed: () => _showFinalConfirmation(context),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'CONTINUE',
                        style: TextStyle(
                          color: Colors.white,
                        ),
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

void _showFinalConfirmation(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.4,
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
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Confirm temporary account pause',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'You\'re about to temporarily pause your account. You can reactivate your account at any time through Accounts Center or by logging into your AAG account.',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 120,
                      height: 44,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(
                              233, 116, 17, 1), // rgba(233, 116, 17, 1)
                          width: 2, // Set border width as desired
                        ),
                        borderRadius: BorderRadius.circular(
                            4), // Optional: Rounded corners
                      ),
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'CANCEL',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF83410A),
                            Color(0xFFE97411),
                            Color(0xFF88440A),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ElevatedButton(
                        onPressed: () =>
                            Navigator.of(context, rootNavigator: true)
                                .popUntil((route) => route.isFirst),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'CONTINUE',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void _showReason(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => _ShowReasonDialog(),
  );
}

class _ShowReasonDialog extends StatefulWidget {
  @override
  _ShowReasonDialogState createState() => _ShowReasonDialogState();
}

class _ShowReasonDialogState extends State<_ShowReasonDialog> {
  // Map to track selected options
  Map<String, bool> selectedOptions = {
    'break': false,
    'trouble': false,
    'data': false,
    'privacy': false,
    'busy': false,
    'else': false,
  };

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF35035A),
              Color(0xFF510985),
              Color(0xFF35035A),
            ],
            stops: [0.1572, 0.5, 0.8753],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pause your AAG account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Text(
              'Pause your account is temporary, and it means your profile will be hidden on AAG until you reactivate it through Accounts Center or by logging into your AAG account.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFE97411),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  CheckboxListTile(
                    title: Text('Just need a break.',
                        style: TextStyle(color: Colors.white)),
                    value: selectedOptions['break'],
                    activeColor: Color(0xFFE97411),
                    checkColor: Colors.white,
                    onChanged: (bool? value) {
                      setState(() {
                        selectedOptions['break'] = value ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Trouble getting started.',
                        style: TextStyle(color: Colors.white)),
                    value: selectedOptions['trouble'],
                    activeColor: Color(0xFFE97411),
                    checkColor: Colors.white,
                    onChanged: (bool? value) {
                      setState(() {
                        selectedOptions['trouble'] = value ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Concerned about my data.',
                        style: TextStyle(color: Colors.white)),
                    value: selectedOptions['data'],
                    activeColor: Color(0xFFE97411),
                    checkColor: Colors.white,
                    onChanged: (bool? value) {
                      setState(() {
                        selectedOptions['data'] = value ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Privacy Concerns.',
                        style: TextStyle(color: Colors.white)),
                    value: selectedOptions['privacy'],
                    activeColor: Color(0xFFE97411),
                    checkColor: Colors.white,
                    onChanged: (bool? value) {
                      setState(() {
                        selectedOptions['privacy'] = value ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('To busy/ too distracting.',
                        style: TextStyle(color: Colors.white)),
                    value: selectedOptions['busy'],
                    activeColor: Color(0xFFE97411),
                    checkColor: Colors.white,
                    onChanged: (bool? value) {
                      setState(() {
                        selectedOptions['busy'] = value ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Something else.',
                        style: TextStyle(color: Colors.white)),
                    value: selectedOptions['else'],
                    activeColor: Color(0xFFE97411),
                    checkColor: Colors.white,
                    onChanged: (bool? value) {
                      setState(() {
                        selectedOptions['else'] = value ?? false;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: Text('CANCEL', style: TextStyle(color: Colors.white)),
                  onPressed: () => Navigator.pop(context),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF83410A),
                        Color(0xFFE97411),
                        Color(0xFF88440A),
                      ],
                      stops: [0.071, 0.491, 0.951],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextButton(
                    child:
                        Text('CONTINUE', style: TextStyle(color: Colors.white)),
                    onPressed: () => _showPasswordVerification(context),
                  ),
                ),
              ],
            ),
          ],
        ),
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
          height: MediaQuery.of(context).size.height * 0.5,
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
            Text(
              'If you want to take a break from AAG account, you can temporarily pause this account',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(71, 113, 47, 160),
                    Color.fromARGB(79, 54, 47, 145),
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: RadioListTile<String>(
                title: Text('Select to confirm and proceed',
                    style: TextStyle(color: Colors.white)),
                value: 'confirm',
                groupValue: selectedReason,
                activeColor: Color(0xFFE97411),
                onChanged: (String? value) {
                  setState(() {
                    selectedReason = value;
                  });
                },
              ),
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

  Widget _buildReasonSelectionPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pause your AAG account',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFE97411),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: selectedOptions.keys.map((key) {
                  return _buildCheckboxOption(key);
                }).toList(),
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
              style: TextStyle(color: Colors.white),
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
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            Text(
              'You\'re about to temporarily pause your account. You can reactivate your account at any time through Accounts Center or by logging into your AAG account.',
              style: TextStyle(fontSize: 20, color: Colors.red),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
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

  Widget _buildCheckboxOption(String key) {
    String title = key == 'break'
        ? 'Just need a break'
        : key == 'trouble'
            ? 'Trouble getting started'
            : key == 'data'
                ? 'Concerned about my data'
                : key == 'privacy'
                    ? 'Privacy Concerns'
                    : key == 'busy'
                        ? 'Too busy/ too distracting'
                        : 'Something else';

    return CheckboxListTile(
      title: Text(title, style: TextStyle(color: Colors.white)),
      value: selectedOptions[key],
      activeColor: Color(0xFFE97411),
      checkColor: Colors.white,
      onChanged: (bool? value) {
        setState(() {
          selectedOptions[key] = value ?? false;
        });
      },
    );
  }

  Widget _buildActionButtons({
    required VoidCallback onCancel,
    required VoidCallback onContinue,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 120,
          height: 44,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFFE97411),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextButton(
            onPressed: onCancel,
            child: Text(
              'CANCEL',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF83410A),
                Color(0xFFE97411),
                Color(0xFF88440A),
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ElevatedButton(
            onPressed: onContinue,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
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
