import 'package:flutter/material.dart';

class LearnMorePage extends StatelessWidget {
  const LearnMorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Learn More"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your waste belongs to...",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Center(
              child: Image.asset(
                'assets/bin/brown_bin.png', // Ensure image exists
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "BROWN BIN",
              style: TextStyle(fontFamily: 'Simpsonfont', fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "AI recycling advises for...",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "BAD MATCHA",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text(
              "- Incorrectly disposed of.\n- Place in accepted compost or areas.\n- Some waste may need special handling.",
            ),
            const SizedBox(height: 20),
            const Text(
              "AI Powered Tips and Tricks",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              "- Proper waste disposal techniques.\n- Alternatives for composting.\n- How to minimize waste impact.",
            ),
            const SizedBox(height: 30),
            // Understood Button with Image Background
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/widgets/black-btn.png',
                    height: 60,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/overview_page');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                    ),
                    child: const Text(
                      "Understood!",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Wrong Object or Material Button with Image Background
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/widgets/outlined-btn.png', // Ensure image exists
                    height: 60,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Define functionality for wrong material/object
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                    ),
                    child: const Text(
                      "Wrong object or material?",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
