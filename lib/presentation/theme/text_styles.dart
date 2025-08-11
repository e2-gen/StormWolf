import 'package:flutter/material.dart';
import 'package:your_app/core/constants/app_constants.dart';

class TextStyles {
  // أنماط النصوص الرئيسية
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: Colors.white,
    height: 1.25,
    letterSpacing: -0.3,
  );

  static const TextStyle headline3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    height: 1.3,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    height: 1.4,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    height: 1.4,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    height: 1.5,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.white,
    height: 1.5,
  );

  static const TextStyle bodyText2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.white70,
    height: 1.5,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    height: 1.5,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.white60,
    height: 1.5,
  );

  static const TextStyle overline = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: Colors.white60,
    height: 1.5,
    letterSpacing: 1.2,
  );

  // أنماط مخصصة للتطبيق
  static TextStyle futuristicTitle(BuildContext context) {
    return TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w900,
      color: Colors.white,
      letterSpacing: 1.5,
      shadows: [
        Shadow(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
          blurRadius: 10,
          offset: const Offset(0, 0),
        ),
      ],
    );
  }

  static TextStyle neonText(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: color ?? Theme.of(context).colorScheme.primary,
      shadows: [
        Shadow(
          color: (color ?? Theme.of(context).colorScheme.primary).withOpacity(0.8),
          blurRadius: 15,
          offset: const Offset(0, 0),
        ),
      ],
    );
  }

  static TextStyle gradientText(BuildContext context) {
    return const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      foreground: Paint()
        ..shader = LinearGradient(
          colors: [Color(0xFF00FFA3), Color(0xFF00E1FF)],
        ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
      height: 1.3,
    );
  }

  // أنماط خاصة بأنواع الأجسام
  static TextStyle bodyTypeTitle(BodyType type) {
    Color color;
    switch (type) {
      case BodyType.ectomorph:
        color = const Color(0xFF00FFA3);
        break;
      case BodyType.mesomorph:
        color = const Color(0xFF00E1FF);
        break;
      case BodyType.endomorph:
        color = const Color(0xFFFF6B6B);
        break;
    }

    return TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w800,
      color: color,
      letterSpacing: 0.5,
    );
  }

  // أنماط النصوص في الأزرار
  static TextStyle elevatedButtonText = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    letterSpacing: 0.5,
  );

  static TextStyle outlinedButtonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  // أنماط النصوص في حقول الإدخال
  static TextStyle inputText = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  static TextStyle inputLabel = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.white70,
  );

  static TextStyle inputError = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Color(0xFFFF6B6B),
  );
}