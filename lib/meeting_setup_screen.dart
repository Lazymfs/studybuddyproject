import 'package:cloud_firestore/cloud_firestore.dart'; 
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
  String? selectedLocation; 
  String selectedTime = "Click to select time (e.g. 14:00)"; 
  
  // 🚀 NISA: Mengambil tarikh real-time dari CalendarDatePicker
  DateTime realSelectedDate = DateTime.now(); 

  // 🚀 NISA: TAMBAH CONTROLLER INI UNTUK TANGKAP NAMA MEETING YANG KAU TAIP
  final TextEditingController titleController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    notesController.dispose();
    super.dispose();
  }

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
        title: const Text('Set Meeting', style: TextStyle(color: AppColors.white)),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Date & Time', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 8),
            Container(
              height: 260, 
              width: double.infinity,
              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16)),
              child: CalendarDatePicker(
                initialDate: realSelectedDate,
                firstDate: DateTime.now(),
                lastDate: DateTime(2030),
                onDateChanged: (DateTime value) {
                  setState(() {
                    realSelectedDate = value;
                  });
                },
              ),
            ),
            
            const SizedBox(height: 16),
            const Text('Time', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 8),
            
            // Menggunakan InkWell asal kawan kau untuk pilih jam
            InkWell(
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  setState(() {
                    selectedTime = pickedTime.format(context);
                  });
                }
              },
              child: IgnorePointer(
                child: CustomTextField(hintText: selectedTime),
              ),
            ),

            const SizedBox(height: 16),
            const Text('Location', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: selectedLocation,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
              hint: const Text('Choose your location', style: TextStyle(fontSize: 14)),
              icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primaryPurple),
              items: ['Library Level 12', 'Discussion Room A', 'Online - MS Teams'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(fontSize: 14)),
                );
              }).toList(),
              onChanged: (String? newValue) => setState(() => selectedLocation = newValue),
            ),
            const SizedBox(height: 16),

            Container(
              height: 200, 
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
              clipBehavior: Clip.hardEdge, 
              child: FlutterMap(
                options: const MapOptions(initialCenter: LatLng(3.1593, 101.7001), initialZoom: 15.0),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.study_buddy',
                  ),
                  const MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(3.1593, 101.7001),
                        width: 40,
                        height: 40,
                        child: Icon(Icons.location_on, color: AppColors.primaryPurple, size: 40),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            const Text('Meeting Title', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            // 🚀 NISA: Kita masukkan controller ke dalam CustomTextField kawan kau
            CustomTextField(
              hintText: 'e.g. Study + Q&A Session',
              controller: titleController,
            ),
            
            const Text('Notes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            CustomTextField(
              hintText: 'About this meeting...',
              controller: notesController,
            ),
            
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
                onPressed: () async {
                  // Format tarikh jadi teks bersih
                  String formattedDate = "${realSelectedDate.day}/${realSelectedDate.month}/${realSelectedDate.year}";
                  String finalTime = selectedTime.contains("Click") ? "14:00" : selectedTime;
                  String finalLoc = selectedLocation ?? 'Library UniKL MIIT';
                  
                  // 🚀 NISA: Kalau user tak taip apa-apa, kita bagi default name. Kalau dia taip, kita ambil teks real dia!
                  String finalTitle = titleController.text.trim().isEmpty 
                      ? 'Group Study Session' 
                      : titleController.text.trim();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Meeting Created Successfully! ✓'), backgroundColor: Colors.green),
                  );

                  // 🚀 SEKARANG FIREBASE AKAN IKUT NAMA YANG KAU TAIP!
                  try {
                    await FirebaseFirestore.instance.collection('meetings').add({
                      'title': finalTitle,
                      'date': formattedDate,
                      'time': finalTime,
                      'location': finalLoc,
                    });

                    // Masukkan ke local storage untuk My Schedule
                    MockData.firebaseMeetings.insert(0, {
                      'title': finalTitle,
                      'date': formattedDate,
                      'time': finalTime,
                      'location': finalLoc,
                    });
                  } catch (e) {
                    print("Error Firebase: $e");
                  }

                  // Pulangkan data ke skrin detail
                  Navigator.pop(context, {
                    'title': finalTitle,
                    'date': formattedDate,
                    'time': finalTime,
                    'location': finalLoc
                  });
                },
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