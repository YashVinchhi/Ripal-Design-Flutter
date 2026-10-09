import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ripal_design/resource/custom_bottom_nav_bar.dart';
import 'package:ripal_design/resource/role_guard.dart';
import 'package:ripal_design/resource/app_notification_icon.dart';
import 'package:ripal_design/service/leave_service.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
import 'package:ripal_design/screen/worker/worker_leave_history_screen.dart';
import 'package:ripal_design/screen/worker/worker_settings_screen.dart';
import 'package:ripal_design/screen/worker/worker_upload_files_screen.dart';

class WorkerLeaveRequestScreen extends StatefulWidget {
  final bool initialSubmitted;

  const WorkerLeaveRequestScreen({
    super.key,
    this.initialSubmitted = false,
  });

  @override
  State<WorkerLeaveRequestScreen> createState() => _WorkerLeaveRequestScreenState();
}

class _WorkerLeaveRequestScreenState extends State<WorkerLeaveRequestScreen> {
  static const Color primaryColor = Color(0xFF5A0000);
  static const Color _bgCream = Color(0xFFFFF7F2);
  static const Color _titleDark = Color(0xFF1E1E1E);

  int _currentIndex = 1;
  late bool _isSubmitted;
  bool _isSubmitting = false;

  DateTime _startDate = DateTime.now().add(const Duration(days: 2));
  DateTime _endDate = DateTime.now().add(const Duration(days: 6));
  String _selectedLeaveType = 'Annual Leave';

  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  final TextEditingController _contextController =
      TextEditingController(text: 'Annual Family Vacation');

  @override
  void initState() {
    super.initState();
    _isSubmitted = widget.initialSubmitted;
    _startDateController = TextEditingController(text: DateFormat('MMM dd, yyyy').format(_startDate));
    _endDateController = TextEditingController(text: DateFormat('MMM dd, yyyy').format(_endDate));
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _contextController.dispose();
    super.dispose();
  }

  int get _calculatedDurationDays {
    final diff = _endDate.difference(_startDate).inDays + 1;
    return diff > 0 ? diff : 1;
  }

