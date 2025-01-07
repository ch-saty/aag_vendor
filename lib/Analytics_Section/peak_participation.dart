import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PeakParticipationSection extends StatefulWidget {
  const PeakParticipationSection({super.key});

  @override
  _PeakParticipationSectionState createState() =>
      _PeakParticipationSectionState();
}

class _PeakParticipationSectionState extends State<PeakParticipationSection> {
  String selectedGraph = 'Game Published'; // Changed to match exact item value
  String timeFilter = 'Weekly'; // Changed to match exact item value

  final List<String> graphOptions = [
    'Game Published',
    'User Demographic',
    'Peak Participation'
  ];

  final List<String> timeFilterOptions = ['Daily', 'Weekly', 'Monthly'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF662C90),
        borderRadius: BorderRadius.circular(8),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.1),
        //     spreadRadius: 2,
        //     blurRadius: 4,
        //     offset: const Offset(0, 2),
        //   ),
        // ],
      ),
      child: Column(
        children: [
          _buildFilters(),
          const SizedBox(height: 20),
          _buildSelectedGraph(),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DropdownButton<String>(
          value: selectedGraph,
          items: graphOptions.map((String value) {
            return DropdownMenuItem<String>(
              value: value, // Use the exact string value
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedGraph = newValue;
              });
            }
          },
        ),
        DropdownButton<String>(
          value: timeFilter,
          items: timeFilterOptions.map((String value) {
            return DropdownMenuItem<String>(
              value: value, // Use the exact string value
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                timeFilter = newValue;
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildSelectedGraph() {
    switch (selectedGraph) {
      case 'Game Published':
        return _buildBarChart();
      case 'User Demographic':
        return _buildPieChart();
      case 'Peak Participation':
        return _buildLineChart();
      default:
        return Container();
    }
  }

  Widget _buildBarChart() {
    return SizedBox(
      height: 300,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 5,
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              // Changed from SideTitles to AxisTitles
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (double value, TitleMeta meta) {
                  // Updated getTitles
                  final days = [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun'
                  ];
                  return Text(days[value.toInt()]);
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: [
            _buildBarGroup(0, 2),
            _buildBarGroup(1, 1),
            _buildBarGroup(2, 4),
            _buildBarGroup(3, 2),
            _buildBarGroup(4, 5),
            _buildBarGroup(5, 2),
            _buildBarGroup(6, 3),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y, // Changed from y to toY
          color: Colors.purple, // Changed from colors to color
          width: 20,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
      ],
    );
  }

  Widget _buildLineChart() {
    return SizedBox(
      height: 300,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              // Changed from SideTitles to AxisTitles
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (double value, TitleMeta meta) {
                  // Updated getTitles
                  final days = [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun'
                  ];
                  return Text(days[value.toInt()]);
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 20),
                const FlSpot(1, 25),
                const FlSpot(2, 18),
                const FlSpot(3, 60),
                const FlSpot(4, 30),
                const FlSpot(5, 25),
                const FlSpot(6, 20),
              ],
              isCurved: true,
              color: Colors.purple, // Changed from colors to color
              barWidth: 3,
              belowBarData: BarAreaData(
                show: true,
                color: Colors.purple
                    .withOpacity(0.3), // Changed from colors to color
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    return SizedBox(
      height: 300,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: 32.7,
              title: 'Bihar\n32.7%',
              color: Colors.white,
              radius: 100,
            ),
            PieChartSectionData(
              value: 28.1,
              title: 'Lucknow\n28.1%',
              color: const Color.fromARGB(255, 233, 207, 252),
              radius: 100,
            ),
            PieChartSectionData(
              value: 22.8,
              title: 'Delhi\n22.8%',
              color: const Color.fromARGB(255, 194, 134, 238),
              radius: 100,
            ),
            PieChartSectionData(
              value: 13.8,
              title: 'Mumbai\n13.8%',
              color: const Color.fromARGB(255, 149, 99, 185),
              radius: 100,
            ),
            PieChartSectionData(
              value: 10.6,
              title: 'Others\n10.6%',
              color: const Color.fromARGB(255, 125, 62, 170),
              radius: 100,
            ),
          ],
        ),
      ),
    );
  }
}
