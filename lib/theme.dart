import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
  );
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.green,
  );
}

const TextStyle switchStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.normal,
);
