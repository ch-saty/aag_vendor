import 'package:flutter/material.dart';

class NotificationData {
  final String imagePath;
  final String name;
  final String time;
  final String? amount;
  final bool? isCredit;
  final String date;

  NotificationData({
    required this.imagePath,
    required this.name,
    required this.time,
    this.amount,
    this.isCredit,
    required this.date,
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

  List<NotificationData> get allNotifications {
    return [
      // October 29 Notifications
      NotificationData(
        imagePath: 'lib/images/credit.png',
        name: 'Sumit Singh',
        time: '09:45 Pm',
        amount: '+₹50.00 Cr',
        isCredit: true,
        date: 'October 29, 2024',
      ),
      NotificationData(
        imagePath: 'lib/images/publishgame.png',
        name: 'Publish Game',
        time: '09:45 Pm',
        date: 'October 29, 2024',
      ),
      NotificationData(
        imagePath: 'lib/images/debit.png',
        name: 'Sumit Singh',
        time: '09:45 Pm',
        amount: '-₹50.00 Cr',
        isCredit: false,
        date: 'October 29, 2024',
      ),
      NotificationData(
        imagePath: 'lib/images/scheduled.png',
        name: 'Scheduled Game',
        time: '08:00 Pm',
        date: 'October 29, 2024',
      ),
      NotificationData(
        imagePath: 'lib/images/challenge.png',
        name: 'Challenging the opponent',
        time: '07:10 Pm',
        date: 'October 29, 2024',
      ),
      NotificationData(
        imagePath: 'lib/images/debit.png',
        name: 'Sumit Singh',
        time: '06:30 Pm',
        amount: '-₹50.00 Cr',
        isCredit: false,
        date: 'October 29, 2024',
      ),
      NotificationData(
        imagePath: 'lib/images/credit.png',
        name: 'Sumit Singh',
        time: '06:15 Pm',
        amount: '+₹50.00 Cr',
        isCredit: true,
        date: 'October 29, 2024',
      ),
      NotificationData(
        imagePath: 'lib/images/approval.png',
        name: 'Approved Request',
        time: '05:05 Pm',
        date: 'October 29, 2024',
      ),
      NotificationData(
        imagePath: 'lib/images/pending.png',
        name: 'Pending Request',
        time: '05:00 Pm',
        date: 'October 29, 2024',
      ),

      // October 28 Notifications
      NotificationData(
        imagePath: 'lib/images/credit.png',
        name: 'Sumit Singh',
        time: '09:45 Pm',
        amount: '+₹50.00 Cr',
        isCredit: true,
        date: 'October 28, 2024',
      ),
      NotificationData(
        imagePath: 'lib/images/publishgame.png',
        name: 'Publish Game',
        time: '09:00 Pm',
        date: 'October 28, 2024',
      ),
      NotificationData(
        imagePath: 'lib/images/debit.png',
        name: 'Sumit Singh',
        time: '08:30 Pm',
        amount: '-₹50.00 Cr',
        isCredit: false,
        date: 'October 28, 2024',
      ),
      NotificationData(
        imagePath: 'lib/images/scheduled.png',
        name: 'Scheduled Game',
        time: '08:00 Pm',
        date: 'October 28, 2024',
      ),
      NotificationData(
        imagePath: 'lib/images/challenge.png',
        name: 'Challenging the opponent',
        time: '07:10 Pm',
        date: 'October 28, 2024',
      ),
      NotificationData(
        imagePath: 'lib/images/approval.png',
        name: 'Approved Request',
        time: '05:05 Pm',
        date: 'October 28, 2024',
      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/idkbg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.15,
                floating: true,
                pinned: false,
                snap: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                title: const Text(
                  'NOTIFICATIONS',
                  style: TextStyle(color: Colors.white),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(48),
                  child: Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        indicatorColor: Colors.orange,
                        labelColor: Colors.orange,
                        unselectedLabelColor: Colors.white,
                        onTap: (index) {
                          setState(() {
                            _tabController.animateTo(index);
                          });
                        },
                        tabs:
                            _tabs.map((String tab) => Tab(text: tab)).toList(),
                      ),
                      Container(
                        height: 1,
                        color: Colors.grey[700],
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildNotificationList(allNotifications),
              _buildNotificationList(transactionNotifications),
              _buildNotificationList(activityNotifications),
            ],
          ),
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
          color: Colors.white,
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
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(113, 47, 160, 155),
            Color.fromARGB(104, 54, 47, 145),
          ],
          stops: [0.0155, 0.9845],
        ),
        borderRadius: BorderRadius.circular(8),
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
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.004),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                  ),
                ),
              ],
            ),
          ),
          if (amount != null)
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
    );
  }
}
