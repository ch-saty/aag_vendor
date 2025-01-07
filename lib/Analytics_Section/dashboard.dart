import 'package:AAG/Analytics_Section/peak_participation.dart';
import 'package:flutter/material.dart';

enum ChartTimeFrame { daily, weekly, monthly }

enum DemographicType { location, gender, age }

class AnalyticsSummary {
  final int followers;
  final double followerGrowth;
  final int gamesPublished;
  final int totalPlayers;
  final double retention;
  final int referral;
  final double gamePlayerCount;
  final List<DailyParticipation> weeklyParticipation;
  final List<DailyGamePublished> weeklyGamesPublished;
  final List<DailyParticipation> dailyTimeParticipation;
  final List<DailyParticipation> dailyParticipation;
  final List<DailyParticipation> monthlyParticipation;
  final GameDistribution gameDistribution;
  final Demographics demographics;

  AnalyticsSummary({
    required this.followers,
    required this.followerGrowth,
    required this.gamesPublished,
    required this.totalPlayers,
    required this.retention,
    required this.weeklyParticipation,
    required this.weeklyGamesPublished,
    required this.dailyParticipation,
    required this.monthlyParticipation,
    required this.gameDistribution,
    required this.demographics,
    required this.referral,
    required this.gamePlayerCount,
    required this.dailyTimeParticipation,
  });
}

class DailyParticipation {
  final DateTime date;
  final double participation;
  final String timeSlot;

  DailyParticipation({
    required this.date,
    required this.participation,
    this.timeSlot = '',
  });
}

class DailyGamePublished {
  final DateTime date;
  final int count;
  DailyGamePublished({required this.date, required this.count});
}

class GameDistribution {
  final double ludoKingPercentage;
  final double snakeLadderPercentage;
  GameDistribution(
      {required this.ludoKingPercentage, required this.snakeLadderPercentage});
}

class Demographics {
  final Map<String, double> cityDistribution;
  final Map<String, double> genderDistribution;
  final Map<String, double> ageDistribution;
  Demographics({
    required this.cityDistribution,
    required this.genderDistribution,
    required this.ageDistribution,
  });
}

class AnalyticsDashboard extends StatefulWidget {
  const AnalyticsDashboard({super.key});
  @override
  _AnalyticsDashboardState createState() => _AnalyticsDashboardState();
}

