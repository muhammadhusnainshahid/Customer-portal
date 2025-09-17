import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'language_provider.dart'; // Import your LanguageProvider

class LanguagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Languages'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('English'),
            onTap: () {
              languageProvider.setLocale('en');
            },
          ),
          ListTile(
            title: Text('Hindi'),
            onTap: () {
              languageProvider.setLocale('hi');
            },
          ),
          ListTile(
            title: Text('Urdu'),
            onTap: () {
              languageProvider.setLocale('ur');
            },
          ),
          ListTile(
            title: Text('Arabic'),
            onTap: () {
              languageProvider.setLocale('ar');
            },
          ),
        ],
      ),
    );
  }
}
