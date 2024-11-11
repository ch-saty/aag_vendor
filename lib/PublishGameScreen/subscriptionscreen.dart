import 'package:AAG/Pages/package_screen.dart';
import 'package:AAG/tobeadded/gradient_button.dart';
import 'package:flutter/material.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool isMonthly = true;
  String expandedPlan = '';
  String selectedPlan = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'SUBSCRIPTION',
          style: TextStyle(color: Colors.white),
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
            Expanded(
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'CURRENT PLAN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildPlanCard(
                          'STANDARD',
                          '₹10,000 / month',
                          'Must Have 100K+ Followers',
                          const Color.fromARGB(255, 113, 47, 160),
                          const Color.fromARGB(255, 54, 47, 145),
                        ),
                        const SizedBox(height: 25),
                        _buildSubscriptionToggle(),
                        const SizedBox(height: 25),
                        const Text(
                          'UPGRADE OTHER PLANS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // _buildSubscriptionToggle(),
                        const SizedBox(height: 25),
                        _buildPlanCard(
                          'PRO',
                          '₹20,000 / month',
                          'Must Have 500K+ Followers',
                          const Color.fromARGB(255, 239, 38, 209),
                          const Color.fromARGB(255, 255, 111, 79),
                        ),
                        const SizedBox(height: 25),
                        _buildPlanCard(
                          'ELITE',
                          '₹30,000 / month',
                          'Must Have 1M+ Followers',
                          const Color.fromARGB(155, 239, 105, 82),
                          const Color.fromARGB(155, 255, 249, 71),
                        ),
                        const SizedBox(height: 25),
                        _buildPlanCard(
                          'ENTERPRISE',
                          '₹40,000 / month',
                          'Upto 10X Return',
                          const Color.fromARGB(255, 3, 189, 156),
                          const Color.fromARGB(255, 3, 87, 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(onTap: () {}, text: 'Continue'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(String title, String price, String subtitle,
      Color gradientColor1, Color gradientColor2) {
    bool isExpanded = expandedPlan == title;
    return Column(
      children: [
        MovingGradientBorder(
          width: MediaQuery.of(context).size.width - 32,
          height: 131,
          gradientColors: [gradientColor1, gradientColor2, gradientColor1],
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                    Text(
                      price,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                  onPressed: () =>
                      setState(() => expandedPlan = isExpanded ? '' : title),
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          AnimatedContainer(
            padding: const EdgeInsets.only(top: 20),
            duration: const Duration(milliseconds: 500),
            child: MovingGradientBorder(
              width: MediaQuery.of(context).size.width - 32,
              height: MediaQuery.of(context).size.height * 0.40,
              gradientColors: [gradientColor1, gradientColor2, gradientColor1],
              child: SingleChildScrollView(
                // This will prevent overflow
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: _buildExpandedContent(
                      title, gradientColor1, gradientColor2),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildExpandedContent(
      String title, Color gradientColor1, Color gradientColor2) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.57,
        child: Column(
          children: [
            ..._getFeatures(title, gradientColor1, gradientColor2),
            ..._getFeatures2(
                title, Colors.red, const Color.fromARGB(255, 231, 57, 44)),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionToggle() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => setState(() => isMonthly = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isMonthly ? Colors.orange : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Monthly',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => setState(() => isMonthly = false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !isMonthly ? Colors.orange : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Annual',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getFeatures(
      String title, Color gradientColor1, Color gradientColor2) {
    List<String> features;
    switch (title.toLowerCase()) {
      case 'standard':
        features = [
          'Must Have 100K+ Followers.',
          'Upto 4 Themes/Skins for the game',
          'Monthly Feature Slots for the games.',
          'Performance-Based Event Unlock.',
          'Referral Bonus',
          'Analytics Dashboard',
          'Priority Support',
          'Unique Game invite link.',
          'Limited Games Access.'
        ];
        break;
      case 'pro':
        features = [
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
        ];
        break;
      case 'elite':
        features = [
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
        ];
        break;
      case 'enterprise':
      default:
        features = [
          'Customized Features and Plan Details',
          'Custom Plans For Business Individuals Only',
          '10x Return',
        ];
        break;
    }

    return features.map((feature) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            GradientCheckbox(
              gradientColors: [gradientColor1, gradientColor2],
              value: true,
              onChanged: (bool? value) {},
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                feature,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  List<Widget> _getFeatures2(
      String title, Color gradientColor1, Color gradientColor2) {
    List<String> features;
    switch (title.toLowerCase()) {
      case 'standard':
        features = [
          'No Daily/ Weekly League Access option.',
          'No Daily/ Weekly Tournament Access option.',
          'No Dedicated Relationship Manager',
          'No Daily/ Weekly Promotional Activities.',
          'No Event Customization Option',
        ];
        break;
      case 'pro':
        features = [
          'Limited Event Customization Options',
          'No Dedicated Relationship Manager'
        ];
        break;
      case 'elite':
        features = [];
        break;
      case 'enterprise':
      default:
        features = [];
        break;
    }

    return features.map((feature) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            GradientCheckbox2(
              gradientColors: [gradientColor1, gradientColor2],
              value: true,
              onChanged: (bool? value) {},
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                feature,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}

class MovingGradientBorder extends StatefulWidget {
  final double width;
  final double height;
  final List<Color> gradientColors;
  final Widget child;

  const MovingGradientBorder({
    super.key,
    required this.width,
    required this.height,
    required this.gradientColors,
    required this.child,
  });

  @override
  _MovingGradientBorderState createState() => _MovingGradientBorderState();
}

class _MovingGradientBorderState extends State<MovingGradientBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: widget.gradientColors,
              stops: [
                _controller.value - 0.3,
                _controller.value,
                _controller.value + 0.3,
              ],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: widget.child,
          ),
        );
      },
    );
  }
}
