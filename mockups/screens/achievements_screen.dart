import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/badge_card.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  int _selectedFilter = 0;

  static const _filters = ['All', 'Training', 'Streak', 'Community', 'Challenge'];

  static const _badges = [
    (
      name: 'First Step',
      rarity: BadgeRarity.common,
      icon: Icons.directions_run,
      earned: true,
      date: 'May 1',
    ),
    (
      name: 'Hot Streak',
      rarity: BadgeRarity.rare,
      icon: Icons.local_fire_department,
      earned: true,
      date: 'May 8',
    ),
    (
      name: 'Drill Sergeant',
      rarity: BadgeRarity.epic,
      icon: Icons.fitness_center,
      earned: true,
      date: 'May 12',
    ),
    (
      name: 'Legend Status',
      rarity: BadgeRarity.legend,
      icon: Icons.emoji_events,
      earned: false,
      date: null,
    ),
    (
      name: 'Team Player',
      rarity: BadgeRarity.common,
      icon: Icons.group,
      earned: true,
      date: 'Apr 28',
    ),
    (
      name: 'Sharpshooter',
      rarity: BadgeRarity.rare,
      icon: Icons.gps_fixed,
      earned: false,
      date: null,
    ),
    (
      name: 'Iron Will',
      rarity: BadgeRarity.epic,
      icon: Icons.shield,
      earned: false,
      date: null,
    ),
    (
      name: 'Floor General',
      rarity: BadgeRarity.rare,
      icon: Icons.sports_basketball,
      earned: true,
      date: 'May 15',
    ),
  ];

  static const _records = [
    (label: 'Most Drills in a Day', value: '8 drills', date: 'May 12'),
    (label: 'Longest Streak', value: '14 days', date: 'Apr 30'),
    (label: 'Most XP in a Week', value: '1,240 XP', date: 'May 5'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding,
            vertical: AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Achievements', style: AppTextStyles.headingL),
              const SizedBox(height: AppSpacing.md),
              _StatsRow(),
              const SizedBox(height: AppSpacing.lg),
              _FilterChipsRow(
                filters: _filters,
                selectedIndex: _selectedFilter,
                onSelected: (i) => setState(() => _selectedFilter = i),
              ),
              const SizedBox(height: AppSpacing.md),
              _BadgeGrid(badges: _badges),
              const SizedBox(height: AppSpacing.lg),
              Text('Personal Records', style: AppTextStyles.headingM),
              const SizedBox(height: AppSpacing.sm),
              ..._records.map((r) => _RecordRow(
                    label: r.label,
                    value: r.value,
                    date: r.date,
                  )),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatChip(
            icon: Icons.bolt,
            label: 'XP Total',
            value: '2,400',
            color: AppColors.orange,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _StatChip(
            icon: Icons.star,
            label: 'Level',
            value: '7',
            color: AppColors.electricBlue,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _StatChip(
            icon: Icons.local_fire_department,
            label: 'Streak',
            value: '12',
            color: AppColors.warning,
          ),
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.md,
        horizontal: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgBorder,
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: AppTextStyles.headingM.copyWith(color: color),
          ),
          const SizedBox(height: 2),
          Text(label, style: AppTextStyles.bodyS),
        ],
      ),
    );
  }
}

class _FilterChipsRow extends StatelessWidget {
  final List<String> filters;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _FilterChipsRow({
    required this.filters,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md, vertical: AppSpacing.xs),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.orange : AppColors.surfaceElevated,
                borderRadius: AppRadius.fullBorder,
                border: isSelected ? null : Border.all(color: AppColors.border),
              ),
              child: Text(
                filters[index],
                style: AppTextStyles.labelM.copyWith(
                  color: isSelected
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BadgeGrid extends StatelessWidget {
  final List<
      ({
        String name,
        BadgeRarity rarity,
        IconData icon,
        bool earned,
        String? date
      })> badges;

  const _BadgeGrid({required this.badges});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        childAspectRatio: 0.75,
      ),
      itemCount: badges.length,
      itemBuilder: (context, index) {
        final b = badges[index];
        return BadgeCard(
          name: b.name,
          rarity: b.rarity,
          icon: b.icon,
          earned: b.earned,
          earnedDate: b.date,
        );
      },
    );
  }
}

class _RecordRow extends StatelessWidget {
  final String label;
  final String value;
  final String date;

  const _RecordRow({
    required this.label,
    required this.value,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.mdBorder,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.orange.withOpacity(0.1),
              borderRadius: AppRadius.smBorder,
            ),
            child: const Icon(Icons.emoji_events,
                color: AppColors.orange, size: 20),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.bodyM),
                Text(date, style: AppTextStyles.bodyS),
              ],
            ),
          ),
          Text(
            value,
            style: AppTextStyles.headingM.copyWith(color: AppColors.orange),
          ),
        ],
      ),
    );
  }
}
