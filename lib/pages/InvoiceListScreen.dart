import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'invoice_summary_screen.dart';

class InvoiceListScreen extends StatefulWidget {
  @override
  _InvoiceListScreenState createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen> {
  double totalPayment = 0.0;
  double remainingPayment = 0.0;

  @override
  void initState() {
    super.initState();
    calculatePayments();
  }

  void calculatePayments() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('invoices').get();

    double total = 0.0;
    double remaining = 0.0;

    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      total += (data['totalPay'] ?? 0.0) as double;
      remaining += (data['remainingPay'] ?? 0.0) as double;
    }

    setState(() {
      totalPayment = total;
      remainingPayment = remaining;
    });
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Confirm Delete'),
              content:
                  const Text('Are you sure you want to delete this invoice?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice List'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          // Display the total and remaining payments
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Payment: \$${totalPayment.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Text(
                  'Remaining Payment: \$${remainingPayment.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('invoices').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No invoices found.'));
                }

                final invoices = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: invoices.length,
                  itemBuilder: (context, index) {
                    final invoice =
                        invoices[index].data() as Map<String, dynamic>;

                    final personName = invoice['personName'] ?? 'Unknown';
                    final totalPay = (invoice['totalPay'] ?? 0.0) as double;
                    final currentPay = (invoice['currentPay'] ?? 0.0) as double;
                    final remainingPay =
                        (invoice['remainingPay'] ?? 0.0) as double;
                    final nextInstallmentDate =
                        invoice['nextInstallmentDate'] ?? 'N/A';
                    final email =
                        invoice['email'] ?? 'N/A'; // Retrieve the email
                    final invoiceId = invoices[index].id; // Get the document ID

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          title: Text(
                            personName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.blueAccent,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Text(
                                'Total Paid: \$${totalPay.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                'Current Paid: \$${currentPay.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                'Remaining Pay: \$${remainingPay.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Next Payment Date: $nextInstallmentDate',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.redAccent),
                                onPressed: () async {
                                  bool confirmed =
                                      await _confirmDelete(context);
                                  if (confirmed) {
                                    await FirebaseFirestore.instance
                                        .collection('invoices')
                                        .doc(invoiceId)
                                        .delete();
                                    // Recalculate the payments after deletion
                                    calculatePayments();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Invoice deleted')),
                                    );
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.arrow_forward_ios,
                                    color: Colors.blueAccent),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          InvoiceSummaryScreen(
                                        totalPay: totalPay,
                                        currentPay: currentPay,
                                        remainingPay: remainingPay,
                                        nextInstallmentDate:
                                            nextInstallmentDate,
                                        personName: personName,
                                        email: email,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
