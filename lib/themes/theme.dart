import 'package:flutter/material.dart';

ThemeData buildLightTheme() {
  return ThemeData(
    brightness: Brightness.light, // light theme
    primarySwatch: Colors.green, // primary colours
    scaffoldBackgroundColor: Colors.green[100],
    textTheme: TextTheme(
      body1: TextStyle(
        color: Colors.black,
      ),
      body2: TextStyle(
        color: Colors.grey[600],
        fontWeight: FontWeight.normal,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    cardTheme: CardTheme(
      elevation: 5,
      color: Colors.grey[100],
    ),
    dividerColor: Colors.grey,
    buttonTheme: ButtonThemeData(
      // disabledColor: Colors.grey[400],
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
