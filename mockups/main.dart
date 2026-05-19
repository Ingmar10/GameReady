import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/drill_library_screen.dart';
import 'screens/active_workout_screen.dart';
import 'screens/achievements_screen.dart';
import 'screens/community_feed_screen.dart';

void main() {
  runApp(const GameReadyMockupApp());
}

class GameReadyMockupApp extends StatelessWidget {
  const GameReadyMockupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameReady Mockups',
      theme: buildAppTheme(),
      debugShowCheckedModeBanner: false,
      home: const _MainShell(),
    );
  }
}

class _MainShell extends StatefulWidget {
  const _MainShell();

  @override
  State<_MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<_MainShell> {
  int _currentIndex = 0;

  static const _screens = [
    HomeScreen(),
    DrillLibraryScreen(),
    ActiveWorkoutScreen(),
    AchievementsScreen(),
    CommunityFeedScreen(),
  ];

  static const _labels = [
    'Home',
    'Train',
    'Workout',
    'Badges',
    'Community',
  ];

  static const _icons = [
    Icons.home_outlined,
    Icons.fitness_center_outlined,
    Icons.play_circle_outline,
    Icons.emoji_events_outlined,
    Icons.group_outlined,
  ];

  static const _activeIcons = [
    Icons.home,
    Icons.fitness_center,
    Icons.play_circle,
    Icons.emoji_events,
    Icons.group,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: _BottomNav(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        labels: _labels,
        icons: _icons,
        activeIcons: _activeIcons,
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<String> labels;
  final List<IconData> icons;
  final List<IconData> activeIcons;

  const _BottomNav({
    required this.currentIndex,
    required this.onTap,
    required this.labels,
    required this.icons,
    required this.activeIcons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: List.generate(
              labels.length,
              (i) => Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onTap(i),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        i == currentIndex ? activeIcons[i] : icons[i],
                        color: i == currentIndex
                            ? AppColors.orange
                            : AppColors.textSecondary,
                        size: 24,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        labels[i],
                        style: AppTextStyles.bodyS.copyWith(
                          fontSize: 10,
                          color: i == currentIndex
                              ? AppColors.orange
                              : AppColors.textSecondary,
                          fontWeight: i == currentIndex
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
