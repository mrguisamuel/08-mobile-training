import 'package:flutter/material.dart';

class MyThemes {
  static final ThemeData lightTheme = ThemeData(
    accentColor: Colors.pink,
    brightness: Brightness.light,
    primaryColor: Colors.blue
  );

  static final ThemeData darkTheme = ThemeData(
    accentColor: Colors.red,
    brightness: Brightness.dark,
    primaryColor: Colors.amber
  );
}