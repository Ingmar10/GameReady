import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/drill_card.dart';

class DrillLibraryScreen extends StatefulWidget {
  const DrillLibraryScreen({super.key});

  @override
  State<DrillLibraryScreen> createState() => _DrillLibraryScreenState();
}

class _DrillLibraryScreenState extends State<DrillLibraryScreen> {
  int _selectedFilter = 0;

  static const _filters = [
    'All',
    'Ball Handling',
    'Shooting',
    'Defense',
    'Athleticism',
    'IQ',
  ];

  static const _drills = [
    (
      title: 'Two-Ball Dribble',
      category: 'Ball Handling',
      duration: '10 min',
      xp: 75,
      level: SkillLevel.rookie,
    ),
    (
      title: 'Pull-Up Jumper Series',
      category: 'Shooting',
      duration: '15 min',
      xp: 100,
      level: SkillLevel.varsity,
    ),
    (
      title: 'Defensive Slides',
      category: 'Defense',
      duration: '8 min',
      xp: 60,
      level: SkillLevel.rookie,
    ),
    (
      title: 'Crossover to Finish',
      category: 'Ball Handling',
      duration: '12 min',
      xp: 90,
      level: SkillLevel.varsity,
    ),
    (
      title: 'Plyometric Jumps',
      category: 'Athleticism',
      duration: '20 min',
      xp: 120,
      level: SkillLevel.elite,
    ),
    (
      title: 'Pick & Roll Read',
      category: 'IQ',
      duration: '15 min',
      xp: 110,
      level: SkillLevel.varsity,
    ),
  ];

  List<
      ({
        String title,
        String category,
        String duration,
        int xp,
        SkillLevel level
      })> get _filteredDrills {
    if (_selectedFilter == 0) return _drills;
    final filter = _filters[_selectedFilter];
    return _drills.where((d) => d.category == filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(),
            const SizedBox(height: AppSpacing.md),
            _SearchBar(),
            const SizedBox(height: AppSpacing.sm),
            _FilterChipsRow(
              filters: _filters,
              selectedIndex: _selectedFilter,
              onSelected: (i) => setState(() => _selectedFilter = i),
            ),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: _DrillGrid(drills: _filteredDrills),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
        vertical: AppSpacing.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Drill Library', style: AppTextStyles.headingL),
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surfaceElevated,
            ),
            child: const Icon(Icons.tune,
                color: AppColors.textSecondary, size: 22),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: AppRadius.mdBorder,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Icon(Icons.search, color: AppColors.textMuted, size: 20),
            ),
            Text(
              'Search drills...',
              style: AppTextStyles.bodyM.copyWith(color: AppColors.textMuted),
            ),
          ],
        ),
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
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding),
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
                color: isSelected
                    ? AppColors.orange
                    : AppColors.surfaceElevated,
                borderRadius: AppRadius.fullBorder,
                border: isSelected
                    ? null
                    : Border.all(color: AppColors.border),
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

class _DrillGrid extends StatelessWidget {
  final List<
      ({
        String title,
        String category,
        String duration,
        int xp,
        SkillLevel level
      })> drills;

  const _DrillGrid({required this.drills});

  @override
  Widget build(BuildContext context) {
    if (drills.isEmpty) {
      return Center(
        child: Text(
          'No drills in this category yet.',
          style: AppTextStyles.bodyM.copyWith(color: AppColors.textMuted),
        ),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
        vertical: AppSpacing.xs,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        childAspectRatio: 0.78,
      ),
      itemCount: drills.length,
      itemBuilder: (context, index) {
        final d = drills[index];
        return DrillCard(
          title: d.title,
          category: d.category,
          duration: d.duration,
          xpReward: d.xp,
          skillLevel: d.level,
        );
      },
    );
  }
}
