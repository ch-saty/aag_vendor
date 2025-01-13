import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

enum ChartTimeFrame { daily, weekly, monthly }

enum DemographicType { location, gender, age, mostplayedgame }

enum ChartType { publishedgame, userparticipation }

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
  final String timeSlot; // Added timeSlot property

  DailyGamePublished({
    required this.date,
    required this.count,
    this.timeSlot = '', // Default empty string to maintain compatibility
  });
}

class GameDistribution {
  final double ludoKingPercentage;
  final double snakeLadderPercentage;
  GameDistribution({
    required this.ludoKingPercentage,
    required this.snakeLadderPercentage,
  });
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
  ChartTimeFrame _selectedTimeFrame = ChartTimeFrame.daily;
  DemographicType _selectedDemographic = DemographicType.location;

  ChartType _selectedChart = ChartType.userparticipation;

  // Sample data initialization

  final Demographics dailyDemographics = Demographics(
    cityDistribution: {
      'Mumbai': 35.8,
      'Delhi': 23.0,
      'Bangalore': 21.0,
      'Lucknow': 10.2,
      'Other Cities': 10.0,
    },
    genderDistribution: {
      'Male': 65.0,
      'Female': 35.0,
    },
    ageDistribution: {
      '12-18': 22.0,
      '18-35': 53.0,
      '35-55': 25.0,
    },
  );

  final Demographics weeklyDemographics = Demographics(
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
  );

  final Demographics monthlyDemographics = Demographics(
    cityDistribution: {
      'Mumbai': 31.8,
      'Delhi': 27.0,
      'Bangalore': 19.0,
      'Lucknow': 12.2,
      'Other Cities': 10.0,
    },
    genderDistribution: {
      'Male': 69.0,
      'Female': 31.0,
    },
    ageDistribution: {
      '12-18': 26.0,
      '18-35': 49.0,
      '35-55': 25.0,
    },
  );

  final Map<ChartTimeFrame, GameDistribution> timeFrameGameDistribution = {
    ChartTimeFrame.daily: GameDistribution(
      ludoKingPercentage: 63,
      snakeLadderPercentage: 37,
    ),
    ChartTimeFrame.weekly: GameDistribution(
      ludoKingPercentage: 65,
      snakeLadderPercentage: 35,
    ),
    ChartTimeFrame.monthly: GameDistribution(
      ludoKingPercentage: 68,
      snakeLadderPercentage: 32,
    ),
  };
  Demographics get currentDemographics {
    switch (_selectedTimeFrame) {
      case ChartTimeFrame.daily:
        return dailyDemographics;
      case ChartTimeFrame.weekly:
        return weeklyDemographics;
      case ChartTimeFrame.monthly:
        return monthlyDemographics;
    }
  }

  GameDistribution get currentGameDistribution {
    return timeFrameGameDistribution[_selectedTimeFrame]!;
  }

  final List<DailyGamePublished> _dailyGamesPublished = List.generate(
    5,
    (index) => DailyGamePublished(
      date: DateTime.now().subtract(Duration(days: index)),
      count: 20 * (index % 5), // Random count between 1 and 5
    ),
  );

