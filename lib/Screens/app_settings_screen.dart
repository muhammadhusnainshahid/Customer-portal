import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Import fluttertoast package

class AppSettingsScreen extends StatefulWidget {
  @override
  _AppSettingsScreenState createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  bool _pushNotifications = true;
  bool _applicationUpdate = true;
  bool _darkMode = false;

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App Settings',
          style: TextStyle(
            color: Colors.white, // Text color for AppBar title
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
            SwitchListTile(
              title: Text(
                'Push Notifications',
                style:
                    TextStyle(color: Colors.white), // Set text color to white
              ),
              value: _pushNotifications,
              onChanged: (bool value) {
                setState(() {
                  _pushNotifications = value;
                });
                // Show toast for push notifications
                _showToast(value
                    ? 'Push Notifications Enabled'
                    : 'Push Notifications Disabled');
              },
              activeColor: Colors.white, // Set the active switch color
              inactiveThumbColor:
                  Colors.grey, // Set the inactive switch thumb color
              inactiveTrackColor:
                  Colors.grey[700], // Set the inactive track color
            ),
            SwitchListTile(
              title: Text(
                'Application Update',
                style:
                    TextStyle(color: Colors.white), // Set text color to white
              ),
              value: _applicationUpdate,
              onChanged: (bool value) {
                setState(() {
                  _applicationUpdate = value;
                });
                // Show toast for application update
                _showToast('Your application is updated');
              },
              activeColor: Colors.white, // Set the active switch color
              inactiveThumbColor:
                  Colors.grey, // Set the inactive switch thumb color
              inactiveTrackColor:
                  Colors.grey[700], // Set the inactive track color
            ),
            SwitchListTile(
              title: Text(
                'Dark Mode',
                style:
                    TextStyle(color: Colors.white), // Set text color to white
              ),
              value: _darkMode,
              onChanged: (bool value) {
                setState(() {
                  _darkMode = value;
                });
                // Optionally show toast for dark mode
                _showToast(value ? 'Dark Mode Enabled' : 'Dark Mode Disabled');
              },
              activeColor: Colors.white, // Set the active switch color
              inactiveThumbColor:
                  Colors.grey, // Set the inactive switch thumb color
              inactiveTrackColor:
                  Colors.grey[700], // Set the inactive track color
            ),
          ],
        ),
      ),
    );
  }
}
