import 'package:flutter/material.dart';
import 'drawer_menu.dart'; // Import the drawer menu

void main() {
  runApp(SettingsApp());
}

class SettingsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'RinsHandwriting', // Ensure this font is loaded
        scaffoldBackgroundColor: Color(0xFFFEFFFB), // Off-white background
      ),
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _selectedLanguage = 'EN';
  String _selectedRegion = 'Europe';
  bool _notificationsEnabled = true;

  final List<String> _languages = ['EN', 'CN', 'KOR'];
  final List<String> _regions = ['Europe', 'Asia', 'America', 'Africa'];

  void _changeLanguage(bool next) {
    setState(() {
      int currentIndex = _languages.indexOf(_selectedLanguage);
      _selectedLanguage = _languages[(currentIndex + (next ? 1 : -1)) % _languages.length];
    });
  }

  void _changeRegion(bool next) {
    setState(() {
      int currentIndex = _regions.indexOf(_selectedRegion);
      _selectedRegion = _regions[(currentIndex + (next ? 1 : -1)) % _regions.length];
    });
  }

  void _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });
  }

  void _navigateToDrawer(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DrawerMenu()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Right Menu Icon
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Image.asset(
                    'assets/widgets/menu-icon.png', // Ensure you have this image
                    width: 75,
                  ),
                  onPressed: () => _navigateToDrawer(context), // Call your function here
                ),
              ),

              const SizedBox(height: 10),

              // Settings Title (Black Button)
              Center(
                child: // Trash Classifier Text
                  Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/widgets/black-btn.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const SizedBox(
                      child: Center(
                      child: Text(
                        "Settings",
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
              ),

              const SizedBox(height: 30),

              // Language Selection
              _buildSettingRow(
                label: "Language",
                value: _selectedLanguage,
                onLeftPress: () => _changeLanguage(false),
                onRightPress: () => _changeLanguage(true),
              ),

              const SizedBox(height: 20),

              // Location Selection
              _buildSettingRow(
                label: "Location",
                value: _selectedRegion,
                onLeftPress: () => _changeRegion(false),
                onRightPress: () => _changeRegion(true),
              ),

              const SizedBox(height: 20),

              // Notifications Toggle
              _buildSettingRow(
                label: "Notifications",
                value: _notificationsEnabled ? "On" : "Off",
                onLeftPress: () => _toggleNotifications(!_notificationsEnabled),
                onRightPress: () => _toggleNotifications(!_notificationsEnabled),
              ),

              const SizedBox(height: 40),

              // Send Feedback Button
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    // Feedback action here
                  },
                  child: const Text(
                    "SEND FEEDBACK",
                    style: TextStyle(
                      fontFamily: 'RinsHandwriting',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Bottom Left Gear Icon
              Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  'assets/widgets/settings-icon.png', // Ensure this image is available
                  width: 75,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to Build Each Setting Row
  Widget _buildSettingRow({
    required String label,
    required String value,
    required VoidCallback onLeftPress,
    required VoidCallback onRightPress,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'RinsHandwriting',
            fontSize: 35,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_left, size: 20),
              onPressed: onLeftPress,
            ),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'RinsHandwriting',
                fontSize: 35,
                decoration: TextDecoration.underline,
                color: Colors.black,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_right, size: 20),
              onPressed: onRightPress,
            ),
          ],
        ),
      ],
    );
  }
}
