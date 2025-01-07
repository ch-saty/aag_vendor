import 'package:AAG/LeagueScreen/leaguescreen_one.dart';
import 'package:AAG/TournamentScreen/tournamentscreen_one.dart';
import 'package:flutter/material.dart';

class EventsSection extends StatelessWidget {
  const EventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              children: [
                Image.asset('lib/images/ActiveGames.png',
                    width: 24, height: 24),
                const SizedBox(width: 8),
                const Text(
                  'EVENTS',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Leagues Subsection
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 27, vertical: 8),
            child: Text(
              'Leagues',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildEventItem(
                    context,
                    'lib/images/ludo.png',
                    () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const PublishLeagueScreen()))),
                const SizedBox(width: 10),
                _buildEventItem(
                    context,
                    'lib/images/ludo.png',
                    () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const PublishLeagueScreen()))),
              ],
            ),
          ),

          // Tournament Subsection
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 27, vertical: 8),
            child: Text(
              'Tournament',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildEventItem(
                    context,
                    'lib/images/ludo.png',
                    () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const PublishTournamentscreen()))),
                const SizedBox(width: 10),
                _buildEventItem(
                    context,
                    'lib/images/ludo.png',
                    () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const PublishTournamentscreen()))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create event item
  Widget _buildEventItem(
      BuildContext context, String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imagePath,
          width: 100,
          height: 100,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
