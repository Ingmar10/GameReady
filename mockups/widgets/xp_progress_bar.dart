import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class XPProgressBar extends StatefulWidget {
  final int currentXP;
  final int maxXP;
  final bool animate;

  const XPProgressBar({
    super.key,
    required this.currentXP,
    required this.maxXP,
    this.animate = true,
  });

  @override
  State<XPProgressBar> createState() => _XPProgressBarState();
}

class _XPProgressBarState extends State<XPProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  double get _targetProgress =>
      (widget.currentXP / widget.maxXP).clamp(0.0, 1.0);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: _targetProgress).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    if (widget.animate) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: AppRadius.fullBorder,
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: _animation.value,
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      gradient: AppColors.orangeBrand,
                      borderRadius: AppRadius.fullBorder,
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.orangeGlow,
                          blurRadius: 8,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.currentXP} XP',
                  style: AppTextStyles.bodyS.copyWith(
                    color: AppColors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${widget.maxXP} XP',
                  style: AppTextStyles.bodyS,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
