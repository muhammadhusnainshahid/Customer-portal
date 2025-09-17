import 'package:flutter/material.dart';

class LanguagesScreen extends StatefulWidget {
  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  String _selectedLanguage = 'English'; // Default selected language

  void _changeLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
    // Implement language change functionality here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Languages',
          style: TextStyle(
            color: Colors.deepPurpleAccent, // Text color for AppBar title
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent, // AppBar background color
        elevation: 0, // Remove shadow
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 89, 0, 255), // Gradient start color
              Color.fromARGB(255, 255, 183, 77), // Gradient end color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            _buildLanguageTile('English', Icons.language, Colors.blue),
            _buildLanguageTile('Hindi', Icons.language, Colors.orange),
            _buildLanguageTile('Urdu', Icons.language, Colors.green),
            _buildLanguageTile('Arabic', Icons.language, Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageTile(String language, IconData icon, Color color) {
    final bool isSelected = _selectedLanguage == language;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
        size: 30,
      ),
      title: Text(
        language,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 18,
          color: isSelected ? Colors.deepPurpleAccent : Colors.white,
        ),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: Colors.deepPurpleAccent,
            )
          : null,
      onTap: () => _changeLanguage(language),
      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      tileColor: isSelected
          ? Colors.deepPurpleAccent.withOpacity(0.1)
          : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
