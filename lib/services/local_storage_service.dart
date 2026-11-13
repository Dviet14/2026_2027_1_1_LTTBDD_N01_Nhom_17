import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static SharedPreferencesWithCache? _preferences;

  static Future<void> initialize() async {
    _preferences ??= await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: <String>{
          'vocabmaster_users_v1',
          'vocabmaster_progress_v1',
          'vocabmaster_language',
          'vocabmaster_theme',
        },
      ),
    );
  }

  static String? getString(String key) {
    return _preferences?.getString(key);
  }

  static Future<void> setString(String key, String value) async {
    final preferences = _preferences;

    if (preferences == null) {
      throw StateError('LocalStorageService has not been initialized.');
    }

    await preferences.setString(key, value);
  }
}
