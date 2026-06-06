import 'package:flutter/material.dart';
import 'constants.dart';
import 'meeting_setup_screen.dart';

class ViewGroupScreen extends StatelessWidget {
  const ViewGroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.primaryPurple,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Header details
          const Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                CircleAvatar(radius: 40, backgroundColor: AppColors.white, child: Icon(Icons.group, size: 40, color: AppColors.primaryPurple)),
                SizedBox(height: 16),
                Text('Project Data Science', style: TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                Text('1 Member', style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),

          // Bottom Content Container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.65,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.creamBackground,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16)),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [Icon(Icons.calendar_today, size: 16, color: Colors.grey), SizedBox(width: 8), Text('No meeting scheduled yet', style: TextStyle(color: Colors.grey))]),
                        SizedBox(height: 12),
                        Row(children: [Icon(Icons.location_on, size: 16, color: Colors.grey), SizedBox(width: 8), Text('No location set', style: TextStyle(color: Colors.grey))]),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('Members', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      CircleAvatar(backgroundColor: Colors.grey, child: Icon(Icons.person, color: AppColors.white)),
                      SizedBox(width: 16),
                      CircleAvatar(backgroundColor: AppColors.white, child: Icon(Icons.add, color: AppColors.primaryPurple)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text('Upcoming Meeting', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  
                  // The "Set Now" container
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.primaryPurple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.primaryPurple, style: BorderStyle.solid),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.calendar_today, color: AppColors.primaryPurple, size: 32),
                        const SizedBox(height: 8),
                        const Text('No meeting yet!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // Pushes the Set Meeting page full screen
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const MeetingSetupScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryPurple,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          child: const Text('Set now', style: TextStyle(color: AppColors.white)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}