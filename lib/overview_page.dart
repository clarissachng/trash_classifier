import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class OverviewPage extends StatefulWidget {
  final String userId;
  const OverviewPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  List<Map<String, dynamic>> monthlySummary = [];
  Map<String, int> categorySummary = {};
  List<String> achievements = [];
  String? selectedMonth;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadFakeData();
  }

  void loadFakeData() {
    // Monthly Waste Summary (Fake Data)
    monthlySummary = [
      {"month": "2024-01", "total": 15},
      {"month": "2024-02", "total": 22},
      {"month": "2024-03", "total": 25},
      {"month": "2024-04", "total": 10},
      {"month": "2024-05", "total": 18},
      {"month": "2024-06", "total": 20},
    ];

    // Achievements (Fake Data)
    achievements = [
      "🌱 Eco Paper Saver",
      "📦 Cardboard Collector",
      "🍃 Organic Hero",
      "🛠️ Metal Recycler"
    ];

    setState(() {});
  }

  void loadCategorySummary(String month) {
    // Fake Category Data based on Month
    Map<String, Map<String, int>> fakeCategoryData = {
      "2024-01": {"paper": 3, "plastic": 5, "trash": 7},
      "2024-02": {"metal": 4, "cardboard": 2, "plastic": 9},
      "2024-03": {"paper": 5, "plastic": 8, "metal": 2, "trash": 7},
      "2024-04": {"biological": 6, "clothes": 4, "shoes": 2},
      "2024-05": {"green-glass": 5, "brown-glass": 3, "white-glass": 4},
      "2024-06": {"batteries": 4, "trash": 6, "clothes": 5},
    };

    categorySummary = fakeCategoryData[month] ?? {};
    selectedMonth = month;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waste Log & Achievements'),
      ),
      body: Scrollbar(
        thumbVisibility: true,
        controller: _scrollController,
        thickness: 8,
        radius: const Radius.circular(10),
        child: ListView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            // Waste Log Section
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'WASTE LOG',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Monthly Overview (Tap a Bar for Details)',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 250,
                    child: buildMonthlyBarChart(),
                  ),
                  if (selectedMonth != null) ...[
                    const SizedBox(height: 20),
                    Text(
                      'Category Breakdown for $selectedMonth',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 200,
                      child: buildCategoryBarChart(),
                    ),
                  ],
                ],
              ),
            ),

            // Achievements Section (Below)
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ACHIEVEMENTS',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  if (achievements.isEmpty)
                    const Center(child: Text('No achievements yet.')),
                  if (achievements.isNotEmpty)
                    ListView.builder(
                      itemCount: achievements.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: const Icon(Icons.star, color: Colors.amber),
                            title: Text(
                              achievements[index],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMonthlyBarChart() {
    return BarChart(
      BarChartData(
        barGroups: monthlySummary.map((item) {
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
            sideTitles: SideTitles(
              showTitles: true,
              interval: 5,
              reservedSize: 30, // Show only on the left
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false), // No right Y-axis
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false), // No top titles
          ),
          bottomTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false), // No X-axis annotations
          ),
        ),
        barTouchData: BarTouchData(
          touchCallback: (event, response) {
            if (response != null &&
                response.spot != null &&
                response.spot!.touchedBarGroupIndex <
                    monthlySummary.length) {
              String month = monthlySummary[
              response.spot!.touchedBarGroupIndex]['month'];
              loadCategorySummary(month);
            }
          },
        ),
      ),
    );
  }

  Widget buildCategoryBarChart() {
    return BarChart(
      BarChartData(
        barGroups: categorySummary.entries.map((entry) {
          return BarChartGroupData(
            x: categorySummary.keys.toList().indexOf(entry.key),
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
            sideTitles: SideTitles(
              showTitles: true,
              interval: 2,
              reservedSize: 30, // Show only on the left
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false), // No right Y-axis
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false), // No top titles
          ),
          bottomTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false), // No X-axis labels
          ),
        ),
      ),
    );
  }
}
