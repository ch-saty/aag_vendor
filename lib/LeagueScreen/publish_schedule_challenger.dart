// ignore_for_file: use_build_context_synchronously

import 'package:AAG/LeagueScreen/publishedleaguescreen.dart';
import 'package:AAG/LeagueScreen/scheduledleaguescreen.dart';
import 'package:AAG/tobeadded/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChallengerScreen extends StatefulWidget {
  final String? selectedPlayer;

  const ChallengerScreen({super.key, required this.selectedPlayer});

  @override
  _ChallengerScreenState createState() => _ChallengerScreenState();
}

class _ChallengerScreenState extends State<ChallengerScreen> {
  // String? selectedPlayer = 'John Doe'; // Example default name
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? scheduledInfo;

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
          "",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 102, 44, 144),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/images/oppcard.png', width: 200, height: 300),
            const SizedBox(
              height: 32,
            ),
            Column(
              children: [
                Text(
                  'Your Challenger',
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.selectedPlayer!,
                  style: const TextStyle(color: Colors.orange, fontSize: 24),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LeaguePublishedScreen(),
                      ),
                    );
                  },
                  text: 'Publish',
                ),
                const SizedBox(width: 50),
                CustomButton(
                  onTap: () {
                    _showSchedulePopup();
                  },
                  text: 'Schedule',
                ),
              ],
            ),
            // You can add more widgets here as needed
          ],
        ),
      ),
    );
  }

  Future<void> _showSchedulePopup() async {
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color.fromARGB(255, 102, 44, 144),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Schedule Game',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      height: 1,
                      color: Colors.white24,
                    ),
                    ListTile(
                      title: const Text(
                        'Select Date',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedDate != null
                                ? DateFormat('EEE, MMM d, yyyy')
                                    .format(selectedDate!)
                                : 'Choose a date',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(
                        Icons.calendar_today,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                    ),
                    ListTile(
                      title: const Text(
                        'Select Time',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedTime != null
                                ? selectedTime!.format(context)
                                : 'Choose a time',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(
                        Icons.access_time,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            selectedTime = pickedTime;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedDate != null && selectedTime != null) {
                          setState(() {
                            scheduledInfo =
                                "Scheduled on ${DateFormat('EEE, MMM d, yyyy').format(selectedDate!)} at ${selectedTime!.format(context)}";
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const EditableScheduledLeagueScreen(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Schedule'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
