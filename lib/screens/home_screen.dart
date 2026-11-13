import 'package:flutter/material.dart';

import '../l10n/app_strings.dart';
import '../l10n/localized_builder.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/progress_service.dart';
import '../widgets/user_avatar.dart';

import 'about_screen.dart';
import 'saved_words_screen.dart';
import 'search_screen.dart';
import 'settings_screen.dart';
import 'stats_screen.dart';
import 'word_set_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _menuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget page,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        },
      ),
    );
  }

  // Chon muc tieu hoc moi ngay
  Future<void> _chooseDailyGoal(
    BuildContext context,
    AppStrings strings,
  ) async {
    final int? selected = await showModalBottomSheet<int>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  strings.get('chooseDailyGoal'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              for (final int goal in [5, 10, 20])
                ListTile(
                  leading: const Icon(Icons.flag_outlined),
                  title: Text('$goal ${strings.get('wordsPerDay')}'),
                  trailing: ProgressService.dailyGoal == goal
                      ? const Icon(Icons.check_circle, color: Colors.teal)
                      : null,
                  onTap: () {
                    Navigator.pop(sheetContext, goal);
                  },
                ),
            ],
          ),
        );
      },
    );

    if (selected != null) {
      ProgressService.setDailyGoal(selected);
    }
  }

  // The muc tieu hoc tap tren trang chu
  Widget _dailyGoalCard(BuildContext context, AppStrings strings) {
    return ValueListenableBuilder<int>(
      valueListenable: ProgressService.changes,
      builder: (context, _, _) {
        final int goal = ProgressService.dailyGoal;
        final int studied = ProgressService.wordsStudiedToday;

        final double progress = (studied / goal).clamp(0.0, 1.0).toDouble();

        return Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              _chooseDailyGoal(context, strings);
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.flag_outlined),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          strings.get('dailyGoalTitle'),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Text('$studied/$goal'),
                      const SizedBox(width: 8),
                      const Icon(Icons.edit_outlined, size: 18),
                    ],
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(value: progress),
                  const SizedBox(height: 8),
                  Text(
                    studied >= goal
                        ? strings.get('dailyGoalAchieved')
                        : '${strings.get('dailyGoalDesc')} • '
                              '$goal ${strings.get('wordsPerDay')}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedBuilder(
      builder: (context, strings) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 76,
            titleSpacing: 16,
            title: Row(
              children: [
                // Logo VocabMaster
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF5547C8), Color(0xFF897BF2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF5547C8).withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.auto_stories_rounded,
                    color: Colors.white,
                    size: 27,
                  ),
                ),

                const SizedBox(width: 12),

                // Ten ung dung va slogan
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'VocabMaster',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Text(
                        strings.languageCode == 'vi'
                            ? 'Học từ vựng thông minh'
                            : 'Learn vocabulary smarter',
                        style: TextStyle(
                          fontSize: 11,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: ValueListenableBuilder<User?>(
            valueListenable: AuthService.currentUser,
            builder: (context, user, _) {
              if (user == null) {
                return const SizedBox.shrink();
              }

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Row(
                    children: [
                      UserAvatar(user: user, radius: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${strings.get('hello')}, ${user.fullName}!',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text(strings.get('welcome')),
                          ],
                        ),
                      ),
                      IconButton(
                        tooltip: strings.get('settings'),
                        icon: const Icon(Icons.settings_outlined),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SettingsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Muc tieu hoc tap
                  _dailyGoalCard(context, strings),

                  const SizedBox(height: 12),

                  _menuCard(
                    context,
                    icon: Icons.menu_book,
                    title: strings.get('wordSets'),
                    subtitle: strings.get('wordSetsDesc'),
                    page: const WordSetListScreen(),
                  ),

                  _menuCard(
                    context,
                    icon: Icons.quiz,
                    title: strings.get('quiz'),
                    subtitle: strings.get('quizDesc'),
                    page: const WordSetListScreen(quizMode: true),
                  ),

                  _menuCard(
                    context,
                    icon: Icons.search,
                    title: strings.get('search'),
                    subtitle: strings.get('searchDesc'),
                    page: const SearchScreen(),
                  ),

                  _menuCard(
                    context,
                    icon: Icons.bookmark,
                    title: strings.get('savedWordsTitle'),
                    subtitle: strings.get('savedWordsDesc'),
                    page: const SavedWordsScreen(),
                  ),

                  _menuCard(
                    context,
                    icon: Icons.bar_chart,
                    title: strings.get('statsTitle'),
                    subtitle: strings.get('statsDesc'),
                    page: const StatsScreen(),
                  ),

                  _menuCard(
                    context,
                    icon: Icons.settings,
                    title: strings.get('settings'),
                    subtitle: strings.get('settingsDesc'),
                    page: const SettingsScreen(),
                  ),

                  _menuCard(
                    context,
                    icon: Icons.info,
                    title: strings.get('about'),
                    subtitle: strings.get('aboutDesc'),
                    page: const AboutScreen(),
                  ),
                  const SizedBox(height: 12),

                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: Text(
                        strings.get('logout'),
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        AuthService.logout();
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
