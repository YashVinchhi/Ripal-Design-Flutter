import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/mobile_frame.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import '../routes.dart';

class ProjectFilesScreen extends StatefulWidget {
  const ProjectFilesScreen({super.key});

  @override
  State<ProjectFilesScreen> createState() => _ProjectFilesScreenState();
}

class _ProjectFilesScreenState extends State<ProjectFilesScreen> {
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _allFiles = [
    {
      'name': 'Modernist_Villa_Phase_01.dwg',
      'type': 'DWG',
      'size': '42.8 MB',
      'date': 'Jun 01, 2026',
      'icon': Icons.architecture_rounded,
    },
    {
      'name': 'Structural_Framing_Spec_v3.pdf',
      'type': 'PDF',
      'size': '14.2 MB',
      'date': 'May 28, 2026',
      'icon': Icons.picture_as_pdf_outlined,
    },
    {
      'name': 'Material_Swatches_HD.zip',
      'type': 'ZIP',
      'size': '68.5 MB',
      'date': 'May 15, 2026',
      'icon': Icons.folder_zip_outlined,
    },
    {
      'name': 'Exterior_Render_Final.jpg',
      'type': 'Image',
      'size': '8.4 MB',
      'date': 'Apr 25, 2026',
      'icon': Icons.image_outlined,
    },
    {
      'name': 'Foundation_Beam_Layout.dwg',
      'type': 'DWG',
      'size': '31.0 MB',
      'date': 'Apr 12, 2026',
      'icon': Icons.architecture_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredFiles = _selectedFilter == 'All'
        ? _allFiles
        : _allFiles.where((f) => f['type'] == _selectedFilter).toList();

    return MobileFrame(
      child: Scaffold(
        backgroundColor: AppColors.background,
        bottomNavigationBar: const RipalBottomNavBar(currentIndex: 2),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header with Back Arrow
                AppHeader(
                  title: 'Project Files',
                  showBack: true,
                  showAvatar: true,
                  onBack: () => Navigator.of(context).maybePop(),
                ),

                const SizedBox(height: 6),

                // 2. Title & Subtitle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Architectural Archive', style: AppTypography.largeTitle.copyWith(fontSize: 22)),
                      const SizedBox(height: 4),
                      Text('All approved blueprints, CAD diagrams and documentation', style: AppTypography.bodyText),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // 3. Filter Pills
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: ['All', 'DWG', 'PDF', 'ZIP', 'Image'].map((filter) {
                      final isSelected = _selectedFilter == filter;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedFilter = filter),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary : AppColors.surface,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected ? AppColors.primary : AppColors.border,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            filter,
                            style: AppTypography.cardSubtitle.copyWith(
                              color: isSelected ? Colors.white : AppColors.textPrimary,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 18),

                // 4. File List
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
                      itemCount: filteredFiles.length,
                      separatorBuilder: (context, index) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final file = filteredFiles[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          child: Row(
                            children: [
                              Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceSecondary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  file['icon'] as IconData,
                                  color: AppColors.primary,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      file['name'] as String,
                                      style: AppTypography.cardTitle.copyWith(fontSize: 14),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      '${file['size']} • ${file['date']}',
                                      style: AppTypography.cardSubtitle.copyWith(fontSize: 11.5),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.file_download_outlined, color: AppColors.primary, size: 22),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Downloading ${file['name']}...'),
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

                const SizedBox(height: 24),

                // 5. Upload New Blueprint Card Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, AppRoutes.uploadFiles),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceSecondary,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add_circle_outline, color: AppColors.primary, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Upload New Blueprints',
                            style: AppTypography.cardTitle.copyWith(
                              color: AppColors.primary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
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