  String get _calculatedDurationText {
    final days = _calculatedDurationDays;
    return '$days Work\n${days == 1 ? "Day" : "Days"}';
  }

  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              onSurface: _titleDark,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;
        _startDateController.text = DateFormat('MMM dd, yyyy').format(picked);
        if (_endDate.isBefore(_startDate)) {
          _endDate = _startDate.add(const Duration(days: 1));
          _endDateController.text = DateFormat('MMM dd, yyyy').format(_endDate);
        }
      });
    }
  }

  Future<void> _pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate.isAfter(_startDate) ? _endDate : _startDate,
      firstDate: _startDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              onSurface: _titleDark,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _endDate = picked;
        _endDateController.text = DateFormat('MMM dd, yyyy').format(picked);
      });
    }
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
      if (_isSubmitted) {
        setState(() => _isSubmitted = false);
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WorkerLeaveHistoryScreen()),
        );
      }
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WorkerSettingsScreen()),
      );
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

  Future<void> _submitRequest() async {
    if (_isSubmitting) return;
    final start = _startDateController.text.trim();
    final end = _endDateController.text.trim();
    final contextText = _contextController.text.trim();
    if (start.isEmpty || end.isEmpty || contextText.length < 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid dates and a reason of at least 5 characters.'), backgroundColor: Colors.red),
      );
      return;
    }
    setState(() => _isSubmitting = true);
    try {
      final days = _calculatedDurationDays;
      final newRecord = LeaveRecord(
        id: 'leave_${DateTime.now().millisecondsSinceEpoch}',
        applicantName: 'Niku',
        applicantRole: 'Site Worker',
        leaveType: _selectedLeaveType,
        dateRange: '${DateFormat("MMM dd").format(_startDate)} - ${DateFormat("MMM dd").format(_endDate)}',
        duration: '$days ${days == 1 ? "day" : "days"}',
        status: 'PENDING',
        appliedDate: DateFormat('MMM dd, yyyy').format(DateTime.now()).toUpperCase(),
        reason: contextText,
      );

      await LeaveService.addLeave(newRecord);

      if (mounted) {
        setState(() {
          _isSubmitted = true;
        });
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to submit leave request. Please try again.'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RoleGuardedScreen(
      allowedRoles: const ['worker'],
      child: Scaffold(
        backgroundColor: _bgCream,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.grid_view_outlined, color: primaryColor),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            _isSubmitted ? 'Leave Request' : 'Leave Request',
            style: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w800,
              fontSize: 22,
            ),
          ),
          actions: const [
            AppNotificationIcon(),
            SizedBox(width: 8),
          ],
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            child: _isSubmitted ? _buildSubmittedSuccessView() : _buildRequestFormView(),
          ),
        ),
      ),
    );
  }

  // ─── STATE 1: Request Leave Form ───────────
  Widget _buildRequestFormView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title & Subtitle
        const Text(
          'Request\nLeave',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: _titleDark,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Submit your absence request for review. Please ensure all documentation for sick leave or conferences is attached for timely approval.',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade700,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 24),

        // Form Card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFF2DED7)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFormLabel('LEAVE TYPE'),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE5CCC9)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedLeaveType,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down, color: primaryColor),
                    items: const [
                      DropdownMenuItem(value: 'Annual Leave', child: Text('Annual Leave')),
                      DropdownMenuItem(value: 'Wellness Day', child: Text('Wellness Day')),
                      DropdownMenuItem(value: 'Conference', child: Text('Conference')),
                      DropdownMenuItem(value: 'Sick Leave', child: Text('Sick Leave')),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedLeaveType = val);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Start Date
              _buildFormLabel('START DATE'),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: _pickStartDate,
                child: AbsorbPointer(
                  child: _buildInputField(
                    controller: _startDateController,
                    hint: 'Select Start Date',
                    suffixIcon: Icons.calendar_today_outlined,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // End Date
              _buildFormLabel('END DATE'),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: _pickEndDate,
                child: AbsorbPointer(
                  child: _buildInputField(
                    controller: _endDateController,
                    hint: 'Select End Date',
                    suffixIcon: Icons.calendar_today_outlined,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Context
              _buildFormLabel('CONTEXT / REASON'),
              const SizedBox(height: 6),
              _buildInputField(
                controller: _contextController,
                hint: 'Enter reason or context...',
                maxLines: 3,
              ),
              const SizedBox(height: 20),

              // Total Duration Box
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF9F6),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFF2DED7)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 16,
                          color: Colors.grey.shade700,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'TOTAL\nDURATION',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                            color: Colors.grey.shade700,
                            height: 1.15,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      _calculatedDurationText,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: primaryColor,
                        height: 1.15,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Submit Request Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Text(
                          'Submit Request',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 12),

              // Past Submissions Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WorkerLeaveHistoryScreen(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Past Submissions',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  // ─── STATE 2: Request Submitted (Dynamic Success View) ───────────
  Widget _buildSubmittedSuccessView() {
    return Column(
      children: [
        const SizedBox(height: 40),

        // Big Checkmark in Soft Circle
        Center(
          child: Container(
            width: 110,
            height: 110,
            decoration: const BoxDecoration(
              color: Color(0xFFFBECEB),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: 54,
                height: 54,
                decoration: const BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 36),

        // Request Submitted Heading
        const Text(
          'Request Submitted',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: _titleDark,
          ),
        ),
        const SizedBox(height: 14),

        // Message
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                height: 1.45,
              ),
              children: [
                const TextSpan(text: 'Your leave request for '),
                TextSpan(
                  text: '$_selectedLeaveType\n(${_startDateController.text} - ${_endDateController.text})',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _titleDark,
                  ),
                ),
                const TextSpan(
                  text: ' has been successfully\nsent to your manager for approval.',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 36),

        // Current Status Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
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
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF9F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.event_available_outlined,
                  color: Color(0xFF9E4723),
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CURRENT STATUS',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Pending Approval',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: _titleDark,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF07F54),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF5D6CE),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),

        // Back to Dashboard Button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DashboardScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            child: const Text(
              'Back to Dashboard',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),

        // View My Requests Button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const WorkerLeaveHistoryScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFBECEB),
              foregroundColor: const Color(0xFF9E4723),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'View My Requests',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9E4723),
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildFormLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.8,
        color: Colors.grey.shade600,
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    IconData? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5CCC9)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: _titleDark,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade400,
          ),
          suffixIcon: suffixIcon != null ? Icon(suffixIcon, size: 18, color: primaryColor) : null,
          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
        ),
      ),
    );
  }
}
