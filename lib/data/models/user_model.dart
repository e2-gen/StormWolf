import 'package:flutter/foundation.dart';
import 'package:stormwolf/core/utils/body_type_calculator.dart';

/// نموذج بيانات المستخدم الأساسي
@immutable
class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password; // Note: In production, never store plain passwords
  final double weight; // بالكيلوجرام
  final double height; // بالسنتيمتر
  final BodyType bodyType;
  final DateTime registerDate;
  final DateTime? lastLogin;
  final List<String> favoriteExercises;
  final Map<String, dynamic>? bodyMeasurements;
  final bool isPremium;
  final int? age;

  const UserModel({
    this.id = '',
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.weight,
    required this.height,
    required this.bodyType,
    DateTime? registerDate,
    this.lastLogin,
    this.favoriteExercises = const [],
    this.bodyMeasurements,
    this.isPremium = false,
    this.age,
  }) : registerDate = registerDate ?? DateTime.now();

  /// إنشاء نسخة معدلة من المستخدم
  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    double? weight,
    double? height,
    BodyType? bodyType,
    DateTime? registerDate,
    DateTime? lastLogin,
    List<String>? favoriteExercises,
    Map<String, dynamic>? bodyMeasurements,
    bool? isPremium,
    int? age,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      bodyType: bodyType ?? this.bodyType,
      registerDate: registerDate ?? this.registerDate,
      lastLogin: lastLogin ?? this.lastLogin,
      favoriteExercises: favoriteExercises ?? this.favoriteExercises,
      bodyMeasurements: bodyMeasurements ?? this.bodyMeasurements,
      isPremium: isPremium ?? this.isPremium,
      age: age ?? this.age,
    );
  }

  /// تحويل النموذج لـ Map لتخزينه
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password, // يجب تشفيرها في التطبيق الحقيقي
      'weight': weight,
      'height': height,
      'bodyType': bodyType.index,
      'registerDate': registerDate.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
      'favoriteExercises': favoriteExercises,
      'bodyMeasurements': bodyMeasurements,
      'isPremium': isPremium,
      'age': age,
    };
  }

  /// إنشاء نموذج من Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      weight: map['weight']?.toDouble() ?? 0.0,
      height: map['height']?.toDouble() ?? 0.0,
      bodyType: BodyType.values[map['bodyType'] ?? 0],
      registerDate: map['registerDate'] != null
          ? DateTime.parse(map['registerDate'])
          : DateTime.now(),
      lastLogin: map['lastLogin'] != null
          ? DateTime.parse(map['lastLogin'])
          : null,
      favoriteExercises: List<String>.from(map['favoriteExercises'] ?? []),
      bodyMeasurements: Map<String, dynamic>.from(
          map['bodyMeasurements'] ?? {}),
      isPremium: map['isPremium'] ?? false,
      age: map['age'],
    );
  }

  /// تحويل النموذج لـ JSON
  String toJson() => json.encode(toMap());

  /// إنشاء نموذج من JSON
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, password: $password, weight: $weight, height: $height, bodyType: $bodyType, registerDate: $registerDate, lastLogin: $lastLogin, favoriteExercises: $favoriteExercises, bodyMeasurements: $bodyMeasurements, isPremium: $isPremium, age: $age)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.id == id &&
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.email == email &&
      other.password == password &&
      other.weight == weight &&
      other.height == height &&
      other.bodyType == bodyType &&
      other.registerDate == registerDate &&
      other.lastLogin == lastLogin &&
      listEquals(other.favoriteExercises, favoriteExercises) &&
      mapEquals(other.bodyMeasurements, bodyMeasurements) &&
      other.isPremium == isPremium &&
      other.age == age;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      email.hashCode ^
      password.hashCode ^
      weight.hashCode ^
      height.hashCode ^
      bodyType.hashCode ^
      registerDate.hashCode ^
      lastLogin.hashCode ^
      favoriteExercises.hashCode ^
      bodyMeasurements.hashCode ^
      isPremium.hashCode ^
      age.hashCode;
  }

  /// حساب مؤشر كتلة الجسم (BMI)
  double get bmi {
    return weight / ((height / 100) * (height / 100));
  }

  /// الحصول على فئة مؤشر كتلة الجسم
  String get bmiCategory {
    final bmiValue = bmi;
    if (bmiValue < 18.5) return 'نقص وزن';
    if (bmiValue < 25) return 'وزن طبيعي';
    if (bmiValue < 30) return 'زيادة وزن';
    return 'سمنة';
  }

  /// الحصول على الاسم الكامل
  String get fullName => '$firstName $lastName';

  /// حساب الوزن المثالي بناء على نوع الجسم
  Map<String, double> get idealWeightRange {
    switch (bodyType) {
      case BodyType.ectomorph:
        return {
          'min': 18.5 * pow(height / 100, 2),
          'max': 24.9 * pow(height / 100, 2),
        };
      case BodyType.mesomorph:
        return {
          'min': 21.0 * pow(height / 100, 2),
          'max': 26.0 * pow(height / 100, 2),
        };
      case BodyType.endomorph:
        return {
          'min': 22.0 * pow(height / 100, 2),
          'max': 27.0 * pow(height / 100, 2),
        };
    }
  }

  /// تحديث آخر تاريخ دخول
  UserModel updateLastLogin() {
    return copyWith(lastLogin: DateTime.now());
  }

  /// تحديث القياسات الجسدية
  UserModel updateMeasurements(Map<String, dynamic> newMeasurements) {
    return copyWith(
      bodyMeasurements: {...?bodyMeasurements, ...newMeasurements},
    );
  }

  /// إضافة تمرين للمفضلة
  UserModel addFavoriteExercise(String exerciseId) {
    return copyWith(
      favoriteExercises: [...favoriteExercises, exerciseId],
    );
  }

  /// إزالة تمرين من المفضلة
  UserModel removeFavoriteExercise(String exerciseId) {
    return copyWith(
      favoriteExercises: favoriteExercises.where((id) => id != exerciseId).toList(),
    );
  }
}