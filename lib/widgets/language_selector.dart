import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class LanguageSelector extends StatelessWidget {
  final Function(Locale) onLanguageChanged;
  final Locale currentLocale;

  const LanguageSelector({
    Key? key,
    required this.onLanguageChanged,
    required this.currentLocale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String languageCode) {
        onLanguageChanged(Locale(languageCode));
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'en',
          child: Row(
            children: [
              Text('English'),
              if (currentLocale.languageCode == 'en')
                Icon(Icons.check, color: Colors.green),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'zh',
          child: Row(
            children: [
              Text('中文'),
              if (currentLocale.languageCode == 'zh')
                Icon(Icons.check, color: Colors.green),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'ko',
          child: Row(
            children: [
              Text('한국어'),
              if (currentLocale.languageCode == 'ko')
                Icon(Icons.check, color: Colors.green),
            ],
          ),
        ),
      ],
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.language),
            SizedBox(width: 8),
            Text(AppLocalizations.of(context).translate('languageSettings')),
          ],
        ),
      ),
    );
  }
}
