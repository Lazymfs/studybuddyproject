import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'constants.dart';
import 'custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator(color: AppColors.white))
          : Stack(
              children: [
                // Top Header Text
                Positioned(
                  top: screenHeight * 0.05,
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
                            text: 'Create ',
                            style: TextStyle(color: AppColors.white), // "Create" kekal Putih
                          ),
                          TextSpan(
                            text: 'Account',
                            style: TextStyle(color: Colors.yellow), // "Account" jadi Kuning
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Bottom Cream Container (Curved Container)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: screenHeight * 0.75, 
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
                            'Choose Username Or Email',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            hintText: 'example@example.com',
                            controller: _usernameController,
                          ),
                          
                          const Text(
                            'Create Password',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            hintText: '••••••••',
                            isPassword: true,
                            suffixIcon: Icons.visibility_off_outlined,
                            controller: _passwordController,
                          ),

                          const SizedBox(height: 32),

                          // Register Button
                          ElevatedButton(
                            onPressed: () async { 
                              String fullEmail = _usernameController.text.trim();
                              String enteredPassword = _passwordController.text.trim();

                              if (fullEmail.isEmpty || enteredPassword.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Please fill in all details!'), backgroundColor: Colors.orange),
                                );
                                return;
                              }
                              
                              String enteredName = fullEmail.split('@')[0];
                              setState(() { _isLoading = true; }); 

                              try {
                                // Register new data in Firebase
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(enteredName) 
                                    .set({
                                  'user_id': enteredName,
                                  'username': enteredName,
                                  'email': fullEmail,
                                  'password': enteredPassword, 
                                  'avatar_url': '',
                                  'last_login': FieldValue.serverTimestamp(),
                                });

                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Account Created Successfully! 🎉'), backgroundColor: Colors.green),
                                  );
                                  Navigator.pop(context);
                                }
                              } catch (e) {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Registration Error: $e'), backgroundColor: Colors.red),
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
                              'Sign Up',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.white),
                            ),
                          ),
                          
                          const SizedBox(height: 24),
                          Center(
                            child: TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                "Already have an account? Log In",
                                style: TextStyle(fontSize: 12, color: AppColors.primaryPurple),
                              ),
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