import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ripal_design/resource/main_scaffold.dart';
import 'package:ripal_design/screen/admin_create_project.dart';
import 'package:ripal_design/screen/admin_invoice_screen.dart';
import 'package:ripal_design/screen/admin_leave_screen.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
import 'package:ripal_design/screen/settings_screen.dart';

class AdminFinanceScreen extends StatefulWidget {
  const AdminFinanceScreen({super.key});

  @override
  State<AdminFinanceScreen> createState() => _AdminFinanceScreenState();
}

class _AdminFinanceScreenState extends State<AdminFinanceScreen> {
  static const Color _cardPink = Color(0xFFFCEFEA);
  static const Color _darkRed = Color(0xFF580B02);
  static const Color _titleDark = Color(0xFF2A0501);
  static const Color _subTitleBrown = Color(0xFF9C5B43);
  static const Color _labelBrown = Color(0xFF7C5D53);
  static const Color _salmonOrange = Color(0xFFF17B58);

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
      appBarTitle: 'FINANCE',
      appBarLeading: IconButton(
        icon: const Icon(Icons.grid_view_outlined, color: _darkRed, size: 24),
        onPressed: () {},
      ),
      appBarActions: [
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
              // Studio Subheader
              const Text(
                'STUDIO FINANCIAL GATEWAY',
                style: TextStyle(
                  color: _subTitleBrown,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Q3 Project Portfolios',
                style: TextStyle(
                  color: _darkRed,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 20),

              // Card 1: Total Project Budget
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
                      'TOTAL PROJECT BUDGET',
                      style: TextStyle(
                        color: _labelBrown,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      '₹ 1,240,000.00',
                      style: TextStyle(
                        color: _titleDark,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Amount Invoiced
                    const Text(
                      'AMOUNT INVOICED',
                      style: TextStyle(
                        color: _labelBrown,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '₹845,200.00',
                      style: TextStyle(
                        color: _darkRed,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: const LinearProgressIndicator(
                        value: 0.68,
                        minHeight: 6,
                        backgroundColor: Color(0xFFE8D5CE),
                        valueColor: AlwaysStoppedAnimation<Color>(_darkRed),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Outstanding Balance
                    const Text(
                      'OUTSTANDING BALANCE',
                      style: TextStyle(
                        color: _labelBrown,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '₹394,800.00',
                      style: TextStyle(
                        color: _darkRed,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: const LinearProgressIndicator(
                        value: 0.32,
                        minHeight: 6,
                        backgroundColor: Color(0xFFE8D5CE),
                        valueColor: AlwaysStoppedAnimation<Color>(_darkRed),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Card 2: Budget Utilization gauge
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                decoration: BoxDecoration(
                  color: _darkRed,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    // Donut Gauge
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: const Size(150, 150),
                            painter: _DonutGaugePainter(
                              progress: 0.68,
                              color: _salmonOrange,
                              backgroundColor: const Color(0xFF7A1C12),
                              strokeWidth: 16,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                '68%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'REVENUE GOAL',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Budget Utilization',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Studio resources are currently optimized for the Q3 expansion phase.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Section Header: Recent Transactions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: _titleDark,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AdminInvoiceScreen()),
                      );
                    },
                    child: const Text(
                      'VIEW ALL',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        color: _subTitleBrown,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Transactions List Container
              Container(
                decoration: BoxDecoration(
                  color: _cardPink,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'DETAILS',
                          style: TextStyle(
                            color: _labelBrown,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        Text(
                          'STATUS',
                          style: TextStyle(
                            color: _labelBrown,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Item 1
                    _buildTransactionRow(
                      category: 'Client',
                      title: 'Invoice #821',
                      dateProject: 'Oct 12, 2024 • Project: Skyline Residence',
                      amount: '₹24,500.00',
                      statusText: 'PAID',
                      statusBg: const Color(0xFFD2F3E1),
                      statusFg: const Color(0xFF23A365),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Divider(color: Color(0xFFE8D5CE), height: 1),
                    ),

                    // Item 2
                    _buildTransactionRow(
                      category: 'Contractor',
                      title: 'Payment - Zenith Penthouse',
                      dateProject: 'Oct 09, 2024 • External Vendor',
                      amount: '₹12,240.00',
                      statusText: 'PENDING',
                      statusBg: const Color(0xFFF2E4DC),
                      statusFg: const Color(0xFF8C6352),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Divider(color: Color(0xFFE8D5CE), height: 1),
                    ),

                    // Item 3
                    _buildTransactionRow(
                      category: 'Site',
                      title: 'Materials',
                      dateProject: 'Oct 04, 2024 • Logistics & Supply',
                      amount: '₹4,800.00',
                      statusText: 'OVERDUE',
                      statusBg: const Color(0xFFFCE3E3),
                      statusFg: const Color(0xFFE53935),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionRow({
    required String category,
    required String title,
    required String dateProject,
    required String amount,
    required String statusText,
    required Color statusBg,
    required Color statusFg,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _titleDark,
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: _titleDark,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                dateProject,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              amount,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: _titleDark,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                statusText,
                style: TextStyle(
                  color: statusFg,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DonutGaugePainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;

  _DonutGaugePainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (min(size.width, size.height) - strokeWidth) / 2;

    final bgPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fgPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    final startAngle = -pi / 2;
    final sweepAngle = 2 * pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _DonutGaugePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
