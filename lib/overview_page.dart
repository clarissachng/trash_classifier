import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'api_service.dart';

class OverviewPage extends StatefulWidget {
  final String userId;
  const OverviewPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  List<Map<String, dynamic>>? monthlySummary;
  Map<String, int>? categorySummary;
  List<String>? achievements;
  String? selectedMonth;

  @override
  void initState() {
    super.initState();
    loadMonthlySummary();
    loadAchievements();
  }

  Future<void> loadMonthlySummary() async {
    var summary = await ApiService().getMonthlySummary(widget.userId);
    setState(() {
      monthlySummary = summary;
    });
  }

  Future<void> loadAchievements() async {
    var result = await ApiService().getUserAchievements(widget.userId);
    setState(() {
      achievements = result;
    });
  }

  Future<void> loadCategorySummary(String month) async {
    var summary = await ApiService().getCategorySummary(widget.userId, month);
    setState(() {
      categorySummary = summary;
      selectedMonth = month;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waste Log & Achievements'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    'Monthly Overview',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  if (monthlySummary != null)
                    SizedBox(
                      height: 250,
                      child: buildMonthlyBarChart(),
                    ),
                  if (categorySummary != null && selectedMonth != null)
                    SizedBox(
                      height: 200,
                      child: buildCategoryBarChart(),
                    ),
                  const SizedBox(height: 12),
                  const Text(
                    'YOU HAVE RECYCLED...',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  if (selectedMonth != null)
                    Text(
                      categorySummary?.keys.join(', ') ?? 'Select a month',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                ],
              ),
            ),

            // Achievements Section
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
                  if (achievements == null)
                    const Center(child: CircularProgressIndicator()),
                  if (achievements != null && achievements!.isEmpty)
                    const Center(child: Text('No achievements yet.')),
                  if (achievements != null)
                    ListView.builder(
                      itemCount: achievements!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: const Icon(Icons.star, color: Colors.amber),
                            title: Text(
                              achievements![index],
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
    );
  }

  Widget buildCategoryBarChart() {
    return BarChart(
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
    );
  }
}
