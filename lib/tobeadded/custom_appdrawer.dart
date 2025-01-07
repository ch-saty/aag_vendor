import 'package:AAG/Analytics_Section/dashboard.dart';
import 'package:AAG/LeagueScreen/scheduledevents_screen.dart';
import 'package:AAG/Pages/new_leaderboard.dart';
import 'package:AAG/Pages/new_login_signup.dart';
import 'package:AAG/PublishGameScreen/history_screen.dart';
import 'package:AAG/tobeadded/underdevelopment.dart';
import 'package:flutter/material.dart';
import 'package:AAG/ActiveSession_Screen/activesession_screen.dart';
import 'package:AAG/FAQScreen/faq_screen_1.dart';
import 'package:AAG/PublishGameScreen/publishscreen.dart';
import 'package:AAG/Pages/transaction_page.dart';
import 'package:AAG/PublishGameScreen/subscriptionscreen.dart';
import 'package:AAG/Refer%20and%20Earn/referandearnscreen.dart';
import 'package:AAG/SettingPage/settingspage.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.69,
      child: Drawer(
        child: Column(
          children: [
            // User Header
            UserAccountsDrawerHeader(
              accountName: const Text('Satyam'),
              accountEmail: const Text('satyam@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('lib/images/ch.png'),
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 102, 44, 144),
              ),
              margin: EdgeInsets.zero, // Remove default margin
            ),

            // Drawer Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  _buildListTile(
                    imagePath: 'lib/images/Home.png',
                    title: 'Home',
                    onTap: () => Navigator.of(context).pop(), // Close drawer
                  ),
                  _buildListTile(
                    imagePath: 'lib/images/Leaderboard.png',
                    title: 'Leaderboard',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewLeaderboardPage(),
                      ),
                    ),
                  ),
                  _buildListTile(
                    imagePath: 'lib/images/Publishgame.png',
                    title: 'Publish Games',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PublishGamesScreen(),
                      ),
                    ),
                  ),
                  _buildListTile(
                    imagePath: 'lib/images/ScheduledGames.png',
                    title: 'Scheduled Games',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScheduledEventsScreen(),
                      ),
                    ),
                  ),
                  _buildListTile(
                    imagePath: 'lib/images/ActiveGames.png',
                    title: 'Active Sessions',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ActiveSessionsScreen(),
                      ),
                    ),
                  ),
                  _buildListTile(
                    imagePath: 'lib/images/publishhistory.png',
                    title: 'Publish History',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HistoryScreen(),
                      ),
                    ),
                  ),
                  _buildListTile(
                    imagePath: 'lib/images/Transactions.png',
                    title: 'Transactions',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InvoiceHistoryScreen(),
                      ),
                    ),
                  ),
                  _buildListTile(
                    imagePath: 'lib/images/packages.png',
                    title: 'Subscription',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SubscriptionScreen(),
                      ),
                    ),
                  ),
                  _buildListTile(
                    imagePath: 'lib/images/ReferEarn.png',
                    title: 'Refer & Earn',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReferAndEarnPage(),
                      ),
                    ),
                  ),
                  _buildListTile(
                    imagePath: 'lib/images/Setting.png',
                    title: 'Settings',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ),
                    ),
                  ),
                  _buildListTile(
                    imagePath: 'lib/images/NotView.png',
                    title: 'Analytics',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnalyticsDashboard(),
                      ),
                    ),
                  ),
                  const Divider(),
                  _buildListTile(
                    imagePath: 'lib/images/T&C.png',
                    title: 'Terms & Conditions',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const CustomPopup(
                          title: 'Terms & Conditions',
                        ),
                      );
                    },
                  ),
                  _buildListTile(
                    imagePath: 'lib/images/Policy.png',
                    title: 'Privacy and Policy',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const CustomPopup(
                          title: 'Privacy and Policy',
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  _buildListTile(
                    imagePath: 'lib/images/Help&Support.png',
                    title: 'Help / Support',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FAQPage(),
                      ),
                    ),
                  ),
                  _buildListTile(
                    imagePath: 'lib/images/Logout.png',
                    title: 'Logout Account',
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const HomePage(),
                        ),
                      );
                    },
                    textColor: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required String imagePath, // Path to the image
    required String title,
    required VoidCallback onTap,
    Color textColor = Colors.black,
  }) {
    return ListTile(
      leading: Image.asset(imagePath,
          width: 28, height: 28), // Use the image as the leading widget
      title: Text(title, style: TextStyle(color: textColor)),
      onTap: onTap,
    );
  }
}
