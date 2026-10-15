import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ripal_design/screen/signup_screen.dart';
import 'package:ripal_design/screen/forgot_password_screen.dart';
import 'package:ripal_design/resource/custom_text_field.dart';
import 'package:ripal_design/resource/custom_button.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Color primaryColor = const Color(0xFF9E4723);
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectivePrimary = isDark ? const Color(0xFFE07A5F) : primaryColor;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF141212) : const Color(0xFFF5F5F5),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0, top: 40.0),
                      child: Text(
                        'Ripal Design',
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w800,
                          color: isDark ? Colors.white : Colors.black,
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
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: const BorderRadius.only(
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
                      Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 2,
                        width: double.infinity,
                        color: effectivePrimary,
                      ),
                      const SizedBox(height: 24),

                      // Email Field
                      CustomTextField(
                        label: 'EMAIL ADDRESS',
                        hintText: 'name@architecture.com',
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        suffixIcon: IconButton(
                          tooltip: 'Add @gmail.com',
                          icon: Image.network(
                            'https://cdn-icons-png.flaticon.com/512/2991/2991148.png',
                            width: 20,
                            height: 20,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.g_mobiledata,
                              color: Color(0xFF4285F4),
                              size: 24,
                            ),
                          ),
                          onPressed: () {
                            final text = _emailController.text.trim();
                            if (text.isEmpty) {
                              _emailController.text = '@gmail.com';
                              _emailController.selection =
                                  TextSelection.fromPosition(
                                const TextPosition(offset: 0),
                              );
                            } else if (!text.contains('@')) {
                              _emailController.text = '$text@gmail.com';
                              _emailController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                    offset: _emailController.text.length),
                              );
                            } else if (!text.endsWith('@gmail.com')) {
                              final username = text.split('@').first;
                              _emailController.text = '$username@gmail.com';
                              _emailController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                    offset: _emailController.text.length),
                              );
                            }
                          },
                        ),
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
                              color: effectivePrimary,
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
                        isLoading: _isLoading,
                        onPressed: _isLoading ? null : () async {
                          final email = _emailController.text.trim().toLowerCase();
                          final password = _passwordController.text.trim();

                          if (email.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter both email and password'),
                              ),
                            );
                            return;
                          }

                          setState(() => _isLoading = true);

                          try {
                            final users = {
                              'rohan@gmail.com': {
                                'password': 'zxcv',
                                'role': 'client',
                                'name': 'Rohan',
                              },
                              'niku@gmail.com': {
                                'password': 'zxcv',
                                'role': 'worker',
                                'name': 'Niku',
                              },
                              'rachit@gmail.com': {
                                'password': 'zxcv',
                                'role': 'employee',
                                'name': 'Rachit',
                              },
                              'yash@gmail.com': {
                                'password': 'zxcv',
                                'role': 'admin',
                                'name': 'Yash',
                              },
                              'admin@gmail.com': {
                                'password': 'admin123',
                                'role': 'admin',
                                'name': 'Admin',
                              },
                            };

                            bool isValidUser = false;
                            Map<String, String>? userData;

                            final prefs = await SharedPreferences.getInstance();
                            final savedEmail = (prefs.getString('userEmail') ?? '').toLowerCase().trim();
                            final savedPassword = prefs.getString('userPassword');

                            if (users.containsKey(email)) {
                              final user = users[email]!;
                              final effectivePassword = (savedEmail == email && savedPassword != null && savedPassword.isNotEmpty)
                                  ? savedPassword
                                  : user['password'];

                              if (password == effectivePassword ||
                                  password == user['password'] ||
                                  (email == 'rachit@gmail.com' && password == 'rachit123')) {
                                isValidUser = true;
                                userData = user;
                              }
                            }

                            if (isValidUser && userData != null) {
                              await prefs.setBool('isLoggedIn', true);
                              await prefs.setString('userName', userData['name']!);
                              await prefs.setString('userEmail', email);
                              await prefs.setString('role', userData['role']!);
                              await prefs.setString('userPassword', password);

                              if (!context.mounted) return;
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DashboardScreen(),
                                ),
                              );
                            } else {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Invalid email or password'),
                                  ),
                                );
                              }
                            }
                          } finally {
                            if (mounted) setState(() => _isLoading = false);
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // Divider Or Sign in with
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: isDark ? const Color(0xFF333333) : Colors.grey.shade300,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Or sign in with',
                              style: TextStyle(
                                color: isDark ? Colors.grey.shade400 : Colors.black87,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: isDark ? const Color(0xFF333333) : Colors.grey.shade300,
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
                            side: BorderSide(color: isDark ? const Color(0xFF333333) : Colors.grey.shade300),
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
                              Text(
                                'Continue With Google',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? Colors.white : Colors.black87,
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
                              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
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
                                color: effectivePrimary,
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
