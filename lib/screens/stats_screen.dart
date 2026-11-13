import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../l10n/app_strings.dart';
import '../l10n/localized_builder.dart';
import '../models/word_set.dart';
import '../services/progress_service.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  Widget _topicCard(BuildContext context, AppStrings strings, WordSet set) {
    final bool isVi = strings.languageCode == 'vi';
    final int known = ProgressService.knownCount(set.id);
    final int total = set.words.length;
    final int? best = ProgressService.bestPercent(set.id);
    final String bestText = best == null ? strings.get('notTaken') : '$best%';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isVi ? set.nameVi : set.nameEn,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: total == 0 ? 0 : known / total),
            const SizedBox(height: 8),
            Text(
              '${strings.get('knownCount')}: $known/$total • '
              '${strings.get('bestScore')}: $bestText',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedBuilder(
      builder: (context, strings) {
        int totalWords = 0;
        int totalKnown = 0;
        int scoreSum = 0;
        int scoreCount = 0;
        for (final WordSet set in sampleWordSets) {
          totalWords += set.words.length;
          totalKnown += ProgressService.knownCount(set.id);
          final int? best = ProgressService.bestPercent(set.id);
          if (best != null) {
            scoreSum += best;
            scoreCount++;
          }
        }
        final String avg = scoreCount == 0
            ? strings.get('notTaken')
            : '${scoreSum ~/ scoreCount}%';
        final int savedCount = ProgressService.savedWords().length;

        return Scaffold(
          appBar: AppBar(title: Text(strings.get('statsTitle'))),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                strings.get('overall'),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.check_circle),
                      title: Text(strings.get('totalKnown')),
                      trailing: Text('$totalKnown/$totalWords'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.bookmark),
                      title: Text(strings.get('savedCount')),
                      trailing: Text('$savedCount'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.emoji_events),
                      title: Text(strings.get('avgScore')),
                      trailing: Text(avg),
                    ),
                    ListTile(
                      leading: const Icon(Icons.flag_outlined),
                      title: Text(strings.get('dailyGoalTitle')),
                      subtitle: Text(strings.get('dailyGoalDesc')),
                      trailing: Text(
                        '${ProgressService.wordsStudiedToday}/'
                        '${ProgressService.dailyGoal}',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                strings.get('byTopic'),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              for (final WordSet set in sampleWordSets)
                _topicCard(context, strings, set),
            ],
          ),
        );
      },
    );
  }
}
