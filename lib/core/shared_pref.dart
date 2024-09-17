import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SharedPrefsManager {
  static const String _boxName = "preferences";
  static const String _accessTokenKey = "access_token";
  static const String _refreshTokenKey = "refresh_token";

  static Future<void> init() async {
    // Initialize Hive and open the box for storing preferences
    await Hive.initFlutter();
    await Hive.openBox(_boxName);
  }

  /// Save access token
  static Future<void> saveAccessToken(String token) async {
    var box = Hive.box(_boxName);
    await box.put(_accessTokenKey, token);
  }

  /// Get access token
  static Future<String?> getAccessToken() async {
    var box = Hive.box(_boxName);
    return box.get(_accessTokenKey);
  }

  /// Remove access token
  static Future<void> removeAccessToken() async {
    var box = Hive.box(_boxName);
    await box.delete(_accessTokenKey);
  }

  /// Save refresh token
  static Future<void> saveRefreshToken(String token) async {
    var box = Hive.box(_boxName);
    await box.put(_refreshTokenKey, token);
  }

  /// Get refresh token
  static Future<String?> getRefreshToken() async {
    var box = Hive.box(_boxName);
    return box.get(_refreshTokenKey);
  }

  /// Remove refresh token
  static Future<void> removeRefreshToken() async {
    var box = Hive.box(_boxName);
    await box.delete(_refreshTokenKey);
  }

  /// Clear all stored data (for logout, etc.)
  static Future<void> clearAll() async {
    var box = Hive.box(_boxName);
    await box.clear();
  }
}