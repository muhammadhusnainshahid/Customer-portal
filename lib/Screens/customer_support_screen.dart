import 'package:flutter/material.dart';

class CustomerSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customer Support',
          style: TextStyle(
            color: Colors.white, // Set text color for AppBar title
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How can we help you?',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set text color to white
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: 28.0,
                    color: Colors.white, // Set icon color to white
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    'Phone: +923185417997',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Icon(
                    Icons.email,
                    size: 28.0,
                    color: Colors.white, // Set icon color to white
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    'Email: husnainshahid@gmail.com',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                'For any assistance, feel free to reach out to us via phone or email. We are here to help you with any issues or queries you may have.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white, // Set text color to white
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
