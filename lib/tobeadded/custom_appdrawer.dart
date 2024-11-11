import 'package:AAG/Account_Screen/account_screen.dart';
import 'package:AAG/ActiveSession_Screen/activesession_screen.dart';
import 'package:AAG/PublishGameScreen/gamescreen.dart';
import 'package:AAG/PublishGameScreen/subscriptionscreen.dart';
import 'package:AAG/LeagueScreen/scheduledevents_screen.dart';
import 'package:AAG/Pages/leaderboardpage.dart';
import 'package:AAG/Pages/loginsignup.dart';
import 'package:AAG/Pages/transaction_page.dart';
import 'package:AAG/Refer%20and%20Earn/referandearnscreen.dart';
import 'package:AAG/SettingPage/settingspage.dart';
import 'package:AAG/tobeadded/underdevelopment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  void _navigateToPage(BuildContext context, String title) {
    // ... (keep the existing navigation logic)
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (BuildContext context, double value, Widget? child) {
        return Transform.translate(
          offset: Offset(-300 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.69,
              child: Drawer(
                child: Stack(
                  children: [
                    // Animated background
                    Animate(
                      effects: [
                        ShimmerEffect(
                          duration: 5.seconds,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ],
                      onPlay: (controller) => controller.repeat(),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.indigo.shade900,
                              Colors.black,
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Glassmorphic content container
                    GlassmorphicContainer(
                      width: double.infinity,
                      height: double.infinity,
                      borderRadius: 15,
                      blur: 5,
                      alignment: Alignment.bottomCenter,
                      border: 0,
                      linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.05),
                        ],
                      ),
                      borderGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.5),
                          Colors.white.withOpacity(0.1),
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      const AssetImage('lib/images/bgd.jpeg'),
                                  fit: BoxFit.fill,
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.6),
                                    BlendMode.darken,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // const SizedBox(height: 60),
                          Expanded(
                            flex: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      MediaQuery.of(context).size.width * 0),
                                  topRight: Radius.circular(
                                      MediaQuery.of(context).size.width * 0),
                                ),
                              ),
                              child: ListView(
                                padding: EdgeInsets.zero,
                                children: <Widget>[
                                  const SizedBox(height: 20),
                                  _buildAnimatedListTile(
                                    icon: 'lib/images/home.png',
                                    title: 'Home',
                                    onTap: () =>
                                        _navigateToPage(context, 'Home'),
                                  ),
                                  _buildAnimatedListTile(
                                    icon: 'lib/images/leaderboard.png',
                                    title: 'Leaderboard',
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LeaderboardPage(),
                                      ),
                                    ),
                                  ),
                                  _buildAnimatedListTile(
                                    icon: 'lib/images/subs.png',
                                    title: 'Subscription',
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SubscriptionScreen(),
                                      ),
                                    ),
                                  ),
                                  _buildAnimatedListTile(
                                      icon: 'lib/images/games.png',
                                      title: 'Publish Games',
                                      onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AppGamesScreen()),
                                          )),
                                  _buildAnimatedListTile(
                                      icon: 'lib/images/active.png',
                                      title: 'Active Sessions',
                                      onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ActiveSessionsScreen()),
                                          )),
                                  _buildAnimatedListTile(
                                      icon: 'lib/images/sg.png',
                                      title: 'Scheduled Games',
                                      onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ScheduledEventsScreen()),
                                          )),
                                  _buildAnimatedListTile(
                                      icon: 'lib/images/invoice.png',
                                      title: 'Transactions',
                                      onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const InvoiceHistoryScreen()),
                                          )),
                                  _buildAnimatedListTile(
                                      icon: 'lib/images/account.png',
                                      title: 'Refer & Earn',
                                      onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ReferAndEarnScreen()),
                                          )),
                                  _buildAnimatedListTile(
                                      icon: 'lib/images/account.png',
                                      title: 'Account',
                                      onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AccountScreen()),
                                          )),
                                  _buildAnimatedListTile(
                                      icon: 'lib/images/settings.png',
                                      title: 'Settings',
                                      onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SettingsPage()),
                                          )),
                                  _buildAnimatedListTile(
                                    icon: 'lib/images/tc.png',
                                    title: 'Terms & Conditions',
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => const CustomPopup(
                                            title: 'Terms & Conditions'),
                                      );
                                    },
                                  ),
                                  _buildAnimatedListTile(
                                    icon: 'lib/images/policy.png',
                                    title: 'Privacy and Policy',
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => const CustomPopup(
                                            title: 'Privacy and Policy'),
                                      );
                                    },
                                  ),
                                  Divider(color: Colors.white.withOpacity(0.2)),
                                  _buildAnimatedListTile(
                                    icon: Icons.help_outline,
                                    title: 'Help / Support',
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => const CustomPopup(
                                            title: 'Help & Support'),
                                      );
                                    },
                                    iconColor: Colors.white,
                                  ),
                                  _buildAnimatedListTile(
                                    icon: Icons.logout,
                                    title: 'Logout Account',
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const LoginScreen()),
                                      );
                                    },
                                    textColor: Colors.red,
                                    iconColor: Colors.red,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height *
                          0.10, // Adjusted position
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            const CircleAvatar(
                              radius: 30, // Reduced size
                              backgroundImage: AssetImage('lib/images/ch.png'),
                            ).animate().fade().scale(),
                            const SizedBox(height: 7),
                            const Text(
                              'Hii Satyam',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ).animate().fadeIn(delay: 500.ms),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedListTile({
    required dynamic icon,
    required String title,
    required VoidCallback onTap,
    Color textColor = Colors.white,
    Color iconColor = Colors.white,
  }) {
    return ListTile(
      leading: icon is IconData
          ? Icon(icon, color: iconColor, size: 22)
          : Image.asset(icon, height: 22, color: iconColor),
      title: Text(title, style: TextStyle(color: textColor)),
      onTap: onTap,
    ).animate().fadeIn(delay: 100.ms).moveX(begin: -50, end: 0);
  }
}
