import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Big Tree (Left)
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset(
              'assets/background/big_tree.png',
              height: 300,
              fit: BoxFit.contain,
            ),
          ),
          // Small Tree (Right)
          Positioned(
            right: 0,
            top: 50,
            child: Image.asset(
              'assets/background/small_tree.png',
              height: 150,
              fit: BoxFit.contain,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Greeting text with profile image
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Hello, John",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/icon/profile-icon.png'),
                        radius: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),

                  // Trash Classifier Text
                  const SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Center(
                      child: Text(
                        "TRASH CLASSIFIER",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  _buildButton("Scan my waste", context),
                  _buildButton("Waste Overview", context),
                  _buildButton("Tips/Fun facts", context),

                  const Spacer(),

                  // Panda illustration moved to the right
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      'assets/character/panda.png',
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Settings icon replaced with specific image
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: IconButton(
                      icon: Image.asset('assets/icon/settings-icon.png', height: 30),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Button Widget
Widget _buildButton(String text, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.black, width: 2),
          ),
        ),
        onPressed: () {},
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    ),
  );
}
