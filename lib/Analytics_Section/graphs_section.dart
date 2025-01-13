import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraphsSection extends StatelessWidget {
  GraphsSection({super.key});

  final List<Map<String, dynamic>> participationData = [
    {'day': 'Mon', 'value': 30},
    {'day': 'Tue', 'value': 45},
    {'day': 'Wed', 'value': 35},
    {'day': 'Thu', 'value': 50},
    {'day': 'Fri', 'value': 40},
    {'day': 'Sat', 'value': 55},
    {'day': 'Sun', 'value': 45},
  ];

  final List<Map<String, dynamic>> gamePublishData = [
    {'day': 'Mon', 'count': 3},
    {'day': 'Tue', 'count': 5},
    {'day': 'Wed', 'count': 2},
    {'day': 'Thu', 'count': 4},
    {'day': 'Fri', 'count': 6},
    {'day': 'Sat', 'count': 3},
    {'day': 'Sun', 'count': 4},
  ];

  final Map<String, double> demographicData = {
    'Bihar': 32.7,
    'Delhi': 22.8,
    'Lucknow': 28.1,
    'Mumbai': 13.8,
    'Other': 2.6,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildParticipationSection(),
        _buildGamePublishedSection(),
        _buildDemographicsSection(),
      ],
    );
  }

  Widget _buildParticipationSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PARTICIPATION',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 60,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 15,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.2),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 &&
                              value.toInt() < participationData.length) {
                            return Text(
                              participationData[value.toInt()]['day'],
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            );
                          }
                          return Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 15,
                        reservedSize: 35,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: participationData.asMap().entries.map((entry) {
                        return FlSpot(
                          entry.key.toDouble(),
                          entry.value['value'].toDouble(),
                        );
                      }).toList(),
                      isCurved: true,
                      color: Color(0xFF662C90),
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGamePublishedSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'GAMES PUBLISHED',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BarChart(
                BarChartData(
                  minY: 0,
                  maxY: 8,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 &&
                              value.toInt() < gamePublishData.length) {
                            return Text(
                              gamePublishData[value.toInt()]['day'],
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            );
                          }
                          return Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 2,
                        reservedSize: 35,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 2,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.2),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: gamePublishData.asMap().entries.map((entry) {
                    return BarChartGroupData(
                      x: entry.key,
                      barRods: [
                        BarChartRodData(
                          toY: entry.value['count'].toDouble(),
                          color: Color(0xFF662C90),
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemographicsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DEMOGRAPHICS',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 50,
                sections: demographicData.entries.map((entry) {
                  final index =
                      demographicData.keys.toList().indexOf(entry.key);
                  return PieChartSectionData(
                    color: Color(0xFF662C90).withOpacity(1 - (index * 0.15)),
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
      ),
    );
  }
}
