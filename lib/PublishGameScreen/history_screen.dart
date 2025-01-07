// ignore_for_file: avoid_print

import 'package:AAG/PublishGameScreen/game_history.dart';
import 'package:AAG/PublishGameScreen/league_history.dart';
import 'package:AAG/TournamentScreen/tournament_history.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool _isGamesSelected = true;
  final List<Map<String, dynamic>> _events = [
    {
      'id': '#13631A',
      'game_name': 'Ludo',
      'publishDate': '01/01/2024',
      'scheduledDate': '05/01/2024',
      'eventType': 'Tournament',
      'type': 'Event'
    },
    {
      'id': '#13632B',
      'game_name': 'Ludo',
      'publishDate': '05/01/2024',
      'scheduledDate': '10/04/2024',
      'eventType': 'League',
      'type': 'Event'
    },
    {
      'id': '#13633C',
      'game_name': 'Chess',
      'publishDate': '12/02/2024',
      'scheduledDate': '11/02/2024',
      'eventType': 'Game',
      'type': 'Game'
    },
    {
      'id': '#13634D',
      'game_name': 'Ladder',
      'publishDate': '05/05/2024',
      'scheduledDate': '05/05/2024',
      'eventType': 'league',
      'type': 'Event'
    },
    {
      'id': '#13631E',
      'game_name': 'Chausar',
      'publishDate': '06/06/2024',
      'scheduledDate': '07/07/2024',
      'eventType': 'Tournament',
      'type': 'Event'
    },
    {
      'id': '#13632F',
      'game_name': 'Mario',
      'publishDate': '07/07/2024',
      'scheduledDate': '08/08/2024',
      'eventType': 'League',
      'type': 'Event'
    },
    {
      'id': '#13633G',
      'game_name': 'Checkers',
      'publishDate': '09/09/2024',
      'scheduledDate': '10/10/2024',
      'eventType': 'Game',
      'type': 'Game'
    },
    {
      'id': '#13634H',
      'game_name': 'Ludo',
      'publishDate': '11/11/2024',
      'scheduledDate': '12/12/2024',
      'eventType': 'league',
      'type': 'Event'
    },
  ];

  List<Map<String, dynamic>> _filteredEvents = [];

  @override
  void initState() {
    super.initState();
    _filteredEvents = _events;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "PUBLISH HISTORY",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 102, 44, 144),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search Bar
            _buildSearchBar(),

            // Toggle Buttons
            _buildToggleButtons(),

            // Event List
            Expanded(
              child: _buildEventList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        onChanged: (value) {
          _filterEvents(value);
        },
        decoration: InputDecoration(
          hintText: 'Enter publish ID',
          filled: true,
          fillColor: Colors.grey[200],
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          suffixIcon: IconButton(
            icon: Icon(Icons.tune, color: Colors.grey),
            onPressed: () {
              _showFilterBottomSheet(context);
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
    );
  }

  void _filterEvents(String query) {
    setState(() {
      _filteredEvents = _events.where((event) {
        return (event['id'].toLowerCase().contains(query.toLowerCase()) ||
            event['game_name'].toLowerCase().contains(query.toLowerCase()));
      }).toList();
    });
  }

  void _showFilterBottomSheet(BuildContext context) {
    // State variables for filter options
    bool isGamesChecked = false;
    bool isLeaguesChecked = false;
    bool isTournamentsChecked = false;

    // Date range variables
    DateTime? publishStartDate;
    DateTime? publishEndDate;
    DateTime? scheduledDate;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            // Date picker for Publish Date range
            Future<void> selectPublishDateRange() async {
              DateTimeRange? picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(1900),
                lastDate: DateTime(2200),
                initialDateRange:
                    publishStartDate != null && publishEndDate != null
                        ? DateTimeRange(
                            start: publishStartDate!, end: publishEndDate!)
                        : null,
              );

              if (picked != null) {
                setState(() {
                  publishStartDate = picked.start;
                  publishEndDate = picked.end;
                });
              }
            }

            // Date picker for Scheduled Date
            Future<void> selectScheduledDate() async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: scheduledDate ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2200),
              );

              if (picked != null) {
                setState(() {
                  scheduledDate = picked;
                });
              }
            }

            return Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      children: [
                        // Header
                        Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 102, 44, 144),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'MANAGE FILTERS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Main content
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left column - Filter categories
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Sort',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    // Vertical line indicator

                                    const Text(
                                      'Event Type',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    const SizedBox(height: 16),
                                    GestureDetector(
                                      onTap: selectPublishDateRange,
                                      child: Text(
                                        'Publish Date',
                                        style: TextStyle(
                                          color: publishStartDate != null &&
                                                  publishEndDate != null
                                              ? Colors.orange
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    GestureDetector(
                                      onTap: selectScheduledDate,
                                      child: Text(
                                        'Scheduled On',
                                        style: TextStyle(
                                          color: scheduledDate != null
                                              ? Colors.orange
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Vertical Divider
                              Container(
                                width: 1,
                                height: 200,
                                color: Colors.grey.shade300,
                              ),

                              // Right column - Filter options
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 16),
                                      const Text(
                                        'FILTER BY EVENT TYPE',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      CheckboxListTile(
                                        title: const Text('Games'),
                                        value: isGamesChecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isGamesChecked = value ?? false;
                                          });
                                        },
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      CheckboxListTile(
                                        title: const Text('Leagues'),
                                        value: isLeaguesChecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isLeaguesChecked = value ?? false;
                                          });
                                        },
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      CheckboxListTile(
                                        title: const Text('Tournament'),
                                        value: isTournamentsChecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isTournamentsChecked =
                                                value ?? false;
                                          });
                                        },
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        contentPadding: EdgeInsets.zero,
                                      ),

                                      // Display selected date ranges
                                      const SizedBox(height: 16),
                                      if (publishStartDate != null &&
                                          publishEndDate != null)
                                        Text(
                                          'Publish Date: ${formatDateSafely(publishStartDate)} - ${formatDateSafely(publishEndDate)}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      if (scheduledDate != null)
                                        Text(
                                          'Scheduled On: ${formatDateSafely(scheduledDate)}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Bottom buttons
                        // const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isGamesChecked = false;
                                  isLeaguesChecked = false;
                                  isTournamentsChecked = false;
                                  publishStartDate = null;
                                  publishEndDate = null;
                                  scheduledDate = null;
                                });
                              },
                              child: const Text(
                                'Clear Filters',
                                style: TextStyle(color: Colors.orange),
                              ),
                            ),
                            const SizedBox(width: 50),
                            ElevatedButton(
                              onPressed: () {
                                // Apply filters to events
                                _applyFilters(
                                    isGamesChecked,
                                    isLeaguesChecked,
                                    isTournamentsChecked,
                                    publishStartDate,
                                    publishEndDate,
                                    scheduledDate);
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Apply',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                      ],
                    ),
                  ),
                ),

                // Floating Close Button
                Positioned(
                  top: -50,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF712FA0),
                              Color(0xFF362F91),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String formatDateSafely(DateTime? date) {
    if (date == null) return 'Not selected';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  void _applyFilters(
      bool isGamesChecked,
      bool isLeaguesChecked,
      bool isTournamentsChecked,
      DateTime? publishStartDate,
      DateTime? publishEndDate,
      DateTime? scheduledDate) {
    setState(() {
      // If no filters are selected, show all events
      if (!isGamesChecked &&
          !isLeaguesChecked &&
          !isTournamentsChecked &&
          publishStartDate == null &&
          publishEndDate == null &&
          scheduledDate == null) {
        _filteredEvents = _events;
        return;
      }

      // Helper function to parse date safely
      DateTime? parseDate(dynamic dateString) {
        if (dateString == null) return null;

        try {
          // Try multiple date formats
          List<String> formats = [
            'yyyy-MM-dd',
            'MM/dd/yyyy',
            'dd/MM/yyyy',
            'yyyy/MM/dd',
            'dd-MM-yyyy',
            'MM-dd-yyyy'
          ];

          for (var format in formats) {
            try {
              return DateFormat(format).parse(dateString.toString());
            } catch (e) {
              // Continue to next format if parsing fails
              continue;
            }
          }

          // If no format works, try parsing directly
          return DateTime.parse(dateString.toString());
        } catch (e) {
          print('Error parsing date: $dateString - $e');
          return null;
        }
      }

      // Filter events based on selected types and dates
      _filteredEvents = _events.where((event) {
        // Event type filtering
        bool typeMatch = (!isGamesChecked &&
                !isLeaguesChecked &&
                !isTournamentsChecked) ||
            (isGamesChecked && event['eventType'].toLowerCase() == 'game') ||
            (isLeaguesChecked &&
                event['eventType'].toLowerCase() == 'league') ||
            (isTournamentsChecked &&
                event['eventType'].toLowerCase() == 'tournament');

        // Publish date filtering
        bool publishDateMatch = true;
        if (publishStartDate != null && publishEndDate != null) {
          DateTime? eventPublishDate = parseDate(event['publishDate']);
          if (eventPublishDate != null) {
            publishDateMatch = (eventPublishDate.isAfter(
                    publishStartDate.subtract(const Duration(days: 1))) &&
                eventPublishDate
                    .isBefore(publishEndDate.add(const Duration(days: 1))));
          } else {
            publishDateMatch = false;
          }
        }

        // Scheduled date filtering
        bool scheduledDateMatch = true;
        if (scheduledDate != null) {
          DateTime? eventScheduledDate = parseDate(event['scheduledDate']);
          if (eventScheduledDate != null) {
            scheduledDateMatch =
                (eventScheduledDate.year == scheduledDate.year &&
                    eventScheduledDate.month == scheduledDate.month &&
                    eventScheduledDate.day == scheduledDate.day);
          } else {
            scheduledDateMatch = false;
          }
        }

        return typeMatch && publishDateMatch && scheduledDateMatch;
      }).toList();
    });
  }

  Widget _buildToggleButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isGamesSelected = true;
              _filteredEvents =
                  _events.where((event) => event['type'] == 'Game').toList();
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _isGamesSelected
                ? const Color.fromARGB(255, 102, 44, 144)
                : Colors.white,
            foregroundColor: _isGamesSelected
                ? Colors.white
                : const Color.fromARGB(255, 102, 44, 144),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
            ),
            // elevation: _isGamesSelected ? 0 : 2,
            // minimumSize: const Size(100, 48), // Increased width by 20
          ),
          child: const Text(
            'GAMES',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isGamesSelected = false;
              _filteredEvents =
                  _events.where((event) => event['type'] == 'Event').toList();
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: !_isGamesSelected
                ? const Color.fromARGB(255, 102, 44, 144)
                : Colors.white,
            foregroundColor: !_isGamesSelected
                ? Colors.white
                : const Color.fromARGB(255, 102, 44, 144),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
            ),
            // elevation: !_isGamesSelected ? 0 : 2,
            // minimumSize: const Size(100, 48), // Increased width by 20
          ),
          child: const Text(
            'EVENTS',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildEventList() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'September 2024',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              itemCount: _filteredEvents.length,
              itemBuilder: (context, index) {
                final event = _filteredEvents[index];
                return _buildEventCard(event);
              },
              separatorBuilder: (context, index) => SizedBox(height: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: [
            _buildEventRowItem('Publish ID', event['id']),
            SizedBox(height: 8),
            _buildEventRowItem('Publish Date', event['publishDate']),
            SizedBox(height: 8),
            _buildEventRowItem('Scheduled On', event['scheduledDate']),
            SizedBox(height: 8),
            _buildEventRowItem('Event Type', event['eventType']),
            // SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  switch (event['eventType']) {
                    case 'Tournament':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TournamentHistory(),
                        ),
                      );
                      break;
                    case 'League':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LeaguesHistoryPage(),
                        ),
                      );
                      break;
                    case 'Game':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameHistoryScreen(),
                        ),
                      );
                      break;
                  }
                },
                child: Text(
                  'View',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventRowItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
  // }
}
