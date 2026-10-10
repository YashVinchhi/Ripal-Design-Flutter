import 'package:flutter/material.dart';

/// A reusable section header used to label form groups
/// e.g. "PERSONAL DETAILS", "PROFESSIONAL PATH", etc.
class SectionHeader extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry padding;

  const SectionHeader({
    super.key,
    required this.title,
    this.padding = const EdgeInsets.only(bottom: 16),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.5,
          color: Color(0xFF9E4723),
        ),
      ),
    );
  }
}
