import 'package:flutter/material.dart';

class SocialMediaPopup extends StatefulWidget {
  const SocialMediaPopup({super.key});

  @override
  State<SocialMediaPopup> createState() => _SocialMediaPopupState();
}

class _SocialMediaPopupState extends State<SocialMediaPopup> {
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

  void _showSocialPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(20),
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
                    const Text(
                      'MANAGE SOCIAL MEDIA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Social Media List
                Column(
                  children: [
                    _buildSocialMediaRow('Facebook', 'lib/images/Facebook.png'),
                    _buildSocialMediaRow(
                        'Instagram', 'lib/images/Instagram.png'),
                    _buildSocialMediaRow('Twitter', 'lib/images/Elemento.png'),
                    _buildSocialMediaRow('YouTube', 'lib/images/YouTube.png'),
                    _buildSocialMediaRow('Snapchat', 'lib/images/Snapchat.png'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSocialMediaRow(String platform, String imagePath) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
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
                  Image.asset(
                    imagePath,
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    platform,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
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
                            _showUrlInput[platform] = true;
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
          if (_showUrlInput[platform]!)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: _buildUrlTextField(platform),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _socialMediaConnected[platform] = true;
                        _showUrlInput[platform] = false;
                        _isEditing[platform] = false;
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

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.share),
      onPressed: () => _showSocialPopup(context),
    );
  }
}
