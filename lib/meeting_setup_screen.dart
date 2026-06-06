import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'constants.dart';
import 'custom_text_field.dart';

class MeetingSetupScreen extends StatefulWidget {
  const MeetingSetupScreen({Key? key}) : super(key: key);

  @override
  State<MeetingSetupScreen> createState() => _MeetingSetupScreenState();
}

class _MeetingSetupScreenState extends State<MeetingSetupScreen> {
  bool setReminder = true;
  bool notifyMembers = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primaryPurple,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: AppColors.white),
        title: const Text('Set Meeting', style: TextStyle(color: AppColors.white)),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Date & Time', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 8),
            // Mock Calendar UI
            Container(
              height: 260, 
              width: double.infinity,
              decoration: BoxDecoration(
              color: AppColors.white, 
              borderRadius: BorderRadius.circular(16)
            ),
              child: CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2030),
              onDateChanged: (DateTime value) {},
            ),
            ),
            const Text('Location', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 8),

          // --- NEW DROPDOWN MENU ---
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
                ),
              ),
              hint: const Text('Choose your location', style: TextStyle(fontSize: 14)),
              icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primaryPurple),
              items: ['Library Level 12', 'Discussion Room A', 'Online - MS Teams'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(fontSize: 14)),
                );
              }).toList(),
              onChanged: (String? newValue) {
    // Dropdown logic goes here
                },
            ),
            const SizedBox(height: 16),
// --- KEEP YOUR EXISTING MAP CONTAINER HERE ---

// This container holds your new real interactive map
Container(
  height: 200, // Made it a bit taller so it's easier to view
  width: double.infinity,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16),
  ),
  clipBehavior: Clip.hardEdge, // Keeps the live map rounded within your UI
  child: FlutterMap(
    options: MapOptions(
      // Centered near Kuala Lumpur / UniKL MIIT area
      initialCenter: LatLng(3.1593, 101.7001), 
      initialZoom: 15.0,
    ),
    children: [
      // This fetches the actual live map tiles
      TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'com.example.study_buddy',
      ),
      // This drops a physical purple pin onto the coordinates
      MarkerLayer(
        markers: [
          Marker(
            point: LatLng(3.1593, 101.7001),
            width: 40,
            height: 40,
            child: const Icon(
              Icons.location_on,
              color: AppColors.primaryPurple,
              size: 40,
            ),
          ),
        ],
      ),
    ],
  ),
),
const SizedBox(height: 16),
            const SizedBox(height: 16),
            const Text('Meeting Title', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const CustomTextField(hintText: 'e.g. Study + Q&A Session'),
            const Text('Notes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const CustomTextField(hintText: 'About this meeting...'),
            
            // Toggles
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Set Reminder', style: TextStyle(fontWeight: FontWeight.bold)),
                Switch(value: setReminder, activeColor: Colors.yellow.shade700, onChanged: (val) => setState(() => setReminder = val)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Notify All Members', style: TextStyle(fontWeight: FontWeight.bold)),
                Switch(value: notifyMembers, activeColor: Colors.yellow.shade700, onChanged: (val) => setState(() => notifyMembers = val)),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Confirm ✓', style: TextStyle(color: AppColors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}