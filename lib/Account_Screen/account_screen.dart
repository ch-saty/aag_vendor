// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:math';

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
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      () => _showpauseAccountPopup(context),
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

  void _showpauseAccountPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: _PauseAccountPopup(),
        );
      },
    );
  }

  void _showLogoutPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
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
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'LOG OUT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
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
                  width: 100,
                  height: 40,
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
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your logout logic here
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Log out',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(233, 116, 17, 1),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showProfliePopup(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    nameController.text = 'Satyam ';
    passwordController.text = 'satyam@aag';
    emailController.text = 'satyams@gmail.com';
    phoneController.text = '8888888888';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF35035A),
                  Color(0xFF510985),
                  Color(0xFF35035A),
                ],
                stops: [0.1572, 0.50, 0.8753],
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
                      'PROFILE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('lib/images/ch.png'),
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
                _buildEditableField('Email Id', emailController),
                _buildEditableField('Phone Number', phoneController,
                    keyboardType: TextInputType.phone),
                SizedBox(height: 20),
                StatefulBuilder(
                  builder: (context, setState) {
                    return InkWell(
                      onTap: () {
                        // Handle save profile logic here
                        print('Name: ${nameController.text}');
                        print('Password: ${passwordController.text}');
                        print('Email: ${emailController.text}');
                        print('Phone: ${phoneController.text}');
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
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
                    );
                  },
                ),
              ],
            ),
          ),
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
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Image.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                  color: Colors.white,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Color.fromARGB(255, 233, 116, 17),
                  size: 24,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Container(
            height: 0.5,
            color: Colors.white.withOpacity(0.8),
          ),
      ],
    );
  }

  void _showSecurityPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.5,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SECURITY',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                _buildSecurityOption(
                  context,
                  'Private Account',
                  'lib/images/private.png',
                  () => _showPrivateAccountPopup(context),
                ),
                _buildSecurityOption(
                  context,
                  '2-Step Verification',
                  'lib/images/2-step.png',
                  () => _show2StepVerificationPopup(context),
                ),
                _buildSecurityOption(
                  context,
                  'Log In Devices',
                  'lib/images/devices.png',
                  () => _showLogInDevicesPopup(context),
                ),
                _buildSecurityOption(
                  context,
                  'Change Password',
                  'lib/images/change_password.png',
                  () => _showChangePasswordPopup(context),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: [
              Color.fromRGBO(113, 47, 160, 0.2), // Purple
              Color.fromRGBO(54, 47, 145, .2), // Dark Blue
            ],
            stops: [0.0155, 0.9845], // Corresponds to 1.55% and 98.45%
            transform: GradientRotation(178.17 * pi / 180), // 178.17 degrees
          ),
        ),
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
    bool isPrivate = false; // Add a state to track the switch value

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // Use StatefulBuilder to update the state within the dialog
          builder: (BuildContext context, StateSetter setState) {
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'PRIVATE ACCOUNT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
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
                            inactiveTrackColor: Colors.red.withOpacity(0.5),
                            onChanged: (bool value) {
                              setState(() {
                                isPrivate = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        'When your account is public, your profile and Publish Game can be seen by anyone, on or off AAG App, even if they don\'t have an AAG account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showLogInDevicesPopup(BuildContext context) {
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'LOG IN DEVICES',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                _buildDeviceItem(context),
                _buildDeviceItem(context),
                SizedBox(height: 16),
              ],
            ),
          ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'LOG IN DEVICES',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
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

  void _showChangePasswordPopup(BuildContext context) {
    // Add these boolean variables to track password visibility
    bool newPasswordVisible = false;
    bool confirmPasswordVisible = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // Wrap with StatefulBuilder to manage state
          builder: (context, setState) {
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'CHANGE PASSWORD',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Current Password',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
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
                                borderSide: BorderSide(color: Colors.white),
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
                                    newPasswordVisible = !newPasswordVisible;
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
                                borderSide: BorderSide(color: Colors.white),
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
                            width: double
                                .infinity, // Ensures the button takes full width
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
                                backgroundColor: Colors
                                    .transparent, // Transparent to show gradient
                                shadowColor:
                                    Colors.transparent, // Remove shadow
                                minimumSize: Size(double.infinity,
                                    48), // Full-width with 48 height
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
                          )
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

  void _show2StepVerificationPopup(BuildContext context) {
    // Controller for the 4-digit code
    List<TextEditingController> codeControllers = List.generate(
      4,
      (index) => TextEditingController(),
    );
    List<FocusNode> focusNodes = List.generate(
      4,
      (index) => FocusNode(),
    );

    // Countdown timer state
    int remainingTime = 30;
    Timer? countdownTimer;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            // Start the timer when the dialog is shown
            countdownTimer ??= Timer.periodic(Duration(seconds: 1), (timer) {
              setState(() {
                if (remainingTime > 0) {
                  remainingTime--;
                } else {
                  countdownTimer?.cancel();
                }
              });
            });

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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '2-STEP VERIFICATION',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.white),
                            onPressed: () {
                              countdownTimer?.cancel();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Enter the 4-digit verification code we texted to your phone',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  focusNodes[index + 1].requestFocus();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      width: double.infinity,
                      child: Container(
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
                            // Implement submit logic here
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
                            padding: EdgeInsets.symmetric(vertical: 16),
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
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
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
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).then((_) {
      countdownTimer?.cancel(); // Cancel timer when dialog is dismissed
    });
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'PAUSE ACCOUNT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'If you want to take a break from AAG account, you can temporarily pause this account',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
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
                SizedBox(height: 20),
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
