import 'package:flutter/material.dart';
import 'package:ripal_design/resource/custom_text_field.dart';
import 'package:ripal_design/resource/custom_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final Color primaryColor = const Color(0xFF9E4723);
  final Color titleColor = const Color(0xFF5A0000); // Dark maroon for title
  final Color linkColor = const Color(0xFFF05B5B); // Coral red for links
  bool _agreeTerms = false;

  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Ripal Design',
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
        titleSpacing: -5.5,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Begin Your Journey',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose your role and set up your professional profile.',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 32),

              // Full Name
              const CustomTextField(
                label: 'FULL NAME',
                hintText: 'Enter your full name',
              ),
              const SizedBox(height: 24),

              // Email Address
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
                        TextPosition(offset: _emailController.text.length),
                      );
                    } else if (!text.endsWith('@gmail.com')) {
                      final username = text.split('@').first;
                      _emailController.text = '$username@gmail.com';
                      _emailController.selection =
                          TextSelection.fromPosition(
                        TextPosition(offset: _emailController.text.length),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Password
              const CustomTextField(
                label: 'PASSWORD',
                hintText: '........',
                isPassword: true,
              ),
              const SizedBox(height: 24),

              // Confirm Password
              const CustomTextField(
                label: 'CONFIRM PASSWORD',
                hintText: '........',
                isPassword: true,
              ),
              const SizedBox(height: 24),

              // Checkbox and terms
              Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: _agreeTerms,
                      onChanged: (value) {
                        setState(() {
                          _agreeTerms = value ?? false;
                        });
                      },
                      activeColor: primaryColor,
                      side: BorderSide(color: Colors.grey.shade400, width: 1.5),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                        ),
                        children: [
                          const TextSpan(text: 'I agree to the '),
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(color: linkColor),
                          ),
                          const TextSpan(text: ' & '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(color: linkColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Create Account Button
              CustomButton(text: 'Create Account', onPressed: () {}),
              const SizedBox(height: 24),

              // Sign In text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
