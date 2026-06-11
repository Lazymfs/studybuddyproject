import 'main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'constants.dart';
import 'custom_text_field.dart';
import 'register_screen.dart'; 

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  // Controller to check password
  final TextEditingController _passwordController = TextEditingController(); 
  bool _isLoading = false; 

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                  child: Center(
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                        children: [
                          TextSpan(
                            text: 'Hi ',
                            style: TextStyle(color: AppColors.white), 
                          ),
                          TextSpan(
                            text: 'Buddy :)',
                            style: TextStyle(color: Colors.yellow), 
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Bottom Cream Section (Curved Container)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: screenHeight * 0.70, 
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
                          CustomTextField(
                            hintText: '••••••••',
                            isPassword: true,
                            suffixIcon: Icons.visibility_off_outlined,
                            controller: _passwordController,
                          ),

                          const SizedBox(height: 24),

                          // Login Button
                          ElevatedButton(
                            onPressed: () async { 
                              String fullEmail = _usernameController.text.trim();
                              String enteredPassword = _passwordController.text.trim();

                              if (fullEmail.isEmpty || enteredPassword.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Please fill in all fields!'), backgroundColor: Colors.orange),
                                );
                                return;
                              }
                              
                              String enteredName = fullEmail.split('@')[0];
                              setState(() { _isLoading = true; }); 

                              try {
                                // Check data for existing user in Firebase
                                DocumentSnapshot userDoc = await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(enteredName)
                                    .get();

                                if (userDoc.exists) {
                                  Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
                                  
                                  if (userData['password'] == enteredPassword) {
                                    await FirebaseFirestore.instance.collection('users').doc(enteredName).update({
                                      'last_login': FieldValue.serverTimestamp(),
                                    });

                                    if (mounted) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MainNavigation(
                                            username: enteredName, 
                                            email: fullEmail, 
                                          )
                                        ),
                                      );
                                    }
                                  } else {
                                    // Wrong Password
                                    if (mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Wrong password! Please try again.'), backgroundColor: Colors.red),
                                      );
                                    }
                                  }
                                } else {
                                  // User is not exist
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('User does not exist. Please Sign Up first!'), backgroundColor: Colors.orange),
                                    );
                                  }
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
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                            child: const Text(
                              'Log In',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.white),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Forgot Password 
                          Center(
                            child: TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Reset password link has been sent to your email ✉️')),
                                );
                              },
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(color: AppColors.primaryPurple, fontSize: 12),
                              ),
                            ),
                          ),

                          const SizedBox(height: 3),

                          // Sign Up
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                                );
                              },
                              child: const Text(
                                "Don't have account yet? Sign up here",
                                style: TextStyle(fontSize: 12, color: Colors.blue),
                              )
                            ),
                          ),
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