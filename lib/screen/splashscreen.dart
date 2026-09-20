import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ripal_design/screen/login_screen.dart';
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
          MaterialPageRoute(builder: (context) => const login_Screen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFFCE6E6); // Soft blush pink
    const primaryColor = Color(0xFF6E1813); // Deep maroon / wine red
    const subtleTextColor = Color(0xFF8D6864);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Top-left architectural lines
            Positioned(
              top: 24,
              left: 24,
              child: CustomPaint(
                size: const Size(100, 140),
                painter: CornerLinesPainter(isTopLeft: true),
              ),
            ),

            // Bottom-right architectural lines
            Positioned(
              bottom: 24,
              right: 24,
              child: CustomPaint(
                size: const Size(100, 140),
                painter: CornerLinesPainter(isTopLeft: false),
              ),
            ),

            // Center Branding Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,

                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 230),
                  Image.asset(
                    'assets/logo/Logo.png',
                    width: 140,
                    height: 140,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.architecture,
                      size: 110,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Ripal Design',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w800,
                      color: primaryColor,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 160),
                  const Text(
                    'ARCHITECTURAL EXCELLENCE',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: subtleTextColor,
                      letterSpacing: 2.8,
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
}

// Custom painter for the offset intersecting corner borders
class CornerLinesPainter extends CustomPainter {
  final bool isTopLeft;

  CornerLinesPainter({required this.isTopLeft});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF3B2E2E)
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
