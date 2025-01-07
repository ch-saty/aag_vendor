import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

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
            _buildPeakParticipationSection(),
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

  Widget _buildPeakParticipationSection() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Peak Participation Time',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('Weekly', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          Text(
            'This week: 24 Jan',
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: 30),
          Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: 0.455,
                    strokeWidth: 20,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '45.5%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Morning',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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

  Widget _buildGamePublishedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'GAME PUBLISHED',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xFF662C90),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Weekly',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Container(
          height: 200,
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
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barGroups: data.weeklyGamesPublished.asMap().entries.map((entry) {
                return BarChartGroupData(
                  x: entry.key,
                  barRods: [
                    BarChartRodData(
                      toY: entry.value.count.toDouble(),
                      color: Color(0xFF662C90),
                      width: 15,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                );
              }).toList(),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        DateFormat('E').format(
                          data.weeklyGamesPublished[value.toInt()].date,
                        ),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                ),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserDemographicSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'USER DEMOGRAPHIC',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xFF662C90),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text('Location', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        SizedBox(height: 15),
        Container(
          height: 300,
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
          child: PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 50,
              sections: data.demographics.cityDistribution.entries.map((entry) {
                return PieChartSectionData(
                  color: Color(0xFF662C90).withOpacity(
                    1 -
                        (data.demographics.cityDistribution.keys
                                .toList()
                                .indexOf(entry.key) *
                            0.15),
                  ),
                  value: entry.value,
                  title: '${entry.value}%',
                  radius: 100,
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}







import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

enum ChartTimeFrame { daily, weekly, monthly }

enum DemographicType { location, gender, age }

// Data Models
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
  late Animation<double> _animation;
  ChartTimeFrame _selectedTimeFrame = ChartTimeFrame.weekly;
  DemographicType _selectedDemographic = DemographicType.location;

  // Sample data initialization
  final List<DailyParticipation> _dailyTimeParticipation = List.generate(
    6,
    (index) => DailyParticipation(
        date: DateTime.now(),
        participation: (40 + index * 10).toDouble(),
        timeSlot: '${(index) * 4}:00'),
  );

  final List<DailyParticipation> _monthlyParticipation = List.generate(
    12,
    (index) => DailyParticipation(
      date: DateTime(2024, index + 1, 1),
      participation: 30 + (index % 3) * 20,
    ),
  );

  final AnalyticsSummary data = AnalyticsSummary(
    followers: 124500,
    followerGrowth: 1.29,
    gamesPublished: 14,
    totalPlayers: 158200,
    retention: 76,
    referral: 15,
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
        'Mumbai': 33.8,
        'Delhi': 25.0,
        'Bangalore': 20.0,
        'Lucknow': 11.2,
        'Other Cities': 10.0,
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
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "ANALYTICS",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF662C90),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryCards(),
                const SizedBox(height: 16),
                Text(
                  'MOST PLAYED GAME',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _mostPlayedGameCard(
                  'lib/images/g1.png',
                  'Ludo',
                  '+${data.gamePlayerCount}',
                  Icons.people_outline,
                ),
                const SizedBox(height: 8),
                _buildMostPlayedGames(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'PEAK PARTICIPATION',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    _buildTimeFrameDropdown(),
                  ],
                ),
                const SizedBox(height: 8),
                _buildParticipationChart(),
                const SizedBox(height: 16),
                Text(
                  'GAME PUBLISHED',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _buildGamePublishedChart(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'USER DEMOGRAPHIC',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    _buildDemographicDropdown(),
                  ],
                ),
                const SizedBox(height: 8),
                _buildDemographics(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeFrameDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: DropdownButton<ChartTimeFrame>(
        value: _selectedTimeFrame,
        underline: Container(),
        icon: Icon(Icons.arrow_drop_down, color: Color(0xFF662C90)),
        onChanged: (ChartTimeFrame? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedTimeFrame = newValue;
              _animationController.reset();
              _animationController.forward();
            });
          }
        },
        items: ChartTimeFrame.values.map((timeFrame) {
          return DropdownMenuItem<ChartTimeFrame>(
            value: timeFrame,
            child: Text(
              timeFrame.toString().split('.').last.toUpperCase(),
              style: TextStyle(color: Color(0xFF662C90)),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDemographicDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: DropdownButton<DemographicType>(
        value: _selectedDemographic,
        underline: Container(),
        icon: Icon(Icons.arrow_drop_down, color: Color(0xFF662C90)),
        onChanged: (DemographicType? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedDemographic = newValue;
              _animationController.reset();
              _animationController.forward();
            });
          }
        },
        items: DemographicType.values.map((type) {
          return DropdownMenuItem<DemographicType>(
            value: type,
            child: Text(
              type.toString().split('.').last.toUpperCase(),
              style: TextStyle(color: Color(0xFF662C90)),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildParticipationChart() {
    List<FlSpot> getSpots() {
      switch (_selectedTimeFrame) {
        case ChartTimeFrame.daily:
          return _dailyTimeParticipation
              .asMap()
              .entries
              .map((entry) =>
                  FlSpot(entry.key.toDouble(), entry.value.participation))
              .toList();
        case ChartTimeFrame.weekly:
          return data.weeklyParticipation
              .asMap()
              .entries
              .map((entry) =>
                  FlSpot(entry.key.toDouble(), entry.value.participation))
              .toList();
        case ChartTimeFrame.monthly:
          return _monthlyParticipation
              .asMap()
              .entries
              .map((entry) =>
                  FlSpot(entry.key.toDouble(), entry.value.participation))
              .toList();
      }
    }

    String getXAxisLabel(double value) {
      switch (_selectedTimeFrame) {
        case ChartTimeFrame.daily:
          if (value.toInt() >= 0 &&
              value.toInt() < _dailyTimeParticipation.length) {
            return _dailyTimeParticipation[value.toInt()].timeSlot;
          }
          break;
        case ChartTimeFrame.weekly:
          if (value.toInt() >= 0 &&
              value.toInt() < data.weeklyParticipation.length) {
            return DateFormat('E')
                .format(data.weeklyParticipation[value.toInt()].date);
          }
          break;
        case ChartTimeFrame.monthly:
          if (value.toInt() >= 0 &&
              value.toInt() < _monthlyParticipation.length) {
            return DateFormat('MMM')
                .format(_monthlyParticipation[value.toInt()].date);
          }
          break;
      }
      return '';
    }

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Container(
                  height: 300,
                  child: LineChart(
                    LineChartData(
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          tooltipRoundedRadius: 8,
                          tooltipPadding: const EdgeInsets.all(8),
                          tooltipMargin: 0,
                          getTooltipItems: (touchedSpots) {
                            return touchedSpots.map((touchedSpot) {
                              return LineTooltipItem(
                                touchedSpot.y.toStringAsFixed(1),
                                const TextStyle(color: Colors.white),
                              );
                            }).toList();
                          },
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        horizontalInterval: 20,
                        verticalInterval: 1,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.grey.withOpacity(0.2),
                            strokeWidth: 1,
                          );
                        },
                        getDrawingVerticalLine: (value) {
                          return FlLine(
                            color: Colors.grey.withOpacity(0.2),
                            strokeWidth: 1,
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                '${value.toInt()}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Transform.rotate(
                                  angle:
                                      _selectedTimeFrame == ChartTimeFrame.daily
                                          ? -0.5
                                          : 0,
                                  child: Text(
                                    getXAxisLabel(value),
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: getSpots()
                              .map((spot) => FlSpot(
                                    spot.x,
                                    spot.y * _animation.value,
                                  ))
                              .toList(),
                          isCurved: true,
                          color: Color(0xFF662C90),
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                radius: 4,
                                color: Color(0xFF662C90),
                                strokeWidth: 2,
                                strokeColor: Colors.white,
                              );
                            },
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            color: Color(0xFF662C90).withOpacity(0.1),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF662C90).withOpacity(0.2),
                                Color(0xFF662C90).withOpacity(0.0),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDemographics() {
    Widget buildChart() {
      switch (_selectedDemographic) {
        case DemographicType.location:
          return _buildLocationChart();
        case DemographicType.gender:
          return _buildGenderChart();
        case DemographicType.age:
          return _buildAgeChart();
      }
    }

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: buildChart(),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  // Keep your existing chart building methods (_buildLocationChart, _buildGenderChart, _buildAgeChart)
  // but wrap their content with AnimatedBuilder similar to _buildParticipationChart
  // Also add similar interactive features (tooltips, hover effects) to these charts

  // Example for one of the demographic charts:
  Widget _buildLocationChart() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Column(
              children: [
                Container(
                  height: 300,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: data.demographics.cityDistribution.entries
                          .map((entry) {
                        return PieChartSectionData(
                          value: entry.value * _animation.value,
                          title: '${entry.value}%',
                          color: Color(0xFF662C90).withOpacity(
                            1 -
                                (data.demographics.cityDistribution.keys
                                        .toList()
                                        .indexOf(entry.key) *
                                    0.2),
                          ),
                          radius: 100,
                          titleStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: data.demographics.cityDistribution.entries
                      .map((entry) => _buildLegendItem(
                            entry.key,
                            Color(0xFF662C90).withOpacity(
                              1 -
                                  (data.demographics.cityDistribution.keys
                                          .toList()
                                          .indexOf(entry.key) *
                                      0.2),
                            ),
                          ))
                      .toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 8,
      childAspectRatio: 1.5,
      children: [
        _buildFollowerCard(
            'Followers',
            NumberFormat.compact().format(data.followers),
            '+${data.followerGrowth}%',
            ''),
        _buildSummaryCard(
          'Game Published',
          data.gamesPublished.toString(),
          '',
          'lib/images/pad.png',
        ),
        _buildSummaryCard(
          'Total Players',
          NumberFormat.compact().format(data.totalPlayers),
          '',
          'lib/images/3player.png',
        ),
        _buildSummaryCard(
          'Retention',
          '${data.retention}%',
          '',
          'lib/images/increase.png',
        ),
        _buildSummaryCard(
          'Total Referral',
          '${data.referral}',
          '',
          'lib/images/reff.png',
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
      String title, String value, String change, String imagePath) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                Spacer(),
                // Icon(icon, color: Color.fromARGB(255, 102, 44, 144)),
                Image.asset(
                  imagePath,
                  height: 20,
                  width: 20,
                )
              ],
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (change.isNotEmpty)
              Text(
                change,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _mostPlayedGameCard(
      String path, String name, String count, IconData icon) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  path,
                  height: 80,
                  // width: 40,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  // lib/images/g1.png
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${count}k',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Icon(icon, color: Color.fromARGB(255, 102, 44, 144)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMostPlayedGames() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 60,
                  sections: [
                    PieChartSectionData(
                      value: data.gameDistribution.ludoKingPercentage,
                      title: '${data.gameDistribution.ludoKingPercentage}%',
                      color: Color.fromARGB(255, 102, 44, 144),
                      radius: 50,
                      titleStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      value: data.gameDistribution.snakeLadderPercentage,
                      title: '${data.gameDistribution.snakeLadderPercentage}%',
                      color: Color.fromARGB(255, 102, 44, 144).withOpacity(0.5),
                      radius: 50,
                      titleStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem(
                    'Ludo King', Color.fromARGB(255, 102, 44, 144)),
                SizedBox(width: 24),
                _buildLegendItem('Snake & Ladder',
                    Color.fromARGB(255, 102, 44, 144).withOpacity(0.5)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildAgeChart() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Age',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: _buildAgeSections(),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: data.demographics.ageDistribution.entries.map((entry) {
                return _buildLegendItem(
                  entry.key,
                  Color.fromARGB(255, 102, 44, 144).withOpacity(
                    1 -
                        (data.demographics.ageDistribution.keys
                                .toList()
                                .indexOf(entry.key) *
                            0.2),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderChart() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Gender',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: [
                    PieChartSectionData(
                      value: data.demographics.genderDistribution['Male']!,
                      title: '${data.demographics.genderDistribution['Male']}%',
                      color: Color.fromARGB(255, 102, 44, 144),
                      radius: 50,
                      titleStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      value: data.demographics.genderDistribution['Female']!,
                      title:
                          '${data.demographics.genderDistribution['Female']}%',
                      color: Color.fromARGB(255, 102, 44, 144).withOpacity(0.5),
                      radius: 50,
                      titleStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem('Male', Color.fromARGB(255, 102, 44, 144)),
                SizedBox(width: 16),
                _buildLegendItem('Female',
                    Color.fromARGB(255, 102, 44, 144).withOpacity(0.5)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFollowerCard(
      String title, String value, String change, String imagePath) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                Spacer(),
                // // Icon(icon, color: Color.fromARGB(255, 102, 44, 144)),
                // Image.asset(
                //   imagePath,
                //   height: 20,
                //   width: 20,
                // )
                Container(
                    // height: 30,
                    // width: 65,
                    padding: EdgeInsets.only(left: 8, right: 2),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '+3.69%',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (change.isNotEmpty)
              Text(
                change,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGamePublishedChart() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 12),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 &&
                              value.toInt() <
                                  data.weeklyGamesPublished.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                DateFormat('E').format(data
                                    .weeklyGamesPublished[value.toInt()].date),
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 12),
                              ),
                            );
                          }
                          return Text('');
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  barGroups: data.weeklyGamesPublished
                      .asMap()
                      .entries
                      .map(
                        (entry) => BarChartGroupData(
                          x: entry.key,
                          barRods: [
                            BarChartRodData(
                              toY: entry.value.count.toDouble(),
                              color: Color.fromARGB(255, 102, 44, 144),
                              width: 16,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildAgeSections() {
    return data.demographics.ageDistribution.entries.map((entry) {
      return PieChartSectionData(
        value: entry.value,
        title: '${entry.value}%',
        color: Color.fromARGB(255, 102, 44, 144).withOpacity(
          1 -
              (data.demographics.ageDistribution.keys
                      .toList()
                      .indexOf(entry.key) *
                  0.2),
        ),
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }
}
