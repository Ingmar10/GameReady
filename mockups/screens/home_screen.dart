import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/player_level_card.dart';
import '../widgets/post_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              _TopBar(),
              const SizedBox(height: AppSpacing.md),
              const PlayerLevelCard(
                displayName: 'Ball King',
                username: 'ballking',
                level: 7,
                xp: 2400,
                xpToNextLevel: 3500,
                streakDays: 12,
              ),
              const SizedBox(height: AppSpacing.lg),
              _SectionHeader(title: "Today's Workout"),
              const SizedBox(height: AppSpacing.sm),
              _TodaysWorkoutCard(),
              const SizedBox(height: AppSpacing.lg),
              _SectionHeader(title: 'Weekly Challenge'),
              const SizedBox(height: AppSpacing.sm),
              _WeeklyChallengeCard(),
              const SizedBox(height: AppSpacing.lg),
              _SectionHeader(title: 'Community Highlights'),
              const SizedBox(height: AppSpacing.sm),
              _CommunityHighlightsRow(),
              const SizedBox(height: AppSpacing.lg),
              _StreakCard(),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'GAMEREADY',
              style: AppTextStyles.displayM.copyWith(
                color: AppColors.orange,
                letterSpacing: 2,
              ),
            ),
            Text(
              'Good morning, baller 🏀',
              style: AppTextStyles.bodyS,
            ),
          ],
        ),
        Stack(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surfaceElevated,
              ),
              child: const Icon(Icons.notifications_outlined,
                  color: AppColors.textSecondary, size: 22),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.orange,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.headingM),
        Text(
          'See all',
          style: AppTextStyles.bodyS.copyWith(color: AppColors.electricBlue),
        ),
      ],
    );
  }
}

class _TodaysWorkoutCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.featuredCard,
        borderRadius: AppRadius.lgBorder,
        border: Border.all(color: AppColors.orange.withOpacity(0.4)),
        boxShadow: const [
          BoxShadow(color: Color(0x22FF6B1A), blurRadius: 20),
          BoxShadow(color: Color(0x66000000), blurRadius: 24, offset: Offset(0, 4)),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 4,
              decoration: const BoxDecoration(
                color: AppColors.orange,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppRadius.lg),
                  bottomLeft: Radius.circular(AppRadius.lg),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.orange.withOpacity(0.15),
                        borderRadius: AppRadius.fullBorder,
                      ),
                      child: Text(
                        'RECOMMENDED FOR YOU',
                        style: AppTextStyles.labelM.copyWith(
                          color: AppColors.orange,
                          fontSize: 10,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'PG Fundamentals — Day 3',
                      style: AppTextStyles.headingL,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        _WorkoutMeta(
                          icon: Icons.timer_outlined,
                          label: '45 min',
                        ),
                        const SizedBox(width: AppSpacing.md),
                        _WorkoutMeta(
                          icon: Icons.fitness_center,
                          label: '5 drills',
                        ),
                        const SizedBox(width: AppSpacing.md),
                        _WorkoutMeta(
                          icon: Icons.bolt,
                          label: '+250 XP',
                          color: AppColors.orange,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.orange,
                          foregroundColor: AppColors.textPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppRadius.mdBorder,
                          ),
                        ),
                        child: Text(
                          'START WORKOUT',
                          style: AppTextStyles.headingS.copyWith(
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkoutMeta extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;

  const _WorkoutMeta({
    required this.icon,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.textSecondary;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: c, size: 14),
        const SizedBox(width: 4),
        Text(
          label,
          style: AppTextStyles.bodyS.copyWith(color: c),
        ),
      ],
    );
  }
}

class _WeeklyChallengeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgBorder,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.electricBlue.withOpacity(0.15),
                    borderRadius: AppRadius.fullBorder,
                  ),
                  child: Text(
                    'WEEKLY CHALLENGE',
                    style: AppTextStyles.labelM.copyWith(
                      color: AppColors.electricBlue,
                      fontSize: 10,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text('Ball Handling Challenge', style: AppTextStyles.headingM),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    const Icon(Icons.schedule,
                        color: AppColors.warning, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '3 days left',
                      style: AppTextStyles.bodyS
                          .copyWith(color: AppColors.warning),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                '72:14:33',
                style: AppTextStyles.displayM.copyWith(
                  color: AppColors.electricBlue,
                  fontSize: 22,
                ),
              ),
              Text(
                'HH:MM:SS',
                style: AppTextStyles.bodyS.copyWith(fontSize: 9),
              ),
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.electricBlue),
                  foregroundColor: AppColors.electricBlue,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm, vertical: 4),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.smBorder,
                  ),
                ),
                child: Text(
                  'JOIN',
                  style: AppTextStyles.labelM.copyWith(
                    color: AppColors.electricBlue,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CommunityHighlightsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final posts = [
      ('hooplife', '2h', 'Just dropped 30 in the park 🔥 Defense was locked in all game.', true),
      ('courtking99', '4h', 'New crossover drill I've been working on — feel the difference in my first step already.', false),
      ('buckets_42', '6h', 'Completed the weekly ball handling challenge. These drills are no joke 💪', false),
    ];

    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: posts.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final (username, time, content, hasMedia) = posts[index];
          return SizedBox(
            width: 260,
            child: PostCard(
              username: username,
              timeAgo: time,
              content: content,
              likeCount: (index + 1) * 12,
              commentCount: (index + 1) * 4,
              hasMedia: hasMedia,
            ),
          );
        },
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgBorder,
        border: Border.all(color: AppColors.orange.withOpacity(0.3)),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.orange.withOpacity(0.08),
            AppColors.surface,
          ],
        ),
      ),
      child: Row(
        children: [
          ShaderMask(
            shaderCallback: (bounds) =>
                AppColors.orangeBrand.createShader(bounds),
            child: const Icon(Icons.local_fire_department,
                color: Colors.white, size: 40),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '12 Day Streak! 🔥',
                  style: AppTextStyles.headingM,
                ),
                Text(
                  "Don't break it — log a workout today!",
                  style: AppTextStyles.bodyS,
                ),
              ],
            ),
          ),
          Text(
            '12',
            style: AppTextStyles.displayL.copyWith(color: AppColors.orange),
          ),
        ],
      ),
    );
  }
}
