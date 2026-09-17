import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MobileFrame extends StatelessWidget {
  final Widget child;

  const MobileFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEFE8E5), // Outer desk/web background tint
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 430, // standard mobile frame boundary
        ),
        child: Container(
          color: AppColors.background,
          child: child,
        ),
      ),
    );
  }
}
