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

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Color titleColor = const Color(0xFF5A0000);
  final Color primaryColor = const Color(0xFF9E4723);
  int _currentIndex = 0;
  String role = 'client';

  @override
  void initState() {
    super.initState();
    _loadRole();
  }

  Future<void> _loadRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role') ?? 'client';
    });
  }

  void _onNavTap(int index) {
    if (role == 'admin') {
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
    } else {
      if (index == 1) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ClientProjectView()));
        return;
      }
      if (index == 2) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ClientContactus()));
        return;
      }
      if (index == 3) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
        return;
      }
    }
    setState(() => _currentIndex = index);
  }

  void _onFabPressed() {
    if (role == 'admin') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminCreateProject()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ClientApplay()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: _currentIndex,
      onFabPressed: _onFabPressed,
      onNavTap: _onNavTap,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: role == 'admin' 
              ? const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
              : const EdgeInsets.all(24.0),
          child: role == 'admin' ? _buildAdminBody() : _buildClientBody(),
        ),
      ),
    );
  }

  Widget _buildClientBody() {
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
              onTap: () {},
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
        const PortfolioCard(
          title: 'Sahara Retreat',
          value: '1.2L',
          badgeText: 'PLANNING',
          badgeColor: Color(0xFF6C2B2B),
          progress: 0.35,
          progressText: '35% Completed',
        ),
        const PortfolioCard(
          title: 'The Vertical Garden',
          value: '2.8Cr',
          badgeText: 'CONSTRUCTION',
          badgeColor: Color(0xFFA0604A),
          progress: 0.78,
          progressText: '78% Completed',
        ),
        const PortfolioCard(
          title: 'Lake Obsidian',
          value: '8.4Cr',
          badgeText: 'FINISHING',
          badgeColor: Color(0xFF3B5274),
          progress: 0.92,
          progressText: '92% Completed',
        ),
      ],
    );
  }

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
          'Welcome, Rajibul',
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
                    MaterialPageRoute(builder: (context) => const ClientProjectView()),
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
                    MaterialPageRoute(builder: (context) => const ClientProjectView()),
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
            _buildQuickAction(Icons.money_outlined, 'INVOICE', onTap: () {
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
                Container(
                  height: 120,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Center(
                    child: Icon(Icons.image_outlined, size: 40, color: Colors.grey.shade400),
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
}
