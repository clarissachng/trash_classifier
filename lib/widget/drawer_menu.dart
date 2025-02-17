import 'package:flutter/material.dart';
import '../main.dart';
import 'settings_page.dart'; // Import the settings page

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          // Menu Title with Plain Background
          const SizedBox(
            height: 100, // Height of the title section
            child: Center(
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 28, // Larger font size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                // Home Button (Black Background)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8, // Add some vertical padding
                    horizontal: 16,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF262626), // Black background
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, // Increased vertical padding
                        horizontal: 16,
                      ),
                      title: const Center(
                        child: Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 24, // Increased font size
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // White text
                          ),
                        ),
                      ),
                      onTap: () {
                        // Handle "Home" button tap
                        Navigator.pop(context); // Close the drawer
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MyApp()),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Space between items
                
                // Using Helper Function for Buttons
                _buildButton("Scan my waste", context, '../screens/scan_page'),
                _buildButton("Waste Log", context, '../overview_page'),
                _buildButton("Tips/Fun facts", context),

                const SizedBox(height: 20), // Space below the last item
              ],
            ),
          ),
          // Settings Icon at the Bottom Left
          Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(16.0),
            child: IconButton(
              icon: Image.asset(
                'assets/icon/settings-icon.png', // Path to your custom icon
                width: 75, // Adjust the size as needed
                height: 75,
              ),
              onPressed: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



// Helper Function for Buttons
Widget _buildButton(String text, BuildContext context, [String? route]) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0), // Increased vertical padding
    child: SizedBox(
      width: double.infinity,
      height: 80, // Increased height for larger buttons
      child: InkWell(
        onTap: () {
          if (route != null && route.isNotEmpty) {
            Navigator.pushNamed(context, route);
          }
        },
        child: Stack(
          children: [
            // Use your image as the button background
            Positioned.fill(
              child: Image.asset(
                'assets/widgets/outlined-btn.png', // Ensure this file exists
                fit: BoxFit.cover,
              ),
            ),
            // Center the text with increased padding
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0), // Increased padding
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold, // Optional: Add bold text
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
