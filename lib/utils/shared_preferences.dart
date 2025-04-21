import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationStorage {
  // Keys for SharedPreferences
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String feelingKey = 'feeling';
  static const String moodKey = 'mood';
  static const String emotionsKey = 'emotions';
  static const String emailKey = 'email';

  // Save Data
  // Save email
  static Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(emailKey, email);
    debugPrint('Saved email to SharedPreferences: $email');
  }

  // Save access token
  static Future<void> saveAccessToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(accessTokenKey, accessToken);
    debugPrint('Saved access token to SharedPreferences: $accessToken');
  }

  // Save refresh token
  static Future<void> saveRefreshToken(String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(refreshTokenKey, refreshToken);
    debugPrint('Saved refresh token to SharedPreferences: $refreshToken');
  }

  // Save feeling rating (1-5)
  static Future<void> saveFeeling(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(feelingKey, value);
    debugPrint('Saved feeling to SharedPreferences: $value');
  }

  // Save mood selection
  static Future<void> saveMood(String mood) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(moodKey, mood);
    debugPrint('Saved mood to SharedPreferences: $mood');
  }

  // Save emotions list
  static Future<void> saveEmotions(List<String> emotions) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(emotionsKey, emotions);
    debugPrint('Saved emotions to SharedPreferences: $emotions');
  }

  // Retrieve Data
  // Get feeling rating
  static Future<int> getFeeling() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(feelingKey) ?? 1;
    return value;
  }

  // Get mood selection
  static Future<String?> getMood() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(moodKey);
    return value;
  }

  // Get emotions list
  static Future<List<String>> getEmotions() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getStringList(emotionsKey) ?? [];
    return value;
  }

  // Get mood selection
  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(emailKey);
    return value;
  }

  // Get access token
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(accessTokenKey);
  }

  // Get refresh token
  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(refreshTokenKey);
  }

  // Delete access token and refresh token
  static Future<void> removeTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(accessTokenKey);
    await prefs.remove(refreshTokenKey);
  }

  // Delete all questionnaire-related keys
  static Future<void> clearQuestionnaireData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(feelingKey);
    await prefs.remove(moodKey);
    await prefs.remove(emotionsKey);
  }

  // Get all questionnaire data
  static Future<Map<String, dynamic>> getAllData() async {
    return {
      'email': await getEmail(),
      'feeling': await getFeeling(),
      'mood': await getMood(),
      'emotions': await getEmotions(),
      'access_token': await getAccessToken(),
      'refresh_token': await getRefreshToken(),
    };
  }
}
