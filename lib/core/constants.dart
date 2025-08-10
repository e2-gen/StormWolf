// ثوابت التطبيق العامة
class AppConstants {
  // ألوان التصميم المستقبلي المظلم
  static const Color primaryColor = Color(0xFF00FFA3);
  static const Color secondaryColor = Color(0xFF00E1FF);
  static const Color darkBackground = Color(0xFF000000);
  static const Color darkSurface = Color(0xFF121212);
  static const Color darkGrey = Color(0xFF1E1E1E);
  static const Color lightGrey = Color(0xFF2D2D2D);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFBDBDBD);

  // أنماط الزوايا
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 16.0;

  // مسافات وتخانات
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double defaultMargin = 20.0;
  static const double buttonHeight = 48.0;

  // أحجام النصوص
  static const double textSizeSmall = 12.0;
  static const double textSizeMedium = 14.0;
  static const double textSizeLarge = 16.0;
  static const double textSizeXLarge = 18.0;
  static const double textSizeXXLarge = 24.0;
  static const double textSizeXXXLarge = 32.0;

  // مدة الحركات والانتقالات
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 350);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // مفاتيح التخزين المحلي
  static const String isLoggedInKey = 'is_logged_in';
  static const String hasRegisteredKey = 'has_registered';
  static const String userDataKey = 'user_data';

  // رسائل التحقق من الصحة
  static const String requiredField = 'This field is required';
  static const String invalidEmail = 'Please enter a valid email';
  static const String shortPassword = 'Password must be at least 6 characters';
  static const String invalidWeight = 'Please enter a valid weight';
  static const String invalidHeight = 'Please enter a valid height';
  static const String invalidWrist = 'Please enter a valid wrist measurement';

  // روابط مساعدة
  static const String privacyPolicyUrl = 'https://example.com/privacy';
  static const String termsOfServiceUrl = 'https://example.com/terms';
  static const String supportEmail = 'support@powertraining.com';

  // مسارات الصور (يمكن استخدام أيقونات Flutter المدمجة بدلاً من الصور)
  static const String appLogo = 'assets/icons/ic_launcher.png';
  static const String placeholderImage = 'assets/images/placeholder.png';
}

// أنواع الجسم مع وصف لكل نوع
class BodyTypeConstants {
  static const Map<BodyType, Map<String, dynamic>> bodyTypes = {
    BodyType.ectomorph: {
      'name': 'Ectomorph',
      'description': 'Lean and long with difficulty building muscle',
      'characteristics': [
        'Small joints',
        'Light build',
        'Flat chest',
        'Fast metabolism',
      ],
    },
    BodyType.mesomorph: {
      'name': 'Mesomorph',
      'description': 'Athletic and muscular with a natural tendency to stay fit',
      'characteristics': [
        'Medium joints',
        'Broad shoulders',
        'Muscular build',
        'Gains muscle easily',
      ],
    },
    BodyType.endomorph: {
      'name': 'Endomorph',
      'description': 'Big, high body fat, often pear-shaped with a tendency to store fat',
      'characteristics': [
        'Large joints',
        'Round body',
        'Gains fat easily',
        'Slow metabolism',
      ],
    },
  };
}

// تمارين لكل نوع جسم
class WorkoutConstants {
  static const Map<BodyType, List<String>> recommendedWorkouts = {
    BodyType.ectomorph: [
      'Compound movements',
      'Heavy weight training',
      'Low reps (4-6)',
      'Long rest periods (2-3 min)',
      'Focus on progressive overload',
    ],
    BodyType.mesomorph: [
      'Mix of compound and isolation',
      'Moderate weight',
      'Moderate reps (8-12)',
      'Short rest periods (30-60 sec)',
      'Focus on symmetry',
    ],
    BodyType.endomorph: [
      'High intensity training',
      'Circuit training',
      'High reps (12-15+)',
      'Very short rest (15-30 sec)',
      'Focus on fat burning',
    ],
  };
}