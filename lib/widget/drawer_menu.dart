import 'package:flutter/material.dart';
import '../main.dart';
import 'settings_page.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFFFB),
      body: SafeArea(
        child: Center(
          child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Right Close Icon
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, size: 35),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 10),

              // Menu Title (Styled like Settings Title)
              Center(
                child: Container(
                  width: 250,
                  height: 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
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
              ),
              const SizedBox(height: 30),

              // Navigation Buttons
              _buildButton("Home", context, () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp()),
                );
              }),
              _buildButton("Scan my waste", context, () {
                Navigator.pushNamed(context, '/scan_page');
              }),
              _buildButton("Waste Log", context, () {
                Navigator.pushNamed(context, '/overview_page');
              }),
              _buildButton("Tips/Fun facts", context, () {
                // Navigate to tips page if available
              }),

              const Spacer(),

              // Settings Icon at the Bottom Left
              Align(
                alignment: Alignment.bottomLeft,
                child: IconButton(
                  icon: Image.asset(
                    'assets/widgets/settings-icon.png',
                    width: 75,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        )
        
      ),
    );
  }

  // Reusable Button Widget
  Widget _buildButton(String text, BuildContext context, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: onPressed,
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
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  text,
                  style: const TextStyle(
                    fontFamily: 'RinsHandwriting',
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
