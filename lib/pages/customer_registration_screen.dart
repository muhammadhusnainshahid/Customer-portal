import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // for date formatting

class CustomerRegistrationScreen extends StatefulWidget {
  @override
  _CustomerRegistrationScreenState createState() =>
      _CustomerRegistrationScreenState();
}

class _CustomerRegistrationScreenState
    extends State<CustomerRegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController registerKeyController = TextEditingController();
  final TextEditingController dealController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController expireDateController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    registerKeyController.dispose();
    dealController.dispose();
    businessNameController.dispose();
    expireDateController.dispose();
    super.dispose();
  }

  Future<void> _selectExpireDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        expireDateController.text = formattedDate; // Set the selected date
      });
    }
  }

  void registerCustomer(BuildContext context) {
    // Basic validation to ensure no field is empty
    if (nameController.text.isEmpty ||
        addressController.text.isEmpty ||
        phoneController.text.isEmpty ||
        registerKeyController.text.isEmpty ||
        dealController.text.isEmpty ||
        businessNameController.text.isEmpty ||
        expireDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    // Add customer to Firestore
    FirebaseFirestore.instance.collection('customers').add({
      'name': nameController.text,
      'address': addressController.text,
      'phone_number': phoneController.text,
      'register_key': registerKeyController.text,
      'deal': dealController.text,
      'business_name': businessNameController.text,
      'expire_date': expireDateController.text,
      'added_date': DateTime.now().toIso8601String(),
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Customer Registered Successfully')),
      );
      Navigator.pop(context); // Navigate back to the previous screen
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to register customer: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Registration'),
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
            children: [
              TextField(
                controller: nameController,
                style:
                    TextStyle(color: Colors.white), // Set text color to white
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.white), // Label color
                  prefixIcon:
                      Icon(Icons.person, color: Colors.white), // Icon color
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.white), // Underline color
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Focused underline color
                  ),
                ),
              ),
              TextField(
                controller: addressController,
                style:
                    TextStyle(color: Colors.white), // Set text color to white
                decoration: InputDecoration(
                  labelText: 'Address',
                  labelStyle: TextStyle(color: Colors.white), // Label color
                  prefixIcon:
                      Icon(Icons.home, color: Colors.white), // Icon color
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.white), // Underline color
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Focused underline color
                  ),
                ),
              ),
              TextField(
                controller: phoneController,
                style:
                    TextStyle(color: Colors.white), // Set text color to white
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(color: Colors.white), // Label color
                  prefixIcon:
                      Icon(Icons.phone, color: Colors.white), // Icon color
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.white), // Underline color
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Focused underline color
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: registerKeyController,
                style:
                    TextStyle(color: Colors.white), // Set text color to white
                decoration: InputDecoration(
                  labelText: 'Register Key',
                  labelStyle: TextStyle(color: Colors.white), // Label color
                  prefixIcon:
                      Icon(Icons.vpn_key, color: Colors.white), // Icon color
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.white), // Underline color
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Focused underline color
                  ),
                ),
              ),
              TextField(
                controller: dealController,
                style:
                    TextStyle(color: Colors.white), // Set text color to white
                decoration: InputDecoration(
                  labelText: 'Deal',
                  labelStyle: TextStyle(color: Colors.white), // Label color
                  prefixIcon:
                      Icon(Icons.business, color: Colors.white), // Icon color
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.white), // Underline color
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Focused underline color
                  ),
                ),
              ),
              TextField(
                controller: businessNameController,
                style:
                    TextStyle(color: Colors.white), // Set text color to white
                decoration: InputDecoration(
                  labelText: 'Business Name',
                  labelStyle: TextStyle(color: Colors.white), // Label color
                  prefixIcon:
                      Icon(Icons.store, color: Colors.white), // Icon color
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.white), // Underline color
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Focused underline color
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _selectExpireDate(context), // Open the date picker
                child: AbsorbPointer(
                  child: TextField(
                    controller: expireDateController,
                    style: TextStyle(
                        color: Colors.white), // Set text color to white
                    decoration: InputDecoration(
                      labelText: 'Expire Date',
                      hintText: 'YYYY-MM-DD',
                      hintStyle:
                          TextStyle(color: Colors.white70), // Hint text color
                      labelStyle: TextStyle(color: Colors.white), // Label color
                      prefixIcon: Icon(Icons.calendar_today,
                          color: Colors.white), // Icon color
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white), // Underline color
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white), // Focused underline color
                      ),
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => registerCustomer(context),
                child: Text('Register Customer'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.purple,
                  backgroundColor: Colors.white, // Text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CustomerRegistrationScreen(),
  ));
}
