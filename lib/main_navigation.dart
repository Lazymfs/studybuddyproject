import 'package:flutter/material.dart';
import 'constants.dart';
import 'home_screen.dart';
import 'schedule_screen.dart'; // The new Agenda tab
import 'messages_screen.dart'; // The new WhatsApp-style tab
import 'profile_screen.dart';
import 'create_group_screen.dart';

class MainNavigation extends StatefulWidget {
  final String username; // 1. Add this variable

  // 2. Require it in the constructor
  const MainNavigation({Key? key, this.username = "User"}) : super(key: key); 

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // 3. Move your _screens list INSIDE the build method so it can access 'widget.username'
    final List<Widget> _screens = [
      HomeScreen(username: widget.username), // Passing it to Home
      const ScheduleScreen(),
      const MessagesScreen(),
      ProfileScreen(username: widget.username), // Passing it to Profile
    ];
    return Scaffold(
      backgroundColor: AppColors.creamBackground,
      body: _screens[_currentIndex],
      
      // The FAB only appears if you are on the Home (0) or Schedule (1) tabs
      floatingActionButton: (_currentIndex == 0 || _currentIndex == 1) 
          ? FloatingActionButton(
              onPressed: () {
                // Pushes Create Group to full screen (hides nav bar)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateGroupScreen()),
                );
              },
              backgroundColor: AppColors.primaryPurple,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              child: const Icon(Icons.add, color: AppColors.white, size: 28),
            )
          : null, // Hides the button on other tabs
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      
      bottomNavigationBar: BottomAppBar(
        color: AppColors.creamBackground,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        elevation: 0,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home_outlined, color: _currentIndex == 0 ? AppColors.primaryPurple : Colors.grey),
                onPressed: () => setState(() => _currentIndex = 0),
              ),
              IconButton(
                icon: Icon(Icons.calendar_today_outlined, color: _currentIndex == 1 ? AppColors.primaryPurple : Colors.grey),
                onPressed: () => setState(() => _currentIndex = 1),
              ),
              const SizedBox(width: 48), // Space for FAB
              IconButton(
                icon: Icon(Icons.chat_bubble_outline, color: _currentIndex == 2 ? AppColors.primaryPurple : Colors.grey),
                onPressed: () => setState(() => _currentIndex = 2),
              ),
              IconButton(
                icon: Icon(Icons.person_outline, color: _currentIndex == 3 ? AppColors.primaryPurple : Colors.grey),
                onPressed: () => setState(() => _currentIndex = 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}