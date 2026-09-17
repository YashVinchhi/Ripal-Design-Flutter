import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class StatisticCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final Color? iconBg;
  final Color? iconColor;
  final String? badgeText;
  final VoidCallback? onTap;

  const StatisticCard({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.iconBg,
    this.iconColor,
    this.badgeText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null || badgeText != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (icon != null)
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: iconBg ?? AppColors.surfaceSecondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        icon,
                        color: iconColor ?? AppColors.primary,
                        size: 20,
                      ),
                    )
                  else
                    const SizedBox.shrink(),
                  if (badgeText != null)
                    Text(
                      badgeText!,
                      style: AppTypography.cardSubtitle.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
            ],
            Text(
              label.toUpperCase(),
              style: AppTypography.statLabel,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: AppTypography.statValue,
            ),
          ],
        ),
      ),
    );
  }
}
