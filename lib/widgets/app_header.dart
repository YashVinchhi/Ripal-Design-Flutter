import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final String? kicker;
  final bool showLogo;
  final bool showBack;
  final bool showClose;
  final bool showNotification;
  final bool showAvatar;
  final VoidCallback? onBack;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onAvatarTap;

  const AppHeader({
    super.key,
    required this.title,
    this.kicker,
    this.showLogo = false,
    this.showBack = false,
    this.showClose = false,
    this.showNotification = false,
    this.showAvatar = true,
    this.onBack,
    this.onNotificationTap,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (kicker != null) ...[
            Text(
              kicker!,
              style: AppTypography.kicker.copyWith(fontSize: 10),
            ),
            const SizedBox(height: 4),
          ],
          Row(
            children: [
              // Left control (Back / Close / Logo)
              if (showBack)
                IconButton(
                  onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary, size: 22),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                )
              else if (showClose)
                IconButton(
                  onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.close, color: AppColors.textPrimary, size: 22),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                )
              else if (showLogo) ...[
                _buildGridLogo(),
                const SizedBox(width: 10),
              ],

              if (showBack || showClose) const SizedBox(width: 12),

              // Title
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.screenTitle.copyWith(
                    fontSize: showLogo ? 19 : 20,
                    letterSpacing: -0.3,
                  ),
                ),
              ),

              // Right controls
              if (showNotification) ...[
                GestureDetector(
                  onTap: onNotificationTap,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(
                        Icons.notifications_none_rounded,
                        color: AppColors.textPrimary,
                        size: 24,
                      ),
                      Positioned(
                        top: 1,
                        right: 2,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
              ],

              if (showAvatar)
                GestureDetector(
                  onTap: onAvatarTap,
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.border, width: 1.5),
                      color: AppColors.surfaceSecondary,
                    ),
                    child: ClipOval(
                      child: CustomPaint(
                        painter: AvatarPatternPainter(),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGridLogo() {
    return SizedBox(
      width: 18,
      height: 18,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _logoSquare(),
              _logoSquare(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _logoSquare(),
              _logoSquare(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _logoSquare() {
    return Container(
      width: 7.5,
      height: 7.5,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(1.5),
      ),
    );
  }
}

class AvatarPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()..color = const Color(0xFFF3ECE9);
    final paint2 = Paint()..color = const Color(0xFFE8DED9);
    final double step = size.width / 4;

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        final rect = Rect.fromLTWH(i * step, j * step, step, step);
        canvas.drawRect(rect, (i + j) % 2 == 0 ? paint1 : paint2);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
