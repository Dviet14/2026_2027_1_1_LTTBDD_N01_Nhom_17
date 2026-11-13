import 'dart:async';

import 'package:flutter/material.dart';

import '../l10n/language_controller.dart';
import '../l10n/localized_builder.dart';
import '../models/quiz_question.dart';
import '../models/word_set.dart';
import '../services/progress_service.dart';
import '../services/quiz_generator.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final WordSet wordSet;

  const QuizScreen({super.key, required this.wordSet});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  static const int _secondsPerQuestion = 15;

  late final List<QuizQuestion> _questions;
  Timer? _timer;
  int _current = 0;
  int _score = 0;
  int _secondsLeft = _secondsPerQuestion;

  // null: chưa trả lời, -1: hết giờ, còn lại là chỉ số đáp án đã chọn
  int? _selected;

  @override
  void initState() {
    super.initState();
    _questions = QuizGenerator.generate(
      widget.wordSet,
      languageCode: LanguageController.current.value,
    );
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsLeft = _secondsPerQuestion;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || _selected != null) {
        timer.cancel();
        return;
      }
      setState(() => _secondsLeft--);
      if (_secondsLeft <= 0) {
        timer.cancel();
        _timeUp();
      }
    });
  }

  void _timeUp() {
    setState(() => _selected = -1);
    ProgressService.addSaved(_questions[_current].word.english);
  }

  void _select(int optionIndex) {
    if (_selected != null) return;
    _timer?.cancel();
    final QuizQuestion question = _questions[_current];
    final bool correct = optionIndex == question.correctIndex;
    setState(() {
      _selected = optionIndex;
      if (correct) {
        _score++;
      }
    });
    if (!correct) {
      ProgressService.addSaved(question.word.english);
    }
  }

  void _next() {
    if (_current < _questions.length - 1) {
      setState(() {
        _current++;
        _selected = null;
      });
      _startTimer();
    } else {
      _timer?.cancel();
      final int percent = (_score * 100) ~/ _questions.length;
      ProgressService.recordQuiz(widget.wordSet.id, percent);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            wordSet: widget.wordSet,
            score: _score,
            total: _questions.length,
          ),
        ),
      );
    }
  }

  Color? _optionColor(int index, QuizQuestion question) {
    if (_selected == null) return null;
    if (index == question.correctIndex) return Colors.green.shade100;
    if (index == _selected) return Colors.red.shade100;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedBuilder(
      builder: (context, strings) {
        final question = _questions[_current];
        final bool isLast = _current == _questions.length - 1;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              '${strings.get('question')} ${_current + 1}/${_questions.length}',
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LinearProgressIndicator(
                  value: (_current + 1) / _questions.length,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.timer),
                    const SizedBox(width: 8),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: _secondsLeft / _secondsPerQuestion,
                        color: _secondsLeft <= 5 ? Colors.red : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('${_secondsLeft}s'),
                  ],
                ),
                const SizedBox(height: 24),
                Text(strings.get('quizPrompt'), textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Text(
                  question.word.english,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(question.word.phonetic, textAlign: TextAlign.center),
                const SizedBox(height: 24),
                for (int i = 0; i < question.options.length; i++)
                  Card(
                    color: _optionColor(i, question),
                    child: ListTile(
                      title: Text(question.options[i]),
                      onTap: () => _select(i),
                    ),
                  ),
                if (_selected == -1)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      strings.get('timeUp'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                const Spacer(),
                FilledButton(
                  onPressed: _selected == null ? null : _next,
                  child: Text(strings.get(isLast ? 'finish' : 'next')),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
