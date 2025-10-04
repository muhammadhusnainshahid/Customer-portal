import 'package:flutter/material.dart';

class InvoiceSummaryScreen extends StatelessWidget {
  final double totalPay;
  final double currentPay;
  final double remainingPay;
  final String nextInstallmentDate;
  final String personName;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Summary'),
        backgroundColor: Colors.deepPurpleAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            buildSummaryTile('Customer Name', personName),
            buildSummaryTile('Email', email),
            buildSummaryTile('Total Paid Balance', totalPay.toStringAsFixed(2)),
            buildSummaryTile('Current Paid', currentPay.toStringAsFixed(2)),
            buildSummaryTile('Remaining Pay', remainingPay.toStringAsFixed(2)),
            buildSummaryTile('Next Payment Date', nextInstallmentDate),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepPurpleAccent,
                ),
                child: const Text(
                  'Back to List',
                  style:
                      TextStyle(fontSize: 18, color: Colors.deepPurpleAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSummaryTile(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.deepPurple,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
