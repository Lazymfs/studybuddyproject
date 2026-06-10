import 'package:cloud_firestore/cloud_firestore.dart'; // NISA
import 'package:flutter/material.dart';
import 'constants.dart';
import 'custom_text_field.dart';
import 'view_group_screen.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({Key? key}) : super(key: key);

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  bool isPrivate = false;

  final TextEditingController _groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primaryPurple,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Create Your Group', style: TextStyle(color: AppColors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Group Photo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 8),
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primaryPurple, style: BorderStyle.solid), 
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, color: AppColors.primaryPurple),
                  SizedBox(height: 8),
                  Text('Upload group photo', style: TextStyle(color: AppColors.primaryPurple, fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('Group Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            CustomTextField(hintText: 'Enter group name', controller: _groupNameController),
            const Text('Subject', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const CustomTextField(hintText: 'Enter subject name'),
            const Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'What is this group about?',
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Private group (invite only)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                Switch(
                  value: isPrivate,
                  activeColor: Colors.yellow.shade700,
                  onChanged: (val) => setState(() => isPrivate = val),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primaryPurple),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Cancel', style: TextStyle(color: AppColors.primaryPurple)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Group Created Successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      String enteredGroupName = _groupNameController.text;
                      if (enteredGroupName.isEmpty) {
                        enteredGroupName = "My Custom Group";
                      }

                      try {
                        await FirebaseFirestore.instance.collection('study_groups').add({
                          'title': enteredGroupName,
                          'members': '1 member',
                        });
                      } catch (e) {
                        print("Firebase simpan error: $e");
                      }
                        
                      // 🚀 NISA: Masuk ke list gudang firebaseGroups (supaya muncul dekat skrin See All)
                      MockData.firebaseGroups.insert(0, {
                        'title': enteredGroupName, 
                        'members': '1 member',
                        'icon': Icons.group,
                      });
    
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewGroupScreen(groupName: enteredGroupName),
                        ),
                      ).then((_) {
                        Navigator.pop(context, true);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryPurple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Create', style: TextStyle(color: AppColors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}