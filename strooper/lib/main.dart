import 'package:flutter/material.dart';
import 'init.dart';
import 'high_score.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HighScore() 
    );
  }
}