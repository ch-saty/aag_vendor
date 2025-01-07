// ignore_for_file: use_build_context_synchronously

import 'package:AAG/Otp_Services/new_otp_services.dart';
import 'package:AAG/Pages/package_screen.dart';
import 'package:AAG/Pages/successverificationscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSetup extends StatefulWidget {
  final String selectedPlan;
  final String mobileNumber;

  const ProfileSetup(
      {super.key, required this.selectedPlan, required this.mobileNumber});

  @override
  State<ProfileSetup> createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _socialLinkController = TextEditingController();
  final OtpService _otpServices = OtpService();

  bool _showFacebookField = false;
  bool _showInstagramField = false;
  bool _showTwitterField = false;

  bool _isFacebookConnected = false;
  bool _isInstagramConnected = false;
  bool _isTwitterConnected = false;
  late String _selectedPlan;
  bool _isLoading = false;

  // Store social media URLs
  Map<String, String> socialMediaUrls = {};

  final Map<String, int> _subscriptionPlans = {
    'Standard': 99900,
    'Elite': 199900,
    'Pro': 299900,
    'Enterprise': 399900,
  };

  @override
  void initState() {
    super.initState();
    _selectedPlan = widget.selectedPlan;
    _loadStoredToken();
  }

  Future<void> _loadStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user_token');
    if (token == null) {
      // Handle case where token is not found
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Session expired. Please login again.'),
          backgroundColor: Colors.red,
        ),
      );
      // Navigate to login screen or handle accordingly
    }
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validate at least one social media is connected
    if (!_isFacebookConnected &&
        !_isInstagramConnected &&
        !_isTwitterConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please connect at least one social media account'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('user_token');

      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Session expired. Please login again.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final result = await _otpServices.submitVendorProfile(
        name: _nameController.text,
        email: _emailController.text,
        planName: _selectedPlan,
        token: token,
        socialMediaUrls: socialMediaUrls,
      );

      if (result['success']) {
        // Save additional user details
        await prefs.setString('user_name', _nameController.text);
        await prefs.setString('user_email', _emailController.text);
        await prefs.setString('selected_plan', _selectedPlan);
        await prefs.setString('mobile_number', widget.mobileNumber);

        // Navigate to success screen
        Navigator.of(context).pushAndRemoveUntil(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const SuccessVerificationScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = const Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.ease;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Profile submission failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => PackageScreen(
                  mobilenumber: widget.mobileNumber,
                ),
              ),
            );
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'lib/images/aag.png',
          height: 40,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _nameController,
                    enabled: !_isLoading,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    enabled: !_isLoading,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Connect Social Media',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      _buildSocialButton(
                        imagePath: 'lib/images/whatsapp.png',
                        title: 'Whatsapp',
                        isConnected: _isFacebookConnected,
                        onTap: () {
                          setState(() {
                            _showFacebookField = !_showFacebookField;
                            _showInstagramField = false;
                            _showTwitterField = false;
                          });
                        },
                      ),
                      if (_showFacebookField)
                        _buildSocialLinkField(
                          onSubmit: () {
                            setState(() {
                              _isFacebookConnected = true;
                              _showFacebookField = false;
                              socialMediaUrls['whatsapp'] =
                                  _socialLinkController.text;
                            });
                          },
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      _buildSocialButton(
                        imagePath: 'lib/images/insta.png',
                        title: 'Instagram',
                        isConnected: _isInstagramConnected,
                        onTap: () {
                          setState(() {
                            _showInstagramField = !_showInstagramField;
                            _showFacebookField = false;
                            _showTwitterField = false;
                          });
                        },
                      ),
                      if (_showInstagramField)
                        _buildSocialLinkField(
                          onSubmit: () {
                            setState(() {
                              _isInstagramConnected = true;
                              _showInstagramField = false;
                              socialMediaUrls['instagram'] =
                                  _socialLinkController.text;
                            });
                          },
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      _buildSocialButton(
                        imagePath: 'lib/images/f_book.png',
                        title: 'Facebook',
                        isConnected: _isTwitterConnected,
                        onTap: () {
                          setState(() {
                            _showTwitterField = !_showTwitterField;
                            _showFacebookField = false;
                            _showInstagramField = false;
                          });
                        },
                      ),
                      if (_showTwitterField)
                        _buildSocialLinkField(
                          onSubmit: () {
                            setState(() {
                              _isTwitterConnected = true;
                              _showTwitterField = false;
                              socialMediaUrls['facebook'] =
                                  _socialLinkController.text;
                            });
                          },
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Subscription',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedPlan,
                    // onSaved: _isLoading,
                    items: _subscriptionPlans.keys.map((String plan) {
                      final monthlyPrice =
                          (_subscriptionPlans[plan]! / 120).toStringAsFixed(2);

                      return DropdownMenuItem<String>(
                        value: plan,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(plan),
                            const SizedBox(width: 50),
                            Text(
                              '₹$monthlyPrice/month',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedPlan = newValue!;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleSignup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required String imagePath,
    required String title,
    required bool isConnected,
    required VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    imagePath,
                    width: 26,
                    height: 26,
                  ),
                  const SizedBox(width: 12),
                  Text(title),
                ],
              ),
              Text(
                isConnected ? 'Connected' : 'Connect',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLinkField({required VoidCallback onSubmit}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _socialLinkController,
              enabled: !_isLoading,
              decoration: const InputDecoration(
                hintText: 'Paste your profile link',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            child: ElevatedButton(
              onPressed: _isLoading ? null : onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _socialLinkController.dispose();
    super.dispose();
  }
}
