import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/mobile_frame.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/workflow_stepper.dart';
import '../data/mock_data.dart';
import '../models/member_model.dart';

class ExecutionCrewScreen extends StatelessWidget {
  final String projectName;

  const ExecutionCrewScreen({
    super.key,
    this.projectName = 'Test 1',
  });

  void _showMemberDetailModal(BuildContext context, MemberModel member) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.surfaceSecondary,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Text(
                  member.initials,
                  style: AppTypography.cardTitle.copyWith(
                    color: AppColors.primary,
                    fontSize: 22,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(member.name, style: AppTypography.largeTitle.copyWith(fontSize: 20)),
                  if (member.isVerified) ...[
                    const SizedBox(width: 6),
                    const Icon(Icons.verified, color: AppColors.primary, size: 18),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              Text(
                member.role.toUpperCase(),
                style: AppTypography.kicker.copyWith(fontSize: 11),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 12),
              _detailRow(Icons.email_outlined, 'Email', member.email),
              const SizedBox(height: 10),
              _detailRow(Icons.phone_outlined, 'Phone', member.phone ?? '+91 98765 43210'),
              const SizedBox(height: 10),
              _detailRow(Icons.apartment_outlined, 'Department', member.department ?? 'Execution Crew'),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: 12),
        Text('$label: ', style: AppTypography.cardSubtitle.copyWith(fontWeight: FontWeight.w600)),
        Expanded(
          child: Text(value, style: AppTypography.cardSubtitle, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MobileFrame(
      child: Scaffold(
        backgroundColor: AppColors.background,
        bottomNavigationBar: const RipalBottomNavBar(currentIndex: -1),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header with Kicker and Back
                AppHeader(
                  title: projectName,
                  kicker: 'PROJECT DETAILS',
                  showBack: true,
                  showAvatar: true,
                  onBack: () => Navigator.of(context).maybePop(),
                ),

                const SizedBox(height: 4),

                // 2. Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Execution Crew',
                    style: AppTypography.largeTitle.copyWith(fontSize: 22),
                  ),
                ),

                const SizedBox(height: 6),

                // 3. Workflow Stepper (Step 2 Active)
                const WorkflowStepper(activeStep: 2),

                const SizedBox(height: 10),

                // 4. Crew Members Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border, width: 1),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: MockData.executionCrew.length,
                      separatorBuilder: (context, index) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final member = MockData.executionCrew[index];
                        return InkWell(
                          onTap: () => _showMemberDetailModal(context, member),
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            child: Row(
                              children: [
                                // Initials Badge
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceSecondary,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    member.initials,
                                    style: AppTypography.cardTitle.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),

                                // Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        member.name,
                                        style: AppTypography.cardTitle.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        member.role,
                                        style: AppTypography.cardSubtitle.copyWith(
                                          fontSize: 12.5,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        member.email,
                                        style: AppTypography.cardSubtitle.copyWith(
                                          fontSize: 12,
                                          color: AppColors.textMuted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
