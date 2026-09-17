import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../routes.dart';

class WorkflowStepper extends StatelessWidget {
  final int activeStep; // 1: Details, 2: Team, 3: Files, 4: Activity

  const WorkflowStepper({
    super.key,
    required this.activeStep,
  });

  void _onStepTap(BuildContext context, int step) {
    if (step == activeStep) return;

    switch (step) {
      case 1:
        Navigator.of(context).pushReplacementNamed(AppRoutes.projectView);
        break;
      case 2:
        Navigator.of(context).pushReplacementNamed(AppRoutes.executionCrew);
        break;
      case 3:
        Navigator.of(context).pushReplacementNamed(AppRoutes.uploadFiles);
        break;
      case 4:
        Navigator.of(context).pushReplacementNamed(AppRoutes.activity);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStep(context, step: 1, label: 'Details'),
          _buildStep(context, step: 2, label: 'Team'),
          _buildStep(context, step: 3, label: 'Files'),
          _buildStep(context, step: 4, label: 'Activity'),
        ],
      ),
    );
  }

  Widget _buildStep(BuildContext context, {required int step, required String label}) {
    final bool isActive = activeStep == step;

    return InkWell(
      onTap: () => _onStepTap(context, step),
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : AppColors.stepperInactiveBg,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '$step',
                style: TextStyle(
                  color: isActive ? Colors.white : AppColors.stepperInactiveText,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              isActive ? label.toUpperCase() : label,
              style: AppTypography.kicker.copyWith(
                fontSize: 11,
                letterSpacing: 0.8,
                color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
                fontWeight: isActive ? FontWeight.w800 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
