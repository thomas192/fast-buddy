import 'package:flutter/material.dart';

class GreenTheme {
  static ThemeData greenTheme() {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.green[400],
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 32,
        ),
      ),
      brightness: Brightness.light,
      primaryColor: Colors.green[400],
      backgroundColor: Colors.transparent,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.lightGreen,
        accentColor: Colors.lightGreen[600],
      ),
    );
  }
}
