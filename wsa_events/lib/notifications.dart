import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  Notifications._();

  static late FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  static late AndroidNotificationDetails _androidDetails;

  static Future<void> _initialize() async  {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _notifications.initialize(
      const InitializationSettings(
        android: android
      )
    );
  }

  static Future<void> setupAndroid() async {
    await _initialize();
    _androidDetails = const AndroidNotificationDetails(
      'show_events',
      'Events',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true
    );
  }

  static void showNotification(CustomNotification notification) {
    _notifications.show(
      notification.id,
      notification.title,
      notification.body,
      NotificationDetails(
        android: _androidDetails
      ),
      payload: notification.payload
    );
  }
}

class CustomNotification {
  final int id;
  final String title;
  final String body;
  final String? payload;

  CustomNotification({
    required this.id,
    required this.title,
    required this.body,
    this.payload = null
  });
}