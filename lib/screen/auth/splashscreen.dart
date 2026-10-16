import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ripal_design/screen/auth/login_screen.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBg = isDark ? const Color(0xFF141212) : const Color(0xFFFCE6E6);
    final effectivePrimary = isDark ? const Color(0xFFE07A5F) : const Color(0xFF6E1813);
    final effectiveSubtle = isDark ? Colors.grey.shade400 : const Color(0xFF8D6864);
    final lineColor = isDark ? const Color(0xFF555555) : const Color(0xFF3B2E2E);

    return Scaffold(
      backgroundColor: effectiveBg,
      body: SafeArea(
        child: Stack(
          children: [
            // Top-left architectural lines
            Positioned(
              top: 24,
              left: 24,
              child: CustomPaint(
                size: const Size(100, 140),
                painter: CornerLinesPainter(isTopLeft: true, lineColor: lineColor),
              ),
            ),

            // Bottom-right architectural lines
            Positioned(
              bottom: 24,
              right: 24,
              child: CustomPaint(
                size: const Size(100, 140),
                painter: CornerLinesPainter(isTopLeft: false, lineColor: lineColor),
              ),
            ),

            // Center Branding Content
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(),
                    Image.asset(
                      'assets/logo/Logo.png',
                      width: 140,
                      height: 140,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.architecture,
                        size: 110,
                        color: effectivePrimary,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Ripal Design',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w800,
                        color: effectivePrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'ARCHITECTURAL EXCELLENCE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: effectiveSubtle,
                        letterSpacing: 2.8,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for the offset intersecting corner borders
class CornerLinesPainter extends CustomPainter {
  final bool isTopLeft;
  final Color lineColor;

  CornerLinesPainter({required this.isTopLeft, this.lineColor = const Color(0xFF3B2E2E)});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    if (isTopLeft) {
      // Horizontal bar extending past vertical line
      canvas.drawLine(const Offset(0, 20), Offset(size.width, 20), paint);
      // Vertical bar extending past horizontal line
      canvas.drawLine(const Offset(20, 0), Offset(20, size.height), paint);
    } else {
      // Horizontal bar extending past vertical line
      canvas.drawLine(
        Offset(0, size.height - 20),
        Offset(size.width, size.height - 20),
        paint,
      );
      // Vertical bar extending past horizontal line
      canvas.drawLine(
        Offset(size.width - 20, 0),
        Offset(size.width - 20, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
