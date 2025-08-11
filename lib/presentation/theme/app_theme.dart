import 'package:flutter/material.dart';
import 'text_styles.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF00FFA3),
      secondary: Color(0xFF00E1FF),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyles.headline1,
      displayMedium: TextStyles.headline2,
      bodyLarge: TextStyles.bodyText1,
      labelLarge: TextStyles.button,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[900],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16, vertical: 14),
    ),
  );
}