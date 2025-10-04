import 'package:customer_portal/pages/InvoiceListScreen.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class PaymentLogScreen extends StatefulWidget {
  @override
  _PaymentLogScreenState createState() => _PaymentLogScreenState();
}

class _PaymentLogScreenState extends State<PaymentLogScreen> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _image = pickedImage;
        });
      }
    } catch (e) {
      print('Error picking image from gallery: $e');
    }
  }

  Future<void> _takePhotoWithCamera() async {
    try {
      final XFile? takenPhoto =
          await _picker.pickImage(source: ImageSource.camera);
      if (takenPhoto != null) {
        setState(() {
          _image = takenPhoto;
        });
      }
    } catch (e) {
      print('Error taking photo with camera: $e');
    }
  }

  Future<void> _deleteTransaction() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this transaction?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        _image = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Transaction deleted successfully')),
      );
    }
  }

  Future<void> _shareOnWhatsApp() async {
    const message = "Payment details: Amount - \$100, Date - 01/01/2024";
    final url = 'whatsapp://send?text=$message';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('WhatsApp not installed or cannot be launched')),
      );
    }
  }

  void _showTotalGeneratedInvoice() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InvoiceListScreen()),
    );
  }

  Future<void> _showTotalEmailReceived() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('emails').get();
    final emails = snapshot.docs;

    if (emails.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No emails found')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Total Emails Received"),
          content: SingleChildScrollView(
            child: Column(
              children: emails.map((doc) {
                final email = doc['email'];
                final docId = doc.id;

                return ListTile(
                  title: Text(email),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('emails')
                          .doc(docId)
                          .delete();
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Transaction'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF5900FF), // Gradient start color
              Color(0xFFFFB74D), // Gradient end color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Customer will receive SMS with edited information',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.photo_library),
                  label: Text('Upload From Gallery'),
                  onPressed: _pickImageFromGallery,
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.camera),
                  label: Text('Take Photo With Camera'),
                  onPressed: _takePhotoWithCamera,
                ),
              ],
            ),
            SizedBox(height: 16),
            if (_image != null)
              Image.file(
                File(_image!.path),
                height: 200,
                width: 200,
              ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _showTotalGeneratedInvoice,
                  child: Text('Total Generated Invoice'),
                ),
                ElevatedButton(
                  onPressed: _showTotalEmailReceived,
                  child: Text('Total Email Received'),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: _shareOnWhatsApp,
              child: Text('Share on WhatsApp'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PaymentLogScreen(),
  ));
}
