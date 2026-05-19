import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/post_card.dart';

class CommunityFeedScreen extends StatelessWidget {
  const CommunityFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.orange,
        foregroundColor: AppColors.textPrimary,
        child: const Icon(Icons.add, size: 28),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _Header()),
            SliverToBoxAdapter(child: _StoriesRow()),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenPadding,
                  AppSpacing.md,
                  AppSpacing.screenPadding,
                  0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Feed', style: AppTextStyles.headingM),
                    Icon(Icons.tune,
                        color: AppColors.textSecondary, size: 20),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
                vertical: AppSpacing.md,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  PostCard(
                    username: 'hooplife',
                    timeAgo: '2h ago',
                    content:
                        'Just dropped 30 in the park run 🔥 Defense was locked in the whole game. That crossover drill is paying off fr.',
                    likeCount: 48,
                    commentCount: 12,
                    isLiked: true,
                    hasMedia: true,
                  ),
                  PostCard(
                    username: 'courtking99',
                    timeAgo: '4h ago',
                    content:
                        'New crossover drill I\'ve been grinding every morning — already feel the difference in my first step. Consistency is everything.',
                    likeCount: 31,
                    commentCount: 7,
                    hasMedia: false,
                  ),
                  PostCard(
                    username: 'buckets_42',
                    timeAgo: '6h ago',
                    content:
                        'Finished the weekly ball handling challenge 💪 These drills are no joke. If you haven\'t tried the two-ball dribble set, you\'re sleeping.',
                    likeCount: 19,
                    commentCount: 4,
                    hasMedia: false,
                  ),
                  const SizedBox(height: 80),
                ]),
              ),
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
          Text('Community', style: AppTextStyles.headingL),
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surfaceElevated,
                ),
                child: const Icon(Icons.search,
                    color: AppColors.textSecondary, size: 22),
              ),
              const SizedBox(width: AppSpacing.sm),
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
            ],
          ),
        ],
      ),
    );
  }
}

class _StoriesRow extends StatelessWidget {
  static const _stories = [
    ('ballking', true, AppColors.orange),
    ('hooplife', false, AppColors.electricBlue),
    ('courtking99', false, AppColors.purple),
    ('buckets_42', false, AppColors.neonGreen),
    ('pg_nation', false, AppColors.warning),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: SizedBox(
        height: 88,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding),
          itemCount: _stories.length,
          separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
          itemBuilder: (context, index) {
            final (username, isYou, glowColor) = _stories[index];
            return _StoryAvatar(
              username: username,
              isYou: isYou,
              glowColor: glowColor,
            );
          },
        ),
      ),
    );
  }
}

class _StoryAvatar extends StatelessWidget {
  final String username;
  final bool isYou;
  final Color glowColor;

  const _StoryAvatar({
    required this.username,
    required this.isYou,
    required this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [glowColor, glowColor.withOpacity(0.3)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: glowColor.withOpacity(0.4),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(2),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surfaceElevated,
                ),
                child: const Icon(Icons.person,
                    color: AppColors.textMuted, size: 28),
              ),
            ),
            if (isYou)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.orange,
                  ),
                  child: const Icon(Icons.add,
                      color: AppColors.textPrimary, size: 14),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          isYou ? 'You' : '@$username',
          style: AppTextStyles.bodyS.copyWith(fontSize: 10),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
