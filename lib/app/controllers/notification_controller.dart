import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationController {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //initialization
  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    //for ios macOS
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => () {},
    );
    // for linux
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    //
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) => () {},
    );
  }

  //show a simple Notification
  static Future showSimpleNotification({
    required String? title,
    required String? body,
    required String? payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('basic_channel', 'Basic Channel',
            channelDescription: 'testing',
            importance: Importance.max,
            priority: Priority.high,
            color: Colors.red,
            category: AndroidNotificationCategory.message,
            chronometerCountDown: true,
            enableVibration: true,
            enableLights: true,
            playSound: true,
            visibility: NotificationVisibility.public,
            actions: [
              AndroidNotificationAction(
                '1',
                'Reply',
                titleColor: Colors.red,
              ),
            ],
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin
        .show(1, title, body, notificationDetails, payload: payload);
  }
}
