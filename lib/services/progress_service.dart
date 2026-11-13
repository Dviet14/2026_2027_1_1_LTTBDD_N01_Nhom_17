import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'auth_service.dart';
import 'local_storage_service.dart';

class ProgressService {
  static const String _storageKey = 'vocabmaster_progress_v1';

  static final Map<String, Map<String, Set<String>>> _known = {};
  static final Map<String, Map<String, int>> _best = {};
  static final Map<String, Set<String>> _saved = {};
  static final Map<String, int> _dailyGoals = {};
  static final Map<String, Map<String, Set<String>>> _dailyWords = {};

  static final ValueNotifier<int> changes = ValueNotifier<int>(0);

  static String _userKey() {
    final user = AuthService.currentUser.value;

    if (user == null) {
      throw StateError('Not logged in');
    }

    return user.id;
  }

  static String _todayKey() {
    final DateTime now = DateTime.now();

    final String month = now.month.toString().padLeft(2, '0');

    final String day = now.day.toString().padLeft(2, '0');

    return '${now.year}-$month-$day';
  }

  // Khoi phuc tien do
  static Future<void> initialize() async {
    final String? raw = LocalStorageService.getString(_storageKey);

    if (raw == null || raw.isEmpty) return;

    try {
      final Map<String, dynamic> data = jsonDecode(raw) as Map<String, dynamic>;

      _known.clear();

      final Map<String, dynamic> knownData = Map<String, dynamic>.from(
        data['known'] as Map? ?? {},
      );

      for (final entry in knownData.entries) {
        final Map<String, dynamic> bySet = Map<String, dynamic>.from(
          entry.value as Map,
        );

        _known[entry.key] = bySet.map(
          (setId, words) => MapEntry(
            setId,
            (words as List<dynamic>).map((word) => word.toString()).toSet(),
          ),
        );
      }

      _best.clear();

      final Map<String, dynamic> bestData = Map<String, dynamic>.from(
        data['best'] as Map? ?? {},
      );

      for (final entry in bestData.entries) {
        final Map<String, dynamic> bySet = Map<String, dynamic>.from(
          entry.value as Map,
        );

        _best[entry.key] = bySet.map(
          (setId, score) => MapEntry(setId, (score as num).toInt()),
        );
      }

      _saved.clear();

      final Map<String, dynamic> savedData = Map<String, dynamic>.from(
        data['saved'] as Map? ?? {},
      );

      for (final entry in savedData.entries) {
        _saved[entry.key] = (entry.value as List<dynamic>)
            .map((word) => word.toString())
            .toSet();
      }

      _dailyGoals
        ..clear()
        ..addAll(
          (Map<String, dynamic>.from(data['dailyGoals'] as Map? ?? {}))
              .map((userId, goal) => MapEntry(userId, (goal as num).toInt())),
        );

      _dailyWords.clear();

      final Map<String, dynamic> dailyData = Map<String, dynamic>.from(
        data['dailyWords'] as Map? ?? {},
      );

      for (final entry in dailyData.entries) {
        final Map<String, dynamic> byDate = Map<String, dynamic>.from(
          entry.value as Map,
        );

        _dailyWords[entry.key] = byDate.map(
          (date, words) => MapEntry(
            date,
            (words as List<dynamic>).map((word) => word.toString()).toSet(),
          ),
        );
      }
    } catch (error, stackTrace) {
      debugPrint('Could not restore study progress: $error');
      debugPrint('$stackTrace');

      _known.clear();
      _best.clear();
      _saved.clear();
      _dailyGoals.clear();
      _dailyWords.clear();
    }
  }

  // Ghi tien do xuong bo nho
  static void _save() {
    final Map<String, dynamic> data = {
      'known': _known.map(
        (userId, bySet) => MapEntry(
          userId,
          bySet.map((setId, words) => MapEntry(setId, words.toList())),
        ),
      ),
      'best': _best,
      'saved': _saved.map((userId, words) => MapEntry(userId, words.toList())),
      'dailyGoals': _dailyGoals,
      'dailyWords': _dailyWords.map(
        (userId, byDate) => MapEntry(
          userId,
          byDate.map((date, words) => MapEntry(date, words.toList())),
        ),
      ),
    };

    unawaited(
      LocalStorageService.setString(_storageKey, jsonEncode(data)).catchError((
        error,
      ) {
        debugPrint('Could not save study progress: $error');
      }),
    );
  }

  // Kiem tra tu da thuoc
  static bool isKnown(String setId, String word) {
    return _known[_userKey()]?[setId]?.contains(word) ?? false;
  }

  static int knownCount(String setId) {
    return _known[_userKey()]?[setId]?.length ?? 0;
  }

  // Danh dau tu da thuoc
  static void toggleKnown(String setId, String word) {
    final String userId = _userKey();

    final Map<String, Set<String>> bySet = _known.putIfAbsent(
      userId,
      () => <String, Set<String>>{},
    );

    final Set<String> words = bySet.putIfAbsent(setId, () => <String>{});

    if (!words.remove(word)) {
      words.add(word);

      _dailyWords
          .putIfAbsent(userId, () => <String, Set<String>>{})
          .putIfAbsent(_todayKey(), () => <String>{})
          .add(word);
    }

    _save();
    changes.value++;
  }

  // Diem quiz cao nhat
  static int? bestPercent(String setId) {
    return _best[_userKey()]?[setId];
  }

  static void recordQuiz(String setId, int percent) {
    final Map<String, int> scores = _best.putIfAbsent(
      _userKey(),
      () => <String, int>{},
    );

    final int? old = scores[setId];

    if (old == null || percent > old) {
      scores[setId] = percent;
    }

    _save();
    changes.value++;
  }

  // Kiem tra tu trong so tay
  static bool isSaved(String word) {
    return _saved[_userKey()]?.contains(word) ?? false;
  }

  static List<String> savedWords() {
    return List<String>.from(_saved[_userKey()] ?? <String>{});
  }

  // Them hoac bo tu kho
  static void toggleSaved(String word) {
    final Set<String> saved = _saved.putIfAbsent(_userKey(), () => <String>{});

    if (!saved.remove(word)) {
      saved.add(word);
    }

    _save();
    changes.value++;
  }

  static void addSaved(String word) {
    final Set<String> saved = _saved.putIfAbsent(_userKey(), () => <String>{});

    if (saved.add(word)) {
      _save();
      changes.value++;
    }
  }

  static void removeSaved(String word) {
    final Set<String>? saved = _saved[_userKey()];

    if (saved != null && saved.remove(word)) {
      _save();
      changes.value++;
    }
  }

  // Muc tieu hoc moi ngay
  static int get dailyGoal {
    return _dailyGoals[_userKey()] ?? 10;
  }

  static int get wordsStudiedToday {
    return _dailyWords[_userKey()]?[_todayKey()]?.length ?? 0;
  }

  static void setDailyGoal(int goal) {
    if (![5, 10, 20].contains(goal)) {
      throw ArgumentError('Daily goal must be 5, 10, or 20.');
    }

    _dailyGoals[_userKey()] = goal;

    _save();
    changes.value++;
  }
}
