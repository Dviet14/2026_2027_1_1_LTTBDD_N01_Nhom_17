import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../l10n/localized_builder.dart';
import '../models/word_set.dart';
import '../services/progress_service.dart';
import '../services/speech_service.dart';
import 'quiz_screen.dart';

class FlashcardScreen extends StatefulWidget {
  final WordSet wordSet;

  const FlashcardScreen({super.key, required this.wordSet});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  int _index = 0;
  bool _showBack = false;

  void _goTo(int newIndex) {
    setState(() {
      _index = newIndex;
      _showBack = false;
    });
  }

  void _toggleKnown() {
    final String word = widget.wordSet.words[_index].english;

    setState(() {
      ProgressService.toggleKnown(widget.wordSet.id, word);
    });
  }

  void _toggleSaved() {
    final String word = widget.wordSet.words[_index].english;

    setState(() {
      ProgressService.toggleSaved(word);
    });
  }

  Widget _face(
    BuildContext context, {
    required String title,
    String? subtitle,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 16),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(fontStyle: FontStyle.italic),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedBuilder(
      builder: (context, strings) {
        final words = widget.wordSet.words;

        final bool isVi = strings.languageCode == 'vi';

        final String title = isVi
            ? widget.wordSet.nameVi
            : widget.wordSet.nameEn;

        if (words.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: Text(title)),
            body: Center(child: Text(strings.get('noWordSets'))),
          );
        }

        final word = words[_index];

        final bool isKnown = ProgressService.isKnown(
          widget.wordSet.id,
          word.english,
        );

        final bool isSaved = ProgressService.isSaved(word.english);

        final String example = isVi
            ? '${word.enExample}\n${word.viExample}'
            : word.enExample;

        final scheme = Theme.of(context).colorScheme;

        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: [
              IconButton(
                tooltip: strings.get('startQuiz'),
                icon: const Icon(Icons.quiz),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuizScreen(wordSet: widget.wordSet),
                    ),
                  );
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  '${_index + 1}/${words.length}   •   '
                  '${strings.get('knownCount')}: '
                  '${ProgressService.knownCount(widget.wordSet.id)}',
                ),

                const SizedBox(height: 16),

                // Flashcard va cac nut thao tac
                Expanded(
                  child: Stack(
                    children: [
                      // Mat truoc va mat sau cua the
                      Positioned.fill(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            setState(() {
                              _showBack = !_showBack;
                            });
                          },
                          child: TweenAnimationBuilder<double>(
                            tween: Tween<double>(
                              begin: 0,
                              end: _showBack ? 1 : 0,
                            ),
                            duration: const Duration(milliseconds: 400),
                            builder: (context, value, _) {
                              final bool isBack = value >= 0.5;

                              return Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..rotateY(value * math.pi),
                                child: isBack
                                    ? Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.identity()
                                          ..rotateY(math.pi),
                                        child: _face(
                                          context,
                                          title: word.meaning(
                                            strings.languageCode,
                                          ),
                                          subtitle: example,
                                          color: scheme.secondaryContainer,
                                        ),
                                      )
                                    : _face(
                                        context,
                                        title: word.english,
                                        subtitle: word.phonetic,
                                        color: scheme.primaryContainer,
                                      ),
                              );
                            },
                          ),
                        ),
                      ),

                      // Ba nut nam ngay trong Flashcard
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Danh dau da thuoc
                            IconButton.filledTonal(
                              tooltip: strings.get(
                                isKnown ? 'unmarkKnown' : 'markKnown',
                              ),
                              icon: Icon(
                                isKnown ? Icons.check_circle : Icons.check,
                              ),
                              onPressed: _toggleKnown,
                            ),

                            const SizedBox(width: 18),

                            // Luu tu vao so tay
                            IconButton.filledTonal(
                              tooltip: strings.get(
                                isSaved ? 'unsaveWord' : 'saveWord',
                              ),
                              icon: Icon(
                                isSaved ? Icons.star : Icons.star_border,
                              ),
                              onPressed: _toggleSaved,
                            ),

                            const SizedBox(width: 18),

                            // Nghe phat am
                            IconButton.filledTonal(
                              tooltip: strings.get('listenPronunciation'),
                              icon: const Icon(Icons.volume_up),
                              onPressed: () {
                                SpeechService.speakEnglish(word.english);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                Text(strings.get('tapToFlip')),

                const SizedBox(height: 16),

                // Chi giu nut dieu huong o phia duoi
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton.icon(
                      onPressed: _index > 0 ? () => _goTo(_index - 1) : null,
                      icon: const Icon(Icons.arrow_back),
                      label: Text(strings.get('previous')),
                    ),

                    OutlinedButton.icon(
                      onPressed: _index < words.length - 1
                          ? () => _goTo(_index + 1)
                          : null,
                      icon: const Icon(Icons.arrow_forward),
                      label: Text(strings.get('next')),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
