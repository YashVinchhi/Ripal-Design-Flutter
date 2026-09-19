import 'package:flutter/material.dart';
import 'package:ripal_design/resource/custom_text_field.dart';
import 'package:ripal_design/resource/custom_button.dart';
import 'package:ripal_design/resource/contact_info_row.dart';
import 'package:ripal_design/resource/client_scaffold.dart';
import 'package:ripal_design/resource/section_header.dart';
import 'package:ripal_design/screen/client_project_view.dart';
import 'package:ripal_design/screen/client_settings.dart';

class ClientContactus extends StatefulWidget {
  const ClientContactus({super.key});

  @override
  State<ClientContactus> createState() => _ClientContactusState();
}

class _ClientContactusState extends State<ClientContactus> {
  final Color titleColor = const Color(0xFF5A0000);
  final Color primaryColor = const Color(0xFF9E4723);

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

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClientScaffold(
      currentIndex: _currentIndex,
      onFabPressed: () {},
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
            MaterialPageRoute(builder: (context) => const ClientSettings()),
          );
          return;
        }
        setState(() => _currentIndex = index);
      },
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
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
              ),
              const SizedBox(height: 20),

              // Email Address
              CustomTextField(
                label: 'EMAIL ADDRESS',
                hintText: 'youremail@example.com',
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
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
                onPressed: () {},
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
          value: _selectedProjectType,
          hint: Text(
            'Residential Design',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          ),
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
        TextField(
          controller: _messageController,
          maxLines: 5,
          keyboardType: TextInputType.multiline,
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
