import 'package:flutter/material.dart';

import '../l10n/localized_builder.dart';
import '../models/word_set.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatelessWidget {
  final WordSet wordSet;
  final int score;
  final int total;

  const ResultScreen({
    super.key,
    required this.wordSet,
    required this.score,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return LocalizedBuilder(
      builder: (context, strings) {
        final int percent = total == 0 ? 0 : (score * 100) ~/ total;
        final int stars = percent >= 80
            ? 3
            : percent >= 50
            ? 2
            : 1;
        final String messageKey = percent >= 80
            ? 'resultGreat'
            : percent >= 50
            ? 'resultOk'
            : 'resultTry';

        return Scaffold(
          appBar: AppBar(
            title: Text(strings.get('result')),
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (i) {
                    return Icon(
                      i < stars ? Icons.star : Icons.star_border,
                      size: 56,
                      color: Colors.amber,
                    );
                  }),
                ),
                const SizedBox(height: 16),
                Text(
                  '${strings.get('points')}: ${score * 10}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  '${strings.get('correctCount')}: $score/$total ($percent%)',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(strings.get(messageKey), textAlign: TextAlign.center),
                const SizedBox(height: 32),
                FilledButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuizScreen(wordSet: wordSet),
                      ),
                    );
                  },
                  child: Text(strings.get('playAgain')),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () =>
                      Navigator.popUntil(context, (route) => route.isFirst),
                  child: Text(strings.get('backHome')),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
