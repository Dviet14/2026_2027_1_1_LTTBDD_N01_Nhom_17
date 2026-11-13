import 'dart:math';

import '../models/quiz_question.dart';
import '../models/word.dart';
import '../models/word_set.dart';

class QuizGenerator {
  static List<QuizQuestion> generate(
    WordSet set, {
    String languageCode = 'vi',
    int maxQuestions = 10,
    Random? random,
  }) {
    if (set.words.length < 2) {
      throw ArgumentError('Bộ từ cần ít nhất 2 từ để tạo quiz');
    }
    final Random rng = random ?? Random();
    final List<Word> shuffledWords = [...set.words]..shuffle(rng);
    final int optionCount = min(4, set.words.length);

    return shuffledWords.take(maxQuestions).map((word) {
      final String correct = word.meaning(languageCode);
      final List<String> wrongOptions =
          set.words
              .where((w) => w.english != word.english)
              .map((w) => w.meaning(languageCode))
              .toList()
            ..shuffle(rng);
      final List<String> options = [
        correct,
        ...wrongOptions.take(optionCount - 1),
      ]..shuffle(rng);
      return QuizQuestion(
        word: word,
        options: options,
        correctIndex: options.indexOf(correct),
      );
    }).toList();
  }
}
