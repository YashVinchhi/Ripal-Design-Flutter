import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/mobile_frame.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../routes.dart';

class LeaveRequestScreen extends StatefulWidget {
  const LeaveRequestScreen({super.key});

  @override
  State<LeaveRequestScreen> createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  String _selectedType = 'Annual Leave';
  final _startDateController = TextEditingController(text: 'Oct 10, 2024');
  final _endDateController = TextEditingController(text: 'Oct 24, 2024');
  final _contextController = TextEditingController();

  final List<String> _leaveTypes = [
    'Annual Leave',
    'Sick Leave',
    'Wellness Day',
    'Conference',
    'Casual Leave',
  ];

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _contextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobileFrame(
      child: Scaffold(
        backgroundColor: AppColors.background,
        bottomNavigationBar: const RipalBottomNavBar(currentIndex: 1),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header with Logo and Avatar
                AppHeader(
                  title: 'Leave Request',
                  showLogo: true,
                  showAvatar: true,
                  onAvatarTap: () => Navigator.pushNamed(context, AppRoutes.settings),
                ),

                const SizedBox(height: 10),

                // 2. Headline & Subtitle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Request\nLeave',
                        style: AppTypography.largeTitle.copyWith(fontSize: 28, height: 1.15),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Submit your absence request for\nreview. Please ensure all documentation\nfor sick leave or conferences is\nattached for timely approval.',
                        style: AppTypography.bodyText,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 3. Form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Selection Type
                      Text(
                        'Selection Type',
                        style: AppTypography.fieldLabel,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.border, width: 1),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedType,
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSecondary),
                            items: _leaveTypes.map((type) {
                              return DropdownMenuItem(
                                value: type,
                                child: Text(type, style: AppTypography.inputValue),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) setState(() => _selectedType = val);
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Start Date
                      CustomTextField(
                        label: 'START DATE',
                        placeholder: 'Enter Start Date',
                        controller: _startDateController,
                        trailing: const Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.textSecondary),
                      ),

                      const SizedBox(height: 16),

                      // End Date
                      CustomTextField(
                        label: 'END DATE',
                        placeholder: 'Enter End Date',
                        controller: _endDateController,
                        trailing: const Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.textSecondary),
                      ),

                      const SizedBox(height: 16),

                      // Context
                      CustomTextField(
                        label: 'CONTEXT',
                        placeholder: 'Enter Your Context',
                        controller: _contextController,
                        maxLines: 4,
                      ),

                      const SizedBox(height: 20),

                      // Total Duration Card
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceSecondary,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border, width: 1),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_month_outlined, color: AppColors.primary, size: 24),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'TOTAL\nDURATION',
                                  style: AppTypography.kicker.copyWith(fontSize: 9.5, height: 1.2),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              '5 Work\nDays',
                              textAlign: TextAlign.right,
                              style: AppTypography.cardTitle.copyWith(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Submit Request Button
                      PrimaryButton(
                        text: 'Submit Request',
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.leaveSubmitted);
                        },
                      ),

                      const SizedBox(height: 12),

                      // Past Submissions Button
                      PrimaryButton(
                        text: 'Past Submissions',
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.leaveHistory);
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
