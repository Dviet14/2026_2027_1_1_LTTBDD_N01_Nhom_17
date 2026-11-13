import 'package:flutter/material.dart';

import '../l10n/localized_builder.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const String _memberName = '<Nguyễn Duy Việt>';
  static const String _studentId = '<23010775>';
  static const String _className = '<CSE702027-1-1-26 (N01)>';
  static const String _githubUrl =
      '<https://github.com/Dviet14/2026_2027_1_1_LTTBDD_N01_Nhom_17.git>';

  Widget _row(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedBuilder(
      builder: (context, strings) {
        return Scaffold(
          appBar: AppBar(title: Text(strings.get('about'))),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                strings.get('teamInfo'),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              Card(
                child: Column(
                  children: [
                    _row(Icons.person, strings.get('memberName'), _memberName),
                    _row(Icons.badge, strings.get('studentId'), _studentId),
                    _row(Icons.school, strings.get('className'), _className),
                    _row(
                      Icons.book,
                      strings.get('course'),
                      strings.get('courseName'),
                    ),
                    _row(Icons.code, strings.get('github'), _githubUrl),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
