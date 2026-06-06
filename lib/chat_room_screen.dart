import 'package:flutter/material.dart';
import 'constants.dart';

class ChatRoomScreen extends StatelessWidget {
  final String chatName; // Passes the name of the person/group clicked

  const ChatRoomScreen({Key? key, required this.chatName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primaryPurple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(chatName, style: const TextStyle(color: AppColors.white)),
      ),
      body: Column(
        children: [
          // Empty space for fake messages
          Expanded(
            child: Center(
              child: Text('Chat history with $chatName will appear here', style: const TextStyle(color: Colors.grey)),
            ),
          ),
          
          // Bottom Message Input Bar
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: AppColors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Row(
              children: [
                const Icon(Icons.attach_file, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    autofocus: true, // THIS POPS THE KEYBOARD AUTOMATICALLY
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: AppColors.primaryPurple,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: AppColors.white, size: 18),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}