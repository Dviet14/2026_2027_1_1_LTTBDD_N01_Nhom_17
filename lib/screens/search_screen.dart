import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../l10n/localized_builder.dart';
import '../models/word.dart';
import '../models/word_set.dart';
import '../services/progress_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<MapEntry<WordSet, Word>> _search() {
    final String q = _query.trim().toLowerCase();
    final List<MapEntry<WordSet, Word>> result = [];
    if (q.isEmpty) return result;
    for (final WordSet set in sampleWordSets) {
      for (final Word word in set.words) {
        final bool match =
            word.english.toLowerCase().contains(q) ||
            word.viMeaning.toLowerCase().contains(q) ||
            word.enDefinition.toLowerCase().contains(q);
        if (match) {
          result.add(MapEntry(set, word));
        }
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedBuilder(
      builder: (context, strings) {
        final bool isVi = strings.languageCode == 'vi';
        return Scaffold(
          appBar: AppBar(title: Text(strings.get('search'))),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _controller,
                  onChanged: (value) => setState(() => _query = value),
                  decoration: InputDecoration(
                    hintText: strings.get('searchHint'),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _query.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _controller.clear();
                              setState(() => _query = '');
                            },
                          ),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                child: ValueListenableBuilder<int>(
                  valueListenable: ProgressService.changes,
                  builder: (context, _, __) {
                    if (_query.trim().isEmpty) {
                      return Center(child: Text(strings.get('searchHint')));
                    }
                    final results = _search();
                    if (results.isEmpty) {
                      return Center(child: Text(strings.get('noResults')));
                    }
                    return ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final WordSet set = results[index].key;
                        final Word word = results[index].value;
                        final bool saved = ProgressService.isSaved(
                          word.english,
                        );
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: ListTile(
                            title: Text(word.english),
                            subtitle: Text(
                              '${word.phonetic} • '
                              '${word.meaning(strings.languageCode)}\n'
                              '${isVi ? set.nameVi : set.nameEn}',
                            ),
                            isThreeLine: true,
                            trailing: IconButton(
                              tooltip: strings.get(
                                saved ? 'unsaveWord' : 'saveWord',
                              ),
                              icon: Icon(
                                saved ? Icons.star : Icons.star_border,
                              ),
                              onPressed: () =>
                                  ProgressService.toggleSaved(word.english),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
