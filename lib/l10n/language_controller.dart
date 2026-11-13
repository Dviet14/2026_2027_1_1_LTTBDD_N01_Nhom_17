import 'dart:async';

import 'package:flutter/foundation.dart';

import '../services/local_storage_service.dart';

class LanguageController {
  static const String _storageKey = 'vocabmaster_language';

  static final ValueNotifier<String> current = ValueNotifier<String>('vi');

  static Future<void> initialize() async {
    final String? saved = LocalStorageService.getString(_storageKey);

    if (saved == 'vi' || saved == 'en') {
      current.value = saved!;
    }
  }

  static void change(String languageCode) {
    if (languageCode != 'vi' && languageCode != 'en') {
      throw ArgumentError('Unsupported language: $languageCode');
    }

    current.value = languageCode;

    unawaited(LocalStorageService.setString(_storageKey, languageCode));
  }
}
