import 'package:flutter/material.dart';

class ReceivePaymentScreen extends StatelessWidget {
  final String installmentData;

  // Constructor to accept data
  const ReceivePaymentScreen({Key? key, required this.installmentData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receive Payment'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Installment Data: $installmentData', // Display the data
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              // Add validation and controller as needed
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'Payment Method'),
              // Add validation and controller as needed
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle payment submission logic
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Payment Received')),
                );
                // Navigate back to Payment Log screen
                Navigator.pop(context);
              },
              child: Text('Receive Payment'),
            ),
          ]),
        ),
      ),
    );
  }
}
