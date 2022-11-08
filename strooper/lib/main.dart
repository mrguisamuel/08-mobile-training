import 'package:flutter/material.dart';
import 'init.dart';
import 'themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: Init() 
    );
  }
}