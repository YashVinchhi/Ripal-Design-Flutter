import 'package:flutter/material.dart';
import 'package:ripal_design/resource/custom_text_field.dart';
import 'package:ripal_design/resource/custom_button.dart';
import 'package:ripal_design/resource/client_scaffold.dart';
import 'package:ripal_design/resource/section_header.dart';
import 'package:ripal_design/screen/client_project_view.dart';
import 'package:ripal_design/screen/client_contactus.dart';

class ClientApplay extends StatefulWidget {
  const ClientApplay({super.key});

  @override
  State<ClientApplay> createState() => _ClientApplayState();
}

class _ClientApplayState extends State<ClientApplay> {
  final Color titleColor = const Color(0xFF5A0000);
  final Color primaryColor = const Color(0xFF9E4723);

  int _currentIndex = 0;
  bool _cvUploaded = false;

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _roleController = TextEditingController();
  final _experienceController = TextEditingController();
  final _portfolioController = TextEditingController();
  final _aboutController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _roleController.dispose();
    _experienceController.dispose();
    _portfolioController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClientScaffold(
      currentIndex: _currentIndex,
      onFabPressed: () {},
      onNavTap: (index) {
        if (index == 0) {
          Navigator.pop(context); // Go back to Dashboard
          return;
        }
        if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ClientProjectView()),
          );
          return;
        }
        if (index == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ClientContactus()),
          );
          return;
        }
        setState(() => _currentIndex = index);
      },
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Hero Header ────────────────────────────
              Text(
                'Join the\nFirm',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  color: titleColor,
                  height: 1.05,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'We are looking for visionary minds to join our collective pursuit of architectural excellence.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),

              // ─── Personal Details ────────────────────────
              const SectionHeader(title: 'PERSONAL DETAILS'),
              CustomTextField(
                label: 'FULL NAME',
                hintText: 'Enter Your Full Name',
                controller: _fullNameController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: 'EMAIL ADDRESS',
                hintText: 'youremail@example.com',
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: 'PHONE NUMBER',
                hintText: 'Enter your phone number',
                keyboardType: TextInputType.phone,
                controller: _phoneController,
              ),
              const SizedBox(height: 32),

              // ─── Professional Path ───────────────────────
              const SectionHeader(title: 'PROFESSIONAL PATH'),
              CustomTextField(
                label: 'DESIRED ROLE',
                hintText: 'Enter your Role',
                controller: _roleController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: 'YEAR OF EXPERIENCE',
                hintText: 'Enter your Experience',
                keyboardType: TextInputType.number,
                controller: _experienceController,
              ),
              const SizedBox(height: 32),

              // ─── Credentials & Work ──────────────────────
              const SectionHeader(title: 'CREDENTIALS & WORK'),

              // CV Upload label
              const Text(
                'CURRICULUM VITAE',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),

              // Upload Box
              GestureDetector(
                onTap: () {
                  // TODO: Implement file picker
                  setState(() => _cvUploaded = !_cvUploaded);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: _cvUploaded ? primaryColor : Colors.grey.shade300,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _cvUploaded
                            ? Icons.check_circle_outline
                            : Icons.upload_file_outlined,
                        color: _cvUploaded
                            ? primaryColor
                            : Colors.grey.shade400,
                        size: 36,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _cvUploaded
                            ? 'CV / Resume Uploaded ✓'
                            : 'Upload CV / Resume',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _cvUploaded
                              ? primaryColor
                              : Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'PDF, DOCX (Max 10MB)',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Portfolio Link
              CustomTextField(
                label: 'PORTFOLIO LINK',
                hintText: 'https://behance.net/yourname',
                keyboardType: TextInputType.url,
                controller: _portfolioController,
              ),
              const SizedBox(height: 20),

              // About You
              const Text(
                'ABOUT YOU',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _aboutController,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Tell us about your architectural philosophy...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 32),

              // ─── Submit Button ───────────────────────────
              CustomButton(
                text: 'Submit Application',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Application submitted successfully!',
                      ),
                      backgroundColor: primaryColor,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                icon: Icons.arrow_forward,
              ),
              const SizedBox(height: 16),

              // ─── Privacy Note ────────────────────────────
              Center(
                child: Text(
                  'By submitting, you agree to our recruitment privacy terms and candidate data processing policy.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
