import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms and Conditions',
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
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms and Conditions',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Text color
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Welcome to our customer portal. By using our services, you agree to the following terms and conditions:',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white, // Text color
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '1. Account Registration:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Text color
                ),
              ),
              Text(
                'All users must register an account to access our services. You are responsible for maintaining the confidentiality of your account information.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white, // Text color
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '2. User Responsibilities:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Text color
                ),
              ),
              Text(
                'Users must provide accurate and up-to-date information. Any misuse of the portal will result in account suspension or termination.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white, // Text color
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '3. Payment:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Text color
                ),
              ),
              Text(
                'All fees associated with the services must be paid in full at the time of purchase. We accept various payment methods for your convenience.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white, // Text color
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '4. Cancellation Policy:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Text color
                ),
              ),
              Text(
                'Cancellations must be made at least 48 hours in advance to avoid any fees. Please refer to our cancellation policy for more details.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white, // Text color
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '5. Service Availability:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Text color
                ),
              ),
              Text(
                'We strive to keep the portal available at all times but cannot guarantee uninterrupted access. We may schedule maintenance or updates as needed.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white, // Text color
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '6. Privacy:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Text color
                ),
              ),
              Text(
                'We are committed to protecting your privacy. Please review our Privacy Policy for more information on how we collect and use your data.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white, // Text color
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '7. Additional Terms:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Text color
                ),
              ),
              Text(
                'Additional terms and conditions may apply. Please refer to our full terms for the complete list of terms and conditions.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white, // Text color
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Thank you for using our customer portal. If you have any questions or concerns, please contact our support team.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white, // Text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
