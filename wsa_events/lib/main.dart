import 'package:flutter/material.dart';
import 'eventscreen.dart';
import 'settings.dart';
import 'notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Notifications.setupAndroid();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/events',
      routes: {
        '/events': (BuildContext context) => const EventScreen(),
        '/settings': (BuildContext context) => const SettingsScreen()
      }
    );
  }
}