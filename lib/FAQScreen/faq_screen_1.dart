// import 'package:AAG/Pages/loading.dart';
import 'package:AAG/FAQScreen/faq_item.dart';
import 'package:AAG/TicketHistoryScreen/tickethistory.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "CHAT & SUPPORT",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 102, 44, 144),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Text(
                'FAQ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    Text(
                      'Subscription and Plans',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    FAQItem(
                      question: 'How can I check my current subscription plan?',
                      answer:
                          'Visit the "Subscription Page" to view your current plan details, including validity, features, and cost.',
                    ),
                    FAQItem(
                      question: ' Can I upgrade my subscription plan?',
                      answer:
                          'Yes, go to the "Subscription Page," explore other plans, and select the desired plan. Confirm payment to activate it.',
                    ),
                    FAQItem(
                      question:
                          'What happens to my plan if I upgrade mid-cycle?',
                      answer:
                          'The new plan activates immediately, and the remaining balance from your current plan is adjusted against the new plan cost.',
                    ),
                    FAQItem(
                      question: 'Can I downgrade or cancel my subscription?',
                      answer:
                          'Yes, you can manage your plan from the "Subscription Page." Downgrades or cancellations will take effect at the end of your current billing cycle.',
                    ),
                    FAQItem(
                      question:
                          'How are the monthly and annual plan costs different?',
                      answer:
                          'Monthly plans are billed monthly, while annual plans offer a discounted rate for upfront payment and a year-long validity.w',
                    ),
                    const SizedBox(height: 16),

                    //
                    Text(
                      'AAG Wallet and Earnings',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    FAQItem(
                      question: 'How is my target revenue determined?',
                      answer:
                          'Your target revenue is calculated based on your subscription plan, activity, and participation metrics.',
                    ),
                    FAQItem(
                      question:
                          'What is the minimum balance required to request a withdrawal?',
                      answer:
                          'You must achieve at least 50% of your target revenue to be eligible for a withdrawal request.',
                    ),
                    FAQItem(
                      question:
                          'Can I withdraw my earnings in multiple transactions?',
                      answer:
                          'Yes, but your withdrawals are subject to meeting the minimum balance criteria and cannot exceed the available eligible amount.',
                    ),
                    FAQItem(
                      question:
                          'Are there any charges for withdrawing earnings?',
                      answer:
                          'No, withdrawals are free. However, ensure your AAG Wallet balance meets the eligibility criteria.',
                    ),
                    FAQItem(
                      question:
                          'How long does it take for a withdrawal request to process?',
                      answer:
                          'Withdrawal requests are processed within 2-5 business days, depending on your payment method and bank.',
                    ),
                    const SizedBox(height: 16),

                    //
                    Text(
                      'General Queries and Support',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    FAQItem(
                      question: 'How do I contact customer support?',
                      answer:
                          'Use the "Support" option in the app menu to reach out to our customer service team.',
                    ),
                    FAQItem(
                      question:
                          'Are there any tutorials or guides for using the app?',
                      answer:
                          'Yes, check the "Help" section in the menu for video tutorials, guides, and FAQs.',
                    ),

                    // "Still Having An Issue?" section with left alignment
                    const SizedBox(
                      height: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Still Having An Issue?',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),
                    // Left-aligned Chat With Us button with updated styling
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TicketHistoryScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                        ),
                        child: const Text(
                          'Chat With Us',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16), // Added bottom padding
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
