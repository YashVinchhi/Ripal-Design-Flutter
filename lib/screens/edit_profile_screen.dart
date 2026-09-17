import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/mobile_frame.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../routes.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController(text: 'Rachit Sharma');
  final _emailController = TextEditingController(text: 'rachit@ripaldesign.com');
  final _phoneController = TextEditingController(text: '+91 98765 43210');
  final _addressController = TextEditingController(text: '402 Skyline Avenue, Phase 2, Design District');
  final _cityController = TextEditingController(text: 'Mumbai');
  final _stateController = TextEditingController(text: 'Maharashtra');
  final _pinController = TextEditingController(text: '400001');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobileFrame(
      child: Scaffold(
        backgroundColor: AppColors.background,
        bottomNavigationBar: const RipalBottomNavBar(currentIndex: 3),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header with Back Arrow
                AppHeader(
                  title: 'Edit Profile',
                  showBack: true,
                  showAvatar: false,
                  onBack: () => Navigator.of(context).maybePop(),
                ),

                const SizedBox(height: 10),

                // 2. Avatar with Camera Badge and "CHANGE PHOTO"
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.uploadProfilePhoto);
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xFFF0E5E2), width: 3),
                                color: AppColors.surfaceSecondary,
                              ),
                              child: ClipOval(
                                child: CustomPaint(
                                  painter: AvatarPatternPainter(),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 2,
                              right: 2,
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.uploadProfilePhoto);
                        },
                        child: Text(
                          'CHANGE PHOTO',
                          style: AppTypography.kicker.copyWith(
                            fontSize: 11.5,
                            letterSpacing: 1.2,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // 3. BASIC INFORMATION Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'B A S I C   I N F O R M A T I O N',
                    style: AppTypography.kicker,
                  ),
                ),
                const SizedBox(height: 16),

                // 4. Form Fields
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      CustomTextField(
                        label: 'FULL NAME',
                        placeholder: 'Enter Your Full Name',
                        controller: _nameController,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'EMAIL ADDRESS',
                        placeholder: 'Enter Your Email',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'PHONE NUMBER',
                        placeholder: 'Enter Your Phone Number',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'MAILING ADDRESS',
                        placeholder: 'Enter Your Mailing Address',
                        controller: _addressController,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'CITY',
                        placeholder: 'Enter Your City',
                        controller: _cityController,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'STATE',
                        placeholder: 'Enter Your State',
                        controller: _stateController,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'PIN CODE',
                        placeholder: 'Enter Your Pin Code',
                        controller: _pinController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 28),

                      // 5. Save Button
                      PrimaryButton(
                        text: 'Save Profile',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Profile updated successfully!'),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
