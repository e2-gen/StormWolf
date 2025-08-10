import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_app/data/models/user_model.dart';
import 'dart:convert';

class SharedPrefs {
  static late SharedPreferences _prefs;

  // تهيئة SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // حفظ بيانات المستخدم
  static Future<void> saveUser(UserModel user) async {
    await _prefs.setString('user_data', jsonEncode(user.toJson()));
    await _prefs.setBool('is_logged_in', true);
    await _prefs.setBool('first_time', false);
  }

  // جلب بيانات المستخدم
  static UserModel? getUser() {
    final userData = _prefs.getString('user_data');
    if (userData != null) {
      return UserModel.fromJson(jsonDecode(userData));
    }
    return null;
  }

  // حذف بيانات المستخدم (تسجيل الخروج)
  static Future<void> clearUser() async {
    await _prefs.remove('user_data');
    await _prefs.setBool('is_logged_in', false);
  }

  // التحقق من حالة تسجيل الدخول
  static bool isLoggedIn() {
    return _prefs.getBool('is_logged_in') ?? false;
  }

  // التحقق إذا كانت المرة الأولى للتشغيل
  static bool isFirstTime() {
    return _prefs.getBool('first_time') ?? true;
  }

  // حفظ إعدادات التطبيق
  static Future<void> saveAppSettings({
    required bool darkMode,
    required bool notifications,
    String? language,
  }) async {
    await _prefs.setBool('dark_mode', darkMode);
    await _prefs.setBool('notifications', notifications);
    if (language != null) {
      await _prefs.setString('language', language);
    }
  }

  // جلب إعدادات الوضع المظلم
  static bool getDarkMode() {
    return _prefs.getBool('dark_mode') ?? true; // افتراضيًا الوضع المظلم
  }

  // جلب إعدادات الإشعارات
  static bool getNotifications() {
    return _prefs.getBool('notifications') ?? true;
  }

  // جلب اللغة المفضلة
  static String getLanguage() {
    return _prefs.getString('language') ?? 'ar'; // افتراضيًا العربية
  }

  // حفظ آخر وزن مسجل
  static Future<void> saveLastWeight(double weight) async {
    await _prefs.setDouble('last_weight', weight);
  }

  // جلب آخر وزن مسجل
  static double getLastWeight() {
    return _prefs.getDouble('last_weight') ?? 70.0; // قيمة افتراضية
  }

  // حفظ نوع الجسم
  static Future<void> saveBodyType(BodyType bodyType) async {
    await _prefs.setString('body_type', bodyType.toString());
  }

  // جلب نوع الجسم
  static BodyType? getBodyType() {
    final type = _prefs.getString('body_type');
    if (type != null) {
      return BodyType.values.firstWhere(
        (e) => e.toString() == type,
        orElse: () => BodyType.mesomorph,
      );
    }
    return null;
  }

  // حفظ تفضيلات الوحدات (كجم/رطل)
  static Future<void> saveWeightUnit(bool isKg) async {
    await _prefs.setBool('weight_unit_kg', isKg);
  }

  // جلب تفضيلات الوحدات
  static bool getWeightUnit() {
    return _prefs.getBool('weight_unit_kg') ?? true; // افتراضيًا كجم
  }

  // طريقة مساعدة لحفظ أي بيانات عامة
  static Future<void> saveData<T>(String key, T value) async {
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is List<String>) {
      await _prefs.setStringList(key, value);
    }
  }

  // طريقة مساعدة لجلب أي بيانات عامة
  static T? getData<T>(String key) {
    switch (T) {
      case String:
        return _prefs.getString(key) as T?;
      case int:
        return _prefs.getInt(key) as T?;
      case double:
        return _prefs.getDouble(key) as T?;
      case bool:
        return _prefs.getBool(key) as T?;
      case List<String>:
        return _prefs.getStringList(key) as T?;
      default:
        return null;
    }
  }
}