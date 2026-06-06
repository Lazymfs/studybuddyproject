import 'package:flutter/material.dart';
import 'constants.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87, // Dark theme like MS Teams
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Agenda', style: TextStyle(color: AppColors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('17 May Monday', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          _buildAgendaItem('13:30', '1 hr', 'Data Science Discussion', 'Library Level 12'),
          _buildAgendaItem('16:15', '1 hr 15m', 'Project Management Review', 'Online'),
          const SizedBox(height: 24),
          const Text('18 May Tuesday', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          _buildAgendaItem('09:30', '1 hr', 'Mobile App Mockup', 'Discussion Room A'),
        ],
      ),
    );
  }

  Widget _buildAgendaItem(String time, String duration, String title, String location) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(time, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 4),
                Text(duration, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Container(width: 2, height: 40, color: AppColors.primaryPurple, margin: const EdgeInsets.symmetric(horizontal: 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: AppColors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(location, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}