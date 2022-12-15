import 'package:flutter/material.dart';
import 'eventscreen.dart';
import 'settings.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> setupNotifications() async {
    // Define the plataform-specific notification settings for Android and iOS
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = IOSInitializationSettings();

    // Construct a plataform-agnostic setting using the initialization from the two plataforms
    const initSettings = InitializationSettings(android: android, iOS: iOS);

    // Initialize the notification plugin with the general setting
    await flutterLocalNotificationsPlugin.initialize(initSettings).then((_) {
      debugPrint('SetupNotifications: setup success!');
    }).catchError((Object error) {
      debugPrint('ErrorNotification: $error');
    });
  }

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