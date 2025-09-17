import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, String>> getUserDetails() async {
    User? user = _auth.currentUser;
    if (user != null) {
      // Fetch user details from Firebase Auth
      return {
        'name': user.displayName ?? 'User Name',
        'email': user.email ?? 'user@example.com',
      };
    } else {
      // Handle the case where the user is not logged in
      return {
        'name': 'User Name',
        'email': 'user@example.com',
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
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
        child: FutureBuilder<Map<String, String>>(
          future: getUserDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error fetching user data'));
            }

            final userDetails = snapshot.data ??
                {'name': 'User Name', 'email': 'user@example.com'};

            return ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(
                    userDetails['name'] ?? 'User Name',
                    style: TextStyle(
                        color: Colors.white), // Account name text color
                  ),
                  accountEmail: Text(
                    userDetails['email'] ?? 'user@example.com',
                    style: TextStyle(
                        color: Colors.white70), // Account email text color
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150',
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent, // Header background color
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.edit, color: Colors.deepPurpleAccent),
                  title: Text('Edit Profile',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushNamed(context, '/edit_profile');
                  },
                ),
                ListTile(
                  leading:
                      Icon(Icons.notifications, color: Colors.deepPurpleAccent),
                  title: Text('Notifications',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushNamed(context, '/notifications');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.language, color: Colors.deepPurpleAccent),
                  title:
                      Text('Languages', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushNamed(context, '/languages');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.deepPurpleAccent),
                  title: Text('App Settings',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushNamed(context, '/app_settings');
                  },
                ),
                ListTile(
                  leading:
                      Icon(Icons.description, color: Colors.deepPurpleAccent),
                  title: Text('Terms and Conditions',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushNamed(context, '/terms_conditions');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.support, color: Colors.deepPurpleAccent),
                  title: Text('Customer Support',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushNamed(context, '/customer_support');
                  },
                ),
                ListTile(
                  leading:
                      Icon(Icons.rate_review, color: Colors.deepPurpleAccent),
                  title: Text('Rate Us', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushNamed(context, '/rate_us');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.deepPurpleAccent),
                  title: Text('Logout', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // Implement logout functionality here
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
