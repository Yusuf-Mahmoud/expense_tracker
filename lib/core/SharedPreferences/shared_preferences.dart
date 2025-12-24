import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  static const _onBoardingKey = 'onBoardingDone';
  static const _pinKey = 'userPin';

  static Future<void> setOnBoardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onBoardingKey, true);
  }

  static Future<bool> isOnBoardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onBoardingKey) ?? false;
  }

  static Future<void> savePin(String pin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_pinKey, pin);
  }

  static Future<String?> getPin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_pinKey);
  }

  static Future<bool> hasPin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_pinKey);
  }
}
