import 'word.dart';

class WordSet {
  final String id;
  final String nameVi;
  final String nameEn;
  final List<Word> words;

  const WordSet({
    required this.id,
    required this.nameVi,
    required this.nameEn,
    required this.words,
  });
}
