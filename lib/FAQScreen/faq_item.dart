import 'package:flutter/material.dart';

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const FAQItem({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.purple.shade100,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.question,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.answer,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
