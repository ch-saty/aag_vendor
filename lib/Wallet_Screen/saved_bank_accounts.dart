// ignore_for_file: deprecated_member_use

import 'package:AAG/Wallet_Screen/add_bank_account.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SavedAccountsScreen extends StatelessWidget {
  const SavedAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "SAVED BANK ACCOUNTS",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 102, 44, 144),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSearchBar(),
                const SizedBox(height: 16),
                _buildAccountCard(
                  'HDFC Bank',
                  'Savings Account',
                  'Anand Mahindra',
                  '****4582',
                ),
                const SizedBox(height: 16),
                _buildAccountCard(
                  'ICICI Bank',
                  'Current Account',
                  'Anand Mahindra',
                  '****7891',
                ),
              ],
            ),
          ),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search accounts',
          prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildAccountCard(
    String bankName,
    String accountType,
    String ownerName,
    String accountNumber,
  ) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () => _showAccountDetails(
            context, bankName, accountType, ownerName, accountNumber),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          FontAwesomeIcons.bank,
                          color: Color.fromARGB(255, 102, 44, 144),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bankName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            accountType,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.grey),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ownerName,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    accountNumber,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAccountDetails(
    BuildContext context,
    String bankName,
    String accountType,
    String ownerName,
    String accountNumber,
  ) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Main Bottom Sheet
            StatefulBuilder(
              builder: (context, setState) {
                bool isDefault = false;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: MediaQuery.of(context).size.height * 0.75,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Header
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 102, 44, 144),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$bankName Details',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Content
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 12 : 20,
                              vertical: isSmallScreen ? 12 : 20,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Bank Icon
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.blue[50],
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    FontAwesomeIcons.bank,
                                    size: 40,
                                    color: Color.fromARGB(255, 102, 44, 144),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Bank Details
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildDetailItem('Bank Name', bankName),
                                    _buildDetailItem(
                                        'Account Holder', ownerName),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildDetailItem('Account Number',
                                        accountNumber.replaceAll('*', '68'))
                                  ],
                                ),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildDetailItem(
                                        'IFSC Code', 'HDFC0001234'),
                                  ],
                                ),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildDetailItem(
                                        'Account Type', accountType),
                                  ],
                                ),
                                const SizedBox(height: 16),

                                // Default Account Checkbox
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey[200]!),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: isDefault,
                                        onChanged: (value) {
                                          setState(() {
                                            isDefault = value!;
                                          });
                                        },
                                        activeColor: const Color.fromARGB(
                                            255, 102, 44, 144),
                                      ),
                                      const Text(
                                        'Set as default bank account to pay',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Save Button
                                InkWell(
                                  onTap: () {
                                    // Handle save changes
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color:
                                          const Color.fromRGBO(255, 146, 29, 1),
                                    ),
                                    child: const Text(
                                      'SAVE CHANGES',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Floating Close Button
            Positioned(
              top: -50,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF712FA0),
                          Color(0xFF362F91),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Add Account',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddBankAccount()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 146, 29, 1),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock,
                size: 12,
                color: Colors.green,
              ),
              const SizedBox(width: 4),
              Text(
                'Encrypted by SHA-256',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

  // Widget _buildCircularButton(IconData icon) {
  //   return Container(
  //     width: 48,
  //     height: 48,
  //     decoration: BoxDecoration(
  //       color: Colors.grey[100],
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: IconButton(
  //       icon: Icon(icon, color: Colors.grey[600]),
  //       onPressed: () {},
  //     ),
  //   );
  // }

  // Widget _buildFilterButtons() {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Row(
  //         children: [
  //           FilterButton(
  //             text: 'All Accounts',
  //             isSelected: true,
  //             onPressed: () {},
  //           ),
  //           FilterButton(
  //             text: 'Personal',
  //             isSelected: false,
  //             onPressed: () {},
  //           ),
  //           FilterButton(
  //             text: 'Business',
  //             isSelected: false,
  //             onPressed: () {},
  //           ),
  //           FilterButton(
  //             text: 'Joint',
  //             isSelected: false,
  //             onPressed: () {},
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }


// class FilterButton extends StatelessWidget {
//   final String text;
//   final bool isSelected;
//   final VoidCallback onPressed;

//   const FilterButton({
//     super.key,
//     required this.text,
//     required this.isSelected,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 8),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: isSelected
//               ? const Color.fromARGB(255, 102, 44, 144)
//               : Colors.white,
//           foregroundColor: isSelected ? Colors.white : Colors.grey[600],
//           side: isSelected ? null : BorderSide(color: Colors.grey[200]!),
//         ),
//         child: Text(text),
//       ),
//     );
//   }
// }
