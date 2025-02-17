import 'package:flutter/material.dart';
import 'api_service.dart';

class AchievementsPage extends StatefulWidget {
  final String userId;
  const AchievementsPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  List<String>? achievements;

  @override
  void initState() {
    super.initState();
    loadAchievements();
  }

  Future<void> loadAchievements() async {
    var result = await ApiService().getUserAchievements(widget.userId);
    setState(() {
      achievements = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Achievements')),
      body: achievements == null
          ? const Center(child: CircularProgressIndicator())
          : achievements!.isEmpty
          ? const Center(child: Text('No achievements yet.'))
          : ListView.builder(
        itemCount: achievements!.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(
                vertical: 8, horizontal: 16),
            child: ListTile(
              leading: const Icon(Icons.star, color: Colors.amber),
              title: Text(
                achievements![index],
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
