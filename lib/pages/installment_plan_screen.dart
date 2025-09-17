import 'package:customer_portal/pages/InvoiceListScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // Platform check for web

class InstallmentPlanScreen extends StatefulWidget {
  const InstallmentPlanScreen({Key? key}) : super(key: key);

  @override
  _InstallmentPlanScreenState createState() => _InstallmentPlanScreenState();
}

class _InstallmentPlanScreenState extends State<InstallmentPlanScreen> {
  final TextEditingController totalPayController = TextEditingController();
  final TextEditingController currentPayController = TextEditingController();
  final TextEditingController nextInstallmentDateController =
      TextEditingController();
  final TextEditingController personNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  double remainingPay = 0.0;

  void calculateRemainingPay() {
    double totalPay = double.tryParse(totalPayController.text) ?? 0.0;
    double currentPay = double.tryParse(currentPayController.text) ?? 0.0;
    setState(() {
      remainingPay = totalPay - currentPay;
    });
  }

  Future<void> saveInvoiceToFirebase({
    required double totalPay,
    required double currentPay,
    required double remainingPay,
    required String nextInstallmentDate,
    required String personName,
    required String email,
  }) async {
    try {
      CollectionReference invoices =
          FirebaseFirestore.instance.collection('invoices');
      await invoices.add({
        'totalPay': totalPay,
        'currentPay': currentPay,
        'remainingPay': remainingPay,
        'nextInstallmentDate': nextInstallmentDate,
        'personName': personName,
        'email': email,
        'createdAt': Timestamp.now(),
      });
    } catch (e) {
      print('Error saving invoice: $e');
    }
  }

  Future<void> sendInvoice() async {
    String nextInstallmentDate = nextInstallmentDateController.text;
    String personName = personNameController.text;
    String email = emailController.text;

    if (nextInstallmentDate.isNotEmpty &&
        personName.isNotEmpty &&
        email.isNotEmpty &&
        validateEmail(email)) {
      await saveInvoiceToFirebase(
        totalPay: double.tryParse(totalPayController.text) ?? 0.0,
        currentPay: double.tryParse(currentPayController.text) ?? 0.0,
        remainingPay: remainingPay,
        nextInstallmentDate: nextInstallmentDate,
        personName: personName,
        email: email,
      );

      // Platform check for web or mobile
      if (kIsWeb) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Invoice Created (Email not supported on Web)')),
        );
      } else {
        // Attempt to send email
        try {
          await sendEmailNotification(email, nextInstallmentDate, personName);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invoice Created and Email Sent')),
          );
        } catch (e) {
          print('Failed to send email: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Invoice Created, but failed to send email.')),
          );
        }
      }

      // Navigate to the next screen (InvoiceListScreen)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => InvoiceListScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill in all fields with valid data.')),
      );
    }
  }

  bool validateEmail(String email) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }

  Future<void> sendEmailNotification(
      String email, String nextInstallmentDate, String personName) async {
    final Email sendEmail = Email(
      body:
          'Dear $personName, your next installment is due on $nextInstallmentDate.',
      subject: 'Installment Reminder',
      recipients: [email],
      isHTML: false,
    );

    await FlutterEmailSender.send(sendEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Installment Plan'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF5900FF), // Gradient start color
              Color(0xFFFFB74D), // Gradient end color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            buildListTile(Icons.person, 'Customer Name', personNameController,
                TextInputType.text),
            const SizedBox(height: 16),
            buildListTile(Icons.attach_money, 'Total Paid Balance',
                totalPayController, TextInputType.number),
            const SizedBox(height: 16),
            buildListTile(Icons.money_off, 'Current Paid', currentPayController,
                TextInputType.number),
            const SizedBox(height: 16),
            buildListTile(Icons.email, 'Email', emailController,
                TextInputType.emailAddress),
            const SizedBox(height: 16),
            buildDatePicker(context),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: sendInvoice,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blueAccent,
                ),
                child: const Text(
                  'Generate Invoice and Send Alert',
                  style: TextStyle(fontSize: 18, color: Colors.blueAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListTile(IconData icon, String label,
      TextEditingController controller, TextInputType keyboardType) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        onChanged: label == 'Total Paid Balance' || label == 'Current Paid'
            ? (value) => calculateRemainingPay()
            : null,
      ),
    );
  }

  Widget buildDatePicker(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.date_range, color: Colors.white),
      title: TextFormField(
        controller: nextInstallmentDateController,
        decoration: InputDecoration(
          labelText: 'Next Payment Date',
          labelStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_today, color: Colors.white),
            onPressed: () => _selectNextInstallmentDate(context),
          ),
        ),
        readOnly: true,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  void _selectNextInstallmentDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        nextInstallmentDateController.text =
            DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  void dispose() {
    totalPayController.dispose();
    currentPayController.dispose();
    nextInstallmentDateController.dispose();
    personNameController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
