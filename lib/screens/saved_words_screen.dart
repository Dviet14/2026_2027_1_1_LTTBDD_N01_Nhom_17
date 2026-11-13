import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../l10n/localized_builder.dart';
import '../models/word.dart';
import '../models/word_set.dart';
import '../services/progress_service.dart';
import '../services/speech_service.dart';
import 'quiz_screen.dart';

class SavedWordsScreen extends StatelessWidget {
  const SavedWordsScreen({super.key});

  List<Word> _loadSavedWords() {
    final Set<String> saved = ProgressService.savedWords().toSet();
    final List<Word> result = [];

    for (final WordSet set in sampleWordSets) {
      for (final Word word in set.words) {
        if (saved.contains(word.english)) {
          result.add(word);
        }
      }
    }

    return result;
  }

  void _startReview(BuildContext context, List<Word> words, String title) {
    final WordSet reviewSet = WordSet(
      id: 'saved_review',
      nameVi: title,
      nameEn: title,
      words: words,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => QuizScreen(wordSet: reviewSet)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedBuilder(
      builder: (context, strings) {
        return Scaffold(
          appBar: AppBar(title: Text(strings.get('savedWordsTitle'))),
          body: ValueListenableBuilder<int>(
            valueListenable: ProgressService.changes,
            builder: (context, _, _) {
              final List<Word> words = _loadSavedWords();

              if (words.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      strings.get('noSavedWords'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(strings.get('savedHint')),
                        const SizedBox(height: 12),
                        FilledButton.icon(
                          onPressed: words.length < 2
                              ? null
                              : () {
                                  _startReview(
                                    context,
                                    words,
                                    strings.get('reviewSaved'),
                                  );
                                },
                          icon: const Icon(Icons.quiz),
                          label: Text(strings.get('reviewSaved')),
                        ),
                        if (words.length < 2) ...[
                          const SizedBox(height: 6),
                          Text(
                            strings.get('reviewNeedsTwo'),
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 12),
                      itemCount: words.length,
                      itemBuilder: (context, index) {
                        final Word word = words[index];

                        return Dismissible(
                          key: ValueKey(word.english),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Theme.of(context).colorScheme.error,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 24),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (_) {
                            ProgressService.removeSaved(word.english);
                          },
                          child: Card(
                            child: ListTile(
                              leading: const Icon(Icons.star),
                              title: Text(word.english),
                              subtitle: Text(
                                '${word.phonetic} • '
                                '${word.meaning(strings.languageCode)}',
                              ),
                              trailing: IconButton(
                                tooltip: strings.get('listenPronunciation'),
                                icon: const Icon(Icons.volume_up),
                                onPressed: () {
                                  SpeechService.speakEnglish(word.english);
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
