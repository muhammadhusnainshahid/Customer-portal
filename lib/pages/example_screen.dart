import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:customer_portal/screens/languages_screen.dart'; // Adjusted import path
import 'package:customer_portal/language_provider.dart'; // Adjusted import path

class ExampleScreen extends StatefulWidget {
  @override
  _ExampleScreenState createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Example Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Language: ${_getLanguageName(languageProvider.locale.languageCode)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final selectedLanguage = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LanguagesScreen(),
                  ),
                );
                if (selectedLanguage != null) {
                  setState(() {
                    // Update the displayed language name based on the selection
                  });
                }
              },
              child: Text('Choose Language'),
            ),
          ],
        ),
      ),
    );
  }

  String _getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'hi':
        return 'Hindi';
      case 'ur':
        return 'Urdu';
      case 'ar':
        return 'Arabic';
      default:
        return 'English';
    }
  }
}
