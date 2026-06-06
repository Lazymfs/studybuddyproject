import 'chat_room_screen.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primaryPurple,
        elevation: 0,
        title: const Text('Messages', style: TextStyle(color: AppColors.white)),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: 5,
        separatorBuilder: (context, index) => Divider(color: Colors.grey.shade300, indent: 72),
        itemBuilder: (context, index) {
          // Dummy data for chats
          List<String> names = ['Study Group - Eng 101', 'Paan', 'Wan', 'Asra', 'Project Management'];
          List<String> messages = ['Don\'t forget the notes!', 'Bro, check the Figma', 'I will compile it tonight.', 'Map screenshot added.', 'Meeting tomorrow at 3pm'];
          
          return ListTile(
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.yellow.shade700,
              child: const Icon(Icons.person, color: AppColors.primaryPurple),
            ),
            title: Text(names[index], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(messages[index], maxLines: 1, overflow: TextOverflow.ellipsis),
            trailing: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('10:45 AM', style: TextStyle(fontSize: 10, color: Colors.grey)),
                SizedBox(height: 4),
                Icon(Icons.circle, size: 12, color: AppColors.primaryPurple), // Unread indicator
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatRoomScreen(chatName: names[index]),
                ),
               );
              }, // Would open chat room
            );
          },
      ),
    );
  }
}