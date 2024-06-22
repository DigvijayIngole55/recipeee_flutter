import 'package:flutter/material.dart';

class AppTheme {
  static const Color lightPink = Color(0xFFFFE6E6);
  static const Color softPink = Color(0xFFE1AFD1);
  static const Color purple = Color(0xFFAD88C6);
  static const Color darkPurple = Color(0xFF6C22A6);

  static final ThemeData lightTheme = ThemeData(
    primaryColor: lightPink,
    scaffoldBackgroundColor: lightPink,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: lightPink,
      secondary: softPink,
      background: lightPink,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: lightPink,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: darkPurple,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        textStyle: TextStyle(fontSize: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: darkPurple,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
          color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
    ),
  );
}
