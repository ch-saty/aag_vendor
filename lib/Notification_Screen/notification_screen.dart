import 'package:flutter/material.dart';

class NotificationData {
  final String imagePath;
  final String name;
  final String time;
  final String? amount;
  final bool? isCredit;
  final String date;
  final String desc;

  NotificationData({
    required this.imagePath,
    required this.name,
    required this.time,
    this.amount,
    this.isCredit,
    required this.date,
    required this.desc,
  });
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['ALL', 'TRANSACTIONS', 'ACTIVITIES'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_handleTabAnimation);
  }

  void _handleTabAnimation() {
    if (_tabController.index != _tabController.animation!.value) {
      final int newIndex =
          _tabController.animation!.value.round() % _tabs.length;
      if (newIndex != _tabController.index) {
        _tabController.index = newIndex;
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
          "NOTIFICATIONS",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 102, 44, 144),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Column(
              children: [
                TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.orange,
                  labelColor: Colors.orange,
                  unselectedLabelColor: Colors.black,
                  onTap: (index) {
                    setState(() {
                      _tabController.index = index;
                    });
                  },
                  tabs: _tabs.map((String tab) {
                    return Tab(
                      child: Text(
                        tab,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500), // Set font size here
                      ),
                    );
                  }).toList(),
                ),
                Container(
                  height: 1,
                  color: Colors.black,
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildNotificationList(allNotifications),
                  _buildNotificationList(transactionNotifications),
                  _buildNotificationList(activityNotifications),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationList(List<NotificationData> notifications) {
    Map<String, List<NotificationData>> groupedNotifications = {};
    for (var notification in notifications) {
      if (!groupedNotifications.containsKey(notification.date)) {
        groupedNotifications[notification.date] = [];
      }
      groupedNotifications[notification.date]!.add(notification);
    }

    return ListView.builder(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.02,
        bottom: MediaQuery.of(context).size.height * 0.02,
      ),
      itemCount: groupedNotifications.length * 2 - 1,
      itemBuilder: (context, index) {
        if (index % 2 == 0) {
          String date = groupedNotifications.keys.elementAt(index ~/ 2);
          return _buildDateHeader(date);
        } else {
          String date = groupedNotifications.keys.elementAt(index ~/ 2);
          return Column(
            children: groupedNotifications[date]!.map((notification) {
              return _buildNotificationItem(
                imagePath: notification.imagePath,
                name: notification.name,
                desc: notification.desc,
                time: notification.time,
                amount: notification.amount,
                isCredit: notification.isCredit,
              );
            }).toList(),
          );
        }
      },
    );
  }

  Widget _buildDateHeader(String date) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child: Text(
        date,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required String imagePath,
    required String name,
    required String time,
    required String desc,
    String? amount,
    bool? isCredit,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: MediaQuery.of(context).size.height * 0.006,
      ),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
            height: MediaQuery.of(context).size.width * 0.1,
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.004),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 10,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                Text(
                  desc,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          if (amount != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amount,
                  style: TextStyle(
                    color: isCredit! ? Colors.green : Colors.red,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  List<NotificationData> get allNotifications {
    return [
      // October 29 Notifications
      NotificationData(
          imagePath: 'lib/images/credit.png',
          name: 'Wallet Credited',
          time: '09:45 Pm',
          amount: '+₹50.00 Cr',
          isCredit: true,
          date: 'October 29, 2024',
          desc: '+₹50.00 Credited in Wallet'),
      NotificationData(
          imagePath: 'lib/images/noti_game_pub.png',
          name: 'Game Published',
          time: '09:45 Pm',
          date: 'October 29, 2024',
          desc: 'Ludo has been published'),
      NotificationData(
          imagePath: 'lib/images/Debit.png',
          name: 'Wallet Debited',
          time: '09:45 Pm',
          amount: '-₹50.00 Cr',
          isCredit: false,
          date: 'October 29, 2024',
          desc: '₹50.00 debited from Wallet'),
      NotificationData(
          imagePath: 'lib/images/scheduledgame.png',
          name: 'Scheduled Game',
          time: '08:00 Pm',
          date: 'October 29, 2024',
          desc: 'Ludo has been scheduled'),
      NotificationData(
          imagePath: 'lib/images/challenges.png',
          name: 'Opponent Challenge ',
          time: '07:10 Pm',
          date: 'October 29, 2024',
          desc: 'Opponent has been Challenge'),
      NotificationData(
          imagePath: 'lib/images/Debit.png',
          name: 'Wallet Debited',
          time: '09:45 Pm',
          amount: '-₹50.00 Cr',
          isCredit: false,
          date: 'October 29, 2024',
          desc: '₹50.00 ddebited from Wallet'),
      NotificationData(
          imagePath: 'lib/images/credit.png',
          name: 'Wallet Credited',
          time: '09:45 Pm',
          amount: '+₹50.00 Cr',
          isCredit: true,
          date: 'October 29, 2024',
          desc: '+₹50.00 Credited in Wallet'),
      NotificationData(
          imagePath: 'lib/images/Approvedrequest.png',
          name: 'Approved Request',
          time: '05:05 Pm',
          date: 'October 29, 2024',
          desc: 'Plan Upgrade approved'),
      NotificationData(
          imagePath: 'lib/images/pendingrequest.png',
          name: 'Request Pending',
          time: '05:00 Pm',
          date: 'October 29, 2024',
          desc: 'Plan Upgrade Request pending'),

      // October 28 Notifications
      NotificationData(
          imagePath: 'lib/images/credit.png',
          name: 'Sumit Singh',
          time: '09:45 Pm',
          amount: '+₹50.00 Cr',
          isCredit: true,
          date: 'October 28, 2024',
          desc: 'Ludo has been published for four hours'),
      NotificationData(
          imagePath: 'lib/images/Publishgame.png',
          name: 'Publish Game',
          time: '09:00 Pm',
          date: 'October 28, 2024',
          desc: 'Ludo has been published for four hours'),
      NotificationData(
          imagePath: 'lib/images/Debit.png',
          name: 'Sumit Singh',
          time: '08:30 Pm',
          amount: '-₹50.00 Cr',
          isCredit: false,
          date: 'October 28, 2024',
          desc: 'Ludo has been published for four hours'),
      NotificationData(
          imagePath: 'lib/images/scheduledgame.png',
          name: 'Scheduled Game',
          time: '08:00 Pm',
          date: 'October 28, 2024',
          desc: 'Ludo has been published for four hours'),
      NotificationData(
          imagePath: 'lib/images/challenges.png',
          name: 'Challenging the opponent',
          time: '07:10 Pm',
          date: 'October 28, 2024',
          desc: 'Ludo has been published for four hours'),
      NotificationData(
          imagePath: 'lib/images/Approvedrequest.png',
          name: 'Approved Request',
          time: '05:05 Pm',
          date: 'October 28, 2024',
          desc: 'Ludo has been published for four hours'),
    ];
  }

  List<NotificationData> get transactionNotifications {
    return allNotifications
        .where((notification) => notification.amount != null)
        .toList();
  }

  List<NotificationData> get activityNotifications {
    return allNotifications
        .where((notification) => notification.amount == null)
        .toList();
  }
}
