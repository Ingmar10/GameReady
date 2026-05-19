import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum SkillLevel { rookie, varsity, elite }

class DrillCard extends StatelessWidget {
  final String title;
  final String category;
  final String duration;
  final int xpReward;
  final SkillLevel skillLevel;
  final VoidCallback? onTap;

  const DrillCard({
    super.key,
    required this.title,
    required this.category,
    required this.duration,
    required this.xpReward,
    required this.skillLevel,
    this.onTap,
  });

  Color get _skillColor {
    switch (skillLevel) {
      case SkillLevel.rookie:
        return AppColors.neonGreen;
      case SkillLevel.varsity:
        return AppColors.electricBlue;
      case SkillLevel.elite:
        return AppColors.orange;
    }
  }

  String get _skillLabel {
    switch (skillLevel) {
      case SkillLevel.rookie:
        return 'Rookie';
      case SkillLevel.varsity:
        return 'Varsity';
      case SkillLevel.elite:
        return 'Elite';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.mdBorder,
          border: Border.all(color: AppColors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ThumbnailSection(title: title),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.headingS.copyWith(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      _MetaChip(
                        icon: Icons.timer_outlined,
                        label: duration,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      _MetaChip(
                        icon: Icons.bolt,
                        label: '+$xpReward XP',
                        color: AppColors.orange,
                      ),
                      const Spacer(),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _skillColor,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _skillLabel,
                        style: AppTextStyles.bodyS.copyWith(
                          color: _skillColor,
                          fontSize: 10,
                        ),
                      ),
                    ],
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

class _ThumbnailSection extends StatelessWidget {
  final String title;

  const _ThumbnailSection({required this.title});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: AppColors.surfaceElevated),
          const Icon(Icons.play_circle_outline,
              color: AppColors.textMuted, size: 36),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.surface.withOpacity(0.85),
                  ],
                  stops: const [0.4, 1.0],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _MetaChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: AppRadius.fullBorder,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 10),
          const SizedBox(width: 2),
          Text(
            label,
            style: AppTextStyles.labelM.copyWith(color: color, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
