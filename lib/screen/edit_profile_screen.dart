import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ripal_design/resource/main_scaffold.dart';
import 'package:ripal_design/screen/admin_create_project.dart';
import 'package:ripal_design/screen/admin_finance_screen.dart';
import 'package:ripal_design/screen/admin_leave_screen.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
import 'package:ripal_design/screen/settings_screen.dart';
import 'package:ripal_design/screen/upload_profile_photo_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static const Color primaryColor = Color(0xFF5A0000);
  static const Color _titleDark = Color(0xFF2A0501);

  int _currentIndex = 3;
  String role = 'admin';

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();

  String? _avatarPath;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role') ?? 'admin';
      _fullNameController.text = prefs.getString('userName') ?? (role == 'admin' ? 'Ar. Ripal Patel' : 'Client User');
      _emailController.text = prefs.getString('userEmail') ?? (role == 'admin' ? 'admin@gmail.com' : 'client@gmail.com');
      _phoneController.text = prefs.getString('userPhone') ?? '+91 98765 43210';
      _addressController.text = prefs.getString('userAddress') ?? '101 Design Studio Tower, Off Ring Road';
      _cityController.text = prefs.getString('userCity') ?? 'Rajkot';
      _stateController.text = prefs.getString('userState') ?? 'Gujarat';
      _pinCodeController.text = prefs.getString('userPinCode') ?? '360005';
    });
  }

  Future<void> _saveProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', _fullNameController.text.trim());
    await prefs.setString('userEmail', _emailController.text.trim());
    await prefs.setString('userPhone', _phoneController.text.trim());
    await prefs.setString('userAddress', _addressController.text.trim());
    await prefs.setString('userCity', _cityController.text.trim());
    await prefs.setString('userState', _stateController.text.trim());
    await prefs.setString('userPinCode', _pinCodeController.text.trim());

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile Saved Successfully!'),
          backgroundColor: primaryColor,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context, true);
    }
  }

  Future<void> _pickAvatar() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UploadProfilePhotoScreen()),
    );
    if (result != null && result is String) {
      setState(() {
        _avatarPath = result;
      });
    }
  }

  void _onNavTap(int index) {
    if (index == 0) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
      return;
    }
    if (index == 1) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminLeaveScreen()));
      return;
    }
    if (index == 2) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminFinanceScreen()));
      return;
    }
    if (index == 3) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
      return;
    }
    setState(() => _currentIndex = index);
  }

  void _onFabPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminCreateProject()));
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: _currentIndex,
      onNavTap: _onNavTap,
      onFabPressed: _onFabPressed,
      appBarTitle: 'Edit Profile',
      appBarLeading: IconButton(
        icon: const Icon(Icons.arrow_back, color: primaryColor),
        onPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar Section with Camera Icon
              Center(
                child: GestureDetector(
                  onTap: _pickAvatar,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFE0C0B0), width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 46,
                          backgroundColor: const Color(0xFFFCEFEA),
                          child: CircleAvatar(
                            radius: 42,
                            backgroundColor: const Color(0xFFFDF8F5),
                            child: const Icon(
                              Icons.person,
                              size: 52,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Section Header
              Text(
                'BASIC INFORMATION',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 16),

              // Input Fields
              _buildField('FULL NAME', 'Enter Your Full Name', _fullNameController),
              const SizedBox(height: 16),

              _buildField('EMAIL ADDRESS', 'Enter Your Email', _emailController),
              const SizedBox(height: 16),

              _buildField('PHONE NUMBER', 'Enter Your Phone Number', _phoneController),
              const SizedBox(height: 16),

              _buildField('MAILING ADDRESS', 'Enter Mailing Address', _addressController, maxLines: 3),
              const SizedBox(height: 16),

              _buildField('CITY', 'Enter Your City', _cityController),
              const SizedBox(height: 16),

              _buildField('STATE', 'Enter Your State', _stateController),
              const SizedBox(height: 16),

              _buildField('PIN CODE', 'Enter Your Pin Code', _pinCodeController),
              const SizedBox(height: 32),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _saveProfileData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Save Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, String hint, TextEditingController controller, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: _titleDark,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
            filled: true,
            fillColor: const Color(0xFFFFF7F2),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFFE5CCC9)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFFE5CCC9)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
