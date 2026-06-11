import 'package:flutter/material.dart';
import 'constants.dart';
import 'view_group_screen.dart'; 

class BrowseGroupsScreen extends StatefulWidget {
  const BrowseGroupsScreen({Key? key}) : super(key: key);

  @override
  State<BrowseGroupsScreen> createState() => _BrowseGroupsScreenState();
}

class _BrowseGroupsScreenState extends State<BrowseGroupsScreen> {
  List<int> joinedIndices = [];

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
        title: const Text('Available Groups', style: TextStyle(color: AppColors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Group',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                filled: true,
                fillColor: AppColors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 24),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: MockData.firebaseGroups.length + MockData.availableGroups.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> group;
                bool isMyCreatedGroup = false;

                // NISA: Read live data, then mock data
                if (index < MockData.firebaseGroups.length) {
                  group = MockData.firebaseGroups[index];
                  isMyCreatedGroup = true; 
                } else {
                  group = MockData.availableGroups[index - MockData.firebaseGroups.length];
                  isMyCreatedGroup = false; 
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: InkWell(
                    onTap: () {
                      // NISA: User can only set meeting on group they created
                      if (isMyCreatedGroup) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewGroupScreen(groupName: group['title']),
                          ),
                        ).then((_) => setState(() {})); 
                      } else {
                        // Notify user 
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('You can only manage and set meetings for groups you created! 🔒'),
                            backgroundColor: Colors.orange,
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(group['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                group['meetingDate'] ?? (isMyCreatedGroup ? 'No meeting set yet' : 'SAT, JUNE 13 7:00 PM UTC'),
                                style: const TextStyle(color: Colors.grey, fontSize: 11),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 14, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                group['meetingLocation'] ?? (isMyCreatedGroup ? 'No location set yet' : 'Library UniKL MIIT, KL'),
                                style: const TextStyle(color: Colors.grey, fontSize: 11),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (isMyCreatedGroup) {
                                    // Own group cannot join
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('You are the creator of this group!')),
                                    );
                                  } else {
                                    setState(() {
                                      if (joinedIndices.contains(index)) {
                                        joinedIndices.remove(index);
                                      } else {
                                        joinedIndices.add(index);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Successfully joined ${group['title']}! 🎉'),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      }
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isMyCreatedGroup 
                                      ? Colors.purple.shade200 
                                      : (joinedIndices.contains(index) ? Colors.grey.shade400 : AppColors.primaryPurple),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                                ),
                                child: Text(
                                  isMyCreatedGroup ? 'Creator' : (joinedIndices.contains(index) ? 'Joined ✓' : 'Join'), 
                                  style: const TextStyle(color: AppColors.white),
                                ),
                              ),
                              Row(
                                children: List.generate(4, (i) => const Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: CircleAvatar(radius: 12, backgroundColor: Colors.grey),
                                )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}