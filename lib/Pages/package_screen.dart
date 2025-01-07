// ignore_for_file: public_member_api_docs, sort_constructors_first
// subscription_screen.dart
import 'package:flutter/material.dart';

import 'package:AAG/Pages/otp_veri.dart';
import 'package:AAG/Pages/signup.dart';

import 'subscription_model.dart';

class PackageScreen extends StatefulWidget {
  final String mobilenumber;

  const PackageScreen({
    super.key,
    required this.mobilenumber,
  });

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  bool isMonthly = true;

  final List<SubscriptionPlan> plans = [
    SubscriptionPlan(
      name: 'Standard',
      description: 'For individual users',
      monthlyPrice: 9990,
      annualPrice: 99900,
      gradientColor1: const Color.fromARGB(255, 31, 63, 173),
      gradientColor2: const Color.fromARGB(255, 49, 46, 130),
      features: [
        'Must Have 100K+ Followers.',
        'Upto 4 Themes/Skins for the game',
        'Monthly Feature Slots for the games.',
        'Performance-Based Event Unlock.',
        'Referral Bonus',
        'Analytics Dashboard',
        'Priority Support',
        'Unique Game invite link.',
        'Limited Games Access.'
      ],
    ),
    SubscriptionPlan(
      name: 'Elite',
      description: 'Perfect for growing teams',
      monthlyPrice: 19900,
      annualPrice: 199900,
      isPopular: true,
      gradientColor1: const Color.fromARGB(255, 123, 34, 201),
      gradientColor2: const Color.fromARGB(255, 88, 28, 136),
      features: [
        'Must Have 500K+ Followers.',
        'Updated Daily Game Publish Limit.',
        'Upto 6 Themes/Skins for the game',
        'Daily/Monthly Feature Slots for the games.',
        'Performance-Based Events Unlock.',
        'Referral Bonus',
        'Analytics Dashboard',
        'Priority Support',
        'Unique Game invite link.',
        'Daily/ Weekly League Access option.',
        'Limited Time Tournament Access option.',
        'Weekly/Monthly Promotional Activities.',
        'Updated Games Access.',
      ],
    ),
    SubscriptionPlan(
      name: 'Pro',
      description: 'For professional teams',
      monthlyPrice: 29900,
      annualPrice: 299900,
      gradientColor1: const Color.fromARGB(255, 201, 137, 4),
      gradientColor2: const Color.fromARGB(255, 134, 78, 14),
      features: [
        'Must-Have 1M+ Followers.',
        'Updated Daily Game Publish Limit.',
        'Upto 12 Themes/Skins for the game',
        'Daily/Weekly/Monthly Feature Slots for the games.',
        'Daily/ Weekly/Monthly League Access option.',
        'Daily/Weekly/Monthly Tournament Access option.',
        'Daily/Weekly/Monthly Promotional Activities.',
        'Special Events Access.',
        'Referral Bonus',
        'Analytics Dashboard',
        'Customized Game invite link.',
        'All Platform Games Access.',
        'Priority Access to Beta Features.',
        'Additional Event Customization Options',
        'Dedicated Relationship Manager'
      ],
    ),
    SubscriptionPlan(
      name: 'Enterprise',
      description: 'Custom solutions',
      monthlyPrice: 39900,
      annualPrice: 399900,
      gradientColor1: const Color.fromARGB(255, 15, 118, 110),
      gradientColor2: const Color.fromARGB(255, 11, 62, 58),
      features: [
        'Customized Features and Plan Details',
        'Custom Plans For Businesses Only',
        '10x Return',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SignUpPage(),
              ),
            );
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'lib/images/aag.png',
          height: 40,
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildToggle(),
              const SizedBox(height: 24),
              _buildSubscriptionCards(),
              // _buildTrustedCompanies(),
              // ElevatedButton(
              //   onPressed: () {},
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.blue,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     padding: const EdgeInsets.symmetric(vertical: 16),
              //   ),
              //   child: const Text(
              //     "Contact Sales",
              //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              //   ),
              // ),
              const SizedBox(height: 10),
              const Text(
                "Need help choosing? Contact our team for a consultation",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Handle chat button press
      //   },
      //   child: const Icon(
      //     Icons.chat,
      //     color: Colors.black,
      //   ),
      // ),
    );
  }

