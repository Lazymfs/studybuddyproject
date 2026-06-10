import 'main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; //NISA: IMPORT CLOUD FIRESTORE
import 'constants.dart';
import 'custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 1. Create the controller here
  final TextEditingController _usernameController = TextEditingController();
  bool _isLoading = false; // NISA: Untuk tunjuk loading bar masa login

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.primaryPurple,
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator(color: AppColors.white))
          : Stack(
              children: [
                // Top Purple Section (Header)
                Positioned(
                  top: screenHeight * 0.15,
                  left: 0,
                  right: 0,
                  child: const Center(
                    child: Text(
                      'Hi Buddy :)',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

          // Bottom Cream Section (Curved Container)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: screenHeight * 0.70, // Takes up bottom 70% of screen
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.creamBackground,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Username Or Email',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            hintText: 'example@example.com',
                            controller: _usernameController,
                          ),
                          
                          const Text(
                            'Password',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          const CustomTextField(
                            hintText: '••••••••',
                            isPassword: true,
                            suffixIcon: Icons.visibility_off_outlined,
                          ),

                          const SizedBox(height: 24),

                          // Login Button
                          ElevatedButton(
                            onPressed: () async { //NISA
                              String fullEmail = _usernameController.text.trim();
                              if (fullEmail.isEmpty) {
                                fullEmail = "ame@unikl.edu.my"; // Fallback email
                              }
                              
                              // Split it to get just the name
                              String enteredName = fullEmail.split('@')[0];

                              setState(() { _isLoading = true; }); //NISA

                              try {
                                // NISA: Daftar user dalam firestore
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(enteredName) 
                                    .set({
                                  'user_id': enteredName,
                                  'username': enteredName,
                                  'email': fullEmail,
                                  'avatar_url': '',
                                  'last_login': FieldValue.serverTimestamp(),
                                });

                                if (mounted) {
                                  // Bila success, hantar data to next screen
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MainNavigation(
                                        username: enteredName, 
                                        email: fullEmail, // Pass the email here!
                                      )
                                    ),
                                  );
                                }
                              } catch (e) {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Firebase Error: $e'), backgroundColor: Colors.red),
                                  );
                                }
                              } finally {
                                if (mounted) { setState(() { _isLoading = false; }); }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryPurple,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Forgot Password Text
                          Center(
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: AppColors.primaryPurple,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Social Login Placeholder
                          const Center(
                            child: Text(
                              'or sign up with',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ),
                          
                          // Add Row for Google/Apple icons here later
                          
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}