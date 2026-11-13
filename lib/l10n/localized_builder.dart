import 'package:flutter/material.dart';

import 'app_strings.dart';
import 'language_controller.dart';

class LocalizedBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, AppStrings strings) builder;

  const LocalizedBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: LanguageController.current,
      builder: (context, code, _) => builder(context, AppStrings(code)),
    );
  }
}
