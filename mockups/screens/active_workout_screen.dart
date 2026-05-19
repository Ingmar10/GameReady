import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ActiveWorkoutScreen extends StatefulWidget {
  const ActiveWorkoutScreen({super.key});

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
  int _currentDrill = 2;
  final int _totalDrills = 5;
  int _currentSet = 2;
  final int _totalSets = 3;
  int _secondsRemaining = 45;
  bool _timerRunning = false;
  Timer? _timer;

  void _toggleTimer() {
    if (_timerRunning) {
      _timer?.cancel();
      setState(() => _timerRunning = false);
    } else {
      setState(() => _timerRunning = true);
      _timer = Timer.periodic(const Duration(seconds: 1), (t) {
        if (_secondsRemaining <= 0) {
          t.cancel();
          setState(() {
            _timerRunning = false;
            _secondsRemaining = 0;
          });
        } else {
          setState(() => _secondsRemaining--);
        }
      });
    }
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _timerRunning = false;
      _secondsRemaining = 45;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _timerDisplay {
    final mins = _secondsRemaining ~/ 60;
    final secs = _secondsRemaining % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _WorkoutProgressHeader(
              currentDrill: _currentDrill,
              totalDrills: _totalDrills,
              planTitle: 'PG Fundamentals — Day 3',
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.md),
                    _VideoPlaceholder(),
                    const SizedBox(height: AppSpacing.md),
                    _DrillInfo(),
                    const SizedBox(height: AppSpacing.md),
                    _SetDisplay(current: _currentSet, total: _totalSets),
                    const SizedBox(height: AppSpacing.lg),
                    _TimerDisplay(
                      timeString: _timerDisplay,
                      isRunning: _timerRunning,
                      onTap: _toggleTimer,
                      onReset: _resetTimer,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
            _BottomControls(
              onPrevious: () {
                if (_currentDrill > 1) {
                  setState(() => _currentDrill--);
                  _resetTimer();
                }
              },
              onLogSet: () {
                if (_currentSet < _totalSets) {
                  setState(() => _currentSet++);
                  _resetTimer();
                }
              },
              onNext: () {
                if (_currentDrill < _totalDrills) {
                  setState(() {
                    _currentDrill++;
                    _currentSet = 1;
                  });
                  _resetTimer();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkoutProgressHeader extends StatelessWidget {
  final int currentDrill;
  final int totalDrills;
  final String planTitle;

  const _WorkoutProgressHeader({
    required this.currentDrill,
    required this.totalDrills,
    required this.planTitle,
  });

  @override
  Widget build(BuildContext context) {
    final progress = currentDrill / totalDrills;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
        vertical: AppSpacing.md,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.close,
                    color: AppColors.textSecondary, size: 22),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(planTitle, style: AppTextStyles.bodyS),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.orange.withOpacity(0.15),
                  borderRadius: AppRadius.fullBorder,
                ),
                child: Text(
                  'Drill $currentDrill of $totalDrills',
                  style: AppTextStyles.labelM.copyWith(
                    color: AppColors.orange,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: AppRadius.fullBorder,
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.border,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.orange),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}

class _VideoPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: AppRadius.lgBorder,
          border: Border.all(color: AppColors.border),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.sports_basketball,
                color: AppColors.textMuted, size: 48),
            Positioned(
              bottom: AppSpacing.sm,
              right: AppSpacing.sm,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.background.withOpacity(0.8),
                  borderRadius: AppRadius.smBorder,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.loop,
                        color: AppColors.textSecondary, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      'LOOP',
                      style: AppTextStyles.bodyS.copyWith(fontSize: 10),
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

class _DrillInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Between-the-Legs Crossover',
                style: AppTextStyles.headingL,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.electricBlue.withOpacity(0.15),
                borderRadius: AppRadius.fullBorder,
              ),
              child: Text(
                'Ball Handling',
                style: AppTextStyles.labelM.copyWith(
                  color: AppColors.electricBlue,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surfaceElevated,
            borderRadius: AppRadius.mdBorder,
            border: Border(
              left: BorderSide(
                  color: AppColors.electricBlue, width: 3),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.lightbulb_outline,
                  color: AppColors.electricBlue, size: 16),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'Keep your eyes up and stay in an athletic stance. Lead with your shoulder to sell the fake before the crossover.',
                  style:
                      AppTextStyles.bodyM.copyWith(color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SetDisplay extends StatelessWidget {
  final int current;
  final int total;

  const _SetDisplay({required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Set ',
          style: AppTextStyles.headingM.copyWith(color: AppColors.textSecondary),
        ),
        Text(
          '$current',
          style: AppTextStyles.displayM.copyWith(color: AppColors.orange),
        ),
        Text(
          ' / $total',
          style: AppTextStyles.headingM.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _TimerDisplay extends StatelessWidget {
  final String timeString;
  final bool isRunning;
  final VoidCallback onTap;
  final VoidCallback onReset;

  const _TimerDisplay({
    required this.timeString,
    required this.isRunning,
    required this.onTap,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surfaceElevated,
              border: Border.all(
                color: isRunning ? AppColors.orange : AppColors.border,
                width: isRunning ? 3 : 1,
              ),
              boxShadow: isRunning
                  ? const [
                      BoxShadow(
                        color: AppColors.orangeGlow,
                        blurRadius: 24,
                        spreadRadius: 0,
                      ),
                    ]
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  timeString,
                  style: AppTextStyles.displayL.copyWith(
                    color: isRunning ? AppColors.orange : AppColors.textPrimary,
                    fontSize: 40,
                  ),
                ),
                const SizedBox(height: 4),
                Icon(
                  isRunning ? Icons.pause : Icons.play_arrow,
                  color: isRunning ? AppColors.orange : AppColors.textSecondary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        TextButton.icon(
          onPressed: onReset,
          icon: const Icon(Icons.refresh,
              color: AppColors.textSecondary, size: 16),
          label: Text(
            'Reset',
            style: AppTextStyles.bodyS.copyWith(color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }
}

class _BottomControls extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onLogSet;
  final VoidCallback onNext;

  const _BottomControls({
    required this.onPrevious,
    required this.onLogSet,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenPadding,
        AppSpacing.md,
        AppSpacing.screenPadding,
        AppSpacing.lg,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onPrevious,
              icon: const Icon(Icons.chevron_left, size: 18),
              label: const Text('Prev'),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.border),
                foregroundColor: AppColors.textSecondary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.mdBorder,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: onLogSet,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orange,
                foregroundColor: AppColors.textPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.mdBorder,
                ),
              ),
              child: Text(
                'LOG SET',
                style: AppTextStyles.headingS.copyWith(letterSpacing: 0.5),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onNext,
              icon: const Icon(Icons.chevron_right, size: 18),
              label: const Text('Next'),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.border),
                foregroundColor: AppColors.textSecondary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.mdBorder,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
