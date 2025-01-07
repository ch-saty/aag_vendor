// import 'package:AAG/tobeadded/plancard.dart';
import 'package:AAG/Wallet_Screen/add_bank_account.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool isBalanceVisible = false;
  final List<Transaction> transactions = [
    Transaction("Debited", "Today, 5:30 PM", -320.00),
    Transaction("Credited", "23/12/2024, 3:15 PM", 850.00),
    Transaction("Debited", "22/12/2024, 1:20 PM", -150.00),
    Transaction("Credited", "22/12/2024, 6:45 PM", 1200.00),
    Transaction("Debited", "22/12/2024, 2:30 PM", -450.00),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "My Wallet ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 102, 44, 144),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(
            //   height: 20,
            // ),
            _buildHeader(),
            _buildTransactionForm(),
            _buildRecentActivities(),
          ],
        ),
      ),
      // bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white, // Deep Purple
            Colors.white,
            Colors.white, // Purple
          ],
          stops: [0.0, 0.5, 1.0], // Optional: control color distribution
        ),
        // color: Color.fromARGB(255, 102, 44, 144),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(8),
          // top: Radius.circular(8)
        ),
      ),
      child: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     GestureDetector(
          //         onTap: () {
          //           Navigator.of(context).pop();
          //         },
          //         child: Icon(Icons.arrow_back, color: Colors.white)),
          //   ],
          // ),
          // const SizedBox(
          //   height: 16,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const Text(
          //       'My Wallet',
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 24,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     SizedBox(
          //       width: 8,
          //     ),
          //     // Expanded(
          //     //   child: Container(
          //     //     margin: const EdgeInsets.symmetric(horizontal: 10),
          //     //     decoration: BoxDecoration(
          //     //       color: Colors.grey.withOpacity(0.3),
          //     //       borderRadius: BorderRadius.circular(8),
          //     //     ),
          //     //     child: Center(
          //     //       child: TextField(
          //     //         style: const TextStyle(color: Colors.white),
          //     //         decoration: InputDecoration(
          //     //           hintText: 'Search',
          //     //           hintStyle: const TextStyle(color: Colors.white70),
          //     //           border: InputBorder.none,
          //     //           contentPadding: const EdgeInsets.symmetric(
          //     //               horizontal: 16, vertical: 8),
          //     //           suffixIcon: IconButton(
          //     //             icon: const Icon(Icons.search, color: Colors.white),
          //     //             onPressed: () {
          //     //               // Search action
          //     //             },
          //     //           ),
          //     //         ),
          //     //       ),
          //     //     ),
          //     //   ),
          //     // ),
          //   ],
          // ),
          // const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Balance',
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        isBalanceVisible ? '₹95,512.00' : '********',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isBalanceVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color.fromRGBO(255, 146, 29, 1),
                          size: 16,
                        ),
                        onPressed: () {
                          setState(() {
                            isBalanceVisible = !isBalanceVisible;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.fingerprint,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),

          // const SizedBox(height: 8),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     // CustomCard(address: '', name: 'Satyam', packageType: 'Standard'),
          //     GestureDetector(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => const AddBankAccount()),
          //           );
          //         },
          //         child: _buildActionButtons()),
          //   ],
          // ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCard(
                  'HDFC Bank',
                  '**** **** **** 4589',
                  'John Doe',
                  '0055',
                ),
                const SizedBox(width: 20),
                _buildCard(
                  'Yes Bank',
                  '**** **** **** 7821',
                  'John Doe',
                  '4585',
                ),
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddBankAccount()),
                          );
                        },
                        child: _buildActionButtons()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String type, String number, String holder, String ifsc) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey[900]!, Colors.grey[800]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/images/chip_64.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                type,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Text(
            'Account Number',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Card Holder',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    holder,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'IFSC',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    ifsc,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionButton(Icons.add_circle, 'Add Bank'),
          // _buildActionButton(Icons.arrow_circle_down, 'Withdraw'),
          // _buildActionButton(Icons.swap_horiz, 'Transfer'),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: Colors.black),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildTransactionForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Amount',
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                // borderSide: BorderSide.none,
                // borderSide: BorderSide.
              ),
            ),
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: 'Choose Bank',
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
            items: const [
              DropdownMenuItem(value: 'HDFC Bank', child: Text('HDFC Bank')),
              DropdownMenuItem(value: 'YES Bank', child: Text('YES Bank')),
              // DropdownMenuItem(value: 'self', child: Text('Self')),
            ],
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(255, 146, 29, 1),
              minimumSize: const Size(150, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {},
            child: const Text(
              'Withdraw',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivities() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Activities',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return Column(
                children: [
                  _buildTransactionItem(transaction),
                  if (index != transactions.length - 1)
                    const SizedBox(
                        height:
                            8), // Add space after each item except the last one
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Transaction transaction) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        // margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    transaction.amount > 0
                        ? Icons.arrow_downward
                        : Icons.arrow_upward,
                    color: transaction.amount > 0 ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.type,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      transaction.date,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              '${transaction.amount > 0 ? '' : ''}₹${transaction.amount.abs().toStringAsFixed(2)}',
              style: TextStyle(
                color: transaction.amount > 0 ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildBottomNavBar() {
  //   return BottomNavigationBar(
  //     type: BottomNavigationBarType.fixed,
  //     selectedItemColor: Colors.black,
  //     unselectedItemColor: Colors.grey,
  //     showUnselectedLabels: true,
  //     items: const [
  //       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
  //       BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.add_circle_outline, size: 30),
  //         label: '',
  //       ),
  //       BottomNavigationBarItem(
  //           icon: Icon(Icons.notifications), label: 'Alerts'),
  //       BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  //     ],
  //     onTap: (index) {},
  //   );
  // }
}

class Transaction {
  final String type;
  final String date;
  final double amount;

  Transaction(this.type, this.date, this.amount);
}
