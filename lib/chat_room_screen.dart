import 'package:flutter/material.dart';
import 'constants.dart';

class ChatRoomScreen extends StatelessWidget {
  final String chatName; // Passes the name of the person/group clicked

  const ChatRoomScreen({Key? key, required this.chatName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    // --- NEW LOGIC: Dynamic Chat Text based on who you clicked ---
    String sentMsg = "Hey! Are we still on for the study session?";
    String receivedMsg = "Awesome, see you then! - $chatName";

    if (chatName == 'Paan') {
      sentMsg = "Did you update the UI for the login screen?";
      receivedMsg = "Bro, check the Figma";
    } else if (chatName == 'Wan') {
      sentMsg = "Are all the dart files ready for testing?";
      receivedMsg = "I will compile it tonight.";
    } else if (chatName == 'Asra') {
      sentMsg = "Did you find a good map placeholder?";
      receivedMsg = "Map screenshot added.";
    } else if (chatName == 'Study Group - Eng 101') {
      sentMsg = "What chapter is the test covering?";
      receivedMsg = "Chapters 4 and 5. Don't forget the notes!";
    } else if (chatName == 'Project Management') {
      sentMsg = "When is our next sprint review?";
      receivedMsg = "Meeting tomorrow at 3pm";
    }

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
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Sent Message (Purple Bubble)
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryPurple,
                      borderRadius: BorderRadius.circular(16).copyWith(bottomRight: const Radius.circular(0)), 
                    ),
                    child: Text(
                      sentMsg, // USING DYNAMIC TEXT
                      style: const TextStyle(color: AppColors.white),
                    ),
                  ),
                ),

                // Received Message (White Bubble)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16).copyWith(bottomLeft: const Radius.circular(0)),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                    ),
                    child: Text(
                      receivedMsg, 
                      style: const TextStyle(color: Colors.black87), 
                    ),
                  ),
                ),
              ],
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
                    autofocus: true, // Pop keyboard
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