class _AnalyticsDashboardState extends State<AnalyticsDashboard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final AnalyticsSummary data = AnalyticsSummary(
    followers: 24500,
    followerGrowth: 1.29,
    gamesPublished: 140,
    totalPlayers: 158200,
    retention: 76,
    referral: 10,
    gamePlayerCount: 45.2,
    weeklyParticipation: [
      DailyParticipation(
          date: DateTime.now().subtract(Duration(days: 6)), participation: 20),
      DailyParticipation(
          date: DateTime.now().subtract(Duration(days: 5)), participation: 40),
      DailyParticipation(
          date: DateTime.now().subtract(Duration(days: 4)), participation: 30),
      DailyParticipation(
          date: DateTime.now().subtract(Duration(days: 3)), participation: 80),
      DailyParticipation(
          date: DateTime.now().subtract(Duration(days: 2)), participation: 60),
      DailyParticipation(
          date: DateTime.now().subtract(Duration(days: 1)), participation: 35),
      DailyParticipation(date: DateTime.now(), participation: 40),
    ],
    weeklyGamesPublished: [
      DailyGamePublished(
          date: DateTime.now().subtract(Duration(days: 6)), count: 2),
      DailyGamePublished(
          date: DateTime.now().subtract(Duration(days: 5)), count: 1),
      DailyGamePublished(
          date: DateTime.now().subtract(Duration(days: 4)), count: 4),
      DailyGamePublished(
          date: DateTime.now().subtract(Duration(days: 3)), count: 2),
      DailyGamePublished(
          date: DateTime.now().subtract(Duration(days: 2)), count: 5),
      DailyGamePublished(
          date: DateTime.now().subtract(Duration(days: 1)), count: 2),
      DailyGamePublished(date: DateTime.now(), count: 3),
    ],
    gameDistribution: GameDistribution(
      ludoKingPercentage: 65,
      snakeLadderPercentage: 35,
    ),
    demographics: Demographics(
      cityDistribution: {
        'Bihar': 32.7,
        'Delhi': 22.8,
        'Lucknow': 28.1,
        'Mumbai': 13.8,
        'Other States': 10.6,
      },
      genderDistribution: {
        'Male': 67.0,
        'Female': 33.0,
      },
      ageDistribution: {
        '12-18': 24.0,
        '18-35': 51.0,
        '35-55': 25.0,
      },
    ),
    dailyParticipation: List.generate(
      30,
      (index) => DailyParticipation(
        date: DateTime.now().subtract(Duration(days: index)),
        participation: 30 + (index % 5 * 10),
      ),
    ),
    monthlyParticipation: [],
    dailyTimeParticipation: [],
  );

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF662C90),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("ANALYTICS",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PeakParticipationSection(),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatCards(),
                    SizedBox(height: 20),
                    _buildMostPlayedGame(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildPeakParticipationSection() {
  //   return Padding(
  //     padding: EdgeInsets.all(20),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               'Peak Participation Time',
  //               style: TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 12,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //               decoration: BoxDecoration(
  //                 color: Colors.white.withOpacity(0.2),
  //                 borderRadius: BorderRadius.circular(20),
  //               ),
  //               child: Text('Weekly', style: TextStyle(color: Colors.white)),
  //             ),
  //           ],
  //         ),
  //         Text(
  //           'This week: 24 Jan',
  //           style: TextStyle(color: Colors.white70, fontSize: 10),
  //         ),
  //         SizedBox(height: 30),
  //         Center(
  //           child: SizedBox(
  //             height: 200,
  //             width: 200,
  //             child: Stack(
  //               alignment: Alignment.center,
  //               children: [
  //                 CircularProgressIndicator(
  //                   value: 0.455,
  //                   strokeWidth: 20,
  //                   backgroundColor: Colors.white.withOpacity(0.2),
  //                   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
  //                 ),
  //                 Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Text(
  //                       '45.5%',
  //                       style: TextStyle(
  //                         color: Colors.white,
  //                         fontSize: 28,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     Text(
  //                       'Morning',
  //                       style: TextStyle(
  //                         color: Colors.white70,
  //                         fontSize: 16,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildStatCards() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard('Followers', '${data.followers}',
            '+${data.followerGrowth}%', Colors.green),
        _buildStatCard('Game Published', '${data.gamesPublished}',
            '+20 this week', Colors.purple),
        _buildStatCard('Total Players', '${data.totalPlayers}',
            '+8.4K this week', Colors.blue),
        _buildStatCard(
            'Retention', '${data.retention}%', '-8.4K this week', Colors.red),
        _buildStatCard(
            'Total Referral', '${data.referral}', '+2 this week', Colors.green),
        _buildStatCard('Engagement Rate', '24.5K', '-1.29%', Colors.red),
      ],
    );
  }

  Widget _buildStatCard(
      String title, String value, String change, Color changeColor) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          Text(value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: changeColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              change,
              style: TextStyle(color: changeColor, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMostPlayedGame() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MOST PLAYED GAME',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'lib/images/g1.png',
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ludo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '45.2K Players',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Icon(Icons.people_outline, color: Color(0xFF662C90)),
            ],
          ),
        ),
      ],
    );
  }

  // Widget _buildGamePublishedSection() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             'GAME PUBLISHED',
  //             style: TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           Container(
  //             padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //             decoration: BoxDecoration(
  //               color: Color(0xFF662C90),
  //               borderRadius: BorderRadius.circular(20),
  //             ),
  //             child: Text(
  //               'Weekly',
  //               style: TextStyle(color: Colors.white),
  //             ),
  //           ),
  //         ],
  //       ),
  //       SizedBox(height: 15),
  //       Container(
  //         height: 200,
  //         padding: EdgeInsets.all(15),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(12),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.black.withOpacity(0.05),
  //               blurRadius: 10,
  //               offset: Offset(0, 5),
  //             ),
  //           ],
  //         ),
  //         child: BarChart(
  //           BarChartData(
  //             alignment: BarChartAlignment.spaceAround,
  //             barGroups: data.weeklyGamesPublished.asMap().entries.map((entry) {
  //               return BarChartGroupData(
  //                 x: entry.key,
  //                 barRods: [
  //                   BarChartRodData(
  //                     toY: entry.value.count.toDouble(),
  //                     color: Color(0xFF662C90),
  //                     width: 15,
  //                     borderRadius: BorderRadius.circular(4),
  //                   ),
  //                 ],
  //               );
  //             }).toList(),
  //             titlesData: FlTitlesData(
  //               show: true,
  //               bottomTitles: AxisTitles(
  //                 sideTitles: SideTitles(
  //                   showTitles: true,
  //                   getTitlesWidget: (value, meta) {
  //                     return Text(
  //                       DateFormat('E').format(
  //                         data.weeklyGamesPublished[value.toInt()].date,
  //                       ),
  //                       style: TextStyle(
  //                         color: Colors.grey[600],
  //                         fontSize: 12,
  //                       ),
  //                     );
  //                   },
  //                 ),
  //               ),
  //               leftTitles: AxisTitles(
  //                 sideTitles: SideTitles(
  //                   showTitles: true,
  //                   reservedSize: 30,
  //                   getTitlesWidget: (value, meta) {
  //                     return Text(
  //                       value.toInt().toString(),
  //                       style: TextStyle(
  //                         color: Colors.grey[600],
  //                         fontSize: 12,
  //                       ),
  //                     );
  //                   },
  //                 ),
  //               ),
  //               rightTitles:
  //                   AxisTitles(sideTitles: SideTitles(showTitles: false)),
  //               topTitles:
  //                   AxisTitles(sideTitles: SideTitles(showTitles: false)),
  //             ),
  //             gridData: FlGridData(show: false),
  //             borderData: FlBorderData(show: false),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildUserDemographicSection() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             'USER DEMOGRAPHIC',
  //             style: TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           Container(
  //             padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //             decoration: BoxDecoration(
  //               color: Color(0xFF662C90),
  //               borderRadius: BorderRadius.circular(20),
  //             ),
  //             child: Text('Location', style: TextStyle(color: Colors.white)),
  //           ),
  //         ],
  //       ),
  //       SizedBox(height: 15),
  //       Container(
  //         height: 300,
  //         padding: EdgeInsets.all(15),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(12),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.black.withOpacity(0.05),
  //               blurRadius: 10,
  //               offset: Offset(0, 5),
  //             ),
  //           ],
  //         ),
  //         child: PieChart(
  //           PieChartData(
  //             sectionsSpace: 0,
  //             centerSpaceRadius: 50,
  //             sections: data.demographics.cityDistribution.entries.map((entry) {
  //               return PieChartSectionData(
  //                 color: Color(0xFF662C90).withOpacity(
  //                   1 -
  //                       (data.demographics.cityDistribution.keys
  //                               .toList()
  //                               .indexOf(entry.key) *
  //                           0.15),
  //                 ),
  //                 value: entry.value,
  //                 title: '${entry.value}%',
  //                 radius: 100,
  //                 titleStyle: TextStyle(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.white,
  //                 ),
  //               );
  //             }).toList(),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
