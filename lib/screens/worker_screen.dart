import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/mobile_frame.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import '../data/mock_data.dart';

class WorkerScreen extends StatefulWidget {
  const WorkerScreen({super.key});

  @override
  State<WorkerScreen> createState() => _WorkerScreenState();
}

class _WorkerScreenState extends State<WorkerScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final workers = MockData.executionCrew.where((w) {
      return w.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          w.role.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          w.email.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

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
                // 1. Header with Back Arrow
                AppHeader(
                  title: 'Workers Directory',
                  showBack: true,
                  showAvatar: true,
                  onBack: () => Navigator.of(context).maybePop(),
                ),

                const SizedBox(height: 8),

                // 2. Search Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.border, width: 1),
                    ),
                    child: TextField(
                      onChanged: (val) => setState(() => _searchQuery = val),
                      style: AppTypography.inputValue,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.search, color: AppColors.textSecondary, size: 20),
                        hintText: 'Search workers by name or email...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 3. Worker Cards
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
                      itemCount: workers.length,
                      separatorBuilder: (context, index) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final member = workers[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          child: Row(
                            children: [
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
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          member.name,
                                          style: AppTypography.cardTitle.copyWith(fontSize: 15),
                                        ),
                                        if (member.isVerified) ...[
                                          const SizedBox(width: 4),
                                          const Icon(Icons.verified, color: AppColors.primary, size: 16),
                                        ],
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${member.role} • ${member.department ?? "Execution"}',
                                      style: AppTypography.cardSubtitle.copyWith(fontSize: 12),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      member.email,
                                      style: AppTypography.cardSubtitle.copyWith(
                                        fontSize: 11.5,
                                        color: AppColors.textMuted,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.phone_outlined, color: AppColors.primary, size: 20),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Calling ${member.name} (${member.phone})...'),
                                      backgroundColor: AppColors.primary,
                                    ),
                                  );
                                },
                              ),
                            ],
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
