import 'package:shared_preferences/shared_preferences.dart';

/// A helper class to manage SharedPreferences operations
/// Provides a singleton pattern for consistent access across the app
class SharedPrefsHelper {
  static SharedPrefsHelper? _instance;
  static SharedPreferences? _prefs;

  SharedPrefsHelper._();

  /// Get singleton instance
  static SharedPrefsHelper get instance {
    _instance ??= SharedPrefsHelper._();
    return _instance!;
  }

  /// Initialize SharedPreferences
  /// Call this in main() before runApp()
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Get SharedPreferences instance
  SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception('SharedPreferences not initialized. Call SharedPrefsHelper.init() first.');
    }
    return _prefs!;
  }

  // String operations
  Future<bool> setString(String key, String value) async {
    return await prefs.setString(key, value);
  }

  String? getString(String key, {String? defaultValue}) {
    return prefs.getString(key) ?? defaultValue;
  }

  // Integer operations
  Future<bool> setInt(String key, int value) async {
    return await prefs.setInt(key, value);
  }

  int? getInt(String key, {int? defaultValue}) {
    return prefs.getInt(key) ?? defaultValue;
  }

  // Double operations
  Future<bool> setDouble(String key, double value) async {
    return await prefs.setDouble(key, value);
  }

  double? getDouble(String key, {double? defaultValue}) {
    return prefs.getDouble(key) ?? defaultValue;
  }

  // Boolean operations
  Future<bool> setBool(String key, bool value) async {
    return await prefs.setBool(key, value);
  }

  bool? getBool(String key, {bool? defaultValue}) {
    return prefs.getBool(key) ?? defaultValue;
  }

  // String List operations
  Future<bool> setStringList(String key, List<String> value) async {
    return await prefs.setStringList(key, value);
  }

  List<String>? getStringList(String key, {List<String>? defaultValue}) {
    return prefs.getStringList(key) ?? defaultValue;
  }

  // Generic operations
  /// Check if key exists
  bool containsKey(String key) {
    return prefs.containsKey(key);
  }

  /// Remove a key
  Future<bool> remove(String key) async {
    return await prefs.remove(key);
  }

  /// Clear all preferences
  Future<bool> clear() async {
    return await prefs.clear();
  }

  /// Get all keys
  Set<String> getKeys() {
    return prefs.getKeys();
  }

  /// Reload preferences from storage
  Future<void> reload() async {
    await prefs.reload();
  }

  // Convenience methods for common use cases

  /// Save user session data
  Future<bool> setUserSession({
    required String userId,
    required String token,
    required bool isLoggedIn,
  }) async {
    final results = await Future.wait([
      setString('user_id', userId),
      setString('auth_token', token),
      setBool('is_logged_in', isLoggedIn),
    ]);
    return results.every((result) => result);
  }

  /// Get user session data
  Map<String, dynamic> getUserSession() {
    return {
      'user_id': getString('user_id'),
      'auth_token': getString('auth_token'),
      'is_logged_in': getBool('is_logged_in', defaultValue: false),
    };
  }

  /// Clear user session
  Future<bool> clearUserSession() async {
    final results = await Future.wait([
      remove('user_id'),
      remove('auth_token'),
      remove('is_logged_in'),
    ]);
    return results.every((result) => result);
  }

  /// Save app settings
  Future<bool> setAppSettings({
    String? theme,
    String? language,
    bool? notifications,
  }) async {
    final List<Future<bool>> futures = [];

    if (theme != null) {
      futures.add(setString('app_theme', theme));
    }
    if (language != null) {
      futures.add(setString('app_language', language));
    }
    if (notifications != null) {
      futures.add(setBool('notifications_enabled', notifications));
    }

    if (futures.isEmpty) return true;

    final results = await Future.wait(futures);
    return results.every((result) => result);
  }

  /// Get app settings
  Map<String, dynamic> getAppSettings() {
    return {
      'theme': getString('app_theme', defaultValue: 'light'),
      'language': getString('app_language', defaultValue: 'en'),
      'notifications': getBool('notifications_enabled', defaultValue: true),
    };
  }

  /// Save object as JSON string
  Future<bool> setObject(String key, Map<String, dynamic> value) async {
    try {
      final jsonString = value.toString();
      return await setString(key, jsonString);
    } catch (e) {
      return false;
    }
  }

  /// Get object from JSON string
  Map<String, dynamic>? getObject(String key) {
    try {
      final jsonString = getString(key);
      if (jsonString == null) return null;

      // For complex JSON parsing, you might want to use dart:convert
      // return json.decode(jsonString);
      return {}; // Placeholder - implement based on your needs
    } catch (e) {
      return null;
    }
  }

  /// Save list of objects
  Future<bool> setObjectList(String key, List<Map<String, dynamic>> value) async {
    try {
      final jsonList = value.map((item) => item.toString()).toList();
      return await setStringList(key, jsonList);
    } catch (e) {
      return false;
    }
  }

  /// Get list of objects
  List<Map<String, dynamic>>? getObjectList(String key) {
    try {
      final jsonList = getStringList(key);
      if (jsonList == null) return null;

      // For complex JSON parsing, you might want to use dart:convert
      return []; // Placeholder - implement based on your needs
    } catch (e) {
      return null;
    }
  }

  /// Debug: Print all stored preferences
  void debugPrintAll() {
    final keys = getKeys();
    print('=== SharedPreferences Debug ===');
    for (final key in keys) {
      final value = prefs.get(key);
      print('$key: $value (${value.runtimeType})');
    }
    print('==============================');
  }
}