import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; 
import 'package:studybuddyproject/onboarding_screen.dart';
import 'onboarding_screen.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase using data from google-services.json
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBONgtWzCXPdD3c-QbY1vdDbD-qXb6Jvis", 
      appId: "1:756101904251:android:828b23e7d45d44b6ca2fde",   
      messagingSenderId: "756101904251",   
      projectId: "studybuddyproject-group3l02b01",          
    ),
  );
  
  runApp(const StudyBuddyApp());
}

class StudyBuddyApp extends StatelessWidget {
  const StudyBuddyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Buddy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const OnboardingScreen(), 
    );
  }
}