import 'package:flutter/material.dart';

/// Reusable 4-step workflow header matching:
/// - Step 1: Details (WorkerProjectViewScreen)
/// - Step 2: Team (WorkerViewMemberScreen)
/// - Step 3: Files (WorkerUploadFilesScreen)
/// - Step 4: Activity (WorkerActivityScreen)
class WorkerStepHeader extends StatelessWidget {
  final int currentStep; // 1, 2, 3, or 4
  final ValueChanged<int> onStepTap;

  const WorkerStepHeader({
    super.key,
    required this.currentStep,
    required this.onStepTap,
  });

  static const Color _primaryColor = Color(0xFF5A0000);
  static const Color _inactiveBg = Color(0xFFF5DDD7);
  static const Color _inactiveTextColor = Color(0xFF5A0000);
  static const Color _inactiveLabelColor = Color(0xFF7A6666);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildStep(context, 1, 'Details', 'DETAILS'),
          _buildDottedDivider(),
          _buildStep(context, 2, 'Team', 'TEAM'),
          _buildDottedDivider(),
          _buildStep(context, 3, 'Files', 'FILES'),
          _buildDottedDivider(),
          _buildStep(context, 4, 'Activity', 'ACTIVITY'),
        ],
      ),
    );
  }

  Widget _buildStep(BuildContext context, int number, String inactiveLabel, String activeLabel) {
    final bool isActive = currentStep == number;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final primary = isDark ? const Color(0xFFE07A5F) : _primaryColor;
    final inactiveBg = isDark ? const Color(0xFF2A2020) : _inactiveBg;
    final inactiveText = isDark ? Colors.grey.shade400 : _inactiveTextColor;
    final inactiveLabelColor = isDark ? Colors.grey.shade400 : _inactiveLabelColor;

    return GestureDetector(
      onTap: () => onStepTap(number),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: isActive ? primary : inactiveBg,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$number',
              style: TextStyle(
                color: isActive ? Colors.white : inactiveText,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            isActive ? activeLabel : inactiveLabel,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive ? primary : inactiveLabelColor,
              letterSpacing: isActive ? 0.8 : 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDottedDivider() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            const double dashWidth = 3.0;
            const double dashSpace = 3.0;
            final double boxWidth = constraints.constrainWidth();
            final int dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                dashCount > 0 ? dashCount : 1,
                (_) => const SizedBox(
                  width: dashWidth,
                  height: 1.2,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Color(0xFFE2C4BD)),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
