import 'package:flutter/material.dart';
import 'game.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/game',
      routes: {
        '/game': (BuildContext context) => const Game(),
        '/home': (BuildContext context) => const Home()
      }
    );
  }
}