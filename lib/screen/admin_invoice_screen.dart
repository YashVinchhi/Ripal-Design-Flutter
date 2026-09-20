import 'package:flutter/material.dart';
import 'package:ripal_design/resource/main_scaffold.dart';
import 'package:ripal_design/screen/admin_create_invoice_screen.dart';
import 'package:ripal_design/screen/admin_create_project.dart';
import 'package:ripal_design/screen/admin_finance_screen.dart';
import 'package:ripal_design/screen/admin_leave_screen.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
import 'package:ripal_design/screen/settings_screen.dart';

class AdminInvoiceScreen extends StatefulWidget {
  const AdminInvoiceScreen({super.key});

  @override
  State<AdminInvoiceScreen> createState() => _AdminInvoiceScreenState();
}

class _AdminInvoiceScreenState extends State<AdminInvoiceScreen> {
  static const Color _cardPink = Color(0xFFFCEFEA);
  static const Color _darkRed = Color(0xFF580B02);
  static const Color _brownBtn = Color(0xFF8B3A1C);
  static const Color _titleDark = Color(0xFF2A0501);
  static const Color _labelBrown = Color(0xFF7C5D53);
  static const Color _pendingText = Color(0xFFA35D43);
  static const Color _pendingBg = Color(0xFFFCECE4);

  int _currentIndex = 2;

  void _onNavTap(int index) {
    if (index == 0) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
      return;
    }
    if (index == 1) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminLeaveScreen()));
      return;
    }
    if (index == 2) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminFinanceScreen()));
      return;
    }
    if (index == 3) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
      return;
    }
    setState(() => _currentIndex = index);
  }

  void _onFabPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminCreateProject()));
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: _currentIndex,
      onNavTap: _onNavTap,
      onFabPressed: _onFabPressed,
      appBarTitle: 'Invoice',
      appBarLeading: IconButton(
        icon: const Icon(Icons.grid_view_outlined, color: _darkRed, size: 24),
        onPressed: () {},
      ),
      appBarActions: [
        IconButton(
          icon: const Icon(Icons.add_circle_outline, color: _darkRed, size: 24),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdminCreateInvoiceScreen()),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFFE0C0B0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey.shade200,
              child: const Icon(Icons.person, color: _darkRed, size: 20),
            ),
          ),
        ),
      ],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Invoice ID & Pending Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'INV-2024-082',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: _titleDark,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: _pendingBg,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'PENDING',
                      style: TextStyle(
                        color: _pendingText,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              const Text(
                'ISSUED AUG 14, 2024',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 20),

              // Client Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _cardPink,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CLIENT',
                      style: TextStyle(
                        color: _labelBrown,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Vanguard Properties',
                      style: TextStyle(
                        color: _titleDark,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'DUE DATE',
                              style: TextStyle(
                                color: _labelBrown,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Sept 12, 2026',
                              style: TextStyle(
                                color: _titleDark,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text(
                              'TOTAL DUE',
                              style: TextStyle(
                                color: _labelBrown,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '₹18,450.00',
                              style: TextStyle(
                                color: _darkRed,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Service Breakdown
              const Text(
                'SERVICE BREAKDOWN',
                style: TextStyle(
                  color: _labelBrown,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 12),

              _buildServiceItem(
                title: 'Structural Planning',
                amount: '₹8,200.00',
                subtext: 'Comprehensive load-bearing analysis and CAD drafting for Phase 2 expansion.',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Divider(color: Color(0xFFE8D5CE), height: 1),
              ),

              _buildServiceItem(
                title: 'Material Procurement',
                amount: '₹6,750.00',
                subtext: 'Sourcing of reclaimed Italian travertine and custom oak millwork.',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Divider(color: Color(0xFFE8D5CE), height: 1),
              ),

              _buildServiceItem(
                title: 'Site Consultation',
                amount: '₹3,500.00',
                subtext: '4x On-site inspections and coordination with structural engineers.',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Divider(color: Color(0xFFE8D5CE), height: 1),
              ),

              // Subtotal Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'SUBTOTAL',
                    style: TextStyle(
                      color: _titleDark,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                  Text(
                    '₹18,450.00',
                    style: TextStyle(
                      color: _titleDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // History Section
              const Text(
                'HISTORY',
                style: TextStyle(
                  color: _labelBrown,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 16),

              // Timeline
              _buildTimelineItem(
                date: 'AUG 14, 2024',
                text: 'Invoice generated and sent to client portal.',
                isFirst: true,
                isLast: false,
                dotColor: _brownBtn,
              ),
              _buildTimelineItem(
                date: 'AUG 16, 2024',
                text: 'Viewed by Vanguard Properties (Sarah J.)',
                isFirst: false,
                isLast: true,
                dotColor: const Color(0xFFE0C0B0),
              ),
              const SizedBox(height: 32),

              // Share PDF Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _brownBtn,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.share_outlined, color: Colors.white, size: 20),
                  label: const Text(
                    'SHARE PDF',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Download Receipt Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: _cardPink,
                    side: const BorderSide(color: Color(0xFFE0C0B0), width: 1),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.file_download_outlined, color: _brownBtn, size: 20),
                  label: const Text(
                    'DOWNLOAD RECEIPT',
                    style: TextStyle(
                      color: _brownBtn,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceItem({
    required String title,
    required String amount,
    required String subtext,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _titleDark,
              ),
            ),
            Text(
              amount,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _titleDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          subtext,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
            height: 1.3,
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required String date,
    required String text,
    required bool isFirst,
    required bool isLast,
    required Color dotColor,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: const Color(0xFFE0C0B0),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 14,
                      color: _titleDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