  Widget _buildToggle() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleButton('Monthly', isMonthly),
          _buildToggleButton('Annual', !isMonthly),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String text, bool selected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isMonthly = text == 'Monthly';
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionCards() {
    return Column(
      children: plans.map((plan) => _buildPlanCard(plan)).toList(),
    );
  }

  Widget _buildPlanCard(SubscriptionPlan plan) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: Stack(
        children: [
          if (plan.isPopular)
            Positioned(
              top: 40,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Popular',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPlanHeader(plan),
              const SizedBox(height: 16),
              _buildFeaturesList(plan),
              const SizedBox(height: 16),
              _buildActionButton(plan),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlanHeader(SubscriptionPlan plan) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plan.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              plan.description,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
        if (plan.name != 'Enterprise')
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '₹${isMonthly ? plan.monthlyPrice : plan.annualPrice}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                isMonthly ? '/mo' : '/yr',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          )
        else
          const Text(
            'Custom pricing',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }

  Widget _buildFeaturesList(SubscriptionPlan plan) {
    return Column(
      children: plan.features.take(3).map((feature) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(feature),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButton(SubscriptionPlan plan) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _showPackagePlanBottomSheet(plan),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Explore Plan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _showPackagePlanBottomSheet(SubscriptionPlan plan) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _PackagePlanBottomSheet(
        title: plan.name,
        gradientColor1: plan.gradientColor1,
        gradientColor2: plan.gradientColor2,
        mobilenumber: widget.mobilenumber,
        packageFeatures: {
          plan.name.toLowerCase(): plan.features,
        },
      ),
    );
  }
}

// Widget _buildTrustedCompanies() {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text(
//         'Trusted by leading companies',
//         style: TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       const SizedBox(height: 16),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: List.generate(
//           4,
//           (index) => Container(
//             width: 80,
//             height: 40,
//             color: Colors.grey[300],
//           ),
//         ),
//       ),
//     ],
//   );
// }

class _PackagePlanBottomSheet extends StatefulWidget {
  final String title;
  final Color gradientColor1;
  final Color gradientColor2;
  final String mobilenumber;
  final Map<String, List<String>> packageFeatures;

  const _PackagePlanBottomSheet({
    required this.title,
    required this.gradientColor1,
    required this.gradientColor2,
    required this.mobilenumber,
    required this.packageFeatures,
  });

  @override
  __PackagePlanBottomSheetState createState() =>
      __PackagePlanBottomSheetState();
}

class __PackagePlanBottomSheetState extends State<_PackagePlanBottomSheet> {
  String _selectedPlan = 'monthly';

  List<Widget> _buildFeaturesList(String packageType) {
    final List<String> features =
        widget.packageFeatures[packageType.toLowerCase()] ?? [];

    return features
        .map((feature) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.check, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      feature,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ))
        .toList();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    // Get screen height
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.75, // 75% of screen height
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [widget.gradientColor1, widget.gradientColor2],
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Subscribe to ${widget.title}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      flex: _selectedPlan == 'monthly' ? 6 : 4,
                      child: _buildPlanOption(
                        'Monthly',
                        ' 799',
                        'Billed Monthly',
                        _selectedPlan == 'monthly',
                        () => setState(() => _selectedPlan = 'monthly'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: _selectedPlan == 'annual' ? 6 : 4,
                      child: _buildPlanOption(
                        'Annual',
                        ' 7,999',
                        'Billed Annually\nSAVE 33%',
                        _selectedPlan == 'annual',
                        () => setState(() => _selectedPlan = 'annual'),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(12),
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: _buildFeaturesList(widget.title),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ProfileSetup(
                              selectedPlan: widget.title,
                              mobileNumber: widget.mobilenumber,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Choose ${widget.title}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanOption(
    String title,
    String price,
    String subtitle,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.all(isSelected ? 16.0 : 12.0),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color.fromARGB(255, 238, 235, 235)
                  : Colors.transparent,
              border: Border.all(
                color: Colors.white,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white,
                    fontSize: isSelected ? 18 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '₹',
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.white,
                        fontSize: isSelected ? 20 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      price,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.white,
                        fontSize: isSelected ? 24 : 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isSelected ? Colors.black54 : Colors.white70,
                    fontSize: isSelected ? 14 : 12,
                  ),
                ),
              ],
            ),
          ),
          if (isSelected)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// int _calculateSavings(int monthlyPrice, int annualPrice) {
//   double monthlyTotal = monthlyPrice * 12;
//   double savings = monthlyTotal - annualPrice;
//   return ((savings / monthlyTotal) * 100).round();
// }
