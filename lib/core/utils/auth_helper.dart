import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static const _keyLoggedIn = 'is_logged_in';
  static const _keyRegistered = 'has_registered';
  static const _keyUserData = 'user_data';

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyLoggedIn) ?? false;
  }

  Future<bool> hasUserRegistered() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyRegistered) ?? false;
  }

  Future<void> saveUserRegistration(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyRegistered, true);
    await prefs.setString(_keyUserData, jsonEncode(userData));
  }

  Future<void> loginUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLoggedIn, true);
  }

  Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLoggedIn, false);
  }
}