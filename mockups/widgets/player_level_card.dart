import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'xp_progress_bar.dart';

class PlayerLevelCard extends StatelessWidget {
  final String displayName;
  final String username;
  final int level;
  final int xp;
  final int xpToNextLevel;
  final int streakDays;

  const PlayerLevelCard({
    super.key,
    required this.displayName,
    required this.username,
    required this.level,
    required this.xp,
    required this.xpToNextLevel,
    required this.streakDays,
  });

  Color get _levelColor {
    if (level <= 5) return AppColors.rarityCommon;
    if (level <= 10) return AppColors.electricBlue;
    if (level <= 15) return AppColors.purple;
    if (level <= 20) return AppColors.orange;
    return AppColors.warning;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgBorder,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _AvatarPlaceholder(size: 56, levelColor: _levelColor),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(displayName, style: AppTextStyles.headingM),
                        const SizedBox(width: AppSpacing.sm),
                        _LevelBadge(level: level, color: _levelColor),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '@$username',
                      style: AppTextStyles.bodyS,
                    ),
                  ],
                ),
              ),
              _StreakDisplay(days: streakDays),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          XPProgressBar(currentXP: xp, maxXP: xpToNextLevel),
        ],
      ),
    );
  }
}

class _AvatarPlaceholder extends StatelessWidget {
  final double size;
  final Color levelColor;

  const _AvatarPlaceholder({required this.size, required this.levelColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surfaceElevated,
        border: Border.all(color: levelColor, width: 2),
      ),
      child: const Icon(Icons.person, color: AppColors.textMuted, size: 28),
    );
  }
}

class _LevelBadge extends StatelessWidget {
  final int level;
  final Color color;

  const _LevelBadge({required this.level, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: AppRadius.fullBorder,
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        'LVL $level',
        style: AppTextStyles.labelM.copyWith(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _StreakDisplay extends StatelessWidget {
  final int days;

  const _StreakDisplay({required this.days});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.orangeBrand.createShader(bounds),
          child: const Icon(Icons.local_fire_department,
              color: Colors.white, size: 28),
        ),
        Text(
          '$days',
          style: AppTextStyles.displayM.copyWith(
            color: AppColors.orange,
            fontSize: 20,
            height: 1.0,
          ),
        ),
        Text('days', style: AppTextStyles.bodyS),
      ],
    );
  }
}
