import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum BadgeRarity { common, rare, epic, legend }

class BadgeCard extends StatelessWidget {
  final String name;
  final BadgeRarity rarity;
  final bool earned;
  final String? earnedDate;
  final IconData icon;
  final VoidCallback? onTap;

  const BadgeCard({
    super.key,
    required this.name,
    required this.rarity,
    required this.icon,
    this.earned = false,
    this.earnedDate,
    this.onTap,
  });

  Color get _rarityColor {
    switch (rarity) {
      case BadgeRarity.common:
        return AppColors.rarityCommon;
      case BadgeRarity.rare:
        return AppColors.rarityRare;
      case BadgeRarity.epic:
        return AppColors.rarityEpic;
      case BadgeRarity.legend:
        return AppColors.rarityLegend;
    }
  }

  String get _rarityLabel {
    switch (rarity) {
      case BadgeRarity.common:
        return 'Common';
      case BadgeRarity.rare:
        return 'Rare';
      case BadgeRarity.epic:
        return 'Epic';
      case BadgeRarity.legend:
        return 'Legend';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: earned
                      ? _rarityColor.withOpacity(0.15)
                      : AppColors.surfaceElevated,
                  border: Border.all(
                    color: earned ? _rarityColor : AppColors.border,
                    width: earned ? 2 : 1,
                  ),
                  boxShadow: earned
                      ? [
                          BoxShadow(
                            color: _rarityColor.withOpacity(0.3),
                            blurRadius: 12,
                            spreadRadius: 0,
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  icon,
                  color: earned ? _rarityColor : AppColors.textMuted,
                  size: 36,
                ),
              ),
              if (!earned)
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.background.withOpacity(0.6),
                  ),
                  child: const Icon(Icons.lock_outline,
                      color: AppColors.textMuted, size: 20),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            name,
            style: AppTextStyles.labelM.copyWith(
              color: earned ? AppColors.textPrimary : AppColors.textMuted,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (earned && earnedDate != null) ...[
            const SizedBox(height: 2),
            Text(
              earnedDate!,
              style: AppTextStyles.bodyS.copyWith(fontSize: 9),
              textAlign: TextAlign.center,
            ),
          ] else if (!earned) ...[
            const SizedBox(height: 2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: _rarityColor.withOpacity(0.1),
                borderRadius: AppRadius.fullBorder,
              ),
              child: Text(
                _rarityLabel,
                style: AppTextStyles.bodyS.copyWith(
                  color: _rarityColor.withOpacity(0.6),
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
