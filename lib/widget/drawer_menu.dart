import 'package:flutter/material.dart';
import '../main.dart';
import 'settings_page.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFFFB), // Restored background color
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Center title & buttons
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Menu Title
                    Container(
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/widgets/black-btn.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Menu",
                          style: TextStyle(
                            fontFamily: 'Simpsonfont',
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30), // Space below title

                    // Menu Buttons
                    _buildButton("Bring me home", context),
                    const SizedBox(height: 20),
                    _buildButton("Scan my waste", context, '/scan_page'),
                    const SizedBox(height: 20),
                    _buildButton("Waste Log", context, '/overview_page'),
                    const SizedBox(height: 20),
                    _buildButton("Tips/Fun facts", context, '/funfact_page'),
                  ],
                ),
              ),

              // Settings Icon at the bottom-left
              Align(
                alignment: Alignment.bottomLeft,
                child: IconButton(
                  icon: Image.asset('assets/icon/settings-icon.png', height: 75),
                  onPressed: () => _navigateToSettings(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper Function for Buttons
Widget _buildButton(String text, BuildContext context, [String? route]) {
  return SizedBox(
    width: double.infinity,
    height: 80,
    child: InkWell(
      onTap: () {
        if (text == "Bring me home") {
          Navigator.popUntil(context, (route) => route.isFirst);
        } else if (route != null && route.isNotEmpty) {
          Navigator.pushNamed(context, route);
        }
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/widgets/outlined-btn.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void _navigateToSettings(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SettingsPage()),
  );
}
