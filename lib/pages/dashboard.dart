import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'payment_log_screen.dart';
import 'installment_plan_screen.dart';

class AccountDashboardScreen extends StatefulWidget {
  @override
  _AccountDashboardScreenState createState() => _AccountDashboardScreenState();
}

class _AccountDashboardScreenState extends State<AccountDashboardScreen> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = [
    AccountDashboardScreenContent(),
    InstallmentPlanScreen(),
    PaymentLogScreen(),
    Container(), // Optionally add another page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Customer Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20, // You can adjust the size as needed
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        elevation: 0,
      ),
      drawer: AppDrawer(),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 3) {
            _scaffoldKey.currentState?.openDrawer();
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Installment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Payment Log',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomerRegistrationScreen(),
            ),
          );
        },
        child: Icon(Icons.person_add),
        backgroundColor: Colors.deepPurpleAccent,
      ),
    );
  }
}

class AccountDashboardScreenContent extends StatefulWidget {
  @override
  _AccountDashboardScreenContentState createState() =>
      _AccountDashboardScreenContentState();
}

class _AccountDashboardScreenContentState
    extends State<AccountDashboardScreenContent> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  double advanceBalance = 0.0;
  double udhaarBalance = 0.0;
  double totalPayment = 0.0;
  double remainingPayment = 0.0;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
    fetchBalances();
    calculatePayments();
  }

  void fetchBalances() async {
    DocumentSnapshot balanceSnapshot = await FirebaseFirestore.instance
        .collection('balances')
        .doc('balanceDoc')
        .get();

    if (balanceSnapshot.exists) {
      setState(() {
        advanceBalance = balanceSnapshot['advance_balance'] ?? 0.0;
        udhaarBalance = balanceSnapshot['udhaar_balance'] ?? 0.0;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;

        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16.0 : 24.0, vertical: 8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.search, color: Colors.deepPurpleAccent),
                    hintText: 'Search by name or phone number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(color: Colors.deepPurpleAccent),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16.0 : 24.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: _buildBalanceCard(
                          'Advance Balance', advanceBalance, Colors.green),
                    ),
                    SizedBox(width: isMobile ? 0 : 16.0),
                    Expanded(
                      child: _buildBalanceCard(
                          'Udhaar Balance', udhaarBalance, Colors.orange),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16.0 : 24.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: _buildPaymentCard(
                          'Total Payment', totalPayment, Colors.blue),
                    ),
                    SizedBox(width: isMobile ? 0 : 16.0),
                    Expanded(
                      child: _buildPaymentCard(
                          'Remaining Payment', remainingPayment, Colors.red),
                    ),
                  ],
                ),
              ),
          
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: isMobile ? 16.0 : 24.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('customers')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final customers = snapshot.data!.docs.where((doc) {
                      final customer = doc.data() as Map<String, dynamic>;
                      final name = customer['name']?.toLowerCase() ?? '';
                      final phoneNumber =
                          customer['phone_number']?.toLowerCase() ?? '';
                      return name.contains(_searchQuery) ||
                          phoneNumber.contains(_searchQuery);
                    }).toList();
                    return ListView.builder(
                      shrinkWrap: true, // Add this to prevent overflow
                      itemCount: customers.length,
                      itemBuilder: (context, index) {
                        final customer =
                            customers[index].data() as Map<String, dynamic>;
                        return CustomerCard(
                          name: customer['name'] ?? 'N/A',
                          phone: customer['phone_number'] ?? 'N/A',
                          registerKey: customer['register_key'] ?? 'N/A',
                          addedDate: customer['added_date'] ?? 'N/A',
                          deal: customer.containsKey('deal')
                              ? customer['deal']
                              : 'N/A',
                          businessName: customer.containsKey('business_name')
                              ? customer['business_name']
                              : 'N/A',
                          expireDate: customer.containsKey('expire_date')
                              ? customer['expire_date']
                              : 'N/A',
                          onDelete: () {
                            FirebaseFirestore.instance
                                .collection('customers')
                                .doc(customers[index].id)
                                .delete()
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Customer deleted')),
                              );
                            }).catchError((error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Failed to delete customer: $error')),
                              );
                            });
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBalanceCard(String title, double amount, Color color) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    
          SizedBox(height: 8),
          Text(
            'Rs. $amount',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(String title, double amount, Color color) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Rs. $amount',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomerCard extends StatelessWidget {
  final String name;
  final String phone;
  final String registerKey;
  final String addedDate;
  final String deal;
  final String businessName;
  final String expireDate;
  final VoidCallback onDelete;

 
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.person),
          backgroundColor: Colors.deepPurpleAccent,
          foregroundColor: Colors.white,
        ),
        title: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.phone, size: 16, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                    child:
                        Text('Phone: $phone', style: TextStyle(fontSize: 14))),
              ],
            ),
            Row(
              children: [
                Icon(Icons.vpn_key, size: 16, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                    child: Text('Register Key: $registerKey',
                        style: TextStyle(fontSize: 14))),
              ],
            ),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                    child: Text('Added Date: $addedDate',
                        style: TextStyle(fontSize: 14))),
              ],
            ),
            Row(
              children: [
                Icon(Icons.local_offer, size: 16, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                    child: Text('Deal: $deal', style: TextStyle(fontSize: 14))),
              ],
            ),

            ),
            Row(
              children: [
                Icon(Icons.date_range, size: 16, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                    child: Text('Expire Date: $expireDate',
                        style: TextStyle(fontSize: 14))),
              ],
            ),
          ],
        ),
        isThreeLine: true,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomerDetailScreen(
                name: name,
                phone: phone,
                registerKey: registerKey,
                addedDate: addedDate,
                deal: deal,
                businessName: businessName,
                expireDate: expireDate,
              ),
            ),
          );
        },
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}

class CustomerDetailScreen extends StatelessWidget {
  final String name;
  final String phone;
  final String registerKey;
  final String addedDate;
  final String deal;
  final String businessName;
  final String expireDate;

  const CustomerDetailScreen({
    Key? key,
    required this.name,
    required this.phone,
    required this.registerKey,
    required this.addedDate,
    required this.deal,
    required this.businessName,
    required this.expireDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.phone, size: 24, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                    child:
                        Text('Phone: $phone', style: TextStyle(fontSize: 18))),
              ],

            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.local_offer, size: 24, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                    child: Text('Deal: $deal', style: TextStyle(fontSize: 18))),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.business, size: 24, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                    child: Text('Business Name: $businessName',
                        style: TextStyle(fontSize: 18))),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.date_range, size: 24, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                    child: Text('Expire Date: $expireDate',
                        style: TextStyle(fontSize: 18))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PdfViewerScreen extends StatelessWidget {
  final Uint8List pdfData;

  const PdfViewerScreen({Key? key, required this.pdfData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Report'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: PDFView(
        pdfData: pdfData,
        enableSwipe: true,
        pageSnap: true,
        fitPolicy: FitPolicy.BOTH,
      ),
    );
  }
}
