import 'package:flutter/material.dart';
import 'package:ripal_design/resource/widgets/checkered_placeholder.dart';
import 'package:ripal_design/resource/widgets/custom_bottom_nav_bar.dart';
import 'package:ripal_design/resource/controllers/role_guard.dart';
import 'package:ripal_design/resource/widgets/app_notification_icon.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
import 'package:ripal_design/screen/worker/worker_leave_history_screen.dart';
import 'package:ripal_design/screen/settings_screen.dart';
import 'package:ripal_design/screen/worker/worker_upload_files_screen.dart';

class WorkerProjectFilesScreen extends StatefulWidget {
  final bool showBackButton;

  const WorkerProjectFilesScreen({
    super.key,
    this.showBackButton = true,
  });

  @override
  State<WorkerProjectFilesScreen> createState() => _WorkerProjectFilesScreenState();
}

class _WorkerProjectFilesScreenState extends State<WorkerProjectFilesScreen> {
  static const Color primaryColor = Color(0xFF5A0000);
  static const Color _bgCream = Color(0xFFFFF7F2);
  static const Color _titleDark = Color(0xFF2A0501);
  static const Color _terracotta = Color(0xFFF07F54);

  int _currentIndex = 2;
  int _selectedFilter = 1; // 0: Contracts, 1: All Assets, 2: Blueprint

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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsScreen()),
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

  @override
  Widget build(BuildContext context) {
    return RoleGuardedScreen(
      allowedRoles: const ['worker', 'employee', 'admin'],
      child: Scaffold(
        backgroundColor: _bgCream,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: widget.showBackButton
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: primaryColor),
                  onPressed: () => Navigator.pop(context),
                )
              : IconButton(
                  icon: const Icon(Icons.grid_view_outlined, color: primaryColor),
                  onPressed: () {},
                ),
          title: const Text(
            'File View',
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Block
              const Text(
                'View Project\nFiles',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: _titleDark,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Access your complete architectural documentation, site media, and structural blueprints for 'The Zenith Penthouse'.",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),

              // Search Bar
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF9F6),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFF3D5CC)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey.shade500, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search blueprints, photos...',
                          hintStyle: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade500,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Upload File Button
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WorkerUploadFilesScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_circle_up_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                  label: const Text(
                    'Upload File',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 2,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Filter Chips
              Row(
                children: [
                  _buildFilterChip('Contracts', 0),
                  const SizedBox(width: 10),
                  _buildFilterChip('All Assets', 1),
                  const SizedBox(width: 10),
                  _buildFilterChip('Blueprint', 2),
                ],
              ),
              const SizedBox(height: 28),

              // ─── BLUEPRINTS SECTION ─────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.architecture, color: primaryColor, size: 18),
                      SizedBox(width: 6),
                      Text(
                        'Blueprints',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _titleDark,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'View All (12)',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _buildBlueprintCard(
                filename: 'Main_Level_HVAC.pdf',
                meta: '14.2 MB • Oct 12, 2023',
              ),
              const SizedBox(height: 14),
              _buildBlueprintCard(
                filename: 'Structural_Cross_Section',
                meta: '8.5 MB • Oct 15, 2023',
              ),
              const SizedBox(height: 28),

              // ─── CONTRACTS SECTION ──────────────────────────────
              const Row(
                children: [
                  Icon(Icons.description_outlined, color: primaryColor, size: 18),
                  SizedBox(width: 6),
                  Text(
                    'Contracts',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _titleDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildContractsContainer(),
              const SizedBox(height: 28),

              // ─── SITE PHOTOS SECTION ────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.camera_alt_outlined, color: primaryColor, size: 18),
                      SizedBox(width: 6),
                      Text(
                        'Site Photos',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _titleDark,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Browse Gallery',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildSitePhotosGrid(),
              const SizedBox(height: 28),

              // ─── WALKTHROUGH SECTION ───────────────────────────
              const Row(
                children: [
                  Icon(Icons.view_in_ar_outlined, color: primaryColor, size: 18),
                  SizedBox(width: 6),
                  Text(
                    'WalkThrough',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _titleDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildWalkThroughVideo(),
              const SizedBox(height: 14),
              _buildMediaItem('Exterior_Night_View.jpg', 'Rendered Oct 10 • 12 MB'),
              const SizedBox(height: 10),
              _buildMediaItem('Master_Bath_A.jpg', 'Rendered Oct 11 • 15 MB'),
              const SizedBox(height: 10),
              _buildMediaItem('Terrace_Layout_V4.png', 'Rendered Oct 14 • 8 MB'),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildFilterChip(String label, int index) {
    final bool isSelected = _selectedFilter == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? _terracotta : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? _terracotta : const Color(0xFFE2C9C3),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildBlueprintCard({
    required String filename,
    required String meta,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF2DED7)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              'assets/project/behance_239114219_12.webp',
              height: 110,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const CheckeredPlaceholder(
                height: 110,
                width: double.infinity,
                squareSize: 12,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      filename,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: _titleDark,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      meta,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.more_vert,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContractsContainer() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF1EC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF2DED7)),
      ),
      child: Column(
        children: [
          _buildContractItem('Standard_Service_Agreement.pdf', 'Signed • Oct 01, 2023'),
          const SizedBox(height: 10),
          _buildContractItem('Permit_Applications_V2.zip', 'Pending • Oct 18, 2023'),
          const SizedBox(height: 10),
          _buildContractItem('Vendor_Invoices_Sept.pdf', 'Paid • Sept 30, 2023'),
        ],
      ),
    );
  }

  Widget _buildContractItem(String name, String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF2DED7)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: _titleDark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSitePhotosGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        4,
        (index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFF2DED7)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: const CheckeredPlaceholder(squareSize: 8),
          ),
        ),
      ),
    );
  }

  Widget _buildWalkThroughVideo() {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF5A6065),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/project/behance_239114219_14.webp',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) => const CheckeredPlaceholder(
                color1: Color(0xFF6B7176),
                color2: Color(0xFF5F656A),
                squareSize: 14,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.35),
              ),
            ),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 28,
              ),
            ),
            Positioned(
              left: 14,
              bottom: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Final Design Concept',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'The Living Sanctum.mp4',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaItem(String name, String meta) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF2DED7)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFF2DED7)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: const CheckeredPlaceholder(squareSize: 4),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: _titleDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  meta,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
