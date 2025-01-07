import 'package:flutter/material.dart';

class AddBankAccount extends StatefulWidget {
  const AddBankAccount({super.key});

  @override
  State<AddBankAccount> createState() => _AddBankAccountState();
}

class _AddBankAccountState extends State<AddBankAccount> {
  String? selectedBank;
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController confirmAccountController =
      TextEditingController();
  final TextEditingController holderNameController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();

  final List<String> banks = [
    'HDFC Bank',
    'State Bank of India',
    'ICICI Bank',
    'Axis Bank',
    'Kotak Mahindra Bank',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Add Bank Account',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 102, 44, 144),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Colors.grey.shade100),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDropdown(),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: accountNumberController,
                        label: 'Account Number',
                        hint: 'Enter account number',
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: ifscController,
                        label: 'IFSC Code',
                        hint: 'Enter IFSC code',
                        textCapitalization: TextCapitalization.characters,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: confirmAccountController,
                        label:
                            'For Security Purpose please Confirm\nAccount Number',
                        hint: 'Re-enter account number',
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: holderNameController,
                        label: 'Account Holder Name',
                        hint: 'Enter account holder name',
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: nicknameController,
                        label: 'QuickName (Optional)',
                        hint: 'Quick Name for the account',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.purple.shade50,
                      Colors.purple.shade50.withOpacity(0.5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.purple.shade100),
                ),
                child: Row(
                  children: [
                    Icon(Icons.lock, color: Colors.purple[700]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Your bank details are encrypted and secure with us',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 146, 29, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Link Bank Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Bank',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              value: selectedBank,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                border: InputBorder.none,
              ),
              hint: const Text('Select your bank'),
              items: banks.map((String bank) {
                return DropdownMenuItem<String>(
                  value: bank,
                  child: Text(bank),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedBank = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          textCapitalization: textCapitalization,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 102, 44, 144)),
            ),
          ),
        ),
      ],
    );
  }
}
