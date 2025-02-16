import 'package:flutter/material.dart';
import 'screens/scan_page.dart';

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
        fontFamily: 'RinsHandwriting',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/scan_page': (context) => const ScanPage(),
      },
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
            top: 100,
            child: Image.asset(
              'assets/background/big_tree.png',
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
          // Small Tree (Right)
          Positioned(
            right: 0,
            top: 100,
            child: Image.asset(
              'assets/background/small_tree.png',
              height: 300,
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
                  const SizedBox(height: 200),

                  // Trash Classifier Text
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const SizedBox(
                      child: Center(
                      child: Text(
                        "TRASH CLASSIFIER",
                        style: TextStyle(
                          fontFamily: 'Simpsonfont',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      ),
                    ),
                  ),
                  _buildButton("Scan my waste", context, 'scan_page'),
                  _buildButton("Waste Overview", context),
                  _buildButton("Tips/Fun facts", context),

                  const Spacer(),

                  // Panda illustration moved to the right
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      'assets/character/panda.png',
                      height: 180,
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

Widget _buildButton(String text, BuildContext context, [String? route]) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: SizedBox(
      width: double.infinity,
      height: 50,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/widgets/outlined-btn.png', // Ensure this file exists
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.black, width: 2),
                ),
              ),
              onPressed: () {
                if (route != null && route.isNotEmpty) {
                  Navigator.pushNamed(context, route);
                }
              },
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}


