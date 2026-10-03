import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ripal_design/resource/main_scaffold.dart';
import 'package:ripal_design/resource/portfolio_card.dart';

import 'package:ripal_design/screen/client_contactus.dart';
import 'package:ripal_design/screen/client_project_view.dart';
import 'package:ripal_design/screen/client_applay.dart';
import 'package:ripal_design/screen/settings_screen.dart';

import 'package:ripal_design/screen/admin_create_project.dart';
import 'package:ripal_design/screen/admin_leave_screen.dart';
import 'package:ripal_design/screen/admin_user_management_screen.dart';

import 'package:ripal_design/screen/admin_finance_screen.dart';
import 'package:ripal_design/screen/admin_invoice_screen.dart';
import 'package:ripal_design/screen/admin_file_view_screen.dart';
import 'package:ripal_design/screen/admin_upload_file_screen.dart';
import 'package:ripal_design/screen/admin_project_detail_screen.dart';
import 'package:ripal_design/screen/admin_leave_history_screen.dart';
import 'package:ripal_design/screen/client_project_detail_screen.dart';

import 'package:ripal_design/resource/checkered_placeholder.dart';
import 'package:ripal_design/screen/worker_activity_screen.dart';
import 'package:ripal_design/screen/worker_leave_history_screen.dart';
import 'package:ripal_design/screen/worker_project_files_screen.dart';
import 'package:ripal_design/screen/worker_project_view_screen.dart';
import 'package:ripal_design/screen/worker_settings_screen.dart';
import 'package:ripal_design/screen/worker_upload_files_screen.dart';
import 'package:ripal_design/screen/worker_view_member_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Color titleColor = const Color(0xFF5A0000);
  final Color primaryColor = const Color(0xFF9E4723);
  int _currentIndex = 0;
  String role = 'admin';
  String userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role') ?? 'admin';
      userName = prefs.getString('userName') ?? '';
    });
  }

  // ─── Admin navigation ─────────────────────────────────────────────────────
  void _onAdminNavTap(int index) {
    if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminLeaveScreen()));
      return;
    }
    if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminFinanceScreen()));
      return;
    }
    if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
      return;
    }
    setState(() => _currentIndex = index);
  }

  void _onAdminFabPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminCreateProject()));
  }

  // ─── Worker navigation ────────────────────────────────────────────────────
  void _onWorkerNavTap(int index) {
    if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkerLeaveHistoryScreen()));
      return;
    }
    if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkerUploadFilesScreen()));
      return;
    }
    if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkerSettingsScreen()));
      return;
    }
    setState(() => _currentIndex = index);
  }

  void _onWorkerFabPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminUploadFileScreen()));
  }

  // ─── Employee navigation ─────────────────────────────────────────────────
  void _onEmployeeNavTap(int index) {
    if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminLeaveHistoryScreen()));
      return;
    }
    if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminUploadFileScreen()));
      return;
    }
    if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
      return;
    }
    setState(() => _currentIndex = index);
  }

  void _onEmployeeFabPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminUploadFileScreen()));
  }

  // ─── Client navigation (IndexedStack-based, no push) ─────────────────────
  void _onClientNavTap(int index) {
    setState(() => _currentIndex = index);
  }

  void _onClientFabPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ClientApplay()));
  }

  @override
  Widget build(BuildContext context) {
    final normalizedRole = role.toLowerCase().trim();
    if (normalizedRole == 'client') {
      return _buildClientShell();
    } else if (normalizedRole == 'worker') {
      return _buildWorkerShell();
    } else if (normalizedRole == 'employee') {
      return _buildEmployeeShell();
    }
    return _buildAdminShell();
  }

  // ─── Client Shell: IndexedStack tab navigation ────────────────────────────
  Widget _buildClientShell() {
    return MainScaffold(
      role: 'client',
      currentIndex: _currentIndex,
      onFabPressed: _onClientFabPressed,
      onNavTap: _onClientNavTap,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // Tab 0: Home
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: _buildClientHomeBody(),
            ),
          ),
          // Tab 1: Projects
          const ClientProjectView(embeddedMode: true),
          // Tab 2: Contact
          const ClientContactus(embeddedMode: true),
          // Tab 3: Profile
          const SettingsScreen(embeddedMode: true),
        ],
      ),
    );
  }

  // ─── Worker Shell ────────────────────────────────────────────────────────
  Widget _buildWorkerShell() {
    return MainScaffold(
      role: 'worker',
      currentIndex: _currentIndex,
      onFabPressed: _onWorkerFabPressed,
      onNavTap: _onWorkerNavTap,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: _buildWorkerBody(),
        ),
      ),
    );
  }

  // ─── Employee Shell ───────────────────────────────────────────────────────
  Widget _buildEmployeeShell() {
    return MainScaffold(
      role: 'employee',
      currentIndex: _currentIndex,
      onFabPressed: _onEmployeeFabPressed,
      onNavTap: _onEmployeeNavTap,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: _buildAdminBody(),
        ),
      ),
    );
  }

  // ─── Admin Shell: unchanged push-based navigation ─────────────────────────
  Widget _buildAdminShell() {
    return MainScaffold(
      role: 'admin',
      currentIndex: _currentIndex,
      onFabPressed: _onAdminFabPressed,
      onNavTap: _onAdminNavTap,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: _buildAdminBody(),
        ),
      ),
    );
  }


  // ─── Client Home Tab Body ─────────────────────────────────────────────────
  Widget _buildClientHomeBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Welcome Header
        Text(
          'Welcome\nour Side',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: titleColor,
            height: 1.1,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Real-time structural performance and\nfinancial overview.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 32),

        // Active Portfolio Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Active\nPortfolio',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: titleColor,
                height: 1.1,
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => _currentIndex = 1),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'View',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Management',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward,
                    color: primaryColor,
                    size: 14,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Portfolio Cards
        PortfolioCard(
          title: 'Sahara Retreat',
          value: '1.2L',
          badgeText: 'PLANNING',
          badgeColor: const Color(0xFF6C2B2B),
          progress: 0.35,
          progressText: '35% Completed',
          imageUrl: 'assets/project/behance_239114219_04.png',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ClientProjectDetailScreen(
                  projectName: 'Sahara Retreat',
                  clientName: 'Sahara Group',
                  budget: '₹1,20,000',
                  timeline: 'Oct 2023 - Dec 2024',
                  type: 'Planning & Design',
                  location: 'Resort District — Desert Hills',
                  progress: 0.35,
                  progressLabel: '35% Completed',
                  imageUrl: 'assets/project/behance_239114219_04.png',
                ),
              ),
            );
          },
        ),
        PortfolioCard(
          title: 'The Vertical Garden',
          value: '2.8Cr',
          badgeText: 'CONSTRUCTION',
          badgeColor: const Color(0xFFA0604A),
          progress: 0.78,
          progressText: '78% Completed',
          imageUrl: 'assets/project/behance_239114219_05.png',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ClientProjectDetailScreen(
                  projectName: 'The Vertical Garden',
                  clientName: 'Eco Urban Developments',
                  budget: '₹2,80,00,000',
                  timeline: 'Jan 2023 - Dec 2024',
                  type: 'Commercial Construction',
                  location: 'Metropolitan Center',
                  progress: 0.78,
                  progressLabel: '78% Completed',
                  imageUrl: 'assets/project/behance_239114219_05.png',
                ),
              ),
            );
          },
        ),
        PortfolioCard(
          title: 'Lake Obsidian',
          value: '8.4Cr',
          badgeText: 'FINISHING',
          badgeColor: const Color(0xFF3B5274),
          progress: 0.92,
          progressText: '92% Completed',
          imageUrl: 'assets/project/behance_239114219_12.png',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ClientProjectDetailScreen(
                  projectName: 'Lake Obsidian',
                  clientName: 'Obsidian Living Ltd',
                  budget: '₹8,40,00,000',
                  timeline: 'May 2022 - Aug 2024',
                  type: 'Residential Luxury',
                  location: 'Lakefront Sanctuary',
                  progress: 0.92,
                  progressLabel: '92% Completed',
                  imageUrl: 'assets/project/behance_239114219_12.png',
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // ─── Admin Body (unchanged) ────────────────────────────────────────────────
  Widget _buildAdminBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'DASHBOARD OVERVIEW',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2),
        ),
        const SizedBox(height: 8),
        Text(
          'Welcome, ${userName.isNotEmpty ? userName : 'Yash'}',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: titleColor),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700, height: 1.4),
            children: const [
              TextSpan(text: 'You have '),
              TextSpan(text: '12 Active Projects\n', style: TextStyle(color: Color(0xFF9E4723), fontWeight: FontWeight.bold)),
              TextSpan(text: 'requiring your attention today.'),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Metric Cards
        _buildMetricCard(
          iconData: Icons.account_balance_wallet_outlined,
          iconBgColor: const Color(0xFFF0B392),
          title: 'TOTAL REVENUE',
          value: '₹4,280,000',
          topRightText: '+12.5%',
          topRightColor: Colors.green,
        ),
        const SizedBox(height: 16),
        _buildMetricCard(
          iconData: Icons.architecture,
          iconBgColor: const Color(0xFFC3D2F0),
          title: 'ACTIVE PROJECTS',
          value: '15',
          topRightText: '48 Active',
          topRightColor: const Color(0xFF9E4723),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ClientProjectView()),
            );
          },
        ),
        const SizedBox(height: 16),
        _buildMetricCard(
          iconData: Icons.group_outlined,
          iconBgColor: const Color(0xFFF2D1CC),
          title: 'TEAM VELOCITY',
          value: '30',
          topRightText: '8 New',
          topRightColor: Colors.black87,
        ),
        const SizedBox(height: 32),

        // Projects Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Projects', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: titleColor)),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ClientProjectView()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Row(
                  children: [
                    Text('EXPLORE PROJECTS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                    const SizedBox(width: 4),
                    Icon(Icons.arrow_forward, size: 16, color: Colors.grey.shade700),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildProjectCard(
                'Skyline Plaza',
                'Phase 3: Structural Framework',
                '75% Done',
                0.75,
                'ACTIVE',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminProjectDetailScreen(
                        projectName: 'Skyline Plaza',
                        clientName: 'Vanguard Properties',
                        budget: '₹2,50,000',
                        timeline: 'Jan 2024 - Dec 2024',
                        type: 'Commercial Architecture',
                        location: 'Skyline Avenue — Phase 3',
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 16),
              _buildProjectCard(
                'Azure Heights',
                'Phase 2: Foundation',
                '30% Done',
                0.3,
                'REVIEW',
                badgeColor: const Color(0xFF9E4723),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminProjectDetailScreen(
                        projectName: 'Azure Heights',
                        clientName: 'Apex Real Estate',
                        budget: '₹1,80,000',
                        timeline: 'Mar 2024 - Nov 2024',
                        type: 'Residential Luxury',
                        location: 'Pacific Coast Highway — Bay Area',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Quick Actions
        Text('Quick Actions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: titleColor)),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.3,
          children: [
            _buildQuickAction(Icons.add_circle_outline, 'NEW PROJECT', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminCreateProject()));
            }),
            _buildQuickAction(Icons.cloud_upload_outlined, 'UPLOAD FILES', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminUploadFileScreen()));
            }),
            _buildQuickAction(Icons.person_outline, 'USERS', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminUserManagementScreen()));
            }),
            _buildQuickAction(Icons.description_outlined, 'FILE VIEWS', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminFileViewScreen()));
            }),
            _buildQuickAction(Icons.event_busy_outlined, 'LEAVE MANGE', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminLeaveScreen()));
            }),
            _buildQuickAction(Icons.receipt_long_outlined, 'FINANCE', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminFinanceScreen()));
            }),
            _buildQuickAction(Icons.payments_outlined, 'INVOICE', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminInvoiceScreen()));
            }),
            _buildQuickAction(Icons.settings_outlined, 'SETTINGS', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
            }),
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildMetricCard({
    required IconData iconData,
    required Color iconBgColor,
    required String title,
    required String value,
    required String topRightText,
    required Color topRightColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text(topRightText, style: TextStyle(color: topRightColor, fontWeight: FontWeight.bold, fontSize: 14)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(iconData, color: Colors.black87, size: 24),
                ),
                const SizedBox(height: 20),
                Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.0)),
                const SizedBox(height: 8),
                Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: titleColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(
    String title,
    String subtitle,
    String progressText,
    double progress,
    String badgeText, {
    Color badgeColor = Colors.black87,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 240,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    'assets/project/behance_239114219_13.png',
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(badgeText, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: titleColor)),
                      Text(progressText, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: const Color(0xFFFADCDC),
                    valueColor: AlwaysStoppedAnimation<Color>(titleColor),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFFADCDC), width: 1.5),
              ),
              child: Icon(icon, color: titleColor, size: 24),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
          ],
        ),
      ),
    );
  }

  // ═════════════════════════════════════════════════════════════════
  // ─── WORKER DASHBOARD BODY (Worker Dashborad.png) ───────────────
  // ═════════════════════════════════════════════════════════════════
  Widget _buildWorkerBody() {
    final displayName = userName.isNotEmpty ? userName : 'Rachit';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ─── DASHBOARD OVERVIEW HEADER ──────────────────────
        const Text(
          'DASHBOARD OVERVIEW',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Color(0xFF7A6666),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Welcome, $displayName',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1E1E1E),
            height: 1.15,
          ),
        ),
        const SizedBox(height: 6),
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF555555),
              height: 1.35,
            ),
            children: [
              TextSpan(text: 'You have '),
              TextSpan(
                text: '12 Active Projects',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9E4723),
                ),
              ),
              TextSpan(text: '\nrequiring your attention today.'),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // ─── STAT CARD 1: ACTIVE PROJECTS ───────────────────
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
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFEBEFFC),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.architecture,
                  color: Color(0xFF5B78E6),
                  size: 20,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'ACTIVE PROJECTS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                  color: Color(0xFF7A6666),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '15',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E1E1E),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ─── STAT CARD 2: TEAM VELOCITY ────────────────────
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
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBECEB),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.groups_outlined,
                      color: Color(0xFF5A0000),
                      size: 20,
                    ),
                  ),
                  const Text(
                    '8 New',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF7A6666),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Text(
                'TEAM VELOCITY',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                  color: Color(0xFF7A6666),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '30',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E1E1E),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // ─── SECTION: Assigned Projects ─────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Assigned Projects',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1E1E1E),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WorkerProjectViewScreen(),
                  ),
                );
              },
              child: Row(
                children: const [
                  Text(
                    'EXPLORE PROJECTS',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      color: Color(0xFF8B3A1C),
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF8B3A1C),
                    size: 14,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Horizontal Project Cards
        SizedBox(
          height: 245,
          child: ListView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            children: [
              _buildWorkerProjectCard(
                title: 'Skyline Plaza',
                subtitle: 'Phase 3: Structural Framework',
                progress: 0.75,
                progressText: '75% Done',
                badgeText: 'ACTIVE',
                badgeColor: const Color(0xFF232323),
                progressColor: titleColor,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WorkerProjectViewScreen(
                        projectName: 'Skyline Plaza',
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 14),
              _buildWorkerProjectCard(
                title: 'Azure Residence',
                subtitle: 'Phase 2: Interior Finishing',
                progress: 0.40,
                progressText: '40% Done',
                badgeText: 'REVIEW',
                badgeColor: const Color(0xFF8B3A1C),
                progressColor: const Color(0xFF8B3A1C),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WorkerProjectViewScreen(
                        projectName: 'Azure Residence',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // ─── SECTION: Quick Actions ─────────────────────────
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1E1E1E),
          ),
        ),
        const SizedBox(height: 16),

        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 1.15,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildWorkerQuickAction(
              icon: Icons.visibility_outlined,
              title: 'VIEW PROJECT',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WorkerProjectViewScreen(),
                  ),
                );
              },
            ),
            _buildWorkerQuickAction(
              icon: Icons.cloud_upload_outlined,
              title: 'UPLOAD FILES',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WorkerUploadFilesScreen(),
                  ),
                );
              },
            ),
            _buildWorkerQuickAction(
              icon: Icons.person_outline,
              title: 'TEAM VIEW',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WorkerViewMemberScreen(),
                  ),
                );
              },
            ),
            _buildWorkerQuickAction(
              icon: Icons.description_outlined,
              title: 'FILE VIEWS',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WorkerProjectFilesScreen(),
                  ),
                );
              },
            ),
            _buildWorkerQuickAction(
              icon: Icons.event_note_outlined,
              title: 'LEAVE MANGE',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WorkerLeaveHistoryScreen(),
                  ),
                );
              },
            ),
            _buildWorkerQuickAction(
              icon: Icons.show_chart,
              title: 'ACTIVITY',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WorkerActivityScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildWorkerProjectCard({
    required String title,
    required String subtitle,
    required double progress,
    required String progressText,
    required String badgeText,
    required Color badgeColor,
    required Color progressColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 255,
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Checkered Image area with Badge
              SizedBox(
                height: 125,
                width: double.infinity,
                child: Stack(
                  children: [
                    const CheckeredPlaceholder(
                      height: 125,
                      width: double.infinity,
                      squareSize: 12,
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          badgeText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Content
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E1E1E),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          progressText,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: const Color(0xFFFBECEB),
                        valueColor: AlwaysStoppedAnimation(progressColor),
                        minHeight: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWorkerQuickAction({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFFF9F6),
                border: Border.all(color: const Color(0xFFF0DCD5), width: 1.5),
              ),
              child: Icon(icon, color: titleColor, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
                color: Color(0xFF1E1E1E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
