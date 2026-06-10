import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryPurple = Color(0xFF6A1B9A);
  static const Color creamBackground = Color(0xFFF5F5F0);
  static const Color white = Colors.white;
}

class MockData {
  static List<Map<String, dynamic>> availableGroups = [
    {
      'title': 'Eng 101 Study for Exam',
      'members': '29 members',
      'date': 'SAT, JUNE 13 7:00 PM UTC',
      'location': 'Library UniKL MIIT, KL',
      'icon': Icons.book,
    },
    {
      'title': 'LAB MDC Mobile',
      'members': '20 members',
      'date': 'SAT, JUNE 13 7:00 PM UTC',
      'location': 'Library UniKL MIIT, KL',
      'icon': Icons.phone_android,
    },
    {
      'title': 'Project Management',
      'members': '15 members',
      'date': 'SAT, JUNE 13 7:00 PM UTC',
      'location': 'Library UniKL MIIT, KL',
      'icon': Icons.bubble_chart,
    },
    {
      'title': 'CTF for beginners',
      'members': '18 members',
      'date': 'SAT, JUNE 13 7:00 PM UTC',
      'location': 'Library UniKL MIIT, KL',
      'icon': Icons.flag,
    },
  ];

  // 🚀 NISA: Stor simpanan untuk data live dari Firebase
  static List<Map<String, dynamic>> firebaseGroups = [];
  static List<Map<String, dynamic>> firebaseMeetings = [];

  // Mock data asal untuk Schedule kawan kau
  static List<Map<String, dynamic>> mockMeetings = [
    {
      'title': 'Mobile Dev Discussion',
      'date': '13 June Saturday',
      'time': '10:00 AM',
      'location': 'Discussion Room A',
    },
    {
      'title': 'UI/UX Review Session',
      'date': '15 June Monday',
      'time': '2:30 PM',
      'location': 'Library Level 12',
    }
  ];
}