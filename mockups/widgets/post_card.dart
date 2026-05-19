import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PostCard extends StatefulWidget {
  final String username;
  final String timeAgo;
  final String content;
  final int likeCount;
  final int commentCount;
  final bool isLiked;
  final bool hasMedia;

  const PostCard({
    super.key,
    required this.username,
    required this.timeAgo,
    required this.content,
    this.likeCount = 0,
    this.commentCount = 0,
    this.isLiked = false,
    this.hasMedia = false,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard>
    with SingleTickerProviderStateMixin {
  late bool _isLiked;
  late int _likeCount;
  late AnimationController _likeController;
  late Animation<double> _likeScale;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLiked;
    _likeCount = widget.likeCount;
    _likeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _likeScale = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.3), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _likeController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _likeController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likeCount += _isLiked ? 1 : -1;
    });
    _likeController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.mdBorder,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PostHeader(
            username: widget.username,
            timeAgo: widget.timeAgo,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(widget.content, style: AppTextStyles.bodyM),
          if (widget.hasMedia) ...[
            const SizedBox(height: AppSpacing.sm),
            _MediaPlaceholder(),
          ],
          const SizedBox(height: AppSpacing.md),
          _PostActions(
            isLiked: _isLiked,
            likeCount: _likeCount,
            commentCount: widget.commentCount,
            likeScale: _likeScale,
            onLike: _toggleLike,
          ),
        ],
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final String username;
  final String timeAgo;

  const _PostHeader({required this.username, required this.timeAgo});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surfaceElevated,
          ),
          child: const Icon(Icons.person, color: AppColors.textMuted, size: 20),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '@$username',
                style: AppTextStyles.headingS.copyWith(fontSize: 14),
              ),
              Text(timeAgo, style: AppTextStyles.bodyS),
            ],
          ),
        ),
        Icon(Icons.more_horiz, color: AppColors.textMuted, size: 20),
      ],
    );
  }
}

class _MediaPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: AppRadius.smBorder,
        ),
        child: const Icon(Icons.image_outlined,
            color: AppColors.textMuted, size: 40),
      ),
    );
  }
}

class _PostActions extends StatelessWidget {
  final bool isLiked;
  final int likeCount;
  final int commentCount;
  final Animation<double> likeScale;
  final VoidCallback onLike;

  const _PostActions({
    required this.isLiked,
    required this.likeCount,
    required this.commentCount,
    required this.likeScale,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ScaleTransition(
          scale: likeScale,
          child: GestureDetector(
            onTap: onLike,
            child: Row(
              children: [
                Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? AppColors.error : AppColors.textSecondary,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  '$likeCount',
                  style: AppTextStyles.bodyS.copyWith(
                    color: isLiked ? AppColors.error : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Row(
          children: [
            const Icon(Icons.chat_bubble_outline,
                color: AppColors.textSecondary, size: 20),
            const SizedBox(width: 4),
            Text('$commentCount', style: AppTextStyles.bodyS),
          ],
        ),
        const SizedBox(width: AppSpacing.lg),
        const Icon(Icons.share_outlined,
            color: AppColors.textSecondary, size: 20),
      ],
    );
  }
}
