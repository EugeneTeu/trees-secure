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

ThemeData buildDarkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.green[600],
    primaryColorLight: Colors.green[100],
    primaryColorDark: Colors.green[500],
    accentColor: Colors.green[400],
    scaffoldBackgroundColor: Colors.black,
    dialogBackgroundColor: Colors.grey[900],
    textTheme: TextTheme(
      body1: TextStyle(
        color: Colors.white,
      ),
      body2: TextStyle(
        color: Colors.grey[400],
        fontWeight: FontWeight.normal,
      ),
    ),
    appBarTheme: AppBarTheme(
      color: Colors.green[900],
    ),
    dividerColor: Colors.grey[700],
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    buttonTheme: ButtonThemeData(
      // disabledColor: Colors.grey[400],
      textTheme: ButtonTextTheme.primary,
    ),
    cardTheme: CardTheme(
      elevation: 0,
      color: Colors.grey[900],
    ),
  );
}
