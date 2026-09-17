import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/mobile_frame.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class PasswordUpdateScreen extends StatefulWidget {
  const PasswordUpdateScreen({super.key});

  @override
  State<PasswordUpdateScreen> createState() => _PasswordUpdateScreenState();
}

class _PasswordUpdateScreenState extends State<PasswordUpdateScreen> {
  final _currentPasswordController = TextEditingController(text: 'secret123');
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;
  bool _hasSpecial = false;

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_validatePassword);
  }

  void _validatePassword() {
    final text = _newPasswordController.text;
    setState(() {
      _hasMinLength = text.length >= 8;
      _hasUppercase = text.contains(RegExp(r'[A-Z]'));
      _hasNumber = text.contains(RegExp(r'[0-9]'));
      _hasSpecial = text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
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
                  title: 'Security Settings',
                  showBack: true,
                  showAvatar: false,
                  onBack: () => Navigator.of(context).maybePop(),
                ),

                const SizedBox(height: 12),

                // 2. Lock Icon & Title
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.lock_outline_rounded,
                          color: Colors.white,
                          size: 34,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Update Password',
                        style: AppTypography.largeTitle.copyWith(fontSize: 22),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Change your password to keep your\naccount secure.',
                        textAlign: TextAlign.center,
                        style: AppTypography.bodyText,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 3. Password Input Fields
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      CustomTextField(
                        label: 'CURRENT PASSWORD',
                        placeholder: '••••••••',
                        controller: _currentPasswordController,
                        isPassword: true,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'NEW PASSWORD',
                        placeholder: '••••••••',
                        controller: _newPasswordController,
                        isPassword: true,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'CONFIRM PASSWORD',
                        placeholder: '••••••••',
                        controller: _confirmPasswordController,
                        isPassword: true,
                      ),
                      const SizedBox(height: 22),

                      // 4. Password Requirements Checklist
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border, width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password Requirements',
                              style: AppTypography.cardTitle.copyWith(fontSize: 13.5),
                            ),
                            const SizedBox(height: 12),
                            _buildRequirementItem('At least 8 characters', _hasMinLength),
                            const SizedBox(height: 8),
                            _buildRequirementItem('One uppercase letter', _hasUppercase),
                            const SizedBox(height: 8),
                            _buildRequirementItem('One number', _hasNumber),
                            const SizedBox(height: 8),
                            _buildRequirementItem('One special character', _hasSpecial),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      // 5. Update Password Button
                      PrimaryButton(
                        text: 'Update Password',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Password updated successfully!'),
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

  Widget _buildRequirementItem(String text, bool isMet) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle_rounded : Icons.cancel_outlined,
          size: 16,
          color: isMet ? AppColors.badgeCompleted : const Color(0xFFC5221F),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: AppTypography.cardSubtitle.copyWith(
            fontSize: 13,
            color: isMet ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
