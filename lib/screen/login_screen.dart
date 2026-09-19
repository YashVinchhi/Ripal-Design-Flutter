import 'package:flutter/material.dart';
import 'package:ripal_design/screen/signup_screen.dart';
import 'package:ripal_design/screen/forgot_password_screen.dart';
import 'package:ripal_design/resource/custom_text_field.dart';
import 'package:ripal_design/resource/custom_button.dart';
import 'package:ripal_design/screen/client_dashborad.dart';

class login_Screen extends StatefulWidget {
  const login_Screen({super.key});

  @override
  State<login_Screen> createState() => _login_ScreenState();
}

class _login_ScreenState extends State<login_Screen> {
  final Color primaryColor = const Color(0xFF9E4723);
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light background for contrast
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Section
            Expanded(
              flex: 2,
              child: SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    // A subtle patterned background could go here if needed
                    // For now, it's just the light background
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0, top: 40.0),
                      child: Text(
                        'Ripal Design',
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Section (Form)
            Expanded(
              flex: 6,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 24.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome Back Header
                      const Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 2,
                        width: double.infinity,
                        color: primaryColor,
                      ),
                      const SizedBox(height: 24),

                      // Email Field
                      CustomTextField(
                        label: 'EMAIL ADDRESS',
                        hintText: 'name@architecture.com',
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                      ),
                      const SizedBox(height: 16),

                      // Password Field
                      CustomTextField(
                        label: 'PASSWORD',
                        hintText: '........',
                        isPassword: true,
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 4),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordScreen(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Sign In Button
                      CustomButton(
                        text: 'Sign In',
                        onPressed: () {
                          if (_emailController.text.toString() ==
                                  "client@gmail.com" &&
                              _passwordController.text.toString() ==
                                  "client123") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Client_Dashborad(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Invalid email or password'),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // Divider Or Sign in with
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                              thickness: 1,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Or sign in with',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Google Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                'https://cdn-icons-png.flaticon.com/512/2991/2991148.png',
                                width: 22,
                                height: 22,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                      Icons.g_mobiledata,
                                      size: 32,
                                      color: Colors.blue,
                                    ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Continue With Google',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Sign Up
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account? ',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
