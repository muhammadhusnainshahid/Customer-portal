import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, String>> getUserDetails() async {
    User? user = _auth.currentUser;
    if (user != null) {
      // Fetch user details from Firebase Auth
      return {
        'name': user.displayName ?? '',
        'email': user.email ?? '',
      };
    } else {
      // Handle the case where the user is not logged in
      return {
        'name': '',
        'email': '',
      };
    }
  }

  Future<void> _logout(BuildContext context) async {
    try {
      await _auth.signOut(); // Sign out from Firebase Auth
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Clear all user details from SharedPreferences

      // Navigate to the login screen after logout
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      // Handle any errors
      print("Logout Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: getUserDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final userDetails = snapshot.data!;
          return Drawer(
            child: Container(
              color:
                  Colors.deepPurple, // Match background color with login/signup
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 89, 0, 255),
                          Color.fromARGB(255, 255, 183, 77),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 30,
                          child: Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.deepPurple,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Hello, ${userDetails['name']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${userDetails['email']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildListTile(
                      context, 'App Settings', '/app_settings', Icons.settings),
                  _buildListTile(context, 'Customer Support',
                      '/customer_support', Icons.support),
                  _buildListTile(
                      context, 'Edit Profile', '/edit_profile', Icons.edit),
                  _buildListTile(
                      context, 'Languages', '/languages', Icons.language),
                  _buildListTile(context, 'Notifications', '/notifications',
                      Icons.notifications),
                  _buildListTile(context, 'Profile', '/profile', Icons.person),
                  _buildListTile(context, 'Rate Us', '/rate_us', Icons.star),
                  _buildListTile(context, 'Terms & Conditions',
                      '/terms_conditions', Icons.info),
                  ListTile(
                    leading: Icon(Icons.logout,
                        color: Colors.red,
                        size: 30), // Beautiful icon with size
                    title: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    onTap: () {
                      _logout(context);
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  ListTile _buildListTile(
      BuildContext context, String title, String routeName, IconData iconData) {
    return ListTile(
      leading: Icon(iconData, color: Colors.white),
      title: Text(
        title,
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
    );
  }
}
