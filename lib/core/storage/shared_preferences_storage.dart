import 'package:shared_preferences/shared_preferences.dart';

import 'app_storage.dart';

class SharedPreferencesStorage implements AppStorage {
  final SharedPreferences preferences;

  const SharedPreferencesStorage({required this.preferences});

  @override
  Future<void> setString(String key, String value) async {
    await preferences.setString(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    return preferences.getString(key);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await preferences.setBool(key, value);
  }

  @override
  Future<bool?> getBool(String key) async {
    return preferences.getBool(key);
  }

  @override
  Future<void> setInt(String key, int value) async {
    await preferences.setInt(key, value);
  }

  @override
  Future<int?> getInt(String key) async {
    return preferences.getInt(key);
  }

  @override
  Future<void> remove(String key) async {
    await preferences.remove(key);
  }

  @override
  Future<void> clear() async {
    await preferences.clear();
  }
}
