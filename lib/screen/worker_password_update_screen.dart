import 'package:flutter/material.dart';
import 'package:ripal_design/resource/custom_bottom_nav_bar.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
import 'package:ripal_design/screen/worker_leave_history_screen.dart';
import 'package:ripal_design/screen/worker_upload_files_screen.dart';

class WorkerPasswordUpdateScreen extends StatefulWidget {
  const WorkerPasswordUpdateScreen({super.key});

  @override
  State<WorkerPasswordUpdateScreen> createState() =>
      _WorkerPasswordUpdateScreenState();
}

class _WorkerPasswordUpdateScreenState extends State<WorkerPasswordUpdateScreen> {
  static const Color primaryColor = Color(0xFF5A0000);
  static const Color _bgCream = Color(0xFFFFF7F2);
  static const Color _titleDark = Color(0xFF1E1E1E);

  int _currentIndex = 3;

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  final TextEditingController _currentController =
      TextEditingController(text: 'zxcv1234');
  final TextEditingController _newController =
      TextEditingController(text: 'secretpass');
  final TextEditingController _confirmController =
      TextEditingController(text: 'secretpass');

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
      return;
    }
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WorkerLeaveHistoryScreen()),
      );
      return;
    }
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WorkerUploadFilesScreen()),
      );
      return;
    }
    if (index == 3) {
      Navigator.pop(context);
      return;
    }
    setState(() => _currentIndex = index);
  }

  void _onFabPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WorkerUploadFilesScreen()),
    );
  }

  void _updatePassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password updated successfully!'),
        backgroundColor: primaryColor,
        duration: Duration(seconds: 2),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgCream,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Security Settings',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onFabPressed,
        backgroundColor: primaryColor,
        shape: const CircleBorder(),
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
        role: 'worker',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),

              // Unlocked Lock Circular Icon
              Center(
                child: Container(
                  width: 74,
                  height: 74,
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock_open_rounded,
                    color: Colors.white,
                    size: 38,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Title & Subtitle
              const Text(
                'Update Password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: _titleDark,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Change your password to keep your\naccount secure.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 28),

              // Form fields
              _buildPasswordField(
                label: 'CURRENT PASSWORD',
                controller: _currentController,
                isObscure: _obscureCurrent,
                onToggle: () => setState(() => _obscureCurrent = !_obscureCurrent),
              ),
              const SizedBox(height: 16),

              _buildPasswordField(
                label: 'NEW PASSWORD',
                controller: _newController,
                isObscure: _obscureNew,
                onToggle: () => setState(() => _obscureNew = !_obscureNew),
              ),
              const SizedBox(height: 16),

              _buildPasswordField(
                label: 'CONFIRM PASSWORD',
                controller: _confirmController,
                isObscure: _obscureConfirm,
                onToggle: () =>
                    setState(() => _obscureConfirm = !_obscureConfirm),
              ),
              const SizedBox(height: 20),

              // Password Requirements Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFF2DED7)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Password Requirements',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: _titleDark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildRequirementRow(
                      text: 'At least 8 characters',
                      isError: true,
                    ),
                    const SizedBox(height: 8),
                    _buildRequirementRow(
                      text: 'One uppercase letter',
                      isError: false,
                    ),
                    const SizedBox(height: 8),
                    _buildRequirementRow(
                      text: 'One number',
                      isError: false,
                    ),
                    const SizedBox(height: 8),
                    _buildRequirementRow(
                      text: 'One special character',
                      isError: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Update Password Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _updatePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                  child: const Text(
                    'Update Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool isObscure,
    required VoidCallback onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE5CCC9)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: isObscure,
                  obscuringCharacter: '•',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    color: _titleDark,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  isObscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.grey.shade500,
                  size: 20,
                ),
                onPressed: onToggle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRequirementRow({
    required String text,
    required bool isError,
  }) {
    return Row(
      children: [
        isError
            ? const Icon(
                Icons.cancel_outlined,
                color: Color(0xFFC53030),
                size: 16,
              )
            : Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 1.5,
                  ),
                ),
              ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
