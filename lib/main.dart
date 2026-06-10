import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // NISA: TAMBAH IMPORT FIREBASE CORE
import 'login_screen.dart'; 

void main() async {
  // NISA:TAMBAH NI SUPAYA FLUTTER READY SEBELUM BIND DENGAN FIREBASE
  WidgetsFlutterBinding.ensureInitialized();

  // NISA: INITIALIZE FIREBASE DIRECT GUNA DATA DARI GOOGLE-SERVICES.JSON (android/app)
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
      home: const LoginScreen(), 
    );
  }
}