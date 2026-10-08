import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ripal_design/resource/custom_text_field.dart';
import 'package:ripal_design/resource/custom_button.dart';
import 'package:ripal_design/resource/contact_info_row.dart';
import 'package:ripal_design/resource/main_scaffold.dart';
import 'package:ripal_design/resource/section_header.dart';
import 'package:ripal_design/screen/client_project_view.dart';
import 'package:ripal_design/screen/settings_screen.dart';
import 'package:ripal_design/screen/client_applay.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
// import 'package:ripal_design/screen/dashboard_screen.dart';


class ClientContactus extends StatefulWidget {
  /// When [embeddedMode] is true, the widget renders only its body content
  /// (no MainScaffold/AppBar/BottomNav) so it can be embedded inside an
  /// IndexedStack in the client shell.
  final bool embeddedMode;

  const ClientContactus({super.key, this.embeddedMode = false});

  @override
  State<ClientContactus> createState() => _ClientContactusState();
}

class _ClientContactusState extends State<ClientContactus> {
  final Color titleColor = const Color(0xFF5A0000);
  final Color primaryColor = const Color(0xFF9E4723);

  final _formKey = GlobalKey<FormState>();
  int _currentIndex = 2; // Contact is index 2 in bottom nav

  String? _selectedProjectType;
  final List<String> _projectTypes = [
    'Residential Design',
    'Commercial Design',
    'Interior Design',
    'Landscape Design',
    'Renovation',
  ];

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitInquiry() async {
    if (_isSubmitting) return;
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all required fields properly'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedProjectType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a project type'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('lastInquiryName', _fullNameController.text.trim());
      await prefs.setString('lastInquiryMessage', _messageController.text.trim());
      if (!mounted) return;
      _showSuccessDialog();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Unable to send inquiry. Please try again.'),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: _submitInquiry,
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
      builder: (dialogContext) {
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
                    Icons.mark_email_read_outlined,
                    size: 40,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Inquiry Sent Successfully!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: titleColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Thank you, ${_fullNameController.text.trim()}. We have received your inquiry for ${_selectedProjectType ?? "your project"}. An architect will reach out within 24 hours.',
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
                      Icon(Icons.confirmation_number_outlined, size: 18, color: primaryColor),
                      const SizedBox(width: 8),
                      Text(
                        'Ticket Ref: #INQ-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
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
                      'Done',
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

  @override
  Widget build(BuildContext context) {
    // Embedded inside DashboardScreen's IndexedStack — no scaffold
    if (widget.embeddedMode) {
      return SafeArea(child: _buildBody());
    }

    // Standalone: full scaffold with nav bar
    return MainScaffold(
      currentIndex: _currentIndex,
      onFabPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ClientApplay()),
        );
      },
      onNavTap: (index) {
        if (index == _currentIndex) return;
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
        if (index == 3) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SettingsScreen()),
          );
          return;
        }
        setState(() => _currentIndex = index);
      },
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Hero Header ─────────────────────────────
            Text(
              'Get in\nTouch',
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
              'We believe in the power of meaningful collaboration. Let\'s discuss how we can bring architectural precision and tactile luxury to your next project.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),

            // ─── Form Section ─────────────────────────────
            const SectionHeader(title: 'START A CONVERSATION'),

            // Full Name
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

            // Email Address
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

            // Project Type Dropdown
            _buildDropdownField(),
            const SizedBox(height: 20),

            // Message
            _buildMessageField(),
            const SizedBox(height: 28),

            // Send Inquiry Button
            CustomButton(
              text: 'Send Inquiry',
              isLoading: _isSubmitting,
              onPressed: _isSubmitting ? null : _submitInquiry,
              icon: Icons.arrow_forward,
            ),
            const SizedBox(height: 40),

            // ─── Divider ──────────────────────────────
            Divider(color: Colors.grey.shade200, thickness: 1),
            const SizedBox(height: 28),

            // ─── Contact Info ──────────────────────────
            const ContactInfoRow(
              icon: Icons.phone_outlined,
              label: 'CALL US',
              value: '+91 94267 89012',
            ),
            const SizedBox(height: 24),

            const ContactInfoRow(
              icon: Icons.mail_outline,
              label: 'MAIL US',
              value: 'projects@ripaldesign.studio',
            ),
            const SizedBox(height: 24),

            const ContactInfoRow(
              icon: Icons.location_on_outlined,
              label: 'LOCATION',
              value:
                  '308 Jassal Complex,\nNanaKati Chowne,\nIsset Ring Road,\nRajkot, Gujarat, India',
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PROJECT TYPE',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: _selectedProjectType,
          hint: Text(
            'Select Project Type',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a project type';
            }
            return null;
          },
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade500),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          items: _projectTypes.map((type) {
            return DropdownMenuItem<String>(
              value: type,
              child: Text(type, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedProjectType = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildMessageField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'MESSAGE',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _messageController,
          maxLines: 5,
          keyboardType: TextInputType.multiline,
          validator: (value) {
            if (value == null || value.trim().length < 10) {
              return 'Please enter a message (min 10 characters)';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'Tell us about your vision...',
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
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
      ],
    );
  }
}
