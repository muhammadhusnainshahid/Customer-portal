import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Today Update',
      'timestamp': DateTime.now().subtract(Duration(hours: 1))
    },
    {
      'title': 'Yesterday Update',
      'timestamp': DateTime.now().subtract(Duration(days: 1))
    },
    {
      'title': 'Booking Successful',
      'timestamp': DateTime.now().subtract(Duration(minutes: 30))
    },
    // Add more notifications here with different timestamps
  ];

  String _formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays} day(s) ago';
    } else if (duration.inHours > 0) {
      return '${duration.inHours} hour(s) ago';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes} minute(s) ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
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
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            final timestamp = notification['timestamp'] as DateTime;
            final duration = DateTime.now().difference(timestamp);

            return ListTile(
              title: Text(
                notification['title'],
                style: TextStyle(
                  color: Colors.white, // Title text color
                ),
              ),
              subtitle: Text(
                _formatDuration(duration),
                style: TextStyle(
                  color: Colors.white70, // Subtitle text color
                ),
              ),
              leading: Icon(
                Icons.notifications,
                color: Colors.deepPurpleAccent,
              ),
            );
          },
        ),
      ),
    );
  }
}
