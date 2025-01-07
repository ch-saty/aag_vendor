import 'package:flutter/material.dart';

class TicketData {
  final String issue;
  final String ticketId;
  final bool isActive;
  final String status;
  final String date;
  final String icon;

  TicketData({
    required this.issue,
    required this.ticketId,
    required this.isActive,
    required this.status,
    required this.date,
    required this.icon,
  });
}

class TicketHistoryScreen extends StatefulWidget {
  const TicketHistoryScreen({super.key});

  @override
  State<TicketHistoryScreen> createState() => _TicketHistoryScreenState();
}

class _TicketHistoryScreenState extends State<TicketHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['ALL', 'ACTIVE', 'RESOLVED'];

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
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "TICKET HISTORY",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 102, 44, 144),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: Color.fromARGB(255, 102, 44, 144),
            labelColor: Color.fromARGB(255, 102, 44, 144),
            unselectedLabelColor: Colors.black,
            onTap: (index) {
              setState(() {
                _tabController.index = index; // Activate tapped tab
              });
            },
            tabs: _tabs.map((String tab) => Tab(text: tab)).toList(),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTicketList(allTickets),
                _buildTicketList(activeTickets),
                _buildTicketList(resolvedTickets),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketList(List<TicketData> tickets) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        return _buildTicketItem(tickets[index]);
      },
    );
  }

  Widget _buildTicketItem(TicketData ticket) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: const Color.fromARGB(96, 0, 0, 0),
            width: 1), // Added black border
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 3,
            offset: Offset(0, 3),
            spreadRadius: 0,
          ), // Added elevation effect
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'lib/images/credit.png',
                height: 40,
                width: 40,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  ticket.issue,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ticket.isActive
                      ? Colors.orange.withOpacity(0.2)
                      : Colors.green.withOpacity(0.2),
                ),
                child: Text(
                  ticket.isActive ? 'Active' : 'Resolved',
                  style: TextStyle(
                    color: ticket.isActive ? Colors.orange : Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ticket ID: ${ticket.ticketId}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              Text(
                ticket.date,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            ticket.status,
            style: const TextStyle(
              color: Color.fromRGBO(255, 146, 29, 1),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  List<TicketData> get allTickets {
    return [
      TicketData(
        issue: "I'm unable to withdraw money.",
        ticketId: "IN.2611TI25649556x",
        isActive: true,
        status: "We are working on it!",
        date: "17 Nov",
        icon: "support_icon",
      ),
      TicketData(
        issue: "I'm unable to withdraw money.",
        ticketId: "IN.2611TI25649556x",
        isActive: false,
        status: "Closed!",
        date: "17 Nov",
        icon: "support_icon",
      ),
      // Add more sample tickets as needed
    ];
  }

  List<TicketData> get activeTickets {
    return allTickets.where((ticket) => ticket.isActive).toList();
  }

  List<TicketData> get resolvedTickets {
    return allTickets.where((ticket) => !ticket.isActive).toList();
  }
}