  final List<DailyGamePublished> _monthlyGamesPublished = List.generate(
    30,
    (index) => DailyGamePublished(
      date: DateTime(2024, index + 1, 1),
      count: 5 * (index % 4), // Random count between 2 and 5
    ),
  );

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
        padding: const EdgeInsets.all(0.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 102, 44, 144),
            ),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 102, 44, 144),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildDemographicDropdown(),
                            _buildTimeFrameDropdown2(),
                          ],
                        ),
                        _buildDemographics(),
                      ],
                    )),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      _mostPlayedGameCard(
                        'lib/images/g1.png',
                        'Ludo',
                        '${data.gamePlayerCount}',
                        Icons.people_outline,
                      ),
                      // const SizedBox(height: 8),
                      // _buildMostPlayedGames(),
                      const SizedBox(height: 16),
                      Text(
                        'USER DEMOGRAPHY',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 102, 44, 144),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // _buildDemographicDropdown(),
                                  _graphDropdown(),
                                  _buildTimeFrameDropdown(),
                                ],
                              ),
                              _buildCharts(),
                              // _buildGamePublishedChart(),
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeFrameDropdown2() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 102, 44, 144),
        borderRadius: BorderRadius.circular(8),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.1),
        //     blurRadius: 4,
        //     offset: Offset(0, 2),
        //   ),
        // ],
      ),
      child: DropdownButton<ChartTimeFrame>(
        value: _selectedTimeFrame,
        underline: Container(),
        icon: Icon(Icons.arrow_drop_down, color: Colors.white),
        dropdownColor: Color.fromARGB(255, 102, 44, 144),
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
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _graphDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 102, 44, 144),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<ChartType>(
        value: _selectedChart,
        underline: Container(),
        dropdownColor: Color.fromARGB(255, 102, 44, 144),
        icon: Icon(Icons.arrow_drop_down, color: Colors.white),
        onChanged: (ChartType? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedChart = newValue;
              _animationController.reset();
              _animationController.forward();
            });
          }
        },
        items: ChartType.values.map((type) {
          return DropdownMenuItem<ChartType>(
            value: type,
            child: Text(
              type.toString().split('.').last.toUpperCase(),
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCharts() {
    Widget buildChart() {
      switch (_selectedChart) {
        case ChartType.publishedgame:
          return _buildGamePublishedChart();
        case ChartType.userparticipation:
          return _buildParticipationChart();
      }
    }

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 400),
      child: buildChart(),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(
          scale: animation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildParticipationChart() {
    List<BarChartGroupData> getBarGroups() {
      switch (_selectedTimeFrame) {
        case ChartTimeFrame.daily:
          return _dailyTimeParticipation
              .asMap()
              .entries
              .map((entry) => BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value.participation * _animation.value,
                        color: const Color(0xFF662C90),
                        width: 16,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                    ],
                  ))
              .toList();
        case ChartTimeFrame.weekly:
          return data.weeklyParticipation
              .asMap()
              .entries
              .map((entry) => BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value.participation * _animation.value,
                        color: const Color(0xFF662C90),
                        width: 20,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                    ],
                  ))
              .toList();
        case ChartTimeFrame.monthly:
          return _monthlyParticipation
              .asMap()
              .entries
              .map((entry) => BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value.participation * _animation.value,
                        color: const Color(0xFF662C90),
                        width: 24,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                    ],
                  ))
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

    double calculateMinWidth() {
      int barCount = 0;
      switch (_selectedTimeFrame) {
        case ChartTimeFrame.daily:
          barCount = _dailyTimeParticipation.length;
          break;
        case ChartTimeFrame.weekly:
          barCount = data.weeklyParticipation.length;
          break;
        case ChartTimeFrame.monthly:
          barCount = _monthlyParticipation.length;
          break;
      }
      return math.max(MediaQuery.of(context).size.width, barCount * 50.0);
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
                return SizedBox(
                  height: 300,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: calculateMinWidth(),
                      child: BarChart(
                        BarChartData(
                          barTouchData: BarTouchData(
                            touchTooltipData: BarTouchTooltipData(
                              tooltipRoundedRadius: 8,
                              tooltipPadding: const EdgeInsets.all(8),
                              tooltipMargin: 0,
                              getTooltipItem:
                                  (group, groupIndex, rod, rodIndex) {
                                return BarTooltipItem(
                                  rod.toY.toStringAsFixed(1),
                                  const TextStyle(color: Colors.white),
                                );
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
                              axisNameWidget: const Text(
                                'User Participation',
                                style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 3,
                                  fontSize: 12,
                                ),
                              ),
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Transform.rotate(
                                      angle: _selectedTimeFrame ==
                                              ChartTimeFrame.daily
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
                          barGroups: getBarGroups(),
                          maxY: 100,
                        ),
                      ),
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

  Widget _buildTimeFrameDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 102, 44, 144),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [],
      ),
      child: DropdownButton<ChartTimeFrame>(
        value: _selectedTimeFrame,
        underline: Container(),
        icon: Icon(Icons.arrow_drop_down, color: Colors.white),
        dropdownColor: Color.fromARGB(255, 102, 44, 144),
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
              style: TextStyle(color: Colors.white, fontSize: 12),
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
        color: Color.fromARGB(255, 102, 44, 144),
        borderRadius: BorderRadius.circular(8),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.2),
        //     spreadRadius: 1,
        //     blurRadius: 4,
        //   ),
        // ],
      ),
      child: DropdownButton<DemographicType>(
        value: _selectedDemographic,
        underline: Container(),
        dropdownColor: Color.fromARGB(255, 102, 44, 144),
        icon: Icon(Icons.arrow_drop_down, color: Colors.white),
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
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          );
        }).toList(),
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
        case DemographicType.mostplayedgame:
          return _buildMostPlayedGames();
        // _buildMostPlayedGames
      }
    }

    return buildChart();
  }

  // Widget _buildLegendItem(String label, Color color, {required Color textColor}) {
  //   return Row(
  //     mainAxisSize: MainAxisSize.min,
  //     // mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Container(
  //         width: 12,
  //         height: 12,
  //         decoration: BoxDecoration(
  //           color: color,
  //           shape: BoxShape.circle,
  //         ),
  //       ),
  //       SizedBox(width: 4),
  //       Text(
  //         label,
  //         style: TextStyle(
  //           fontSize: 12,
  //           color: Colors.grey[600],
  //         ),
  //       ),
  //       SizedBox(width: 8),
  //     ],
  //   );
  // }

  Widget _buildGamePublishedChart() {
    List<BarChartGroupData> getBarGroups() {
      switch (_selectedTimeFrame) {
        case ChartTimeFrame.daily:
          return _dailyGamesPublished
              .asMap()
              .entries
              .map((entry) => BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value.count.toDouble() * _animation.value,
                        color: const Color(0xFF662C90),
                        width: 16,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                    ],
                  ))
              .toList();
        case ChartTimeFrame.weekly:
          return data.weeklyGamesPublished
              .asMap()
              .entries
              .map((entry) => BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value.count.toDouble() * _animation.value,
                        color: const Color(0xFF662C90),
                        width: 20,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                    ],
                  ))
              .toList();
        case ChartTimeFrame.monthly:
          return _monthlyGamesPublished
              .asMap()
              .entries
              .map((entry) => BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value.count.toDouble() * _animation.value,
                        color: const Color(0xFF662C90),
                        width: 24,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                    ],
                  ))
              .toList();
      }
    }

    String getXAxisLabel(double value) {
      switch (_selectedTimeFrame) {
        case ChartTimeFrame.daily:
          if (value.toInt() >= 0 &&
              value.toInt() < _dailyGamesPublished.length) {
            return _dailyGamesPublished[value.toInt()].timeSlot;
          }
          break;
        case ChartTimeFrame.weekly:
          if (value.toInt() >= 0 &&
              value.toInt() < data.weeklyGamesPublished.length) {
            return DateFormat('E')
                .format(data.weeklyGamesPublished[value.toInt()].date);
          }
          break;
        case ChartTimeFrame.monthly:
          if (value.toInt() >= 0 &&
              value.toInt() < _monthlyGamesPublished.length) {
            return DateFormat('MMM')
                .format(_monthlyGamesPublished[value.toInt()].date);
          }
          break;
      }
      return '';
    }

    double calculateMinWidth() {
      int barCount = 0;
      switch (_selectedTimeFrame) {
        case ChartTimeFrame.daily:
          barCount = _dailyGamesPublished.length;
          break;
        case ChartTimeFrame.weekly:
          barCount = data.weeklyGamesPublished.length;
          break;
        case ChartTimeFrame.monthly:
          barCount = _monthlyGamesPublished.length;
          break;
      }
      return math.max(MediaQuery.of(context).size.width, barCount * 50.0);
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
                return SizedBox(
                  height: 300,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: calculateMinWidth(),
                      child: BarChart(
                        BarChartData(
                          barTouchData: BarTouchData(
                            touchTooltipData: BarTouchTooltipData(
                              tooltipRoundedRadius: 8,
                              tooltipPadding: const EdgeInsets.all(8),
                              tooltipMargin: 0,
                              getTooltipItem:
                                  (group, groupIndex, rod, rodIndex) {
                                return BarTooltipItem(
                                  rod.toY.toStringAsFixed(1),
                                  const TextStyle(color: Colors.white),
                                );
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
                              axisNameWidget: const Text(
                                'Games Published',
                                style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 3,
                                  fontSize: 12,
                                ),
                              ),
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Transform.rotate(
                                      angle: _selectedTimeFrame ==
                                              ChartTimeFrame.daily
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
                          barGroups: getBarGroups(),
                          maxY: 100,
                        ),
                      ),
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
                    fontSize: 12,
                  ),
                ),
                Spacer(),
                // // Icon(icon, color: Color.fromARGB(255, 102, 44, 144)),
                Image.asset(
                  imagePath,
                  height: 25,
                  width: 25,
                )
                // Container(
                //     // height: 30,
                //     // width: 65,
                //     padding: EdgeInsets.only(left: 8, right: 2),
                //     decoration: BoxDecoration(
                //       color: Colors.green.withOpacity(0.1),
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: [
                //         Text(
                //           '+3.69%',
                //           style: TextStyle(
                //             color: Colors.green,
                //           ),
                //         ),
                //       ],
                //     )),
              ],
            ),
            SizedBox(height: 5),
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
            'lib/images/games_section.png'),
        _buildSummaryCard(
          'Game Published',
          data.gamesPublished.toString(),
          '+20 this week',
          'lib/images/pad.png',
        ),
        _buildSummaryCard(
          'Total Players',
          NumberFormat.compact().format(data.totalPlayers),
          '+8.5k this week',
          'lib/images/3player.png',
        ),
        _buildSummaryCard(
          'Retention',
          '${data.retention}%',
          '+1% this week',
          'lib/images/increase.png',
        ),
        // _buildSummaryCard(
        //   'Total Referral',
        //   '${data.referral}',
        //   '+2 this week',
        //   'lib/images/reff.png',
        // ),
        // _buildFollowerCard(
        //     'Engagement',
        //     NumberFormat.compact().format(data.followers),
        //     '+${data.followerGrowth}%',
        //     ''),
      ],
    );
  }

  Widget _buildSummaryCard(
      String title, String value, String change, String imagePath) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
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
                // Icon(icon, color: Color.fromARGB(255, 102, 44, 144)),
                Container(
                  width: 61,
                  height: 24,
                  // padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color.fromRGBO(255, 146, 29, 1),
                        width: 1,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '₹2',
                        style: TextStyle(color: Colors.orange, fontSize: 12),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationChart() {
    final List<Color> chartColors = [
      Color.fromRGBO(255, 255, 255, 1),
      Color.fromRGBO(233, 207, 252, 1),
      Color.fromRGBO(194, 134, 238, 1),
      Color.fromRGBO(149, 99, 185, 1),
      Color.fromRGBO(125, 62, 170, 1),
    ];

    final double baseRadius = 100;
    final double sectionAnimationDuration =
        0.2; // Duration for each section animation

    return Card(
      key: ValueKey('location'),
      elevation: 0,
      color: Color.fromARGB(255, 102, 44, 144),
      child: Container(
        height: 400,
        padding: const EdgeInsets.all(16.0),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      // Shadow layer
                      PieChart(
                        PieChartData(
                          sectionsSpace: 2, // Add space between sections
                          centerSpaceRadius: 40,
                          sections: currentDemographics.cityDistribution.entries
                              .map((entry) {
                            int index = currentDemographics
                                .cityDistribution.keys
                                .toList()
                                .indexOf(entry.key);

                            // Calculate start time for each section
                            double startTime = index * sectionAnimationDuration;
                            double normalizedTime =
                                (_animation.value - startTime) /
                                    sectionAnimationDuration;
                            double sectionAnimation =
                                normalizedTime.clamp(0.0, 1.0);

                            // Only show section if it's time for it to animate
                            if (_animation.value < startTime) {
                              return PieChartSectionData(
                                value: entry.value,
                                radius: 0,
                                color: Colors.transparent,
                              );
                            }

                            return PieChartSectionData(
                              value: entry.value,
                              title: sectionAnimation == 1.0
                                  ? '${entry.value}%'
                                  : '',
                              color: Colors.black.withOpacity(0.2),
                              radius: baseRadius * sectionAnimation,
                              titleStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: index == 0 ? Colors.black : Colors.white,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      // Main pie chart layer
                      PieChart(
                        PieChartData(
                          sectionsSpace: 2,
                          centerSpaceRadius: 40,
                          sections: currentDemographics.cityDistribution.entries
                              .map((entry) {
                            int index = currentDemographics
                                .cityDistribution.keys
                                .toList()
                                .indexOf(entry.key);

                            // Calculate start time for each section
                            double startTime = index * sectionAnimationDuration;
                            double normalizedTime =
                                (_animation.value - startTime) /
                                    sectionAnimationDuration;
                            double sectionAnimation =
                                normalizedTime.clamp(0.0, 1.0);

                            // Only show section if it's time for it to animate
                            if (_animation.value < startTime) {
                              return PieChartSectionData(
                                value: entry.value,
                                radius: 0,
                                color: Colors.transparent,
                              );
                            }

                            // Add gradient and elevation effect
                            return PieChartSectionData(
                              value: entry.value,
                              title: sectionAnimation == 1.0
                                  ? '${entry.value}%'
                                  : '',
                              color: chartColors[index % chartColors.length],
                              radius: baseRadius * sectionAnimation,
                              titleStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: index == 0 ? Colors.black : Colors.white,
                              ),
                              badgeWidget: sectionAnimation == 1.0
                                  ? _buildGlowBadge(
                                      chartColors[index % chartColors.length])
                                  : null,
                              badgePositionPercentageOffset: 0.98,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children:
                      currentDemographics.cityDistribution.entries.map((entry) {
                    int index = currentDemographics.cityDistribution.keys
                        .toList()
                        .indexOf(entry.key);
                    return _buildLegendItem(
                      entry.key,
                      chartColors[index % chartColors.length],
                      textColor: Colors.white,
                    );
                  }).toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildGlowBadge(Color color) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildAgeChart() {
    final List<Color> chartColors = [
      Color.fromRGBO(255, 255, 255, 1),
      Color.fromRGBO(233, 207, 252, 1),
      Color.fromRGBO(194, 134, 238, 1),
    ];

    return Card(
      key: ValueKey('age'),
      elevation: 0,
      color: Color.fromARGB(255, 102, 44, 144),
      child: Container(
        height: 400,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Text(
            //   'Age Distribution',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // SizedBox(height: 16),
            Expanded(
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections:
                      currentDemographics.ageDistribution.entries.map((entry) {
                    int index = currentDemographics.ageDistribution.keys
                        .toList()
                        .indexOf(entry.key);
                    return PieChartSectionData(
                      value: entry.value,
                      title: '${entry.value}%',
                      color: chartColors[index % chartColors.length],
                      radius: 100,
                      titleStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: index == 0 ? Colors.black : Colors.white,
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
              children:
                  currentDemographics.ageDistribution.entries.map((entry) {
                int index = currentDemographics.ageDistribution.keys
                    .toList()
                    .indexOf(entry.key);
                return _buildLegendItem(
                  entry.key,
                  chartColors[index % chartColors.length],
                  textColor: Colors.white,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderChart() {
    final List<Color> chartColors = [
      Color.fromRGBO(255, 255, 255, 1),
      Color.fromRGBO(194, 134, 238, 1),
    ];

    return Card(
      key: ValueKey('gender'),
      elevation: 2,
      color: Color.fromARGB(255, 102, 44, 144),
      child: Container(
        height: 400,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Text(
            //   'Gender Distribution',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // SizedBox(height: 16),
            Expanded(
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: [
                    PieChartSectionData(
                      value: currentDemographics.genderDistribution['Male']!,
                      title:
                          '${currentDemographics.genderDistribution['Male']}%',
                      color: chartColors[0],
                      radius: 100,
                      titleStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    PieChartSectionData(
                      value: currentDemographics.genderDistribution['Female']!,
                      title:
                          '${currentDemographics.genderDistribution['Female']}%',
                      color: chartColors[1],
                      radius: 100,
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
                _buildLegendItem('Male', chartColors[0],
                    textColor: Colors.white),
                SizedBox(width: 16),
                _buildLegendItem('Female', chartColors[1],
                    textColor: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMostPlayedGames() {
    final List<Color> chartColors = [
      Color.fromRGBO(255, 255, 255, 1),
      Color.fromRGBO(194, 134, 238, 1),
    ];

    return Card(
      elevation: 0,
      color: Color.fromARGB(255, 102, 44, 144),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Most Played Games',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // SizedBox(height: 16),
            Container(
              height: 300,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 60,
                  sections: [
                    PieChartSectionData(
                      value: currentGameDistribution.ludoKingPercentage,
                      title: '${currentGameDistribution.ludoKingPercentage}%',
                      color: chartColors[0],
                      radius: 60,
                      titleStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    PieChartSectionData(
                      value: currentGameDistribution.snakeLadderPercentage,
                      title:
                          '${currentGameDistribution.snakeLadderPercentage}%',
                      color: chartColors[1],
                      radius: 60,
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
                _buildLegendItem('Ludo King', chartColors[0],
                    textColor: Colors.white),
                SizedBox(width: 24),
                _buildLegendItem('Snake & Ladder', chartColors[1],
                    textColor: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Update the legend item builder to accept text color
  Widget _buildLegendItem(String text, Color color,
      {Color textColor = Colors.black}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
