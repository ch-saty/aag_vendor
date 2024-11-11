import 'package:AAG/Pages/package_screen.dart';
import 'package:AAG/Pages/successverificationscreen.dart';
// import 'package:AAG/Pages/verificationscreen.dart';
import 'package:AAG/tobeadded/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SignUpPage2 extends StatefulWidget {
  final String selectedPlan;
  final String phoneNumber;

  const SignUpPage2({
    super.key,
    required this.selectedPlan,
    required this.phoneNumber,
  });

  @override
  _SignUpPage2State createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  final Map<String, bool> _socialMediaConnected = {
    'Facebook': false,
    'Instagram': false,
    'Youtube': false,
    'Snapchat': false,
    'Twitter': false,
  };
  String _selectedPlan = '';
  late AnimationController _controller;
  late Animation<double> _animation;
  final Map<String, bool> _showUrlInput = {};
  final Map<String, TextEditingController> _urlControllers = {};
  final Map<String, bool> _isEditing = {};

  @override
  void initState() {
    super.initState();
    _selectedPlan = widget.selectedPlan;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
    for (var platform in _socialMediaConnected.keys) {
      _showUrlInput[platform] = false;
      _urlControllers[platform] = TextEditingController();
      _isEditing[platform] = false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    for (var controller in _urlControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Image.asset(
          "lib/images/aag_white.png",
          width: 85,
          height: 50,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/images/idkbg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: AnimationLimiter(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 600),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Profile Setup',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  const SizedBox(height: 30),
                  _buildTextField('Name'),
                  _buildTextField(widget.phoneNumber, enabled: false),
                  _buildTextField('Your Email'),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Social Media Connection',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 10),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _isExpanded
                        ? _buildExpandedSocialMedia()
                        : _buildCollapsedSocialMedia(),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Center(
                      child: Text(
                        _isExpanded ? 'Show Less' : 'Others',
                        style:
                            const TextStyle(color: Colors.orange, fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSelectedPlan(),
                  const SizedBox(height: 20),
                  Center(
                    child: ScaleTransition(
                      scale: _animation,
                      child: CustomButton(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const SuccessVerificationScreen(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = const Offset(0.0, 1.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;
                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        text: 'Submit',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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

  Widget _buildCollapsedSocialMedia() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSocialMediaButton("Facebook", "lib/images/Facebook.png"),
        _buildSocialMediaButton("Instagram", "lib/images/Instagram.png"),
        _buildSocialMediaButton("Twitter", "lib/images/Elemento.png"),
      ],
    );
  }

  Widget _buildExpandedSocialMedia() {
    return Column(
      children: [
        _buildSocialMediaButton("Facebook", "lib/images/Facebook.png"),
        _buildSocialMediaButton("Instagram", "lib/images/Instagram.png"),
        _buildSocialMediaButton("Twitter", "lib/images/Elemento.png"),
        _buildSocialMediaButton("Snapchat", "lib/images/Snapchat.png"),
        _buildSocialMediaButton("Youtube", "lib/images/Youtube.png"),
      ],
    );
  }

  Widget _buildSocialMediaButton(String text, String iconPath) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(iconPath, width: 60, height: 60),
                  const SizedBox(width: 10),
                  Text(text, style: const TextStyle(color: Colors.white)),
                ],
              ),
              if (!_showUrlInput[text]!)
                _socialMediaConnected[text]!
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _isEditing[text] = true;
                            _showUrlInput[text] = true;
                            _socialMediaConnected[text] = false;
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 233, 116, 17),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _showUrlInput[text] = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 233, 116, 17),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Connect',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
            ],
          ),
          if (_showUrlInput[text]!)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: _buildUrlTextField(text),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _socialMediaConnected[text] = true;
                        _showUrlInput[text] = false;
                        _isEditing[text] = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 233, 116, 17),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildUrlTextField(String platform) {
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

  Widget _buildSelectedPlan() {
    return GestureDetector(
      onTap: () {
        _showPlanSelectionDialog();
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color.fromARGB(255, 233, 116, 17)),
          color: Colors.black.withOpacity(0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Selected Plan',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 233, 116, 17),
              ),
              child: Text(
                _selectedPlan,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPlanSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.only(
                top: 10, bottom: 10), // Padding to create space for the border
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 131, 65, 10), // Red-like gradient start
                  Color.fromARGB(255, 233, 116, 17), // Blue-like gradient end
                ],
              ),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.69,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('lib/images/idkbg.jpg'),
                  fit: BoxFit.cover, // Cover the background image entirely
                ),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(
                        200, 76, 76, 77), // Gradient with transparency
                    Color.fromARGB(200, 21, 21, 21),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Select other Plan',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      children: [
                        _buildPlanOption(
                          'Standard',
                          [
                            const Color.fromARGB(255, 113, 47, 160),
                            const Color.fromARGB(255, 54, 47, 145),
                          ],
                          MediaQuery.of(context).size.width,
                        ),
                        const SizedBox(height: 12),
                        _buildPlanOption(
                          'Pro',
                          [
                            const Color.fromARGB(255, 239, 38, 209),
                            const Color.fromARGB(255, 241, 178, 164),
                          ],
                          MediaQuery.of(context).size.width,
                        ),
                        const SizedBox(height: 12),
                        _buildPlanOption(
                          'Elite',
                          [
                            const Color.fromARGB(155, 239, 105, 82),
                            const Color.fromARGB(188, 255, 249, 71),
                          ],
                          MediaQuery.of(context).size.width,
                        ),
                        const SizedBox(height: 12),
                        _buildPlanOption(
                          'Enterprise',
                          [
                            const Color.fromARGB(255, 3, 189, 156),
                            const Color.fromARGB(255, 3, 87, 12),
                          ],
                          MediaQuery.of(context).size.width,
                        ),
                        const SizedBox(height: 17),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(
                            'Close',
                            style: TextStyle(color: Colors.white38),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlanOption(
      String plan, List<Color> gradientColors, double screenWidth) {
    double cardWidth = screenWidth > 600 ? 255 : screenWidth * 0.5;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPlan = plan;
        });
        Navigator.of(context).pop();
      },
      child: MovingGradientBorder(
        width: cardWidth,
        height: 61,
        gradientColors: [
          gradientColors[0],
          gradientColors[1],
          gradientColors[0],
        ],
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  plan,
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
