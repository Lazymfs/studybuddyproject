import 'package:flutter/material.dart';

class AppColors {
  // Using the hex codes from your theme
  static const Color primaryPurple = Color(0xFF4B1F6F);
  static const Color creamBackground = Color(0xFFEDE4DC);
  static const Color white = Colors.white;
  static const Color textDark = Color(0xFF333333);
}

class MockData {
  // This acts as a shared database for your mockup
  static List<Map<String, dynamic>> availableGroups = [
    {'title': 'Eng 101 Study for Exam', 'members': '29 members', 'icon': Icons.menu_book},
    {'title': 'Project Management', 'members': '15 members', 'icon': Icons.group_work},
    {'title': 'LAB MDC Mobile', 'members': '20 members', 'icon': Icons.phone_android},
    {'title': 'CTF for beginners', 'members': '18 members', 'icon': Icons.flag},
  ];
}