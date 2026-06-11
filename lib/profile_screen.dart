import 'package:flutter/material.dart';
import 'constants.dart';
import 'login_screen.dart'; 

class ProfileScreen extends StatelessWidget {
  final String username; // ADD THIS
  final String email; // 1. Add email variable

  const ProfileScreen({
    Key? key, 
    required this.username, 
    required this.email // 2. Require it
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.primaryPurple,
      body: Stack(
        children: [
          // Header Text
          const Positioned(
            top: 60,
            left: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('My Profile', style: TextStyle(color: AppColors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                Text('Manage your account', style: TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),

          // Bottom Cream (Curved Container)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.75,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.creamBackground,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                children: [
                  // Profile Icon
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.yellow.shade700,
                    child: const Icon(Icons.person_outline, size: 50, color: AppColors.primaryPurple),
                  ),
                  const SizedBox(height: 16),
                  Text('Buddy $username', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryPurple)),
                  Text(email, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 40),

                  // Menu Buttons
                  _ProfileMenuButton(title: 'Edit Profile', icon: Icons.person_outline, onTap: () {}),
                  const SizedBox(height: 16),
                  _ProfileMenuButton(title: 'Settings', icon: Icons.settings_outlined, onTap: () {}),
                  const SizedBox(height: 16),
                  _ProfileMenuButton(title: 'Log Out', icon: Icons.logout, isDestructive: true, onTap: () {
                    // This wipes the navigation history and sends them to the Login Screen
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (route) => false,
                    );
                   }
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

// Reusable widget for the profile menu items
class _ProfileMenuButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDestructive;

  const _ProfileMenuButton({
    required this.title,
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: isDestructive ? Colors.redAccent : AppColors.primaryPurple),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDestructive ? Colors.redAccent : Colors.black87, 
              ),
            ),
            const Spacer(),
            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}