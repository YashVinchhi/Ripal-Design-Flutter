import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../models/leave_model.dart';

class StatusBadge extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const StatusBadge({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  factory StatusBadge.fromLeaveStatus(LeaveStatus status) {
    switch (status) {
      case LeaveStatus.approved:
        return const StatusBadge(
          text: 'APPROVED',
          backgroundColor: AppColors.statusApprovedBg,
          textColor: AppColors.statusApprovedText,
        );
      case LeaveStatus.pending:
        return const StatusBadge(
          text: 'PENDING',
          backgroundColor: AppColors.statusPendingBg,
          textColor: AppColors.statusPendingText,
        );
      case LeaveStatus.rejected:
        return const StatusBadge(
          text: 'REJECTED',
          backgroundColor: AppColors.statusRejectedBg,
          textColor: AppColors.statusRejectedText,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text.toUpperCase(),
        style: AppTypography.badge.copyWith(
          color: textColor,
          fontSize: 9.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
