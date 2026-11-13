import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SpeechService {
  static final FlutterTts _engine = FlutterTts();

  static Future<void> speakEnglish(String text) async {
    final String value = text.trim();

    if (value.isEmpty) return;

    try {
      await _engine.stop();
      await _engine.setLanguage('en-US');
      await _engine.setSpeechRate(0.45);
      await _engine.setPitch(1.0);
      await _engine.speak(value);
    } catch (error) {
      debugPrint('Text-to-speech error: $error');
    }
  }

  static Future<void> stop() async {
    try {
      await _engine.stop();
    } catch (error) {
      debugPrint('Text-to-speech stop error: $error');
    }
  }
}
