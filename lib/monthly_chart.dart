import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'api_service.dart';
import 'achievements.dart';

class MonthlyChart extends StatefulWidget {
  final String userId;
  const MonthlyChart({Key? key, required this.userId}) : super(key: key);

  @override
  State<MonthlyChart> createState() => _MonthlyChartState();
}

class _MonthlyChartState extends State<MonthlyChart> {
  List<Map<String, dynamic>>? monthlySummary;
  Map<String, int>? categorySummary;
  String? selectedMonth;

  @override
  void initState() {
    super.initState();
    loadMonthlySummary();
  }

  Future<void> loadMonthlySummary() async {
    var summary = await ApiService().getMonthlySummary(widget.userId);
    setState(() {
      monthlySummary = summary;
    });
  }

  Future<void> loadCategorySummary(String month) async {
    var summary = await ApiService().getCategorySummary(widget.userId, month);
    setState(() {
      categorySummary = summary;
      selectedMonth = month;
    });
  }

  void openAchievementsPage() {
    Navigator.pushNamed(
      context,
      '/achievements_page',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Monthly Waste Log')),
      body: Column(
        children: [
          if (monthlySummary != null) Expanded(child: buildMonthlyBarChart()),
          if (categorySummary != null && selectedMonth != null)
            Expanded(child: buildCategoryBarChart()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: openAchievementsPage,
              icon: const Icon(Icons.emoji_events),
              label: const Text(
                'Achievements',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMonthlyBarChart() {
    return Column(
      children: [
        const Text(
          'Monthly Waste Scans',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: BarChart(
            BarChartData(
              barGroups: monthlySummary!.map((item) {
                return BarChartGroupData(
                  x: int.parse(item['month'].split('-')[1]),
                  barRods: [
                    BarChartRodData(
                      toY: item['total'].toDouble(),
                      width: 16,
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    )
                  ],
                );
              }).toList(),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true, interval: 5),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text(value.toInt().toString());
                    },
                  ),
                ),
              ),
              barTouchData: BarTouchData(
                touchCallback: (event, response) {
                  if (response != null && response.spot != null) {
                    final index = response.spot!.touchedBarGroupIndex;
                    String month = monthlySummary![index]['month'];
                    loadCategorySummary(month);
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCategoryBarChart() {
    return Column(
      children: [
        Text(
          'Category Breakdown for $selectedMonth',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: BarChart(
            BarChartData(
              barGroups: categorySummary!.entries.map((entry) {
                return BarChartGroupData(
                  x: categorySummary!.keys.toList().indexOf(entry.key),
                  barRods: [
                    BarChartRodData(
                      toY: entry.value.toDouble(),
                      width: 12,
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                    )
                  ],
                );
              }).toList(),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true, interval: 2),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text(categorySummary!.keys.elementAt(value.toInt()));
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
