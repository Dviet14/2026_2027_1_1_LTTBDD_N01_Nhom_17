import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../l10n/localized_builder.dart';
import '../models/word_set.dart';
import '../services/progress_service.dart';
import 'flashcard_screen.dart';
import 'quiz_screen.dart';

class WordSetListScreen extends StatelessWidget {
  final bool quizMode;

  const WordSetListScreen({super.key, this.quizMode = false});

  @override
  Widget build(BuildContext context) {
    return LocalizedBuilder(
      builder: (context, strings) {
        final bool isVi = strings.languageCode == 'vi';

        return Scaffold(
          appBar: AppBar(
            title: Text(
              quizMode ? strings.get('quizChooseSet') : strings.get('wordSets'),
            ),
          ),
          body: sampleWordSets.isEmpty
              ? Center(child: Text(strings.get('noWordSets')))
              : ValueListenableBuilder<int>(
                  valueListenable: ProgressService.changes,
                  builder: (context, _, __) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: sampleWordSets.length,
                      itemBuilder: (context, index) {
                        final WordSet set = sampleWordSets[index];

                        final int known = ProgressService.knownCount(set.id);

                        final int? best = ProgressService.bestPercent(set.id);

                        String detail =
                            '${set.words.length} '
                            '${strings.get('words')} • '
                            '${strings.get('knownCount')}: '
                            '$known/${set.words.length}';

                        if (best != null) {
                          detail += ' • ${strings.get('bestScore')}: $best%';
                        }

                        return Card(
                          child: ListTile(
                            leading: Icon(
                              quizMode ? Icons.quiz : Icons.menu_book,
                            ),
                            title: Text(isVi ? set.nameVi : set.nameEn),
                            subtitle: Text(detail),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) {
                                    return quizMode
                                        ? QuizScreen(wordSet: set)
                                        : FlashcardScreen(wordSet: set);
                                  },
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
        );
      },
    );
  }
}
