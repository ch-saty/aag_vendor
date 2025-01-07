import 'package:flutter/material.dart';

class TopInviteesSection extends StatelessWidget {
  const TopInviteesSection({super.key});

  Widget _buildTopInvitee(String imagePath, String amount, String rank) {
    return Column(
      children: [
        Stack(
          children: [
            // Profile Image Container
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.amber, width: 2),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Rank Badge
            Positioned(
              left: -4,
              bottom: -4,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  rank,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          amount,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage('lib/images/refer.png'),
          fit: BoxFit.cover,
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.6),
            Colors.black.withOpacity(0.9),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'TOP INVITEES',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 45),
          // Top Invitees Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildTopInvitee('lib/images/a.png', '₹1,50,000', '2'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildTopInvitee('lib/images/b.png', '₹2,00,000', '1'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTopInvitee('lib/images/e.jpeg', '₹1,00,000', '3'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
