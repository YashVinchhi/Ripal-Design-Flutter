import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ripal_design/resource/custom_text_field.dart';
import 'package:ripal_design/resource/custom_button.dart';
import 'package:ripal_design/resource/main_scaffold.dart';
import 'package:ripal_design/resource/section_header.dart';
import 'package:ripal_design/screen/client_project_view.dart';
import 'package:ripal_design/screen/client_contactus.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
import 'package:ripal_design/screen/settings_screen.dart';

class ClientApplay extends StatefulWidget {
  const ClientApplay({super.key});

  @override
  State<ClientApplay> createState() => _ClientApplayState();
}

class _ClientApplayState extends State<ClientApplay> {
  final Color titleColor = const Color(0xFF5A0000);
  final Color primaryColor = const Color(0xFF9E4723);

  final _formKey = GlobalKey<FormState>();
  int _currentIndex = 0;
  
  bool _cvUploaded = false;
  bool _isSubmitting = false;
  String? _cvFileName;
  int? _cvFileSize;

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

  Future<void> _pickCvFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );
      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        setState(() {
          _cvFileName = file.name;
          _cvFileSize = file.size;
          _cvUploaded = true;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick file: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _clearCvFile() {
    setState(() {
      _cvFileName = null;
      _cvFileSize = null;
      _cvUploaded = false;
    });
  }

  Future<void> _submitForm() async {
    if (_isSubmitting) return;
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill out all required fields properly'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_cvUploaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload your CV / Resume before submitting'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('lastApplicationName', _fullNameController.text.trim());
      await prefs.setString('lastApplicationCv', _cvFileName!);
      if (!mounted) return;
      _showSuccessDialog();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Unable to submit application. Please try again.'),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: _submitForm,
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFFFFF7F2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE5DDD5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    size: 72,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Form Submitted Successfully!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: titleColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Thank you, ${_fullNameController.text.trim()}. Your application for ${_roleController.text.trim()} has been submitted. Our team will review your CV and respond shortly.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.badge_outlined, size: 18, color: primaryColor),
                      const SizedBox(width: 8),
                      Text(
                        'Application Ref: #RD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => DashboardScreen()),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Return to Dashboard',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: _currentIndex,
      onFabPressed: () {},
      onNavTap: (index) {
        if (index == 0) {
          Navigator.pop(context);
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
        if (index == 3) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SettingsScreen()),
          );
          return;
        }
        setState(() => _currentIndex = index);
      },
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'EMAIL ADDRESS',
                  hintText: 'youremail@example.com',
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email address';
                    }
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'PHONE NUMBER',
                  hintText: 'Enter 10-digit phone number',
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                  maxLength: 10,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your phone number';
                    }
                    final cleanPhone = value.replaceAll(RegExp(r'\D'), '');
                    if (cleanPhone.length != 10) {
                      return 'Phone number must be exactly 10 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // ─── Professional Path ───────────────────────
                const SectionHeader(title: 'PROFESSIONAL PATH'),
                CustomTextField(
                  label: 'DESIRED ROLE',
                  hintText: 'Enter your Role',
                  controller: _roleController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter desired role';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'YEAR OF EXPERIENCE',
                  hintText: 'Enter your Experience',
                  keyboardType: TextInputType.number,
                  controller: _experienceController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter years of experience';
                    }
                    return null;
                  },
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
                  onTap: _pickCvFile,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                    decoration: BoxDecoration(
                      color: _cvUploaded ? const Color(0xFFFFF0EA) : Colors.white,
                      border: Border.all(
                        color: _cvUploaded ? primaryColor : Colors.grey.shade300,
                        width: _cvUploaded ? 1.5 : 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _cvUploaded
                        ? Row(
                            children: [
                              Icon(Icons.insert_drive_file, color: primaryColor, size: 36),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _cvFileName ?? 'CV Document',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      _cvFileSize != null
                                          ? _formatFileSize(_cvFileSize!)
                                          : 'Uploaded ✓',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close, color: Colors.red),
                                onPressed: _clearCvFile,
                                tooltip: 'Remove CV',
                              ),
                            ],
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.upload_file_outlined,
                                color: Colors.grey.shade400,
                                size: 36,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Upload CV / Resume',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'PDF, DOC, DOCX (Max 10MB)',
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
                  validator: (value) {
                    if (value != null && value.isNotEmpty && !value.startsWith('http')) {
                      return 'Please enter a valid link starting with http:// or https://';
                    }
                    return null;
                  },
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
                TextFormField(
                  controller: _aboutController,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.trim().length < 10) {
                      return 'Please tell us about yourself (min 10 characters)';
                    }
                    return null;
                  },
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
                  isLoading: _isSubmitting,
                  onPressed: _isSubmitting ? null : _submitForm,
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
      ),
    );
  }
}
