import 'package:flutter/material.dart';
import '../main.dart'; // Import main.dart to access MyApp.of(context)
import '../l10n/app_localizations.dart';

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

    Locale newLocale;
    switch (_selectedLanguage) {
      case 'EN':
        newLocale = Locale('en');
        break;
      case 'CN':
        newLocale = Locale('zh');
        break;
      case 'KOR':
        newLocale = Locale('ko');
        break;
      default:
        newLocale = Locale('en');
    }
    MyApp().setLocale(context, newLocale);
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
              Center(
                child: Text(
                  AppLocalizations.of(context).translate("settings"),
                  style: TextStyle(
                    fontFamily: 'Simpsonfont',
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Language Selection
              _buildSettingRow(
                label: AppLocalizations.of(context).translate("language"),
                value: _selectedLanguage,
                onLeftPress: () => _changeLanguage(false),
                onRightPress: () => _changeLanguage(true),
              ),

              const SizedBox(height: 20),

              // Location Selection
              _buildSettingRow(
                label: AppLocalizations.of(context).translate("location"),
                value: _selectedRegion,
                onLeftPress: () {},
                onRightPress: () {},
              ),

              const SizedBox(height: 20),

              // Notifications Toggle
              _buildSettingRow(
                label: AppLocalizations.of(context).translate("notifications"),
                value: _notificationsEnabled ? "On" : "Off",
                onLeftPress: () {},
                onRightPress: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingRow({
    required String label,
    required String value,
    required VoidCallback onLeftPress,
    required VoidCallback onRightPress,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 20)),
        Row(
          children: [
            IconButton(icon: Icon(Icons.arrow_left), onPressed: onLeftPress),
            Text(value),
            IconButton(icon: Icon(Icons.arrow_right), onPressed: onRightPress),
          ],
        ),
      ],
    );
  }
}
