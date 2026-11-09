class Word {
  final String english;
  final String phonetic;
  final String viMeaning;
  final String viExample;
  final String enDefinition;
  final String enExample;

  const Word({
    required this.english,
    required this.phonetic,
    required this.viMeaning,
    required this.viExample,
    required this.enDefinition,
    required this.enExample,
  });

  /// Đọc một dòng dạng:
  /// english | phonetic | viMeaning | viExample | enDefinition | enExample
  factory Word.parse(String line) {
    final List<String> parts = line.split('|').map((p) => p.trim()).toList();
    if (parts.length != 6) {
      throw FormatException(
        'Dòng từ vựng phải có 6 phần, hiện có ${parts.length}: $line',
      );
    }
    return Word(
      english: parts[0],
      phonetic: parts[1],
      viMeaning: parts[2],
      viExample: parts[3],
      enDefinition: parts[4],
      enExample: parts[5],
    );
  }

  /// Giao diện 'vi' trả nghĩa Việt, còn lại trả định nghĩa Anh.
  String meaning(String languageCode) {
    return languageCode == 'vi' ? viMeaning : enDefinition;
  }
}
