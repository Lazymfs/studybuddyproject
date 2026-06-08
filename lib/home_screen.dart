import 'package:flutter/material.dart';
import 'constants.dart';
import 'group_card.dart';

class HomeScreen extends StatelessWidget {
  final String username; // ADD THIS

  const HomeScreen({Key? key, required this.username}) : super(key: key); // UPDATE THIS

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.creamBackground, // Base background color
      child: Column(
        children: [
          // Purple Header
          Container(
            padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 32),
            decoration: const BoxDecoration(
              color: AppColors.primaryPurple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'Hi 👋\nBuddy $username',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.yellow.shade700,
                      child: const Icon(Icons.notifications, color: AppColors.primaryPurple),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Search Bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search group',
                    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    prefixIcon: const Icon(Icons.search, color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Available Groups',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('See all', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // Grid of Group Cards
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85,
                    children: const [
                      GroupCard(
                        title: 'Eng 101 Study for Exam',
                        members: '29 members',
                        icon: Icons.menu_book,
                      ),
                      GroupCard(
                        title: 'Project Management',
                        members: '15 members',
                        icon: Icons.group_work,
                      ),
                      GroupCard(
                        title: 'LAB MDC Mobile',
                        members: '20 members',
                        icon: Icons.phone_android,
                      ),
                      GroupCard(
                        title: 'CTF for beginners',
                        members: '18 members',
                        icon: Icons.flag,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}