import 'package:flutter/material.dart';
import 'constants.dart';
import 'meeting_setup_screen.dart';

class ViewGroupScreen extends StatefulWidget {
  final String groupName; 

  const ViewGroupScreen({Key? key, required this.groupName}) : super(key: key);

  @override
  State<ViewGroupScreen> createState() => _ViewGroupScreenState();
}

class _ViewGroupScreenState extends State<ViewGroupScreen> {
  bool meetingSet = false; 
  
  // 🚀 NISA: Menyimpan maklumat real-time untuk paparan kad kawan kau
  String liveDateText = "No meeting scheduled yet";
  String liveLocationText = "No location set";

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
           Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                const CircleAvatar(radius: 40, backgroundColor: AppColors.white, child: Icon(Icons.science, size: 40, color: AppColors.primaryPurple)),
                const SizedBox(height: 16),
                Text(widget.groupName, style: const TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                const Text('1 Member', style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          const Icon(Icons.calendar_today, size: 16, color: Colors.grey), 
                          const SizedBox(width: 8), 
                          // 🚀 NISA: Guna data REAL-TIME pilihan user
                          Text(liveDateText, style: TextStyle(color: meetingSet ? AppColors.primaryPurple : Colors.grey, fontWeight: meetingSet ? FontWeight.bold : FontWeight.normal))
                        ]),
                        const SizedBox(height: 12),
                        Row(children: [
                          const Icon(Icons.location_on, size: 16, color: Colors.grey), 
                          const SizedBox(width: 8), 
                          // 🚀 NISA: Guna data REAL-TIME pilihan lokasi
                          Text(liveLocationText, style: TextStyle(color: meetingSet ? Colors.black87 : Colors.grey))
                        ]),
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
                  
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: meetingSet ? AppColors.white : AppColors.primaryPurple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.primaryPurple, style: BorderStyle.solid),
                    ),
                    child: Column(
                      children: [
                        Icon(meetingSet ? Icons.check_circle : Icons.calendar_today, color: meetingSet ? Colors.green : AppColors.primaryPurple, size: 32),
                        const SizedBox(height: 8),
                        Text(meetingSet ? 'Meeting Ready!' : 'No meeting yet!', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        const SizedBox(height: 16),
                        
                        if (!meetingSet) 
                          ElevatedButton(
                            onPressed: () async {
                              // 🚀 Tangkap data real-time map/date/time dari screen sebelah
                              final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const MeetingSetupScreen()));
                              
                              if (result != null && result is Map<String, String>) {
                                setState(() {
                                  meetingSet = true;
                                  liveDateText = "${result['date']} @ ${result['time']}";
                                  liveLocationText = result['location']!;
                                  
                                  // Update juga ke dalam list See All global supaya tersimpan live
                                  if (MockData.firebaseGroups.isNotEmpty) {
                                    MockData.firebaseGroups[0]['meetingDate'] = liveDateText;
                                    MockData.firebaseGroups[0]['meetingLocation'] = liveLocationText;
                                  }
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryPurple, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
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