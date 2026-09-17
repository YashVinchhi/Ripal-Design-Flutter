import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/mobile_frame.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/workflow_stepper.dart';
import '../widgets/project_card.dart';
import '../data/mock_data.dart';
import '../routes.dart';

class ProjectViewScreen extends StatelessWidget {
  const ProjectViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final project = MockData.obsidianHouse;

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
                // 1. Header with Back Arrow and Title
                AppHeader(
                  title: 'THE OBSIDIAN HOUSE',
                  showBack: true,
                  showAvatar: true,
                  onAvatarTap: () => Navigator.pushNamed(context, AppRoutes.settings),
                  onBack: () => Navigator.of(context).maybePop(),
                ),

                const SizedBox(height: 4),

                // 2. Workflow Stepper (Step 1 Active)
                const WorkflowStepper(activeStep: 1),

                const SizedBox(height: 12),

                // 3. Hero Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: const Color(0xFF383838),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: CustomPaint(
                            size: const Size(double.infinity, 220),
                            painter: BlueprintGridPainter(),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Color(0xCC1A1A1A)],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      'UNDER CONSTRUCTION',
                                      style: AppTypography.badge.copyWith(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.25),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      '75% COMPLETE',
                                      style: AppTypography.badge.copyWith(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    project.title,
                                    style: AppTypography.largeTitle.copyWith(
                                      color: Colors.white,
                                      fontSize: 22,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on_outlined, size: 14, color: Colors.white70),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          project.location ?? '',
                                          style: AppTypography.cardSubtitle.copyWith(
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                // 4. Project Metadata Grid
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _metaRow('CLIENT', project.client ?? 'Vanguard Properties'),
                      const SizedBox(height: 12),
                      _metaRow('BUDGET', project.budget ?? '₹12,50,000'),
                      const SizedBox(height: 12),
                      _metaRow('TIMELINE', project.timeline ?? 'Oct 2023 - Dec 2024'),
                      const SizedBox(height: 12),
                      _metaRow('TYPE', project.type ?? 'Residential Luxury'),
                    ],
                  ),
                ),

                const SizedBox(height: 26),

                // 5. Key Milestones Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Key Milestones',
                    style: AppTypography.largeTitle.copyWith(fontSize: 22),
                  ),
                ),
                const SizedBox(height: 16),

                // Timeline Milestones
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: project.milestones.asMap().entries.map((entry) {
                      final index = entry.key;
                      final m = entry.value;
                      final isLast = index == project.milestones.length - 1;
                      final isActive = m.status == 'Active';

                      return IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Timeline dot & line
                            Column(
                              children: [
                                Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                    color: isActive ? AppColors.primary : const Color(0xFFD4C2BD),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                if (!isLast)
                                  Expanded(
                                    child: Container(
                                      width: 1.5,
                                      color: const Color(0xFFD4C2BD),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(width: 14),

                            // Milestone Card
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 18),
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.border, width: 1),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          m.title,
                                          style: AppTypography.cardTitle.copyWith(fontSize: 14.5),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: isActive ? AppColors.surfaceSecondary : const Color(0xFFF3ECE9),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            m.status,
                                            style: AppTypography.badge.copyWith(
                                              color: isActive ? AppColors.primary : AppColors.textSecondary,
                                              fontSize: 9.5,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      m.description,
                                      style: AppTypography.cardSubtitle.copyWith(fontSize: 12.5),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 16),

                // 6. Project Team Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('PROJECT TEAM', style: AppTypography.kicker),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _teamMemberCard(
                        name: 'Rajibul Sheikh',
                        role: 'Lead Architect',
                        initials: 'RS',
                      ),
                      const SizedBox(height: 10),
                      _teamMemberCard(
                        name: 'Yash Vinchhi',
                        role: 'Structural Lead',
                        initials: 'YV',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 7. Site Gallery Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('SITE GALLERY', style: AppTypography.kicker),
                      Text('VIEW ALL', style: AppTypography.actionLink),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: List.generate(3, (index) {
                      return Expanded(
                        child: Container(
                          height: 85,
                          margin: EdgeInsets.only(right: index < 2 ? 10 : 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border, width: 1),
                            color: const Color(0xFFF6F0ED),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CustomPaint(
                              painter: BlueprintGridPainter(),
                            ),
                          ),
                        ),
                      );
                    }),
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

  Widget _metaRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(label, style: AppTypography.kicker.copyWith(fontSize: 10.5)),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTypography.cardTitle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _teamMemberCard({
    required String name,
    required String role,
    required String initials,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surfaceSecondary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              initials,
              style: AppTypography.cardTitle.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTypography.cardTitle.copyWith(fontSize: 14.5)),
                const SizedBox(height: 2),
                Text(role, style: AppTypography.cardSubtitle.copyWith(fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.verified, color: AppColors.primary, size: 18),
        ],
      ),
    );
  }
}
