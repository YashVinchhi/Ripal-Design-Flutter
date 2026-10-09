import 'package:flutter/material.dart';
import 'package:ripal_design/resource/app_image_helper.dart';
import 'package:ripal_design/resource/main_scaffold.dart';
import 'package:ripal_design/resource/app_navigation.dart';
import 'package:ripal_design/service/user_service.dart';
import 'package:ripal_design/screen/auth/upload_profile_photo_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static const Color primaryColor = Color(0xFF5A0000);
  static const Color _titleDark = Color(0xFF2A0501);

  final int _currentIndex = 3;
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
    final user = await UserService.getCurrentUser();
    if (!mounted) return;
    setState(() {
      role = user.role;
      _fullNameController.text = user.name;
      _emailController.text = user.email;
      _phoneController.text = user.phone;
      _addressController.text = user.address;
      _cityController.text = user.city;
      _stateController.text = user.state;
      _pinCodeController.text = user.pinCode;
      _avatarPath = user.avatarPath;
    });
  }

  Future<void> _saveProfileData() async {
    final name = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your full name'), backgroundColor: Colors.red),
      );
      return;
    }
    if (!email.contains('@') || !email.contains('.')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address'), backgroundColor: Colors.red),
      );
      return;
    }
    final cleanPhone = _phoneController.text.replaceAll(RegExp(r'\D'), '');
    if (cleanPhone.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Phone number must have at least 10 digits'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    await UserService.updateProfile(
      name: name,
      email: email,
      phone: _phoneController.text.trim(),
      address: _addressController.text.trim(),
      city: _cityController.text.trim(),
      state: _stateController.text.trim(),
      pinCode: _pinCodeController.text.trim(),
      avatarPath: _avatarPath,
    );

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
    } else {
      final user = await UserService.getCurrentUser();
      setState(() {
        _avatarPath = user.avatarPath;
      });
    }
  }

  void _onNavTap(int index) {
    AppNavigation.handleNavTap(context, index, currentRole: role);
  }

  void _onFabPressed() {
    AppNavigation.handleFabPressed(context, currentRole: role);
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
                            child: ClipOval(
                              child: buildProfileImage(
                                _avatarPath,
                                width: 84,
                                height: 84,
                                fit: BoxFit.cover,
                                fallback: const Icon(
                                  Icons.person,
                                  size: 52,
                                  color: primaryColor,
                                ),
                              ),
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
              const SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: _pickAvatar,
                  child: const Text(
                    'CHANGE PHOTO',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      color: Color(0xFF8B3A1C),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

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

              _buildField('PHONE NUMBER', 'Enter 10-Digit Phone Number', _phoneController, maxLength: 10, keyboardType: TextInputType.phone),
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

  Widget _buildField(String label, String hint, TextEditingController controller, {int maxLines = 1, int? maxLength, TextInputType keyboardType = TextInputType.text}) {
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
          maxLength: maxLength,
          keyboardType: keyboardType,
          buildCounter: maxLength != null ? (context, {required currentLength, required isFocused, maxLength}) => null : null,
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
