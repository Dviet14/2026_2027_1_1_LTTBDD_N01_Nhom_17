import 'dart:async';

import 'package:flutter/material.dart';

import 'local_storage_service.dart';

class ThemeController {
  static const String _storageKey = 'vocabmaster_theme';

  // Bang mau co san
  static const List<Color> presets = [
    Color(0xFF008F83), // Xanh ngoc
    Color(0xFF2563EB), // Xanh duong
    Color(0xFF5547C8), // Tim indigo
    Color(0xFF9333EA), // Tim
    Color(0xFFDB2777), // Hong
    Color(0xFFE11D48), // Do hong
    Color(0xFFEA580C), // Cam
    Color(0xFFCA8A04), // Vang
    Color(0xFF16A34A), // Xanh la
    Color(0xFF0891B2), // Cyan
    Color(0xFF475569), // Xam xanh
    Color(0xFF7C3AED), // Tim violet
  ];

  static final ValueNotifier<Color> current = ValueNotifier<Color>(presets[0]);

  // Khoi phuc mau da chon
  static Future<void> initialize() async {
    final String? saved = LocalStorageService.getString(_storageKey);

    final int? colorValue = int.tryParse(saved ?? '');

    if (colorValue != null) {
      current.value = Color(colorValue);
    }
  }

  // Thay doi mau giao dien
  static void change(Color color) {
    current.value = color;

    unawaited(
      LocalStorageService.setString(
        _storageKey,
        color.toARGB32().toString(),
      ).catchError((error) {
        debugPrint('Could not save theme color: $error');
      }),
    );
  }
}
